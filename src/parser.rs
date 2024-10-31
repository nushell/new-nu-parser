use crate::compiler::{Compiler, RollbackPoint, Span};
use crate::errors::{Severity, SourceError};
use crate::naming::{BarewordContext, NameStrictness, NAME_STRICT, STRING_STRICT};
use crate::token::{Token, TokenType};

use tracy_client::span;

pub struct Parser {
    pub compiler: Compiler,
    pub span_offset: usize,
    content_length: usize,
    next_token: Option<Token>,
    next_offset: usize,
    tokens: Vec<Token>, // TODO: Remove, just for testing
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct NodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct BlockId(pub usize);

#[derive(Debug, Clone)]
pub struct Block {
    pub nodes: Vec<NodeId>,
}

impl Block {
    pub fn new(nodes: Vec<NodeId>) -> Block {
        Block { nodes }
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum BlockContext {
    /// This block is a whole block of code not wrapped in curlies (e.g., a file)
    Bare,
    /// This block is wrapped in curlies
    Curlies,
    /// This block should be parsed as part of a closure starting after closure params
    Closure,
}

#[derive(Debug)]
pub enum ParamsContext {
    /// Params for a command signature
    Squares,
    /// Params for a closure
    Pipes,
}

// TODO: All nodes with Vec<...> should be moved to their own ID (like BlockId) to allow Copy trait
#[derive(Debug, PartialEq, Clone)]
pub enum AstNode {
    Int,
    Float,
    String,
    Name,
    Type {
        name: NodeId,
        params: Option<NodeId>,
        optional: bool,
    },
    Variable,

    // Booleans
    True,
    False,

    // Empty values
    Null,

    // Operators
    Equal,
    NotEqual,
    LessThan,
    GreaterThan,
    LessThanOrEqual,
    GreaterThanOrEqual,
    Plus,
    Append,
    Minus,
    Multiply,
    Divide,
    // Modulo,
    And,
    Or,
    Pow,

    // Assignments
    Assignment,
    AddAssignment,
    SubtractAssignment,
    MultiplyAssignment,
    DivideAssignment,
    // TODO: append assignment ++=

    // Statements
    Let {
        variable_name: NodeId,
        ty: Option<NodeId>,
        initializer: NodeId,
        is_mutable: bool,
    },
    While {
        condition: NodeId,
        block: NodeId,
    },
    For {
        variable: NodeId,
        range: NodeId,
        block: NodeId,
    },
    Loop {
        block: NodeId,
    },
    Return(Option<NodeId>),
    Break,
    Continue,

    // Definitions
    Def {
        name: NodeId,
        params: NodeId,
        return_ty: Option<NodeId>,
        block: NodeId,
    },
    Params(Vec<NodeId>),
    Param {
        name: NodeId,
        ty: Option<NodeId>,
    },
    Closure {
        params: Option<NodeId>,
        block: NodeId,
    },

    /// Long flag ('--' + one or more letters)
    FlagLong,
    /// Short flag ('-' + single letter)
    FlagShort,
    /// Group of short flags ('-' + more than 1 letters)
    FlagShortGroup,

    // Expressions
    Call {
        parts: Vec<NodeId>,
    },
    NamedValue {
        name: NodeId,
        value: NodeId,
    },
    BinaryOp {
        lhs: NodeId,
        op: NodeId,
        rhs: NodeId,
    },
    Range {
        lhs: NodeId,
        rhs: NodeId,
    },
    List(Vec<NodeId>),
    Table {
        header: NodeId,
        rows: Vec<NodeId>,
    },
    Record {
        pairs: Vec<(NodeId, NodeId)>,
    },
    MemberAccess {
        target: NodeId,
        field: NodeId,
    },
    Block(BlockId),
    If {
        condition: NodeId,
        then_block: NodeId,
        else_block: Option<NodeId>,
    },
    Match {
        target: NodeId,
        match_arms: Vec<(NodeId, NodeId)>,
    },
    Statement(NodeId),
    Garbage,
}

pub const ASSIGNMENT_PRECEDENCE: usize = 10;

impl AstNode {
    pub fn precedence(&self) -> usize {
        match self {
            AstNode::Pow => 100,
            AstNode::Multiply | AstNode::Divide => 95,
            //AstNode::Modulo => 95,
            AstNode::Plus | AstNode::Minus => 90,
            AstNode::LessThan
            | AstNode::LessThanOrEqual
            | AstNode::GreaterThan
            | AstNode::GreaterThanOrEqual
            | AstNode::Equal
            | AstNode::NotEqual => 80,
            AstNode::And => 50,
            AstNode::Or => 40,
            AstNode::Assignment
            | AstNode::AddAssignment
            | AstNode::SubtractAssignment
            | AstNode::MultiplyAssignment
            | AstNode::DivideAssignment => ASSIGNMENT_PRECEDENCE,
            _ => 0,
        }
    }
}

impl Parser {
    pub fn new(compiler: Compiler, span_offset: usize) -> Self {
        let content_length = compiler.source.len() - span_offset;
        Self {
            compiler,
            content_length,
            span_offset,
            next_token: None,
            next_offset: span_offset,
            tokens: vec![],
        }
    }

    pub fn lex(&mut self) {
        while self.has_tokens() {
            if let Some(token) = self.next() {
                self.tokens.push(token);
            }
        }
    }

    fn position(&mut self) -> usize {
        if let Some(Token { span_start, .. }) = self.peek() {
            span_start
        } else {
            self.content_length
        }
    }

    fn get_span_end(&self, node_id: NodeId) -> usize {
        self.compiler.spans[node_id.0].end
    }

    pub fn parse(mut self) -> Compiler {
        let _span = span!();
        self.block(BlockContext::Bare);

        self.compiler
    }

    pub fn expression_or_assignment(&mut self) -> NodeId {
        let _span = span!();
        self.math_expression(true)
    }

    pub fn expression(&mut self) -> NodeId {
        let _span = span!();
        self.math_expression(false)
    }

    pub fn math_expression(&mut self, allow_assignment: bool) -> NodeId {
        let _span = span!();
        let mut expr_stack = Vec::<(NodeId, NodeId)>::new();

        let mut last_prec = 1000000;

        let span_start = self.position();

        // Check for special forms
        if self.is_keyword(b"if") {
            return self.if_expression();
        } else if self.is_keyword(b"match") {
            return self.match_expression();
        }
        // TODO
        // } else if self.is_keyword(b"where") {
        // }

        // Otherwise assume a math expression
        let mut leftmost = self.simple_expression(NAME_STRICT);

        if let Some(Token {
            token_type: TokenType::Equals,
            ..
        }) = self.peek()
        {
            if !allow_assignment {
                self.error("assignment found in expression");
            }
            let op = self.operator();

            let rhs = self.expression();
            let span_end = self.get_span_end(rhs);

            return self.create_node(
                AstNode::BinaryOp {
                    lhs: leftmost,
                    op,
                    rhs,
                },
                span_start,
                span_end,
            );
        }

        while self.has_tokens() {
            if self.is_operator() {
                let missing_space_before_op = !self.is_horizontal_space();
                let op = self.operator();
                let missing_space_after_op = !self.is_horizontal_space();

                if missing_space_before_op {
                    self.error_on_node("missing space before operator", op);
                }

                if missing_space_after_op {
                    self.error_on_node("missing space after operator", op);
                }

                let op_prec = self.operator_precedence(op);

                if op_prec == ASSIGNMENT_PRECEDENCE && !allow_assignment {
                    self.error_on_node("assignment found in expression", op);
                }

                let rhs = if self.is_simple_expression() {
                    self.simple_expression(NAME_STRICT)
                } else {
                    self.error("incomplete math expression")
                };

                while op_prec <= last_prec {
                    let Some((op, rhs)) = expr_stack.pop() else {
                        break;
                    };

                    last_prec = self.operator_precedence(op);

                    if last_prec < op_prec {
                        expr_stack.push((op, rhs));
                        break;
                    }

                    let lhs = expr_stack.last_mut().map_or(&mut leftmost, |l| &mut l.1);

                    let (span_start, span_end) = self.spanning(*lhs, rhs);
                    *lhs = self.create_node(
                        AstNode::BinaryOp { lhs: *lhs, op, rhs },
                        span_start,
                        span_end,
                    );
                }

                expr_stack.push((op, rhs));

                last_prec = op_prec;
            } else {
                break;
            }
        }

        while let Some((op, rhs)) = expr_stack.pop() {
            let lhs = expr_stack.last_mut().map_or(&mut leftmost, |l| &mut l.1);

            let (span_start, span_end) = self.spanning(*lhs, rhs);

            *lhs = self.create_node(
                AstNode::BinaryOp { lhs: *lhs, op, rhs },
                span_start,
                span_end,
            );
        }

        leftmost
    }

    pub fn simple_expression(&mut self, bareword_context: BarewordContext) -> NodeId {
        let _span = span!();
        let span_start = self.position();

        let mut expr = if self.is_lcurly() {
            self.record_or_closure()
        } else if self.is_lparen() {
            self.lparen();
            let output = self.expression();
            self.rparen();
            output
        } else if self.is_lsquare() {
            self.list_or_table()
        } else if self.is_keyword(b"true") || self.is_keyword(b"false") {
            self.boolean()
        } else if self.is_keyword(b"null") {
            self.null()
        } else if self.is_string() {
            self.string()
        } else if self.is_number() {
            self.number()
        } else if self.is_dollar() {
            self.variable()
        } else if self.is_bareword(bareword_context.strictness) {
            if bareword_context.as_string {
                let node_id = self.bareword(bareword_context.strictness);
                self.compiler.ast_nodes[node_id.0] = AstNode::String;
                node_id
            } else {
                self.call()
            }
        } else {
            self.error("incomplete expression")
        };

        loop {
            if self.is_horizontal_space() {
                return expr;
            } else if self.is_dotdot() {
                // Range
                self.next();

                if self.is_horizontal_space() {
                    // TODO: implement range from
                    //
                    // TODO: tweak the garbage location.
                    self.error("incomplete range");
                    return expr;
                } else {
                    let rhs = self.simple_expression(STRING_STRICT);
                    let span_end = self.get_span_end(rhs);

                    expr =
                        self.create_node(AstNode::Range { lhs: expr, rhs }, span_start, span_end);
                }
            } else if self.is_dot() {
                // Member access
                self.next();

                if self.is_horizontal_space() {
                    self.error("missing path name");
                    return expr;
                }

                let prev_offset = self.span_offset;

                let name = self.name();

                let field_or_call = if self.is_lparen() {
                    self.span_offset = prev_offset;
                    self.variable()
                } else {
                    name
                };
                let span_end = self.get_span_end(field_or_call);

                match self.compiler.get_node_mut(field_or_call) {
                    AstNode::Variable | AstNode::Name => {
                        expr = self.create_node(
                            AstNode::MemberAccess {
                                target: expr,
                                field: field_or_call,
                            },
                            span_start,
                            span_end,
                        );
                    }
                    _ => {
                        self.error("expected field");
                    }
                }
            } else {
                return expr;
            }
        }
    }

    pub fn number(&mut self) -> NodeId {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Number,
                span_start,
                span_end,
            }) => {
                self.next();
                let contents = &self.compiler.source[span_start..span_end];

                if contents.contains(&b'.') {
                    self.create_node(AstNode::Float, span_start, span_end)
                } else {
                    self.create_node(AstNode::Int, span_start, span_end)
                }
            }
            _ => self.error("expected: number"),
        }
    }

