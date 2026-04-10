use crate::ast_nodes::{
    AstNode, BlockId, BlockNode, ExpressionNode, ExpressionNodeId, NameNode, NameNodeId,
    NameOrString, NodeId, NodeIdGetter, NodeIndexer, NodePusher, PipelineNode, StatementNode,
    StatementNodeId, StatementOrExpression, StringNode, StringNodeId, VariableNode, VariableNodeId,
};
use crate::compiler::{Compiler, RollbackPoint, Span};
use crate::errors::{Severity, SourceError};
use crate::lexer::{Token, Tokens};

use tracy_client::span;

pub struct Parser {
    pub compiler: Compiler,
    tokens: Tokens,
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
    /// Fields for a record
    Angles,
}

#[derive(Debug)]
pub enum BarewordContext {
    /// Bareword is a string (e.g., in a list)
    String,
    /// Bareword is a name (e.g., in a call position)
    Call,
}

pub const ASSIGNMENT_PRECEDENCE: usize = 10;

impl AstNode {
    pub fn precedence(&self) -> usize {
        match self {
            AstNode::Pow => 100,
            AstNode::Multiply | AstNode::Divide | AstNode::FloorDiv | AstNode::Modulo => 95,
            AstNode::Plus | AstNode::Minus => 90,
            AstNode::LessThan
            | AstNode::LessThanOrEqual
            | AstNode::GreaterThan
            | AstNode::GreaterThanOrEqual
            | AstNode::Equal
            | AstNode::NotEqual
            | AstNode::RegexMatch
            | AstNode::NotRegexMatch
            | AstNode::In
            | AstNode::Append => 80,
            AstNode::And => 50,
            AstNode::Xor => 45,
            AstNode::Or => 40,
            AstNode::Assignment
            | AstNode::AddAssignment
            | AstNode::SubtractAssignment
            | AstNode::MultiplyAssignment
            | AstNode::DivideAssignment
            | AstNode::AppendAssignment => ASSIGNMENT_PRECEDENCE,
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

    fn get_span_end<T: NodeIdGetter>(&self, node_id: T) -> usize {
        node_id.get_span(&self.compiler).end
    }

    pub fn parse(mut self) -> Compiler {
        let _span = span!();
        let _ = self.block(BlockContext::Bare);

        self.compiler
    }

    pub fn expression(&mut self) -> Option<ExpressionNodeId> {
        let _span = span!();
        self.math_expression(false)
    }

    fn pipeline(
        &mut self,
        first_element: ExpressionNodeId,
        span_start: usize,
    ) -> Option<ExpressionNodeId> {
        let mut expressions = vec![first_element];
        while self.is_pipe() {
            self.pipe();
            // maybe a new time
            if self.is_newline() {
                self.tokens.advance()
            }
            expressions.push(self.expression()?);
        }
        let span_end = self.position();
        let pipeline_id = PipelineNode::new(expressions).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        );
        // pipeline itself is an expression, so we push an expression node for it.
        // It may make more overhead but it simpifies this `pipeline` interface.
        Some(ExpressionNode::Pipeline(pipeline_id).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn pipeline_or_expression_or_assignment(&mut self) -> Option<ExpressionNodeId> {
        // get the first expression
        let _span = span!();
        let span_start = self.position();
        let first = self.math_expression(true)?;
        if let ExpressionNode::BinaryOp { op, .. } = self.compiler.get_node(first) {
            if matches!(
                self.compiler.get_node(*op),
                AstNode::Assignment
                    | AstNode::AddAssignment
                    | AstNode::SubtractAssignment
                    | AstNode::MultiplyAssignment
                    | AstNode::DivideAssignment
                    | AstNode::AppendAssignment
            ) {
                return Some(first);
            }
        }
        // pipeline with one element is an expression actually
        if !self.is_pipe() {
            return Some(first);
        }
        self.pipeline(first, span_start)
    }

    // Can be a pipeline or expression
    pub fn pipeline_or_expression(&mut self) -> Option<ExpressionNodeId> {
        let _span = span!();
        let span_start = self.position();
        let first_id = self.expression()?;
        // pipeline with one element is an expression actually.
        if !self.is_pipe() {
            return Some(first_id);
        }
        self.pipeline(first_id, span_start)
    }

    fn math_expression(&mut self, allow_assignment: bool) -> Option<ExpressionNodeId> {
        let _span = span!();
        let mut expr_stack = Vec::<(NodeId, ExpressionNodeId)>::new();

        let mut last_prec = 1000000;

        let span_start = self.position();

        // Check for special forms
        if self.is_keyword(b"if") {
            return self.if_expression();
        } else if self.is_keyword(b"match") {
            return self.match_expression();
        } else if self.is_keyword(b"try") {
            return self.try_expression();
        }
        // TODO
        // } else if self.is_keyword(b"where") {
        // }

        // Otherwise assume a math expression
        let mut leftmost = self.simple_expression(BarewordContext::Call)?;

        if self.is_equals() {
            if !allow_assignment {
                self.error("assignment found in expression");
            }
            let op = self.operator()?;

            let rhs = self.pipeline_or_expression()?;
            let span_end = self.get_span_end(rhs);

            return Some(
                ExpressionNode::BinaryOp {
                    lhs: leftmost,
                    op,
                    rhs,
                }
                .push_node(
                    Span {
                        start: span_start,
                        end: span_end,
                    },
                    &mut self.compiler,
                ),
            );
        }

        while self.has_tokens() {
            if self.is_operator() {
                let missing_space_before_op = !self.is_horizontal_space();
                let op = self.operator()?;
                let missing_space_after_op = !self.is_horizontal_space();

                if missing_space_before_op {
                    self.error_on_node("missing space before operator", NodeIndexer::General(op));
                }

                if missing_space_after_op {
                    self.error_on_node("missing space after operator", NodeIndexer::General(op));
                }

                let op_prec = self.operator_precedence(op);

                if op_prec == ASSIGNMENT_PRECEDENCE && !allow_assignment {
                    self.error_on_node("assignment found in expression", NodeIndexer::General(op));
                }

                let rhs = if self.is_simple_expression() {
                    self.simple_expression(BarewordContext::Call)?
                } else {
                    self.error("incomplete math expression");
                    return None;
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
                    *lhs = ExpressionNode::BinaryOp { lhs: *lhs, op, rhs }.push_node(
                        Span {
                            start: span_start,
                            end: span_end,
                        },
                        &mut self.compiler,
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

            *lhs = ExpressionNode::BinaryOp { lhs: *lhs, op, rhs }.push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            );
        }

        Some(leftmost)
    }

    pub fn simple_expression(
        &mut self,
        bareword_context: BarewordContext,
    ) -> Option<ExpressionNodeId> {
        let _span = span!();

        // skip comments and newlines
        while self.is_comment() || self.is_newline() {
            self.tokens.advance();
        }

        let span_start = self.position();

        let (token, span) = self.tokens.peek();

        let mut expr = match token {
            Token::LCurly => self.record_or_closure()?,
            Token::LParen => {
                self.tokens.advance();
                if self.tokens.peek_token() == Token::RParen {
                    self.error("use null instead of ()");
                    return None;
                } else {
                    let output = self.expression()?;
                    self.rparen();
                    output
                }
            }
            Token::LSquare => self.list_or_table()?,
            Token::Int => self.advance_node(ExpressionNode::Int, span),
            Token::Float => self.advance_node(ExpressionNode::Float, span),
            Token::DoubleQuotedString => {
                let string_node_id = self.advance_node(StringNode, span);
                self.compiler
                    .string_to_expression
                    .get(&string_node_id)
                    .expect("should exists")
                    .clone()
            }
            Token::SingleQuotedString => {
                let string_node_id = self.advance_node(StringNode, span);
                self.compiler
                    .string_to_expression
                    .get(&string_node_id)
                    .expect("should exists")
                    .clone()
            }
            Token::Dollar => self.variable()?,
            Token::Bareword => match self.compiler.get_span_contents_manual(span.start, span.end) {
                b"true" => self.advance_node(ExpressionNode::True, span),
                b"false" => self.advance_node(ExpressionNode::False, span),
                b"null" => self.advance_node(ExpressionNode::Null, span),
                _ => match bareword_context {
                    BarewordContext::String => {
                        // it's a string, so just make a string.
                        let string_node_id = self.advance_node(StringNode, span);
                        self.compiler
                            .string_to_expression
                            .get(&string_node_id)
                            .expect("should exists")
                            .clone()
                    }
                    BarewordContext::Call => self.call()?,
                },
            },
            _ => {
                self.error("incomplete expression");
                return None;
            }
        };

        loop {
            if self.is_horizontal_space() {
                return Some(expr);
            } else if self.is_dotdot() {
                // Range
                self.tokens.advance();

                if self.is_horizontal_space() {
                    // TODO: implement range from
                    //
                    // TODO: tweak the garbage location.
                    self.error("incomplete range");
                    return Some(expr);
                } else {
                    let rhs = self.simple_expression(BarewordContext::String)?;
                    let span_end = self.get_span_end(rhs);

                    ExpressionNode::Range { lhs: expr, rhs }.push_node(
                        Span {
                            start: span_start,
                            end: span_end,
                        },
                        &mut self.compiler,
                    );
                }
            } else if self.is_dot() {
                // Member access
                self.tokens.advance();

                if self.is_horizontal_space() {
                    self.error("missing path name");
                    return Some(expr);
                }

                let name = self.name()?;
                let field_or_call = if self.is_lparen() {
                    self.variable()?
                } else {
                    self.compiler
                        .name_to_expression
                        .get(&name)
                        .expect("should exist")
                        .clone()
                };
                let span_end = self.get_span_end(field_or_call);

                expr = ExpressionNode::MemberAccess {
                    target: expr,
                    field: field_or_call,
                }
                .push_node(
                    Span {
                        start: span_start,
                        end: span_end,
                    },
                    &mut self.compiler,
                );
            } else {
                return Some(expr);
            }
        }
    }

    pub fn advance_node<T: NodePusher>(&mut self, node: T, span: Span) -> T::Output {
        self.tokens.advance();
        node.push_node(span, &mut self.compiler)
    }

    pub fn variable(&mut self) -> Option<ExpressionNodeId> {
        if self.is_dollar() {
            let span_start = self.position();
            self.tokens.advance();

            if let (Token::Bareword, name_span) = self.tokens.peek() {
                self.tokens.advance();
                let variable_node_id = VariableNode.push_node(
                    Span {
                        start: span_start,
                        end: name_span.end,
                    },
                    &mut self.compiler,
                );
                Some(
                    self.compiler
                        .variable_to_expression
                        .get(&variable_node_id)
                        .expect("should exists")
                        .clone(),
                )
            } else {
                self.error("variable name must be a bareword");
                None
            }
        } else {
            self.error("expected variable starting with '$'");
            None
        }
    }

    pub fn variable_decl(&mut self) -> Option<VariableNodeId> {
        let _span = span!();

        let span_start = self.position();

        if self.is_dollar() {
            self.tokens.advance();
        }

        if let (Token::Bareword, name_span) = self.tokens.peek() {
            self.tokens.advance();
            Some(VariableNode.push_node(
                Span {
                    start: span_start,
                    end: name_span.end,
                },
                &mut self.compiler,
            ))
        } else {
            self.error("variable assignment name must be a bareword");
            None
        }
    }

    pub fn advance_unchecked<T: NodePusher>(&mut self, node: T) -> T::Output {
        let span = self.tokens.peek_span();
        self.tokens.advance();
        node.push_node(span, &mut self.compiler)
    }

    pub fn call(&mut self) -> Option<ExpressionNodeId> {
        let _span = span!();
        let mut head = vec![self.call_name()];
        let mut parts = vec![];
        let mut is_head = true;
        let span_start = self.position();

        while self.has_tokens() {
            if self.is_newline() {
                break;
            }

            if self.is_name() && is_head {
                head.push(self.advance_unchecked(NameNode));
                continue;
            }

            // TODO: Add flags

            is_head = false;
            let arg_id = self.simple_expression(BarewordContext::String)?;
            parts.push(arg_id);
        }

        let span_end = self.position();

        Some(ExpressionNode::Call { head, parts }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn list_or_table(&mut self) -> Option<ExpressionNodeId> {
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
                } else if !matches!(self.compiler.get_node(items[0]), ExpressionNode::List(_)) {
                    self.error_on_node(
                        "tables require a list for their headers",
                        NodeIndexer::Expression(items[0]),
                    )
                }
                self.tokens.advance();
                is_table = true;
            } else if self.is_simple_expression() {
                items.push(self.simple_expression(BarewordContext::String)?);
            } else {
                self.error("expected list item");
                if self.is_eof() {
                    // prevent forever looping if there is no token to put the error on
                    break;
                }
            }
        }

        if is_table {
            let header = items.remove(0);
            Some(
                ExpressionNode::Table {
                    header,
                    rows: items,
                }
                .push_node(
                    Span {
                        start: span_start,
                        end: span_end,
                    },
                    &mut self.compiler,
                ),
            )
        } else {
            Some(ExpressionNode::List(items).push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ))
        }
    }

    pub fn record_or_closure(&mut self) -> Option<ExpressionNodeId> {
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
            let params = self.signature_params(ParamsContext::Pipes);
            let block = self.block(BlockContext::Closure)?;
            self.rcurly();
            span_end = self.position();

            return Some(ExpressionNode::Closure { params, block }.push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ));
        }

        let rollback_point = self.get_rollback_point();
        loop {
            self.skip_newlines();
            if self.is_rcurly() {
                self.rcurly();
                span_end = self.position();
                break;
            }
            let key = self.simple_expression(BarewordContext::String)?;
            self.skip_newlines();
            if first_pass && !self.is_colon() {
                is_closure = true;
                break;
            }
            self.colon();
            self.skip_newlines();
            let val = self.simple_expression(BarewordContext::String)?;
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
            let block = self.block(BlockContext::Closure)?;
            self.rcurly();

            span_end = self.position();

            Some(
                ExpressionNode::Closure {
                    params: None,
                    block,
                }
                .push_node(
                    Span {
                        start: span_start,
                        end: span_end,
                    },
                    &mut self.compiler,
                ),
            )
        } else {
            Some(ExpressionNode::Record { pairs: items }.push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ))
        }
    }

