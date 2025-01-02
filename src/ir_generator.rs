use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::parser::{AstNode, NodeId};
use nu_protocol::ast::{Math, Operator};
use nu_protocol::ir::{Instruction, IrBlock, Literal};
use nu_protocol::{RegId, Span};

/// Generates IR (Intermediate Representation) from nu AST.
pub struct IrGenerator<'a> {
    // Immutable reference to a compiler after the typechecker pass
    compiler: &'a Compiler,
    errors: Vec<SourceError>,

    instructions: Vec<Instruction>,
    register_count: u32,
    file_count: u32,
}

impl<'a> IrGenerator<'a> {
    pub fn new(compiler: &'a Compiler) -> Self {
        Self {
            compiler,
            errors: Default::default(),
            instructions: Default::default(),
            register_count: 0,
            file_count: 0,
        }
    }

    /// Generates the IR from the given state of the compiler.
    /// After this is called, use `block` and `errors` to get the result.
    pub fn generate(&mut self) {
        if self.compiler.ast_nodes.is_empty() {
            return;
        }
        let Some(reg) = self.generate_node(NodeId(self.compiler.ast_nodes.len() - 1)) else {
            return;
        };
        self.instructions.push(Instruction::Return { src: reg });
    }

    /// Returns generated IR block.
    ///
    /// Call `generate` before using this method and ensure there are no errors.
    pub fn block(self) -> IrBlock {
        // TODO: properly generate the spans
        // TODO: figure out what to do with AST, as this parser has different
        // representation of AST than the old parser.
        let mut spans = vec![];
        let mut ast = vec![];
        for _ in 0..(self.instructions.len()) {
            spans.push(Span { start: 0, end: 0 });
            ast.push(None);
        }
        IrBlock {
            instructions: self.instructions,
            spans,
            data: Default::default(),
            ast,
            comments: Default::default(),
            register_count: self.register_count,
            file_count: self.file_count,
        }
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
        result.push_str(&format!("register_count: {}\n", self.register_count));
        result.push_str(&format!("file_count: {}\n", self.file_count));

        for (idx, instruction) in self.instructions.iter().enumerate() {
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
        let r = RegId::new(self.register_count);
        self.register_count += 1;
        r
    }

    fn span_to_string(&mut self, node_id: NodeId) -> Option<String> {
        match std::str::from_utf8(self.compiler.get_span_contents(node_id)) {
            Ok(val) => Some(val.to_string()),
            Err(err) => {
                self.error(
                    format!("failed to convert a node to string: {err}"),
                    node_id,
                );
                None
            }
        }
    }

    fn span_to_i64(&mut self, node_id: NodeId) -> Option<i64> {
        match self.span_to_string(node_id)?.parse::<i64>() {
            Ok(val) => Some(val),
            Err(err) => {
                self.error(
                    format!("failed to convert a node to string: {err}"),
                    node_id,
                );
                None
            }
        }
    }

    fn generate_node(&mut self, node_id: NodeId) -> Option<RegId> {
        let ast_node = &self.compiler.ast_nodes[node_id.0];
        match ast_node {
            AstNode::Int => {
                let next_reg = self.next_register();
                let val = self.span_to_i64(node_id)?;
                self.instructions.push(Instruction::LoadLiteral {
                    dst: next_reg,
                    lit: Literal::Int(val),
                });
                Some(next_reg)
            }
            AstNode::Block(block_id) => {
                let block = &self.compiler.blocks[block_id.0];
                let mut last = None;
                for id in &block.nodes {
                    last = self.generate_node(*id);
                    last?;
                }
                last
            }
            AstNode::BinaryOp { lhs, op, rhs } => {
                let l = self.generate_node(*lhs)?;
                let r = self.generate_node(*rhs)?;
                let o = self.node_to_operator(*op)?;
                self.instructions.push(Instruction::BinaryOp {
                    lhs_dst: l,
                    op: o,
                    rhs: r,
                });
                Some(l)
            }
            _ => {
                self.error(format!("node {:?} not suported yet", ast_node), node_id);
                None
            }
        }
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
