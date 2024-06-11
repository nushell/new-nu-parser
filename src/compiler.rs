use crate::resolver::{Frame, NameBindings, ScopeId, VarId, Variable};
use crate::typechecker::{TypeId, Types};
use crate::{
    errors::SourceError,
    parser::{AstNode, Block, NodeId},
};
use std::collections::HashMap;

pub struct RollbackPoint {
    idx_span_start: usize,
    idx_nodes: usize,
    idx_errors: usize,
    idx_blocks: usize,
    span_offset: usize,
}

#[derive(Debug, Clone, Copy)]
pub struct Span {
    pub start: usize,
    pub end: usize,
}

#[derive(Debug)]
pub struct Compiler {
    // Core information, indexed by NodeId:
    pub spans: Vec<Span>,
    pub ast_nodes: Vec<AstNode>,
    pub node_types: Vec<TypeId>,
    // node_lifetimes: Vec<AllocationLifetime>,
    pub blocks: Vec<Block>, // Blocks, indexed by BlockId
    pub source: Vec<u8>,
    pub file_offsets: Vec<(String, usize, usize)>, // fname, start, end

    // name bindings:
    /// All scope frames ever entered, indexed by ScopeId
    pub scope: Vec<Frame>,
    /// Stack of currently entered scope frames
    pub scope_stack: Vec<ScopeId>,
    /// Variables, indexed by VarId
    pub variables: Vec<Variable>,
    /// Mapping of variable's name node -> Variable
    pub var_resolution: HashMap<NodeId, VarId>,

    // Definitions:
    // indexed by FunId
    // pub functions: Vec<Function>,
    // indexed by TypeId
    // types: Vec<Type>,

    // Use/def
    // pub call_resolution: HashMap<NodeId, CallTarget>,
    // pub type_resolution: HashMap<NodeId, TypeId>,
    pub errors: Vec<SourceError>,
}

impl Default for Compiler {
    fn default() -> Self {
        Self::new()
    }
}

impl Compiler {
    pub fn new() -> Self {
        Self {
            spans: vec![],
            ast_nodes: vec![],
            node_types: vec![],
            blocks: vec![],
            source: vec![],
            file_offsets: vec![],

            scope: vec![],
            scope_stack: vec![],
            variables: vec![],
            var_resolution: HashMap::new(),

            // variables: vec![],
            // functions: vec![],
            // types: vec![],

            // call_resolution: HashMap::new(),
            // var_resolution: HashMap::new(),
            // type_resolution: HashMap::new(),
            errors: vec![],
        }
    }

    pub fn print(&self) {
        let output = self.display_state();
        print!("{output}");
    }

    #[allow(clippy::format_collect)]
    pub fn display_state(&self) -> String {
        let mut result = "==== COMPILER ====\n".to_string();

        for (idx, ast_node) in self.ast_nodes.iter().enumerate() {
            result.push_str(&format!(
                "{}: {:?} ({} to {})\n",
                idx, ast_node, self.spans[idx].start, self.spans[idx].end
            ));
        }

        if !self.errors.is_empty() {
            result.push_str("==== COMPILER ERRORS ====\n");
            for error in &self.errors {
                result.push_str(&format!(
                    "{:?} (NodeId {}): {}\n",
                    error.severity, error.node_id.0, error.message
                ));
            }
        }

        result
    }

    pub fn merge_name_bindings(&mut self, name_bindings: NameBindings) {
        self.scope.extend(name_bindings.scope);
        self.scope_stack.extend(name_bindings.scope_stack);
        self.variables.extend(name_bindings.variables);
        self.var_resolution.extend(name_bindings.var_resolution);
        self.errors.extend(name_bindings.errors);
    }

    pub fn merge_types(&mut self, types: Types) {
        self.node_types.extend(types.node_types);
        self.errors.extend(types.errors);
    }

    pub fn add_file(&mut self, fname: &str, contents: &[u8]) {
        let span_offset = self.source.len();

        self.file_offsets
            .push((fname.to_string(), span_offset, span_offset + contents.len()));

        self.source.extend_from_slice(contents);
    }

    pub fn span_offset(&self) -> usize {
        self.source.len()
    }

    pub fn get_node(&self, node_id: NodeId) -> &AstNode {
        &self.ast_nodes[node_id.0]
    }

    pub fn get_node_mut(&mut self, node_id: NodeId) -> &mut AstNode {
        &mut self.ast_nodes[node_id.0]
    }

    pub fn push_node(&mut self, ast_node: AstNode) -> NodeId {
        self.ast_nodes.push(ast_node);

        NodeId(self.ast_nodes.len() - 1)
    }

    pub fn get_rollback_point(&self, span_offset: usize) -> RollbackPoint {
        RollbackPoint {
            idx_span_start: self.spans.len(),
            idx_nodes: self.ast_nodes.len(),
            idx_errors: self.errors.len(),
            idx_blocks: self.blocks.len(),
            span_offset,
        }
    }

    pub fn apply_compiler_rollback(&mut self, rbp: RollbackPoint) -> usize {
        self.blocks.truncate(rbp.idx_blocks);
        self.ast_nodes.truncate(rbp.idx_nodes);
        self.errors.truncate(rbp.idx_errors);
        self.spans.truncate(rbp.idx_span_start);

        rbp.span_offset
    }

    /// Get span of node
    pub fn get_span(&self, node_id: NodeId) -> Span {
        *self
            .spans
            .get(node_id.0)
            .expect("internal error: missing span of node")
    }

    /// Get the source contents of a span of a node
    pub fn get_span_contents(&self, node_id: NodeId) -> &[u8] {
        let span = self.get_span(node_id);
        self.source
            .get(span.start..span.end)
            .expect("internal error: missing source of span")
    }
}