    pub fn operator(&mut self) -> Option<NodeId> {
        let (token, span) = self.tokens.peek();

        match token {
            Token::Plus => Some(self.advance_node(AstNode::Plus, span)),
            Token::PlusPlus => Some(self.advance_node(AstNode::Append, span)),
            Token::Dash => Some(self.advance_node(AstNode::Minus, span)),
            Token::Asterisk => Some(self.advance_node(AstNode::Multiply, span)),
            Token::ForwardSlash => Some(self.advance_node(AstNode::Divide, span)),
            Token::ForwardSlashForwardSlash => Some(self.advance_node(AstNode::FloorDiv, span)),
            Token::LessThan => Some(self.advance_node(AstNode::LessThan, span)),
            Token::LessThanEqual => Some(self.advance_node(AstNode::LessThanOrEqual, span)),
            Token::GreaterThan => Some(self.advance_node(AstNode::GreaterThan, span)),
            Token::GreaterThanEqual => Some(self.advance_node(AstNode::GreaterThanOrEqual, span)),
            Token::EqualsEquals => Some(self.advance_node(AstNode::Equal, span)),
            Token::ExclamationEquals => Some(self.advance_node(AstNode::NotEqual, span)),
            Token::EqualsTilde => Some(self.advance_node(AstNode::RegexMatch, span)),
            Token::ExclamationTilde => Some(self.advance_node(AstNode::NotRegexMatch, span)),
            Token::AsteriskAsterisk => Some(self.advance_node(AstNode::Pow, span)),
            Token::Equals => Some(self.advance_node(AstNode::Assignment, span)),
            Token::PlusEquals => Some(self.advance_node(AstNode::AddAssignment, span)),
            Token::DashEquals => Some(self.advance_node(AstNode::SubtractAssignment, span)),
            Token::AsteriskEquals => Some(self.advance_node(AstNode::MultiplyAssignment, span)),
            Token::ForwardSlashEquals => Some(self.advance_node(AstNode::DivideAssignment, span)),
            Token::PlusPlusEquals => Some(self.advance_node(AstNode::AppendAssignment, span)),
            Token::Bareword => match self.compiler.get_span_contents_manual(span.start, span.end) {
                b"mod" => Some(self.advance_node(AstNode::Modulo, span)),
                b"in" => Some(self.advance_node(AstNode::In, span)),
                b"and" => Some(self.advance_node(AstNode::And, span)),
                b"xor" => Some(self.advance_node(AstNode::Xor, span)),
                b"or" => Some(self.advance_node(AstNode::Or, span)),
                op => {
                    self.error(format!(
                        "Unknown operator: '{}'",
                        String::from_utf8_lossy(op)
                    ));
                    None
                }
            },
            _ => {
                self.error("expected: operator");
                None
            }
        }
    }

