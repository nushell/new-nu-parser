use crate::compiler::{Compiler, RollbackPoint, Span};
use crate::errors::{Severity, SourceError};
use crate::lexer::{TokenType3, Tokens};
use crate::naming::{BarewordContext, NAME_STRICT, STRING_STRICT};

use tracy_client::span;

pub struct Parser {
    pub compiler: Compiler,
    tokens: Tokens,
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
    pub fn new(compiler: Compiler, tokens: Tokens) -> Self {
        Self { compiler, tokens }
    }

    fn position(&mut self) -> usize {
        self.tokens.peek_span().start
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

        if self.is_equals() {
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

        // skip comments and newlines
        while self.is_comment() || self.is_newline() {
            self.tokens.advance();
        }

        let span_start = self.position();

        let (token, span) = self.tokens.peek();

        let mut expr = match token {
            TokenType3::LCurly => self.record_or_closure(),
            TokenType3::LParen => {
                self.lparen();
                let output = self.expression();
                self.rparen();
                output
            }
            TokenType3::LSquare => self.list_or_table(),
            TokenType3::Int => self.advance_node(AstNode::Int, span),
            TokenType3::Float => self.advance_node(AstNode::Float, span),
            TokenType3::DoubleQuotedString => self.advance_node(AstNode::String, span),
            TokenType3::SingleQuotedString => self.advance_node(AstNode::String, span),
            TokenType3::Dollar => self.variable(),
            TokenType3::Bareword => {
                match self.compiler.get_span_contents_manual(span.start, span.end) {
                    b"true" => self.advance_node(AstNode::True, span),
                    b"false" => self.advance_node(AstNode::False, span),
                    b"null" => self.advance_node(AstNode::Null, span),
                    _ => {
                        if bareword_context.as_string {
                            let node_id = self.name();
                            self.compiler.ast_nodes[node_id.0] = AstNode::String;
                            node_id
                        } else {
                            self.call()
                        }
                    }
                }
            }
            _ => self.error("incomplete expression"),
        };

        loop {
            if self.is_horizontal_space() {
                return expr;
            } else if self.is_dotdot() {
                // Range
                self.tokens.advance();

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
                self.tokens.advance();

                if self.is_horizontal_space() {
                    self.error("missing path name");
                    return expr;
                }

                let name = self.name();

                let field_or_call = if self.is_lparen() {
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

    pub fn advance_node(&mut self, node: AstNode, span: Span) -> NodeId {
        self.tokens.advance();
        self.create_node(node, span.start, span.end)
    }

    pub fn variable(&mut self) -> NodeId {
        if self.is_dollar() {
            let span_start = self.position();
            self.tokens.advance();

            if let (TokenType3::Bareword, name_span) = self.tokens.peek() {
                self.tokens.advance();
                self.create_node(AstNode::Variable, span_start, name_span.end)
            } else {
                self.error("variable name must be a bareword")
            }
        } else {
            self.error("expected variable starting with '$'")
        }
    }

    pub fn variable_decl(&mut self) -> NodeId {
        let _span = span!();

        let span_start = self.position();

        if self.is_dollar() {
            self.tokens.advance();
        }

        if let (TokenType3::Bareword, name_span) = self.tokens.peek() {
            self.tokens.advance();
            self.create_node(AstNode::Variable, span_start, name_span.end)
        } else {
            self.error("variable assignment name must be a bareword")
        }
    }

    pub fn call(&mut self) -> NodeId {
        let _span = span!();
        let mut parts = vec![self.name()];
        let mut is_head = true;
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
                self.tokens.advance();
                break;
            } else if self.is_comma() || self.is_newline() {
                // TODO: should we disallow `[,,,]`?
                self.tokens.advance();
            } else if self.is_semicolon() {
                if items.len() != 1 {
                    self.error("semicolon to create table should immediately follow headers");
                } else if !matches!(self.compiler.get_node(items[0]), AstNode::List(_)) {
                    self.error_on_node("tables require a list for their headers", items[0])
                }
                self.tokens.advance();
                is_table = true;
            } else if self.is_simple_expression() {
                items.push(self.simple_expression(STRING_STRICT));
            } else {
                items.push(self.error("expected list item"));
                if self.is_eof() {
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
        self.skip_newlines();

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
            self.skip_newlines();
            if self.is_rcurly() {
                self.rcurly();
                span_end = self.position();
                break;
            }
            let key = self.simple_expression(STRING_STRICT);
            self.skip_newlines();
            if first_pass && !self.is_colon() {
                is_closure = true;
                break;
            }
            self.colon();
            self.skip_newlines();
            let val = self.simple_expression(STRING_STRICT);
            items.push((key, val));
            first_pass = false;

            if self.is_comma() {
                self.comma()
            }
            if self.is_eof() {
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
        let (token, span) = self.tokens.peek();

        match token {
            TokenType3::Plus => self.advance_node(AstNode::Plus, span),
            TokenType3::PlusPlus => self.advance_node(AstNode::Append, span),
            TokenType3::Dash => self.advance_node(AstNode::Minus, span),
            TokenType3::Asterisk => self.advance_node(AstNode::Multiply, span),
            TokenType3::ForwardSlash => self.advance_node(AstNode::Divide, span),
            TokenType3::LessThan => self.advance_node(AstNode::LessThan, span),
            TokenType3::LessThanEqual => self.advance_node(AstNode::LessThanOrEqual, span),
            TokenType3::GreaterThan => self.advance_node(AstNode::GreaterThan, span),
            TokenType3::GreaterThanEqual => self.advance_node(AstNode::GreaterThanOrEqual, span),
            TokenType3::EqualsEquals => self.advance_node(AstNode::Equal, span),
            TokenType3::ExclamationEquals => self.advance_node(AstNode::NotEqual, span),
            TokenType3::AsteriskAsterisk => self.advance_node(AstNode::Pow, span),
            TokenType3::Equals => self.advance_node(AstNode::Assignment, span),
            TokenType3::PlusEquals => self.advance_node(AstNode::AddAssignment, span),
            TokenType3::DashEquals => self.advance_node(AstNode::SubtractAssignment, span),
            TokenType3::AsteriskEquals => self.advance_node(AstNode::MultiplyAssignment, span),
            TokenType3::ForwardSlashEquals => self.advance_node(AstNode::DivideAssignment, span),
            TokenType3::Bareword => {
                match self.compiler.get_span_contents_manual(span.start, span.end) {
                    b"and" => self.advance_node(AstNode::And, span),
                    b"or" => self.advance_node(AstNode::Or, span),
                    op => self.error(format!(
                        "Unknown operator: '{}'",
                        String::from_utf8_lossy(op)
                    )),
                }
            }
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
        match self.tokens.peek() {
            (TokenType3::DoubleQuotedString, span) => self.advance_node(AstNode::String, span),
            (TokenType3::SingleQuotedString, span) => self.advance_node(AstNode::String, span),
            _ => self.error("expected: string"),
        }
    }

    pub fn name(&mut self) -> NodeId {
        match self.tokens.peek() {
            (TokenType3::Bareword, span) => self.advance_node(AstNode::Name, span),
            _ => self.error("expected: name"),
        }
    }

    pub fn has_tokens(&mut self) -> bool {
        self.tokens.peek_token() != TokenType3::Eof
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
                self.tokens.advance();

                let pattern_result = self.simple_expression(NAME_STRICT);

                match_arms.push((pattern, pattern_result));
            } else if self.is_newline() {
                self.tokens.advance();
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
        self.skip_newlines();

        let then_block = self.block(BlockContext::Curlies);
        self.skip_newlines();

        let else_block = if self.is_keyword(b"else") {
            self.tokens.advance();
            self.skip_newlines();

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
                    self.tokens.advance();
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
                    self.tokens.advance();
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
        if let (TokenType3::Bareword, span) = self.tokens.peek() {
            let name = self.name();
            let mut params = None;
            if self.is_less_than() {
                // We have generics
                params = Some(self.type_params());
            }

            let optional = if self.is_question_mark() {
                // We have an optional type
                self.tokens.advance();
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
                span.start,
                span.end,
            )
        } else {
            self.error("expect name")
        }
    }

    pub fn def_statement(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();

        self.keyword(b"def");

        let name = match self.tokens.peek() {
            (TokenType3::Bareword, span) => self.advance_node(AstNode::Name, span),
            (TokenType3::DoubleQuotedString | TokenType3::SingleQuotedString, span) => {
                self.advance_node(AstNode::String, span)
            }
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

    // TODO: Deduplicate code between let/mut/const assignments
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

    // TODO: Deduplicate code between let/mut/const assignments
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
        if self.is_keyword(keyword) {
            self.tokens.advance();
        } else {
            self.error(format!(
                "expected keyword: {}",
                String::from_utf8_lossy(keyword)
            ));
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
            } else if self.is_semicolon() || self.is_newline() || self.is_comment() {
                self.tokens.advance();
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
                    self.tokens.advance();
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
        let (token, span) = self.tokens.peek();

        match token {
            TokenType3::Plus
            | TokenType3::PlusPlus
            | TokenType3::Dash
            | TokenType3::Asterisk
            | TokenType3::ForwardSlash
            | TokenType3::LessThan
            | TokenType3::LessThanEqual
            | TokenType3::GreaterThan
            | TokenType3::GreaterThanEqual
            | TokenType3::EqualsEquals
            | TokenType3::ExclamationEquals
            | TokenType3::AsteriskAsterisk
            | TokenType3::Equals
            | TokenType3::PlusEquals
            | TokenType3::DashEquals
            | TokenType3::AsteriskEquals
            | TokenType3::ForwardSlashEquals => true,
            TokenType3::Bareword => {
                let op = self.compiler.get_span_contents_manual(span.start, span.end);
                op == b"and" || op == b"or"
            }
            _ => false,
        }
    }

    pub fn is_equals(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Equals
    }

    pub fn is_comma(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Comma
    }

    pub fn is_lcurly(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::LCurly
    }

    pub fn is_rcurly(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::RCurly
    }

    pub fn is_lparen(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::LParen
    }

    pub fn is_rparen(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::RParen
    }

    pub fn is_lsquare(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::LSquare
    }

    pub fn is_rsquare(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::RSquare
    }

    pub fn is_less_than(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::LessThan
    }

    pub fn is_greater_than(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::GreaterThan
    }

    pub fn is_pipe(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Pipe
    }

    pub fn is_dollar(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Dollar
    }

    pub fn is_comment(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Comment
    }

    pub fn is_question_mark(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::QuestionMark
    }

    pub fn is_thin_arrow(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::ThinArrow
    }

    pub fn is_thick_arrow(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::ThickArrow
    }

    pub fn is_colon(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Colon
    }

    pub fn is_newline(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Newline
    }

    pub fn is_semicolon(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Semicolon
    }

    pub fn is_dot(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Dot
    }

    pub fn is_dotdot(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::DotDot
    }

    pub fn is_coloncolon(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::ColonColon
    }

    pub fn is_int(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Int
    }

    pub fn is_float(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Float
    }

    pub fn is_string(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::DoubleQuotedString
            || self.tokens.peek_token() == TokenType3::SingleQuotedString
    }

    pub fn is_keyword(&mut self, keyword: &[u8]) -> bool {
        if let (TokenType3::Bareword, span) = self.tokens.peek() {
            self.compiler.get_span_contents_manual(span.start, span.end) == keyword
        } else {
            false
        }
    }

    pub fn is_name(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Bareword
    }

    pub fn is_eof(&mut self) -> bool {
        self.tokens.peek_token() == TokenType3::Eof
    }

    pub fn is_horizontal_space(&self) -> bool {
        let span_position = self.tokens.peek_span().start;
        let whitespace: &[u8] = b" \t";

        span_position > 0 && whitespace.contains(&self.compiler.source[span_position - 1])
    }

    pub fn is_expression(&mut self) -> bool {
        self.is_simple_expression()
            || self.is_keyword(b"if")
            || self.is_keyword(b"match")
            || self.is_keyword(b"where")
    }

    pub fn is_simple_expression(&mut self) -> bool {
        self.is_string()
            || self.is_int()
            || self.is_float()
            || self.is_lcurly()
            || self.is_lsquare()
            || self.is_lparen()
            || self.is_dot()
            || self.is_dollar()
            || self.is_keyword(b"true")
            || self.is_keyword(b"false")
            || self.is_keyword(b"null")
            || self.is_name()
    }

    pub fn error_on_node(&mut self, message: impl Into<String>, node_id: NodeId) {
        self.compiler.errors.push(SourceError {
            message: message.into(),
            node_id,
            severity: Severity::Error,
        });
    }

    pub fn error(&mut self, message: impl Into<String>) -> NodeId {
        let (token, span) = self.tokens.peek();

        if token != TokenType3::Eof {
            self.tokens.advance();
        }

        let node_id = self.create_node(AstNode::Garbage, span.start, span.end);
        self.compiler.errors.push(SourceError {
            message: message.into(),
            node_id,
            severity: Severity::Error,
        });

        node_id
    }

    pub fn create_node(&mut self, ast_node: AstNode, span_start: usize, span_end: usize) -> NodeId {
        self.compiler.spans.push(Span {
            start: span_start,
            end: span_end,
        });
        self.compiler.push_node(ast_node)
    }

    pub fn lparen(&mut self) {
        if self.is_lparen() {
            self.tokens.advance();
        } else {
            self.error("expected: left paren '('");
        }
    }

    pub fn rparen(&mut self) {
        if self.is_rparen() {
            self.tokens.advance();
        } else {
            self.error("expected: right paren ')'");
        }
    }

    pub fn lsquare(&mut self) {
        if self.is_lsquare() {
            self.tokens.advance();
        } else {
            self.error("expected: left bracket '['");
        }
    }

    pub fn rsquare(&mut self) {
        if self.is_rsquare() {
            self.tokens.advance();
        } else {
            self.error("expected: right bracket ']'");
        }
    }

    pub fn lcurly(&mut self) {
        if self.is_lcurly() {
            self.tokens.advance();
        } else {
            self.error("expected: left bracket '{'");
        }
    }

    pub fn rcurly(&mut self) {
        if self.is_rcurly() {
            self.tokens.advance();
        } else {
            self.error("expected: right bracket '}'");
        }
    }

    pub fn pipe(&mut self) {
        if self.is_pipe() {
            self.tokens.advance();
        } else {
            self.error("expected: pipe symbol '|'");
        }
    }

    pub fn less_than(&mut self) {
        if self.is_less_than() {
            self.tokens.advance();
        } else {
            self.error("expected: less than/left angle bracket '<'");
        }
    }

    pub fn greater_than(&mut self) {
        if self.is_greater_than() {
            self.tokens.advance();
        } else {
            self.error("expected: greater than/right angle bracket '>'");
        }
    }

    pub fn equals(&mut self) {
        if self.is_equals() {
            self.tokens.advance();
        } else {
            self.error("expected: equals '='");
        }
    }

    pub fn colon(&mut self) {
        if self.is_colon() {
            self.tokens.advance();
        } else {
            self.error("expected: colon ':'");
        }
    }

    pub fn comma(&mut self) {
        if self.is_comma() {
            self.tokens.advance();
        } else {
            self.error("expected: comma ','");
        }
    }

    pub fn skip_newlines(&mut self) {
        while self.is_newline() {
            self.tokens.advance();
        }
    }

    fn get_rollback_point(&self) -> RollbackPoint {
        self.compiler.get_rollback_point(self.tokens.pos())
    }

    fn apply_rollback(&mut self, rbp: RollbackPoint) {
        let token_pos = self.compiler.apply_compiler_rollback(rbp);
        self.tokens.set_pos(token_pos);
    }
}
