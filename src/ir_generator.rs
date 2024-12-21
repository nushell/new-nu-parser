use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::parser::{AstNode, NodeId};
use nu_protocol::ast::{Math, Operator};
use nu_protocol::ir::{Instruction, IrBlock, Literal};
use nu_protocol::{RegId, Span};
use std::collections::HashMap;
use std::sync::Arc;

/// Generates IR (Intermediate Representation) from nu AST.
pub struct IrGenerator<'a> {
    // Immutable reference to a compiler after the typechecker pass
    compiler: &'a Compiler,
    block: IrBlock,
    errors: Vec<SourceError>,
}

impl<'a> IrGenerator<'a> {
    pub fn new(compiler: &'a Compiler) -> Self {
        Self {
            compiler,
            block: IrBlock {
                instructions: vec![],
                spans: vec![],
                data: Arc::new([]),
                ast: vec![],
                comments: vec![],
                register_count: 0,
                file_count: 0,
            },
            errors: vec![],
        }
    }

    /// Generates the IR from the given state of the compiler.
    /// After this is called, use `block` and `errors` to get the result.
    pub fn generate(&mut self) {
        let mut instructions = vec![];
        let mut next_free_reg = RegId::new(0);
        let mut last_reg = RegId::new(0);
        let mut node_to_reg: HashMap<NodeId, RegId> = HashMap::new();
        for (i, ast_node) in self.compiler.ast_nodes.iter().enumerate() {
            match ast_node {
                AstNode::Plus | AstNode::Multiply => {}
                AstNode::Int => {
                    let val = match std::str::from_utf8(self.compiler.get_span_contents(NodeId(i)))
                    {
                        Ok(val) => val,
                        Err(err) => {
                            self.error(
                                format!("failed to convert a node to string: {err}"),
                                NodeId(i),
                            );
                            return;
                        }
                    };
                    let val = match val.parse::<i64>() {
                        Ok(val) => val,
                        Err(err) => {
                            self.error(
                                format!("failed to convert a node to string: {err}"),
                                NodeId(i),
                            );
                            return;
                        }
                    };
                    instructions.push(Instruction::LoadLiteral {
                        dst: next_free_reg,
                        lit: Literal::Int(val),
                    });
                    eprintln!("{} => {}", i, next_free_reg);
                    node_to_reg.insert(NodeId(i), next_free_reg);
                    next_free_reg = RegId::new(next_free_reg.get() + 1);
                }
                AstNode::BinaryOp { lhs, op, rhs } => {
                    let l = match node_to_reg.get(lhs) {
                        Some(l) => l,
                        None => {
                            self.error("failed to find register for given node".to_string(), *lhs);
                            return;
                        }
                    };
                    let r = match node_to_reg.get(rhs) {
                        Some(r) => r,
                        None => {
                            self.error("failed to find register for given node".to_string(), *lhs);
                            return;
                        }
                    };
                    let o = match self.node_to_operator(*op) {
                        Ok(o) => o,
                        Err(e) => {
                            self.errors.push(e);
                            return;
                        }
                    };
                    instructions.push(Instruction::BinaryOp {
                        lhs_dst: *l,
                        op: o,
                        rhs: *r,
                    });
                    last_reg = *l;
                    node_to_reg.insert(NodeId(i), *l);
                }
                _ => {
                    self.error(format!("node {:?} not suported yet", ast_node), NodeId(i));
                }
            }
        }

        instructions.push(Instruction::Return { src: last_reg });

        let mut spans = vec![];
        let mut ast = vec![];
        for _ in 0..instructions.len() {
            spans.push(Span { start: 0, end: 0 });
            ast.push(None);
        }
        self.block = IrBlock {
            instructions,
            spans,
            data: Arc::new([]),
            ast,
            comments: Vec::new(),
            register_count: next_free_reg.get(),
            file_count: 0,
        };
    }

    /// Returns generated IR block.
    ///
    /// Call `generate` before using this method and ensure there are no errors.
    pub fn block(self) -> IrBlock {
        self.block
    }

    /// Returns errors encountered during IR generation step.
    ///
    /// Call `generate` before using this method.
    pub fn errors(&self) -> &Vec<SourceError> {
        &self.errors
    }

    /// Displays the state of the IR generator.
    /// The output can be used for human debugging and for snapshot tests.
    pub fn display_state(&self) -> String {
        let mut result = String::new();
        result.push_str("==== IR ====\n");
        result.push_str(&format!("register_count: {}\n", self.block.register_count));
        result.push_str(&format!("file_count: {}\n", self.block.register_count));

        for (idx, instruction) in self.block.instructions.iter().enumerate() {
            result.push_str(&format!("{}: {:?}\n", idx, instruction));
        }

        if !self.errors.is_empty() {
            result.push_str("==== IR ERRORS ====\n");
            for error in &self.errors {
                result.push_str(&format!(
                    "{:?} (NodeId {}): {}\n",
                    error.severity, error.node_id.0, error.message
                ));
            }
        }
        result
    }

    fn node_to_operator(&self, node_id: NodeId) -> Result<Operator, SourceError> {
        match self.compiler.get_node(node_id) {
            AstNode::Plus => Ok(Operator::Math(Math::Plus)),
            AstNode::Multiply => Ok(Operator::Math(Math::Multiply)),
            node => Err(SourceError {
                message: format!("unrecognized operator {:?}", node),
                node_id,
                severity: Severity::Error,
            }),
        }
    }

    fn error(&mut self, message: impl Into<String>, node_id: NodeId) {
        self.errors.push(SourceError {
            message: message.into(),
            node_id,
            severity: Severity::Error,
        });
    }
}