    pub fn operator_precedence(&mut self, operator: NodeId) -> usize {
        self.compiler.get_node(operator).precedence()
    }

    pub fn spanning<T: NodeIdGetter>(&mut self, from: T, to: T) -> (usize, usize) {
        (
            from.get_span(&self.compiler).start,
            to.get_span(&self.compiler).end,
        )
    }

    pub fn string(&mut self) -> Option<StringNodeId> {
        match self.tokens.peek() {
            (Token::DoubleQuotedString, span) => Some(self.advance_node(StringNode, span)),
            (Token::SingleQuotedString, span) => Some(self.advance_node(StringNode, span)),
            _ => {
                self.error("expected: string");
                None
            }
        }
    }

    pub fn name(&mut self) -> Option<NameNodeId> {
        match self.tokens.peek() {
            (Token::Bareword, span) => Some(self.advance_node(NameNode, span)),
            _ => {
                self.error("expected: name");
                None
            }
        }
    }

    pub fn call_name(&mut self) -> NameNodeId {
        let (mut token, mut span) = self.tokens.peek();

        loop {
            if [Token::Eof, Token::Newline].contains(&token) {
                break;
            }

            self.tokens.advance();
            let (next_token, next_span) = self.tokens.peek();

            if next_span.start > span.end {
                // horizontal whitespace
                break;
            }

            token = next_token;
            span.end = next_span.end;
        }

        NameNode.push_node(span, &mut self.compiler)
    }

