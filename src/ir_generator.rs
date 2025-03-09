use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::parser::{AstNode, Expr, NodeId};
use nu_protocol::ast::{Math, Operator};
use nu_protocol::ir::{Instruction, IrBlock, Literal};
use nu_protocol::{RegId, Span};

/// Generates IR (Intermediate Representation) from nu AST.
pub struct IrGenerator<'a> {
    // Immutable reference to a compiler after the typechecker pass
    compiler: &'a Compiler,
    errors: Vec<SourceError>,
    block: IrBlock,
}

impl<'a> IrGenerator<'a> {
    pub fn new(compiler: &'a Compiler) -> Self {
        Self {
            compiler,
            errors: Default::default(),
            block: IrBlock {
                instructions: Default::default(),
                spans: Default::default(),
                data: Default::default(),
                ast: Default::default(),
                comments: Default::default(),
                register_count: 0,
                file_count: 0,
            },
        }
    }

    /// Generates the IR from the given state of the compiler.
    /// After this is called, use `block` and `errors` to get the result.
    pub fn generate(&mut self) {
        if self.compiler.ast_nodes.is_empty() {
            return;
        }
        let node_id = NodeId(self.compiler.ast_nodes.len() - 1);
        let Some(reg) = self.generate_node(node_id) else {
            return;
        };
        self.add_instruction(node_id, Instruction::Return { src: reg });
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

    /// Prints the internal state to standard output.
    pub fn print(&self) {
        let output = self.display_state();
        print!("{output}");
    }

    /// Displays the state of the IR generator.
    /// The output can be used for human debugging and for snapshot tests.
    pub fn display_state(&self) -> String {
        let mut result = String::new();
        result.push_str("==== IR ====\n");
        result.push_str(&format!("register_count: {}\n", self.block.register_count));
        result.push_str(&format!("file_count: {}\n", self.block.file_count));

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

    // Returns unused register.
    fn next_register(&mut self) -> RegId {
        let r = RegId::new(self.block.register_count);
        self.block.register_count += 1;
        r
    }

    fn generate_node(&mut self, node_id: NodeId) -> Option<RegId> {
        let ast_node = &self.compiler.ast_nodes[node_id.0];
        match ast_node {
            AstNode::Expr(Expr::Int) => {
                let next_reg = self.next_register();
                let val = self.compiler.node_as_i64(node_id);
                self.add_instruction(
                    node_id,
                    Instruction::LoadLiteral {
                        dst: next_reg,
                        lit: Literal::Int(val),
                    },
                );
                Some(next_reg)
            }
            AstNode::Expr(Expr::Block(block_id)) => {
                let block = &self.compiler.blocks[block_id.0];
                let mut last = None;
                for id in &block.nodes {
                    last = self.generate_node(*id);
                    last?;
                }
                last
            }
            AstNode::Expr(Expr::BinaryOp { lhs, op, rhs }) => {
                let l = self.generate_node(*lhs)?;
                let r = self.generate_node(*rhs)?;
                let o = self.node_to_operator(*op)?;
                self.add_instruction(
                    node_id,
                    Instruction::BinaryOp {
                        lhs_dst: l,
                        op: o,
                        rhs: r,
                    },
                );
                Some(l)
            }
            _ => {
                self.error(format!("node {:?} not suported yet", ast_node), node_id);
                None
            }
        }
    }

    fn add_instruction(&mut self, node_id: NodeId, instruction: Instruction) {
        let span = self.compiler.get_span(node_id);
        self.block.spans.push(Span {
            start: span.start,
            end: span.end,
        });
        self.block.ast.push(None);
        self.block.instructions.push(instruction);
    }

    fn node_to_operator(&mut self, node_id: NodeId) -> Option<Operator> {
        match self.compiler.get_node(node_id) {
            AstNode::Plus => Some(Operator::Math(Math::Plus)),
            AstNode::Multiply => Some(Operator::Math(Math::Multiply)),
            node => {
                self.error(format!("unrecognized operator {:?}", node), node_id);
                None
            }
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