    pub fn boolean(&mut self) -> NodeId {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == b"true" => {
                self.next();
                self.create_node(AstNode::True, span_start, span_end)
            }
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == b"false" => {
                self.next();
                self.create_node(AstNode::False, span_start, span_end)
            }
            _ => self.error("expected: boolean"),
        }
    }

    pub fn null(&mut self) -> NodeId {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == b"null" => {
                self.next();

                self.create_node(AstNode::Null, span_start, span_end)
            }
            _ => self.error("expected: null"),
        }
    }

    pub fn variable(&mut self) -> NodeId {
        if self.is_dollar() {
            let span_start = self.position();

            self.next();
            let name = self
                .next()
                .expect("internal error: missing token that was expected to be there");
            let name_end = name.span_end;
            self.create_node(AstNode::Variable, span_start, name_end)
        } else {
            self.error("expected variable")
        }
    }

    pub fn variable_decl(&mut self) -> NodeId {
        let _span = span!();
        if self.is_dollar() {
            let span_start = self.position();

            self.next();
            let name = self
                .next()
                .expect("internal error: missing token that was expected to be there");
            let name_end = name.span_end;
            self.create_node(AstNode::Variable, span_start, name_end)
        } else if self.is_name() {
            let name = self
                .next()
                .expect("internal error: missing token that was expected to be there");
            let name_start = name.span_start;
            let name_end = name.span_end;
            self.create_node(AstNode::Variable, name_start, name_end)
        } else {
            self.error("expected variable")
        }
    }

    pub fn call(&mut self) -> NodeId {
        let _span = span!();
        let mut parts = vec![self.bareword(NameStrictness::AllCharsExcept(&[]))];
        let mut is_head = true;
        // let mut args = vec![];
        let span_start = self.position();

        while self.has_tokens() {
            if self.is_newline() {
                break;
            }

            if self.is_name() && is_head {
                parts.push(self.name());
                continue;
            }

            // TODO: Add flags

            is_head = false;
            let arg_id = self.simple_expression(STRING_STRICT);
            parts.push(arg_id);
        }

        let span_end = self.position();

        self.create_node(AstNode::Call { parts }, span_start, span_end)
    }

    pub fn list_or_table(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let mut is_table = false;
        let mut items = vec![];

        self.lsquare();
        let mut span_end = self.position();

        loop {
            if self.is_rsquare() {
                span_end = self.position();
                self.next();
                break;
            } else if self.is_comma() || self.is_newline() {
                // TODO: should we disallow `[,,,]`?
                self.next();
            } else if self.is_semicolon() {
                if items.len() != 1 {
                    self.error("semicolon to create table should immediately follow headers");
                } else if !matches!(self.compiler.get_node(items[0]), AstNode::List(_)) {
                    self.error_on_node("tables require a list for their headers", items[0])
                }
                self.next();
                is_table = true;
            } else if self.is_simple_expression() {
                items.push(self.simple_expression(STRING_STRICT));
            } else {
                items.push(self.error("expected list item"));
                if self.peek().is_none() {
                    // prevent forever looping if there is no token to put the error on
                    break;
                }
            }
        }

        if is_table {
            let header = items.remove(0);
            self.create_node(
                AstNode::Table {
                    header,
                    rows: items,
                },
                span_start,
                span_end,
            )
        } else {
            self.create_node(AstNode::List(items), span_start, span_end)
        }
    }

    pub fn record_or_closure(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let mut span_end = self.position(); // TODO: make sure we only initialize it expectedly

        let mut is_closure = false;
        let mut first_pass = true;
        // For the record
        let mut items = vec![];

        self.lcurly();
        self.skip_space_and_newlines();

        // Explicit closure case
        if self.is_pipe() {
            let args = Some(self.signature_params(ParamsContext::Pipes));
            let block = self.block(BlockContext::Closure);
            self.rcurly();
            span_end = self.position();

            return self.create_node(
                AstNode::Closure {
                    params: args,
                    block,
                },
                span_start,
                span_end,
            );
        }

        let rollback_point = self.get_rollback_point();
        loop {
            self.skip_space_and_newlines();
            if self.is_rcurly() {
                self.rcurly();
                span_end = self.position();
                break;
            }
            let key = self.simple_expression(STRING_STRICT);
            self.skip_space_and_newlines();
            if first_pass && !self.is_colon() {
                is_closure = true;
                break;
            }
            self.colon();
            self.skip_space_and_newlines();
            let val = self.simple_expression(STRING_STRICT);
            items.push((key, val));
            first_pass = false;

            if self.is_comma() {
                self.comma()
            }
            if self.peek().is_none() {
                // abort when appropriate
                break;
            }
        }

        if is_closure {
            self.apply_rollback(rollback_point);
            let block = self.block(BlockContext::Closure);
            self.rcurly();

            span_end = self.position();

            self.create_node(
                AstNode::Closure {
                    params: None,
                    block,
                },
                span_start,
                span_end,
            )
        } else {
            self.create_node(AstNode::Record { pairs: items }, span_start, span_end)
        }
    }

    pub fn operator(&mut self) -> NodeId {
        match self.peek() {
            Some(Token {
                token_type,
                span_start,
                span_end,
                ..
            }) => match token_type {
                TokenType::Plus => {
                    self.next();
                    self.create_node(AstNode::Plus, span_start, span_end)
                }
                TokenType::PlusPlus => {
                    self.next();
                    self.create_node(AstNode::Append, span_start, span_end)
                }
                TokenType::Dash => {
                    self.next();
                    self.create_node(AstNode::Minus, span_start, span_end)
                }
                TokenType::Asterisk => {
                    self.next();
                    self.create_node(AstNode::Multiply, span_start, span_end)
                }
                TokenType::ForwardSlash => {
                    self.next();
                    self.create_node(AstNode::Divide, span_start, span_end)
                }
                TokenType::LessThan => {
                    self.next();
                    self.create_node(AstNode::LessThan, span_start, span_end)
                }
                TokenType::LessThanEqual => {
                    self.next();
                    self.create_node(AstNode::LessThanOrEqual, span_start, span_end)
                }
                TokenType::GreaterThan => {
                    self.next();
                    self.create_node(AstNode::GreaterThan, span_start, span_end)
                }
                TokenType::GreaterThanEqual => {
                    self.next();
                    self.create_node(AstNode::GreaterThanOrEqual, span_start, span_end)
                }
                TokenType::EqualsEquals => {
                    self.next();
                    self.create_node(AstNode::Equal, span_start, span_end)
                }
                TokenType::ExclamationEquals => {
                    self.next();
                    self.create_node(AstNode::NotEqual, span_start, span_end)
                }
                TokenType::AsteriskAsterisk => {
                    self.next();
                    self.create_node(AstNode::Pow, span_start, span_end)
                }
                TokenType::AmpersandAmpersand => {
                    self.next();
                    self.create_node(AstNode::And, span_start, span_end)
                }
                TokenType::PipePipe => {
                    self.next();
                    self.create_node(AstNode::Or, span_start, span_end)
                }
                TokenType::Equals => {
                    self.next();
                    self.create_node(AstNode::Assignment, span_start, span_end)
                }
                TokenType::PlusEquals => {
                    self.next();
                    self.create_node(AstNode::AddAssignment, span_start, span_end)
                }
                TokenType::DashEquals => {
                    self.next();
                    self.create_node(AstNode::SubtractAssignment, span_start, span_end)
                }
                TokenType::AsteriskEquals => {
                    self.next();
                    self.create_node(AstNode::MultiplyAssignment, span_start, span_end)
                }
                TokenType::ForwardSlashEquals => {
                    self.next();
                    self.create_node(AstNode::DivideAssignment, span_start, span_end)
                }
                TokenType::Name => {
                    let op = &self.compiler.source[span_start..span_end];
                    match op {
                        b"and" => {
                            self.next();
                            self.create_node(AstNode::And, span_start, span_end)
                        }
                        b"or" => {
                            self.next();
                            self.create_node(AstNode::Or, span_start, span_end)
                        }
                        _ => self.error(format!(
                            "Unknown operator: '{}'",
                            String::from_utf8_lossy(op)
                        )),
                    }
                }
                _ => self.error("expected: operator"),
            },
            _ => self.error("expected: operator"),
        }
    }

    pub fn operator_precedence(&mut self, operator: NodeId) -> usize {
        self.compiler.get_node(operator).precedence()
    }

    pub fn spanning(&mut self, from: NodeId, to: NodeId) -> (usize, usize) {
        (
            self.compiler.spans[from.0].start,
            self.compiler.spans[to.0].end,
        )
    }

    pub fn string(&mut self) -> NodeId {
        match self.peek() {
            Some(Token {
                token_type: TokenType::String,
                span_start,
                span_end,
                ..
            }) => {
                self.next();
                self.create_node(AstNode::String, span_start, span_end)
            }
            _ => self.error("expected: string"),
        }
    }

    pub fn name(&mut self) -> NodeId {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
                ..
            }) => {
                self.next();
                self.create_node(AstNode::Name, span_start, span_end)
            }
            _ => self.error("expect name"),
        }
    }

    pub fn bareword(&mut self, name_strictness: NameStrictness) -> NodeId {
        match self.peek_bareword(name_strictness) {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
                ..
            }) => {
                self.next_bareword(name_strictness);
                self.create_node(AstNode::Name, span_start, span_end)
            }
            _ => self.error("expect bareword"),
        }
    }

    pub fn has_tokens(&mut self) -> bool {
        self.peek().is_some()
    }

    pub fn match_expression(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let span_end;

        self.keyword(b"match");
        let target = self.simple_expression(STRING_STRICT);

        let mut match_arms = vec![];

        if !self.is_lcurly() {
            return self.error("expected left curly brace '{'");
        }

        self.lcurly();

        loop {
            if self.is_rcurly() {
                span_end = self.position() + 1;
                self.rcurly();
                break;
            } else if self.is_simple_expression() {
                let pattern = self.simple_expression(STRING_STRICT);

                if !self.is_thick_arrow() {
                    return self.error("expected thick arrow (=>) between match cases");
                }
                self.next();

                let pattern_result = self.simple_expression(NAME_STRICT);

                match_arms.push((pattern, pattern_result));
            } else if self.is_newline() {
                self.next();
            } else {
                return self.error("expected match arm in match");
            }
        }

        self.create_node(AstNode::Match { target, match_arms }, span_start, span_end)
    }

    pub fn if_expression(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let span_end;

        self.keyword(b"if");

        let condition = self.expression();
        while self.is_newline() {
            self.next();
        }
        let then_block = self.block(BlockContext::Curlies);

        while self.is_newline() {
            self.next();
        }

        let else_block = if self.is_keyword(b"else") {
            self.next();
            while self.is_newline() {
                self.next();
            }
            let block = if self.is_keyword(b"if") {
                self.if_expression()
            } else if self.is_keyword(b"match") {
                self.match_expression()
            } else {
                self.block(BlockContext::Curlies)
            };
            span_end = self.get_span_end(block);
            Some(block)
        } else {
            span_end = self.get_span_end(then_block);
            None
        };

        self.create_node(
            AstNode::If {
                condition,
                then_block,
                else_block,
            },
            span_start,
            span_end,
        )
    }

    // directly ripped from `type_params` just changed delimiters
    // FIXME: simplify if appropriate
    pub fn signature_params(&mut self, params_context: ParamsContext) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let span_end;
        let param_list = {
            match params_context {
                ParamsContext::Pipes => self.pipe(),
                ParamsContext::Squares => self.lsquare(),
            }

            let mut output = vec![];

            while self.has_tokens() {
                match params_context {
                    ParamsContext::Pipes => {
                        if self.is_pipe() {
                            break;
                        }
                    }
                    ParamsContext::Squares => {
                        if self.is_rsquare() {
                            break;
                        }
                    }
                }

                if self.is_comma() {
                    self.next();
                    continue;
                }

                let name = self.name();

                let ty = if self.is_colon() {
                    // We have a type
                    self.colon();

                    Some(self.typename())
                } else {
                    None
                };

                let name_span = self.compiler.spans[name.0];
                let param_span_end = if let Some(ty_id) = ty {
                    self.compiler.spans[ty_id.0].end
                } else {
                    name_span.end
                };

                let param =
                    self.create_node(AstNode::Param { name, ty }, name_span.start, param_span_end);

                // output.push(self.name());
                output.push(param);
            }

            span_end = self.position() + 1;

            match params_context {
                ParamsContext::Pipes => self.pipe(),
                ParamsContext::Squares => self.rsquare(),
            }

            output
        };

        self.create_node(AstNode::Params(param_list), span_start, span_end)
    }

    pub fn type_params(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let span_end;
        let param_list = {
            self.less_than();

            let mut output = vec![];

            while self.has_tokens() {
                if self.is_greater_than() {
                    break;
                }

                if self.is_comma() {
                    self.next();
                    continue;
                }

                output.push(self.typename());
            }

            span_end = self.position() + 1;
            self.greater_than();

            output
        };

        self.create_node(AstNode::Params(param_list), span_start, span_end)
    }

    pub fn typename(&mut self) -> NodeId {
        let _span = span!();
        match self.peek() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
                ..
            }) => {
                let name = self.name();
                let mut params = None;
                if self.is_less_than() {
                    // We have generics
                    params = Some(self.type_params());
                }

                let optional = if self.is_question_mark() {
                    // We have an optional type
                    self.next();
                    true
                } else {
                    false
                };

                self.create_node(
                    AstNode::Type {
                        name,
                        params,
                        optional,
                    },
                    span_start,
                    span_end,
                )
            }
            _ => self.error("expect name"),
        }
    }

    pub fn def_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();

        self.keyword(b"def");

        let name = match self.next() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) => self.create_node(AstNode::Name, span_start, span_end),
            Some(Token {
                token_type: TokenType::String,
                span_start,
                span_end,
            }) => self.create_node(AstNode::String, span_start, span_end),
            _ => return self.error("expected def name"),
        };

        let params = self.signature_params(ParamsContext::Squares);
        let block = self.block(BlockContext::Curlies);

        let span_end = self.get_span_end(block);

        self.create_node(
            AstNode::Def {
                name,
                params,
                return_ty: None,
                block,
            },
            span_start,
            span_end,
        )
    }

    pub fn let_statement(&mut self) -> NodeId {
        let _span = span!();
        let is_mutable = false;
        let span_start = self.position();

        self.keyword(b"let");

        let variable_name = self.variable_decl();

        let ty = if self.is_colon() {
            // We have a type
            self.colon();

            Some(self.typename())
        } else {
            None
        };

        self.equals();

        let initializer = self.expression();

        let span_end = self.get_span_end(initializer);

        self.create_node(
            AstNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable,
            },
            span_start,
            span_end,
        )
    }

    pub fn mut_statement(&mut self) -> NodeId {
        let _span = span!();
        let is_mutable = true;
        let span_start = self.position();

        self.keyword(b"mut");

        let variable_name = self.variable_decl();

        let ty = if self.is_colon() {
            // We have a type
            self.colon();

            Some(self.typename())
        } else {
            None
        };

        self.equals();

        let initializer = self.expression();

        let span_end = self.get_span_end(initializer);

        self.create_node(
            AstNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable,
            },
            span_start,
            span_end,
        )
    }

    pub fn keyword(&mut self, keyword: &[u8]) {
        let _span = span!();
        match self.peek() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == keyword => {
                self.next();
            }
            _ => {
                self.error(format!(
                    "expected keyword: {}",
                    String::from_utf8_lossy(keyword)
                ));
            }
        }
    }

    pub fn block(&mut self, context: BlockContext) -> NodeId {
        let _span = span!();
        let span_start = self.position();

        let mut code_body = vec![];
        if let BlockContext::Curlies = context {
            self.lcurly();
        }

        while self.has_tokens() {
            if self.is_rcurly() && context == BlockContext::Curlies {
                self.rcurly();
                break;
            } else if self.is_rcurly() && context == BlockContext::Closure {
                // not responsible for parsing it, yield back to the closure pass
                break;
            } else if self.is_semicolon() || self.is_newline() {
                self.next();
                continue;
            } else if self.is_keyword(b"def") {
                code_body.push(self.def_statement());
            } else if self.is_keyword(b"let") {
                code_body.push(self.let_statement());
            } else if self.is_keyword(b"mut") {
                code_body.push(self.mut_statement());
            } else if self.is_keyword(b"while") {
                code_body.push(self.while_statement());
            } else if self.is_keyword(b"for") {
                code_body.push(self.for_statement());
            } else if self.is_keyword(b"loop") {
                code_body.push(self.loop_statement());
            } else if self.is_keyword(b"return") {
                code_body.push(self.return_statement());
            } else if self.is_keyword(b"continue") {
                code_body.push(self.continue_statement());
            } else if self.is_keyword(b"break") {
                code_body.push(self.break_statement());
            } else {
                let exp_span_start = self.position();
                let expression = self.expression_or_assignment();
                let exp_span_end = self.get_span_end(expression);

                if self.is_semicolon() {
                    // This is a statement, not an expression
                    self.next();
                    code_body.push(self.create_node(
                        AstNode::Statement(expression),
                        exp_span_start,
                        exp_span_end,
                    ))
                } else {
                    code_body.push(expression);
                }
            }
        }

        self.compiler.blocks.push(Block::new(code_body));
        let span_end = self.position();

        self.create_node(
            AstNode::Block(BlockId(self.compiler.blocks.len() - 1)),
            span_start,
            span_end,
        )
    }

    pub fn while_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"while");

        let condition = self.expression();
        let block = self.block(BlockContext::Curlies);
        let span_end = self.get_span_end(block);

        self.create_node(AstNode::While { condition, block }, span_start, span_end)
    }

    pub fn for_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"for");

        let variable = self.variable_decl();
        self.keyword(b"in");

        let range = self.simple_expression(NAME_STRICT);
        let block = self.block(BlockContext::Curlies);
        let span_end = self.get_span_end(block);

        self.create_node(
            AstNode::For {
                variable,
                range,
                block,
            },
            span_start,
            span_end,
        )
    }

    pub fn loop_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"loop");
        let block = self.block(BlockContext::Curlies);
        let span_end = self.get_span_end(block);

        self.create_node(AstNode::Loop { block }, span_start, span_end)
    }

    pub fn return_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        let span_end;

        self.keyword(b"return");

        let ret_val = if self.is_expression() {
            let expr = self.expression();
            span_end = self.get_span_end(expr);
            Some(expr)
        } else {
            span_end = span_start + b"return".len();
            None
        };

        self.create_node(AstNode::Return(ret_val), span_start, span_end)
    }

    pub fn continue_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"continue");
        let span_end = span_start + b"continue".len();

        self.create_node(AstNode::Continue, span_start, span_end)
    }

    pub fn break_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"break");
        let span_end = span_start + b"break".len();

        self.create_node(AstNode::Break, span_start, span_end)
    }

    pub fn is_operator(&mut self) -> bool {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) => {
                &self.compiler.source[span_start..span_end] == b"and"
                    || &self.compiler.source[span_start..span_end] == b"or"
            }
            Some(Token { token_type, .. }) => matches!(
                token_type,
                TokenType::Asterisk
                    | TokenType::AsteriskAsterisk
                    | TokenType::Dash
                    | TokenType::EqualsEquals
                    | TokenType::ExclamationEquals
                    | TokenType::ForwardSlash
                    | TokenType::LessThan
                    | TokenType::LessThanEqual
                    | TokenType::Plus
                    | TokenType::PlusPlus
                    | TokenType::GreaterThan
                    | TokenType::GreaterThanEqual
                    | TokenType::AmpersandAmpersand
                    | TokenType::PipePipe
                    | TokenType::Equals
                    | TokenType::PlusEquals
                    | TokenType::DashEquals
                    | TokenType::AsteriskEquals
                    | TokenType::ForwardSlashEquals
            ),
            _ => false,
        }
    }

    pub fn is_comma(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Comma,
                ..
            })
        )
    }

    pub fn is_lcurly(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::LCurly,
                ..
            })
        )
    }

    pub fn is_rcurly(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::RCurly,
                ..
            })
        )
    }

    pub fn is_lparen(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::LParen,
                ..
            })
        )
    }

    pub fn is_rparen(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::RParen,
                ..
            })
        )
    }

    pub fn is_lsquare(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::LSquare,
                ..
            })
        )
    }

    pub fn is_rsquare(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::RSquare,
                ..
            })
        )
    }

    pub fn is_less_than(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::LessThan,
                ..
            })
        )
    }

    pub fn is_greater_than(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::GreaterThan,
                ..
            })
        )
    }

    pub fn is_pipe(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Pipe,
                ..
            })
        )
    }

    pub fn is_dollar(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Dollar,
                ..
            })
        )
    }

    pub fn is_question_mark(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::QuestionMark,
                ..
            })
        )
    }

    pub fn is_thin_arrow(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::ThinArrow,
                ..
            })
        )
    }

    pub fn is_thick_arrow(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::ThickArrow,
                ..
            })
        )
    }

    // pub fn is_double_pipe(&mut self) -> bool {
    //     matches!(
    //         self.peek(),
    //         Some(Token {
    //             token_type: TokenType::PipePipe,
    //             ..
    //         })
    //     )
    // }

    // pub fn is_double_ampersand(&mut self) -> bool {
    //     matches!(
    //         self.peek(),
    //         Some(Token {
    //             token_type: TokenType::AmpersandAmpersand,
    //             ..
    //         })
    //     )
    // }

    // pub fn is_dash(&mut self) -> bool {
    //     matches!(
    //         self.peek(),
    //         Some(Token {
    //             token_type: TokenType::Dash,
    //             ..
    //         })
    //     )
    // }

    pub fn is_colon(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Colon,
                ..
            })
        )
    }

    pub fn is_newline(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Newline,
                ..
            })
        )
    }

    pub fn is_semicolon(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Semicolon,
                ..
            })
        )
    }

    pub fn is_dot(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Dot,
                ..
            })
        )
    }

    pub fn is_dotdot(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::DotDot,
                ..
            })
        )
    }

    pub fn is_coloncolon(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::ColonColon,
                ..
            })
        )
    }

    pub fn is_number(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Number,
                ..
            })
        )
    }

    pub fn is_string(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::String,
                ..
            })
        )
    }

    pub fn is_keyword(&mut self, keyword: &[u8]) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == keyword
        )
    }

    pub fn is_name(&mut self) -> bool {
        matches!(
            self.peek(),
            Some(Token {
                token_type: TokenType::Name,
                ..
            })
        )
    }

    pub fn is_bareword(&mut self, name_strictness: NameStrictness) -> bool {
        matches!(
            self.peek_bareword(name_strictness),
            Some(Token {
                token_type: TokenType::Name,
                ..
            })
        )
    }

    pub fn is_expression(&mut self) -> bool {
        self.is_simple_expression()
            || self.is_keyword(b"if")
            || self.is_keyword(b"match")
            || self.is_keyword(b"where")
    }

    pub fn is_simple_expression(&mut self) -> bool {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Number,
                ..
            })
            | Some(Token {
                token_type: TokenType::String,
                ..
            })
            | Some(Token {
                token_type: TokenType::LCurly,
                ..
            })
            | Some(Token {
                token_type: TokenType::LSquare,
                ..
            })
            | Some(Token {
                token_type: TokenType::LParen,
                ..
            }) => true,
            Some(Token {
                token_type: TokenType::Dot,
                ..
            }) => true,
            Some(Token {
                token_type: TokenType::Dollar,
                ..
            }) => true,
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == b"true" => true,
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == b"false" => true,
            Some(Token {
                token_type: TokenType::Name,
                span_start,
                span_end,
            }) if &self.compiler.source[span_start..span_end] == b"null" => true,
            Some(Token {
                token_type: TokenType::Name,
                ..
            }) => true,
            _ => false,
        }
    }

    pub fn error_on_node(&mut self, message: impl Into<String>, node_id: NodeId) {
        self.compiler.errors.push(SourceError {
            message: message.into(),
            node_id,
            severity: Severity::Error,
        });
    }

    pub fn error(&mut self, message: impl Into<String>) -> NodeId {
        if let Some(Token {
            span_start,
            span_end,
            ..
        }) = self.next()
        {
            let node_id = self.create_node(AstNode::Garbage, span_start, span_end);
            self.compiler.errors.push(SourceError {
                message: message.into(),
                node_id,
                severity: Severity::Error,
            });

            node_id
        } else {
            let node_id =
                self.create_node(AstNode::Garbage, self.content_length, self.content_length);
            self.compiler.errors.push(SourceError {
                message: message.into(),
                node_id,
                severity: Severity::Error,
            });

            node_id
        }
    }

    pub fn create_node(&mut self, ast_node: AstNode, span_start: usize, span_end: usize) -> NodeId {
        self.compiler.spans.push(Span {
            start: span_start,
            end: span_end,
        });
        self.compiler.push_node(ast_node)
    }

    pub fn lparen(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::LParen,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: left paren '('");
            }
        }
    }

    pub fn rparen(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::RParen,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: right paren ')'");
            }
        }
    }

    pub fn lsquare(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::LSquare,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: left bracket '['");
            }
        }
    }

    pub fn rsquare(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::RSquare,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: right bracket ']'");
            }
        }
    }

    pub fn lcurly(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::LCurly,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: left bracket '{'");
            }
        }
    }

    pub fn rcurly(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::RCurly,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: right bracket '}'");
            }
        }
    }

    pub fn pipe(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Pipe,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: pipe symbol '|'");
            }
        }
    }

    pub fn less_than(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::LessThan,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: less than/left angle bracket '<'");
            }
        }
    }

    pub fn greater_than(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::GreaterThan,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: greater than/right angle bracket '>'");
            }
        }
    }

    pub fn equals(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Equals,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: equals '='");
            }
        }
    }

    pub fn colon(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Colon,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: colon ':'");
            }
        }
    }
    pub fn comma(&mut self) {
        match self.peek() {
            Some(Token {
                token_type: TokenType::Comma,
                ..
            }) => {
                self.next();
            }
            _ => {
                self.error("expected: comma ','");
            }
        }
    }

    pub fn lex_quoted_string(&mut self) -> Option<Token> {
        let span_start = self.span_offset;
        let mut span_position = span_start + 1;
        let mut is_escaped = false;
        while span_position < self.compiler.source.len() {
            if is_escaped {
                is_escaped = false;
            } else if self.compiler.source[span_position] == b'\\' {
                is_escaped = true;
            } else if self.compiler.source[span_position] == b'"'
                || self.compiler.source[span_position] == b'\''
            {
                span_position += 1;
                break;
            }
            span_position += 1;
        }

        self.span_offset = span_position;

        Some(Token {
            token_type: TokenType::String,
            span_start,
            span_end: self.span_offset,
        })
    }

    pub fn lex_number(&mut self) -> Option<Token> {
        let span_start = self.span_offset;
        let mut span_position = span_start;
        while span_position < self.compiler.source.len() {
            if !self.compiler.source[span_position].is_ascii_digit() {
                break;
            }
            span_position += 1;
        }

        // Check to see if we have a hex/octal/binary number
        if span_position < self.compiler.source.len() && self.compiler.source[span_position] == b'x'
        {
            span_position += 1;
            while span_position < self.compiler.source.len() {
                if !self.compiler.source[span_position].is_ascii_hexdigit() {
                    break;
                }
                span_position += 1;
            }
        } else if span_position < self.compiler.source.len()
            && self.compiler.source[span_position] == b'o'
        {
            span_position += 1;
            while span_position < self.compiler.source.len() {
                if !(self.compiler.source[span_position] >= b'0'
                    && self.compiler.source[span_position] <= b'7')
                {
                    break;
                }
                span_position += 1;
            }
        } else if span_position < self.compiler.source.len()
            && self.compiler.source[span_position] == b'b'
        {
            span_position += 1;
            while span_position < self.compiler.source.len() {
                if !(self.compiler.source[span_position] >= b'0'
                    && self.compiler.source[span_position] <= b'1')
                {
                    break;
                }
                span_position += 1;
            }
        } else if span_position < self.compiler.source.len()
            && self.compiler.source[span_position] == b'.'
            && (span_position + 1 < self.compiler.source.len())
            && self.compiler.source[span_position + 1].is_ascii_digit()
        {
            // Looks like a float
            span_position += 1;
            while span_position < self.compiler.source.len() {
                if !self.compiler.source[span_position].is_ascii_digit() {
                    break;
                }
                span_position += 1;
            }

            if span_position < self.compiler.source.len()
                && (self.compiler.source[span_position] == b'e'
                    || self.compiler.source[span_position] == b'E')
            {
                span_position += 1;

                if span_position < self.compiler.source.len()
                    && self.compiler.source[span_position] == b'-'
                {
                    span_position += 1;
                }

                while span_position < self.compiler.source.len() {
                    if !self.compiler.source[span_position].is_ascii_digit() {
                        break;
                    }
                    span_position += 1;
                }
            }
        }

        self.span_offset = span_position;

        Some(Token {
            token_type: TokenType::Number,
            span_start,
            span_end: self.span_offset,
        })
    }

    pub fn is_horizontal_space(&self) -> bool {
        let span_position = self.span_offset;
        let whitespace: &[u8] = b" \t";

        span_position < self.compiler.source.len()
            && whitespace.contains(&self.compiler.source[span_position])
    }

    pub fn skip_space(&mut self) {
        let mut span_position = self.span_offset;
        let whitespace: &[u8] = b" \t";
        while span_position < self.compiler.source.len() {
            if !whitespace.contains(&self.compiler.source[span_position]) {
                break;
            }
            span_position += 1;
        }
        self.span_offset = span_position;
    }

    pub fn skip_space_and_newlines(&mut self) {
        self.skip_space();
        while self.newline().is_some() {
            self.skip_space();
        }
    }

    pub fn newline(&mut self) -> Option<Token> {
        if matches!(
            self.next_token,
            Some(Token {
                token_type: TokenType::Newline,
                ..
            })
        ) {
            let token = self.next_token;
            self.next_token = None;
            self.span_offset = self.next_offset;
            token
        } else {
            let mut span_position = self.span_offset;
            let whitespace: &[u8] = b"\r\n";
            while span_position < self.compiler.source.len() {
                if !whitespace.contains(&self.compiler.source[span_position]) {
                    break;
                }
                span_position += 1;
            }

            if self.span_offset == span_position {
                None
            } else {
                let output = Some(Token {
                    token_type: TokenType::Newline,
                    span_start: self.span_offset,
                    span_end: span_position,
                });
                self.span_offset = span_position;
                output
            }
        }
    }

    pub fn skip_comment(&mut self) {
        let mut span_position = self.span_offset;
        while span_position < self.compiler.source.len()
            && self.compiler.source[span_position] != b'\n'
        {
            span_position += 1;
        }
        self.span_offset = span_position;
    }

    /// More relaxed name lexing
    pub fn lex_bareword(&mut self, name_strictness: NameStrictness) -> Option<Token> {
        let span_start = self.span_offset;
        let mut span_position = span_start;

        match name_strictness {
            NameStrictness::Strict => {
                while span_position < self.compiler.source.len()
                    && !self.compiler.source[span_position].is_ascii_whitespace()
                    && (!self.compiler.source[span_position].is_ascii_punctuation()
                        || self.compiler.source[span_position] == b'_')
                {
                    span_position += 1;
                }
            }
            NameStrictness::AllCharsExcept(chars) => {
                while span_position < self.compiler.source.len()
                    && !self.compiler.source[span_position].is_ascii_whitespace()
                    && !chars.contains(&self.compiler.source[span_position])
                {
                    span_position += 1;
                }
            }
        }

        self.span_offset = span_position;

        Some(Token {
            token_type: TokenType::Name,
            span_start,
            span_end: self.span_offset,
        })
    }

    fn lex_redirect_symbol(&mut self) -> Option<Token> {
        let span_start = self.span_offset;
        let content = &self.compiler.source[span_start..];
        let redirect_tokens: [(&[u8], TokenType); 8] = [
            (b"o>", TokenType::OutGreaterThan),
            (b"o>>", TokenType::OutGreaterGreaterThan),
            (b"e>", TokenType::ErrGreaterThan),
            (b"e>>", TokenType::ErrGreaterGreaterThan),
            (b"o+e>", TokenType::OutErrGreaterThan),
            (b"o+e>>", TokenType::OutErrGreaterGreaterThan),
            (b"e>|", TokenType::ErrGreaterThanPipe),
            (b"o+e>|", TokenType::OutErrGreaterThanPipe),
        ];
        for (bytes, token_type) in redirect_tokens {
            if content.starts_with(bytes) {
                let result = Token {
                    token_type,
                    span_start,
                    span_end: span_start + bytes.len(),
                };
                self.span_offset = result.span_end;
                return Some(result);
            }
        }
        None
    }

    pub fn lex_symbol(&mut self) -> Option<Token> {
        // try span redirection symbol first.
        let result = self.lex_redirect_symbol();
        if result.is_some() {
            return result;
        }

        let span_start = self.span_offset;
        let result = match self.compiler.source[span_start] {
            b'(' => Token {
                token_type: TokenType::LParen,
                span_start,
                span_end: span_start + 1,
            },
            b'[' => Token {
                token_type: TokenType::LSquare,
                span_start,
                span_end: span_start + 1,
            },
            b'{' => Token {
                token_type: TokenType::LCurly,
                span_start,
                span_end: span_start + 1,
            },
            b'<' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::LessThanEqual,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::LessThan,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b')' => Token {
                token_type: TokenType::RParen,
                span_start,
                span_end: span_start + 1,
            },
            b']' => Token {
                token_type: TokenType::RSquare,
                span_start,
                span_end: span_start + 1,
            },
            b'}' => Token {
                token_type: TokenType::RCurly,
                span_start,
                span_end: span_start + 1,
            },
            b'>' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::GreaterThanEqual,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::GreaterThan,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'+' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'+'
                {
                    Token {
                        token_type: TokenType::PlusPlus,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::PlusEquals,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Plus,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'-' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'>'
                {
                    Token {
                        token_type: TokenType::ThinArrow,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::DashEquals,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Dash,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'*' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'*'
                {
                    Token {
                        token_type: TokenType::AsteriskAsterisk,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::AsteriskEquals,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Asterisk,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'/' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'/'
                {
                    Token {
                        token_type: TokenType::ForwardSlashForwardSlash,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::ForwardSlashEquals,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::ForwardSlash,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'=' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::EqualsEquals,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'~'
                {
                    Token {
                        token_type: TokenType::EqualsTilde,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'>'
                {
                    Token {
                        token_type: TokenType::ThickArrow,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Equals,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b':' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b':'
                {
                    Token {
                        token_type: TokenType::ColonColon,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Colon,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'$' => Token {
                token_type: TokenType::Dollar,
                span_start,
                span_end: span_start + 1,
            },
            b';' => Token {
                token_type: TokenType::Semicolon,
                span_start,
                span_end: span_start + 1,
            },
            b'.' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'.'
                {
                    Token {
                        token_type: TokenType::DotDot,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Dot,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'!' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'='
                {
                    Token {
                        token_type: TokenType::ExclamationEquals,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'~'
                {
                    Token {
                        token_type: TokenType::ExclamationTilde,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Exclamation,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'|' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'|'
                {
                    Token {
                        token_type: TokenType::PipePipe,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Pipe,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b'&' => {
                if self.span_offset < (self.compiler.source.len() - 1)
                    && self.compiler.source[self.span_offset + 1] == b'&'
                {
                    Token {
                        token_type: TokenType::AmpersandAmpersand,
                        span_start,
                        span_end: span_start + 2,
                    }
                } else {
                    Token {
                        token_type: TokenType::Ampersand,
                        span_start,
                        span_end: span_start + 1,
                    }
                }
            }
            b',' => Token {
                token_type: TokenType::Comma,
                span_start,
                span_end: span_start + 1,
            },
            b'?' => Token {
                token_type: TokenType::QuestionMark,
                span_start,
                span_end: span_start + 1,
            },
            x => {
                panic!(
                    "Internal compiler error: symbol character mismatched in lexer: {}",
                    x as char
                )
            }
        };

        self.span_offset = result.span_end;

        Some(result)
    }

    pub fn peek(&mut self) -> Option<Token> {
        self.peek_bareword(NameStrictness::Strict)
    }

    pub fn peek_bareword(&mut self, name_strictness: NameStrictness) -> Option<Token> {
        let _span = span!();
        if self.next_token.is_none() {
            let prev_offset = self.span_offset;
            self.next_token = self.next_bareword(name_strictness);
            self.next_offset = self.span_offset;
            self.span_offset = prev_offset;
        }

        self.next_token
    }

    #[allow(clippy::should_implement_trait)]
    pub fn next(&mut self) -> Option<Token> {
        self.next_bareword(NameStrictness::Strict)
    }

    pub fn next_bareword(&mut self, name_strictness: NameStrictness) -> Option<Token> {
        let _span = span!();

        if let Some(token) = self.next_token {
            self.next_token = None;
            self.span_offset = self.next_offset;
            Some(token)
        } else {
            loop {
                if self.span_offset >= self.compiler.source.len() {
                    return None;
                }

                let char = self.compiler.source[self.span_offset];

                if char.is_ascii_digit() {
                    return self.lex_number();
                } else if char == b'"' || char == b'\'' {
                    return self.lex_quoted_string();
                } else if char == b'#' {
                    // Comment
                    self.skip_comment();
                } else if is_symbol(&self.compiler.source[self.span_offset..]) {
                    return self.lex_symbol();
                } else if char == b' ' || char == b'\t' {
                    self.skip_space()
                } else if char == b'\r' || char == b'\n' {
                    return self.newline();
                } else {
                    return self.lex_bareword(name_strictness);
                }
            }
        }
    }

    fn get_rollback_point(&self) -> RollbackPoint {
        self.compiler.get_rollback_point(self.span_offset)
    }

    fn apply_rollback(&mut self, rbp: RollbackPoint) {
        self.span_offset = self.compiler.apply_compiler_rollback(rbp);
        self.next_token = None;
        self.next_offset = self.span_offset;
    }
}

fn is_symbol(source: &[u8]) -> bool {
    let first_byte = source[0];
    if [
        b'+', b'-', b'*', b'/', b'.', b',', b'(', b'[', b'{', b'<', b')', b']', b'}', b'>', b':',
        b';', b'=', b'$', b'|', b'!', b'~', b'&', b'\'', b'"', b'?',
    ]
    .contains(&first_byte)
    {
        return true;
    }

    let redirect_symbols: [&[u8]; 8] = [
        b"o>", b"e>", b"o>>", b"e>>", b"o+e>", b"o+e>>", b"e>|", b"o+e>|",
    ];
    for s in redirect_symbols {
        if source.starts_with(s) {
            return true;
        }
    }

    false
}