    pub fn has_tokens(&mut self) -> bool {
        self.tokens.peek_token() != Token::Eof
    }

    pub fn match_expression(&mut self) -> Option<ExpressionNodeId> {
        let _span = span!();
        let span_start = self.position();
        let span_end;

        self.keyword(b"match");
        let target = self.simple_expression(BarewordContext::String)?;

        let mut match_arms = vec![];

        if !self.is_lcurly() {
            self.error("expected left curly brace '{'");
            return None;
        }

        self.lcurly();

        loop {
            if self.is_rcurly() {
                span_end = self.position() + 1;
                self.rcurly();
                break;
            } else if self.is_simple_expression() {
                let pattern = self.simple_expression(BarewordContext::String)?;

                if !self.is_thick_arrow() {
                    self.error("expected thick arrow (=>) between match cases");
                    return None;
                }
                self.tokens.advance();

                let pattern_result = self.simple_expression(BarewordContext::String)?;

                if self.is_comma() {
                    self.tokens.advance();
                }

                match_arms.push((pattern, pattern_result));
            } else if self.is_newline() {
                self.tokens.advance();
            } else {
                self.error("expected match arm in match");
                return None;
            }
        }

        Some(ExpressionNode::Match { target, match_arms }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn if_expression(&mut self) -> Option<ExpressionNodeId> {
        let _span = span!();
        let span_start = self.position();
        let span_end;

        self.keyword(b"if");

        let condition = self.expression()?;
        self.skip_newlines();

        let then_block = self.block(BlockContext::Curlies)?;
        self.skip_newlines();

        let else_block = if self.is_keyword(b"else") {
            self.tokens.advance();
            self.skip_newlines();

            let block = if self.is_keyword(b"if") {
                let exp = self.if_expression()?;
                span_end = self.get_span_end(exp);
                NodeIndexer::Expression(exp)
            } else if self.is_keyword(b"match") {
                let match_exp = self.match_expression()?;
                span_end = self.get_span_end(match_exp);
                NodeIndexer::Expression(match_exp)
            } else {
                let exp = self.block(BlockContext::Curlies)?;
                span_end = self.get_span_end(exp);
                NodeIndexer::Block(exp)
            };
            Some(block)
        } else {
            span_end = self.get_span_end(then_block);
            None
        };

        Some(
            ExpressionNode::If {
                condition,
                then_block,
                else_block,
            }
            .push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ),
        )
    }

    pub fn try_expression(&mut self) -> Option<ExpressionNodeId> {
        let _span = span!();
        let span_start = self.position();

        self.keyword(b"try");

        let try_block = self.block(BlockContext::Curlies)?;
        let mut span_end = self.get_span_end(try_block);
        self.skip_newlines();

        // catch
        let catch_block = if self.is_keyword(b"catch") {
            self.tokens.advance();
            self.skip_newlines();

            let block = self.block(BlockContext::Curlies)?;
            span_end = self.get_span_end(block);

            Some(block)
        } else {
            None
        };

        // finally
        let finally_block = if self.is_keyword(b"finally") {
            self.tokens.advance();
            self.skip_newlines();

            let block = self.block(BlockContext::Curlies)?;
            span_end = self.get_span_end(block);
            Some(block)
        } else {
            None
        };

        Some(
            ExpressionNode::Try {
                try_block,
                catch_block,
                finally_block,
            }
            .push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ),
        )
    }

    // directly ripped from `type_params` just changed delimiters
    // FIXME: simplify if appropriate
    pub fn signature_params(&mut self, params_context: ParamsContext) -> Option<NodeId> {
        let _span = span!();
        let span_start = self.position();
        let span_end;
        let param_list = {
            match params_context {
                ParamsContext::Pipes => self.pipe(),
                ParamsContext::Squares => self.lsquare(),
                ParamsContext::Angles => self.less_than(),
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
                    ParamsContext::Angles => {
                        if self.is_greater_than() {
                            break;
                        }
                    }
                }

                if self.is_comma() {
                    self.tokens.advance();
                    continue;
                }

                let name = self.name()?;

                let ty = if self.is_colon() {
                    // We have a type
                    self.colon();

                    Some(self.typename()?)
                } else {
                    None
                };

                let name_span = name.get_span(&self.compiler);
                let param_span_end = if let Some(ty_id) = ty {
                    ty_id.get_span(&self.compiler).end
                } else {
                    name_span.end
                };

                let param = AstNode::Param { name, ty }.push_node(
                    Span {
                        start: name_span.start,
                        end: param_span_end,
                    },
                    &mut self.compiler,
                );

                // output.push(self.name());
                output.push(param);
            }

            span_end = self.position() + 1;

            match params_context {
                ParamsContext::Pipes => self.pipe(),
                ParamsContext::Squares => self.rsquare(),
                ParamsContext::Angles => self.greater_than(),
            }

            output
        };

        Some(AstNode::Params(param_list).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn type_params(&mut self) -> NodeId {
        let _span = span!();
        let span_start = self.position();
        self.less_than();

        let mut param_list = vec![];

        while self.has_tokens() {
            if self.is_greater_than() {
                break;
            }

            if self.is_comma() {
                self.tokens.advance();
                continue;
            }

            if let Some(name) = self.name() {
                param_list.push(name)
            }
        }

        let span_end = self.position() + 1;
        self.greater_than();

        AstNode::TypeParams(param_list).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        )
    }

    pub fn type_args(&mut self) -> Option<NodeId> {
        let _span = span!();
        let span_start = self.position();
        let span_end;
        let arg_list = {
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

                output.push(self.typename()?);
            }

            span_end = self.position() + 1;
            self.greater_than();

            output
        };

        Some(AstNode::TypeArgs(arg_list).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn typename(&mut self) -> Option<NodeId> {
        let _span = span!();
        if let (Token::Bareword, span) = self.tokens.peek() {
            let name = self.name()?;
            let name_text = name.get_span_contents(&self.compiler);

            if name_text == b"record" {
                let fields = self.signature_params(ParamsContext::Angles)?;
                let optional = if self.is_question_mark() {
                    // We have an optional type
                    self.tokens.advance();
                    true
                } else {
                    false
                };
                let span_end = self.position();
                return Some(AstNode::RecordType { fields, optional }.push_node(
                    Span {
                        start: span.start,
                        end: span_end,
                    },
                    &mut self.compiler,
                ));
            }

            let mut args = None;
            if self.is_less_than() {
                // We have generics
                args = Some(self.type_args()?);
            }

            let optional = if self.is_question_mark() {
                // We have an optional type
                self.tokens.advance();
                true
            } else {
                false
            };

            Some(
                AstNode::Type {
                    name,
                    args,
                    optional,
                }
                .push_node(
                    Span {
                        start: span.start,
                        end: span.end,
                    },
                    &mut self.compiler,
                ),
            )
        } else {
            self.error("expect name");
            None
        }
    }

    pub fn in_out_type(&mut self) -> Option<NodeId> {
        let _span = span!();
        let span_start = self.position();

        let in_ty = self.typename()?;
        self.thin_arrow();
        let out_ty = self.typename()?;

        let span_end = self.position();
        Some(AstNode::InOutType(in_ty, out_ty).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn in_out_types(&mut self) -> Option<NodeId> {
        let _span = span!();
        self.colon();

        if self.is_lsquare() {
            let span_start = self.position();

            self.tokens.advance();

            let mut output = vec![];
            while self.has_tokens() {
                if self.is_rsquare() {
                    break;
                }

                if self.is_comma() {
                    self.tokens.advance();
                    continue;
                }

                output.push(self.in_out_type()?);
            }

            self.rsquare();
            let span_end = self.position();

            Some(AstNode::InOutTypes(output).push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ))
        } else {
            let ty = self.in_out_type()?;
            let span = ty.get_span(&self.compiler);
            Some(AstNode::InOutType(ty, ty).push_node(
                Span {
                    start: span.start,
                    end: span.end,
                },
                &mut self.compiler,
            ))
        }
    }

    pub fn def_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();

        self.keyword(b"def");
        let mut has_env_flag = false;
        let mut has_wrapped_flag = false;

        // maybe `--env` or `--wrapped`
        while let (Token::DashDash, _) = self.tokens.peek() {
            self.tokens.advance();
            match self.tokens.peek() {
                // let's make sure that the word is `env` or `wrapped`
                (Token::Bareword, span) => {
                    let flag_name = self.compiler.get_span_contents_manual(span.start, span.end);
                    if flag_name == b"env" {
                        if has_env_flag {
                            self.error("duplicated --env flag");
                            return None;
                        }
                        has_env_flag = true;
                    } else if flag_name == b"wrapped" {
                        if has_wrapped_flag {
                            self.error("duplicated --wrapped flag");
                            return None;
                        }
                        has_wrapped_flag = true
                    } else {
                        self.error("expect --env or --wrapped");
                        return None;
                    }
                    self.tokens.advance();
                }
                _ => {
                    self.error("incomplete flag name");
                    return None;
                }
            }
        }

        let name = match self.tokens.peek() {
            (Token::Bareword, span) => NameOrString::Name(self.advance_node(NameNode, span)),
            (Token::DoubleQuotedString | Token::SingleQuotedString, span) => {
                NameOrString::String(self.advance_node(StringNode, span))
            }
            _ => {
                self.error("expected def name");
                return None;
            }
        };

        let type_params = if self.is_less_than() {
            Some(self.type_params())
        } else {
            None
        };

        let params = self.signature_params(ParamsContext::Squares)?;
        let in_out_types = if self.is_colon() {
            Some(self.in_out_types()?)
        } else {
            None
        };
        let block = self.block(BlockContext::Curlies)?;

        let span_end = self.get_span_end(block);

        Some(
            StatementNode::Def {
                name,
                type_params,
                params,
                in_out_types,
                block,
                env: has_env_flag,
                wrapped: has_wrapped_flag,
            }
            .push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ),
        )
    }

    pub fn extern_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();

        self.keyword(b"extern");

        let name = match self.tokens.peek() {
            (Token::Bareword, span) => NameOrString::Name(self.advance_node(NameNode, span)),
            (Token::DoubleQuotedString | Token::SingleQuotedString, span) => {
                NameOrString::String(self.advance_node(StringNode, span))
            }
            _ => {
                self.error("expected def name");
                return None;
            }
        };

        let params = self.signature_params(ParamsContext::Squares)?;
        let span_end = self.position();

        Some(StatementNode::Extern { name, params }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    // TODO: Deduplicate code between let/mut/const assignments
    pub fn let_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let is_mutable = false;
        let span_start = self.position();

        self.keyword(b"let");

        let variable_name = self.variable_decl()?;

        let ty = if self.is_colon() {
            // We have a type
            self.colon();

            Some(self.typename()?)
        } else {
            None
        };

        self.equals();

        let initializer = self.pipeline_or_expression()?;

        let span_end = self.get_span_end(initializer);

        Some(
            StatementNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable,
            }
            .push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ),
        )
    }

    // TODO: Deduplicate code between let/mut/const assignments
    pub fn mut_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let is_mutable = true;
        let span_start = self.position();

        self.keyword(b"mut");

        let variable_name = self.variable_decl()?;

        let ty = if self.is_colon() {
            // We have a type
            self.colon();

            Some(self.typename()?)
        } else {
            None
        };

        self.equals();

        let initializer = self.pipeline_or_expression()?;

        let span_end = self.get_span_end(initializer);

        Some(
            StatementNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable,
            }
            .push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ),
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

    pub fn block(&mut self, context: BlockContext) -> Option<BlockId> {
        let _span = span!();
        let span_start = self.position();

        let mut code_body = vec![];
        if let BlockContext::Curlies = context {
            self.lcurly();
        }

        // NOTE: Here we make early returns on statements, so there is only one error pop up.
        // We can also consider parsing as much as possible and collect all errors, but that might
        // cause a lot of cascading errors, so let's see how this goes first.
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
                code_body.push(StatementOrExpression::Statement(self.def_statement()?));
            } else if self.is_keyword(b"let") {
                code_body.push(StatementOrExpression::Statement(self.let_statement()?));
            } else if self.is_keyword(b"mut") {
                code_body.push(StatementOrExpression::Statement(self.mut_statement()?));
            } else if self.is_keyword(b"while") {
                code_body.push(StatementOrExpression::Statement(self.while_statement()?));
            } else if self.is_keyword(b"for") {
                code_body.push(StatementOrExpression::Statement(self.for_statement()?));
            } else if self.is_keyword(b"loop") {
                code_body.push(StatementOrExpression::Statement(self.loop_statement()?));
            } else if self.is_keyword(b"return") {
                code_body.push(StatementOrExpression::Statement(self.return_statement()?));
            } else if self.is_keyword(b"continue") {
                code_body.push(StatementOrExpression::Statement(self.continue_statement()));
            } else if self.is_keyword(b"break") {
                code_body.push(StatementOrExpression::Statement(self.break_statement()));
            } else if self.is_keyword(b"alias") {
                code_body.push(StatementOrExpression::Statement(self.alias_statement()?));
            } else if self.is_keyword(b"extern") {
                code_body.push(StatementOrExpression::Statement(self.extern_statement()?));
            } else {
                let exp_span_start = self.position();
                let pipeline = self.pipeline_or_expression_or_assignment()?;
                let exp_span_end = self.get_span_end(pipeline);

                if self.is_semicolon() {
                    // This is a statement, not an expression
                    self.tokens.advance();
                    code_body.push(StatementOrExpression::Statement(
                        StatementNode::Expr(pipeline).push_node(
                            Span {
                                start: exp_span_start,
                                end: exp_span_end,
                            },
                            &mut self.compiler,
                        ),
                    ));
                } else {
                    code_body.push(StatementOrExpression::Expression(pipeline));
                }
            }
        }

        let span_end = self.position();
        Some(BlockNode { nodes: code_body }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn while_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"while");

        if self.is_operator() {
            // TODO: flag parsing
            self.error("WIP: Flags on while are not supported yet");
            self.tokens.advance();
        }

        let condition = self.expression()?;
        let block = self.block(BlockContext::Curlies)?;
        let span_end = self.get_span_end(block);

        Some(StatementNode::While { condition, block }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn for_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"for");

        let variable = self.variable_decl()?;
        self.keyword(b"in");

        let range = self.simple_expression(BarewordContext::String)?;
        let block = self.block(BlockContext::Curlies)?;
        let span_end = self.get_span_end(block);

        Some(
            StatementNode::For {
                variable,
                range,
                block,
            }
            .push_node(
                Span {
                    start: span_start,
                    end: span_end,
                },
                &mut self.compiler,
            ),
        )
    }

    pub fn loop_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"loop");
        let block = self.block(BlockContext::Curlies)?;
        let span_end = self.get_span_end(block);

        Some(StatementNode::Loop { block }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn return_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();
        let span_end;

        self.keyword(b"return");

        let ret_val = if self.is_expression() {
            let expr = self.expression()?;
            span_end = self.get_span_end(expr);
            Some(expr)
        } else {
            span_end = span_start + b"return".len();
            None
        };

        Some(StatementNode::Return(ret_val).push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn continue_statement(&mut self) -> StatementNodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"continue");
        let span_end = span_start + b"continue".len();

        StatementNode::Continue.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        )
    }

    pub fn break_statement(&mut self) -> StatementNodeId {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"break");
        let span_end = span_start + b"break".len();

        StatementNode::Break.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        )
    }

    pub fn alias_statement(&mut self) -> Option<StatementNodeId> {
        let _span = span!();
        let span_start = self.position();
        self.keyword(b"alias");
        let new_name = if self.is_string() {
            NameOrString::String(self.string()?)
        } else {
            NameOrString::Name(self.name()?)
        };
        self.equals();
        let (old_name, span_end) = if self.is_string() {
            let s = self.string()?;
            (NameOrString::String(s), self.get_span_end(s))
        } else {
            let s = self.name()?;
            (NameOrString::Name(s), s.get_span(&self.compiler).end)
        };
        Some(StatementNode::Alias { new_name, old_name }.push_node(
            Span {
                start: span_start,
                end: span_end,
            },
            &mut self.compiler,
        ))
    }

    pub fn is_operator(&mut self) -> bool {
        let (token, span) = self.tokens.peek();

        match token {
            Token::Plus
            | Token::PlusPlus
            | Token::Dash
            | Token::Asterisk
            | Token::ForwardSlash
            | Token::ForwardSlashForwardSlash
            | Token::LessThan
            | Token::LessThanEqual
            | Token::GreaterThan
            | Token::GreaterThanEqual
            | Token::EqualsEquals
            | Token::ExclamationEquals
            | Token::EqualsTilde
            | Token::ExclamationTilde
            | Token::AsteriskAsterisk
            | Token::Equals
            | Token::PlusEquals
            | Token::DashEquals
            | Token::AsteriskEquals
            | Token::ForwardSlashEquals
            | Token::PlusPlusEquals => true,
            Token::Bareword => {
                let op = self.compiler.get_span_contents_manual(span.start, span.end);
                op == b"mod" || op == b"in" || op == b"and" || op == b"xor" || op == b"or"
            }
            _ => false,
        }
    }

    pub fn is_equals(&mut self) -> bool {
        self.tokens.peek_token() == Token::Equals
    }

    pub fn is_comma(&mut self) -> bool {
        self.tokens.peek_token() == Token::Comma
    }

    pub fn is_lcurly(&mut self) -> bool {
        self.tokens.peek_token() == Token::LCurly
    }

    pub fn is_rcurly(&mut self) -> bool {
        self.tokens.peek_token() == Token::RCurly
    }

    pub fn is_lparen(&mut self) -> bool {
        self.tokens.peek_token() == Token::LParen
    }

    pub fn is_rparen(&mut self) -> bool {
        self.tokens.peek_token() == Token::RParen
    }

    pub fn is_lsquare(&mut self) -> bool {
        self.tokens.peek_token() == Token::LSquare
    }

    pub fn is_rsquare(&mut self) -> bool {
        self.tokens.peek_token() == Token::RSquare
    }

    pub fn is_less_than(&mut self) -> bool {
        self.tokens.peek_token() == Token::LessThan
    }

    pub fn is_greater_than(&mut self) -> bool {
        self.tokens.peek_token() == Token::GreaterThan
    }

    pub fn is_pipe(&mut self) -> bool {
        self.tokens.peek_token() == Token::Pipe
    }

    pub fn is_dollar(&mut self) -> bool {
        self.tokens.peek_token() == Token::Dollar
    }

    pub fn is_comment(&mut self) -> bool {
        self.tokens.peek_token() == Token::Comment
    }

    pub fn is_question_mark(&mut self) -> bool {
        self.tokens.peek_token() == Token::QuestionMark
    }

    pub fn is_thin_arrow(&mut self) -> bool {
        self.tokens.peek_token() == Token::ThinArrow
    }

    pub fn is_thick_arrow(&mut self) -> bool {
        self.tokens.peek_token() == Token::ThickArrow
    }

    pub fn is_colon(&mut self) -> bool {
        self.tokens.peek_token() == Token::Colon
    }

    pub fn is_newline(&mut self) -> bool {
        self.tokens.peek_token() == Token::Newline
    }

    pub fn is_semicolon(&mut self) -> bool {
        self.tokens.peek_token() == Token::Semicolon
    }

    pub fn is_dot(&mut self) -> bool {
        self.tokens.peek_token() == Token::Dot
    }

    pub fn is_dotdot(&mut self) -> bool {
        self.tokens.peek_token() == Token::DotDot
    }

    pub fn is_coloncolon(&mut self) -> bool {
        self.tokens.peek_token() == Token::ColonColon
    }

    pub fn is_int(&mut self) -> bool {
        self.tokens.peek_token() == Token::Int
    }

    pub fn is_float(&mut self) -> bool {
        self.tokens.peek_token() == Token::Float
    }

    pub fn is_string(&mut self) -> bool {
        self.tokens.peek_token() == Token::DoubleQuotedString
            || self.tokens.peek_token() == Token::SingleQuotedString
    }

    pub fn is_keyword(&mut self, keyword: &[u8]) -> bool {
        if let (Token::Bareword, span) = self.tokens.peek() {
            self.compiler.get_span_contents_manual(span.start, span.end) == keyword
        } else {
            false
        }
    }

    pub fn is_name(&mut self) -> bool {
        self.tokens.peek_token() == Token::Bareword
    }

    pub fn is_eof(&mut self) -> bool {
        self.tokens.peek_token() == Token::Eof
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

    pub fn error_on_node(&mut self, message: impl Into<String>, node_id: NodeIndexer) {
        self.compiler.errors.push(SourceError {
            message: message.into(),
            node_id,
            severity: Severity::Error,
        });
    }

    pub fn error(&mut self, message: impl Into<String>) {
        let (token, span) = self.tokens.peek();

        if token != Token::Eof {
            self.tokens.advance();
        }

        let node_id = NodeIndexer::General(AstNode::Garbage.push_node(span, &mut self.compiler));
        self.compiler.errors.push(SourceError {
            message: message.into(),
            node_id,
            severity: Severity::Error,
        });
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

    pub fn thin_arrow(&mut self) {
        if self.is_thin_arrow() {
            self.tokens.advance();
        } else {
            self.error("expected: thin arrow '->'");
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
