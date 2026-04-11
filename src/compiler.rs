use crate::ast_nodes::{
    AstNode, BlockNode, ExpressionNode, ExpressionNodeId, NameNode, NameNodeId, NameOrVariable,
    NodeIdGetter, NodeIndexer, NodePusher, PipelineId, PipelineNode, StatementNode,
    StatementNodeId, StringNode, StringNodeId, VariableNode, VariableNodeId,
};
use crate::errors::SourceError;
use crate::protocol::Command;
use crate::resolver::{
    DeclId, Frame, NameBindings, ScopeId, TypeDecl, TypeDeclId, VarId, Variable,
};
use crate::typechecker::{TypeId, Types};
use std::collections::HashMap;

pub struct RollbackPoint {
    idx_ast_nodes: usize,
    idx_name_nodes: usize,
    idx_string_nodes: usize,
    idx_variable_nodes: usize,
    idx_expression_nodes: usize,
    idx_statment_nodes: usize,
    idx_pipeline_nodes: usize,
    idx_blocks: usize,
    idx_errors: usize,
    token_pos: usize,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Span {
    pub start: usize,
    pub end: usize,
}

impl Span {
    pub fn new(start: usize, end: usize) -> Self {
        Self { start, end }
    }
}

#[derive(Debug, PartialEq)]
pub struct Spanned<T> {
    pub item: T,
    pub span: Span,
}

impl<T> Spanned<T> {
    pub fn new(item: T, span: Span) -> Self {
        Spanned { item, span }
    }
}

#[derive(Clone, Debug)]
pub struct NodeSpans<T> {
    nodes: Vec<T>, // indexed by relative nodeId
    spans: Vec<Span>,
}

impl<T> NodeSpans<T> {
    pub fn new() -> Self {
        Self {
            nodes: vec![],
            spans: vec![],
        }
    }
    pub fn get_span(&self, i: usize) -> Span {
        self.spans[i]
    }

    pub fn get_node(&self, i: usize) -> &T {
        &self.nodes[i]
    }

    pub fn get_node_mut(&mut self, i: usize) -> &mut T {
        &mut self.nodes[i]
    }

    pub fn push(&mut self, span: Span, node: T) {
        self.spans.push(span);
        self.nodes.push(node);
    }

    pub fn len(&self) -> usize {
        self.nodes.len()
    }

    pub fn truncate(&mut self, len: usize) {
        self.nodes.truncate(len);
        self.spans.truncate(len);
    }

    pub fn is_empty(&self) -> bool {
        self.nodes.is_empty()
    }

    pub fn iter_nodes(&self) -> std::slice::Iter<'_, T> {
        self.nodes.iter()
    }

    pub fn display_nodes(&self) -> String
    where
        T: std::fmt::Debug,
    {
        let mut result = self
            .nodes
            .iter()
            .enumerate()
            .map(|(i, node)| {
                format!(
                    "{}: {:?} ({} to {})",
                    i, node, self.spans[i].start, self.spans[i].end
                )
            })
            .collect::<Vec<_>>()
            .join("\n");
        result.push('\n');
        result
    }
}

#[derive(Clone)]
pub struct Compiler {
    // different types of nodes.
    pub name_nodes: NodeSpans<NameNode>,
    pub string_nodes: NodeSpans<StringNode>,
    pub variable_nodes: NodeSpans<VariableNode>,
    pub expression_nodes: NodeSpans<ExpressionNode>,
    pub ast_nodes: NodeSpans<AstNode>,
    pub statement_nodes: NodeSpans<StatementNode>,
    pub block_nodes: NodeSpans<BlockNode>, // Blocks, indexed by BlockId
    pub pipeline_nodes: NodeSpans<PipelineNode>, // Pipelines, indexed by PipelineId
    pub indexer: Vec<NodeIndexer>,

    pub node_types: Vec<TypeId>,
    // node_lifetimes: Vec<AllocationLifetime>,
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
    pub var_resolution: HashMap<NameOrVariable, VarId>,
    /// Type declarations, indexed by TypeDeclId
    pub type_decls: Vec<TypeDecl>,
    /// Mapping of type decl's name node -> TypeDecl
    pub type_resolution: HashMap<NameOrVariable, TypeDeclId>,
    /// Declarations (commands, aliases, externs), indexed by DeclId
    pub decls: Vec<Box<dyn Command>>,
    /// Declaration NodeIds, indexed by DeclId
    pub decl_nodes: Vec<StatementNodeId>,
    /// Mapping of decl's name node -> Command
    /// It can be NameOrString, or an AstNode::Call.
    // NOTE: not sure why it can be ExpressionNode::Call, but let's keep the original behavior.
    pub decl_resolution: HashMap<NodeIndexer, DeclId>,

    // Definitions:
    // indexed by FunId
    // pub functions: Vec<Function>,
    // indexed by TypeId
    // types: Vec<Type>,

    // Use/def
    // pub call_resolution: HashMap<NodeId, CallTarget>,
    pub errors: Vec<SourceError>,

    // cache mapping
    pub name_to_expression: HashMap<NameNodeId, ExpressionNodeId>,
    pub variable_to_expression: HashMap<VariableNodeId, ExpressionNodeId>,
    pub string_to_expression: HashMap<StringNodeId, ExpressionNodeId>,
    pub pipeline_to_expression: HashMap<PipelineId, ExpressionNodeId>,
}

impl Default for Compiler {
    fn default() -> Self {
        Self::new()
    }
}

impl Compiler {
    pub fn new() -> Self {
        Self {
            string_nodes: NodeSpans::new(),
            variable_nodes: NodeSpans::new(),
            ast_nodes: NodeSpans::new(),
            name_nodes: NodeSpans::new(),
            expression_nodes: NodeSpans::new(),
            statement_nodes: NodeSpans::new(),
            pipeline_nodes: NodeSpans::new(),
            node_types: vec![],
            indexer: vec![],
            block_nodes: NodeSpans::new(),
            source: vec![],
            file_offsets: vec![],

            scope: vec![],
            scope_stack: vec![],
            variables: vec![],
            var_resolution: HashMap::new(),
            type_decls: vec![],
            type_resolution: HashMap::new(),
            decls: vec![],
            decl_nodes: vec![],
            decl_resolution: HashMap::new(),

            // variables: vec![],
            // functions: vec![],
            // types: vec![],

            // call_resolution: HashMap::new(),
            name_to_expression: HashMap::new(),
            variable_to_expression: HashMap::new(),
            string_to_expression: HashMap::new(),
            pipeline_to_expression: HashMap::new(),

            // call_resolution: HashMap::new(),
            errors: vec![],
        }
    }

    pub fn print(&self) {
        let output = self.display_state();
        print!("{output}");
    }

    #[allow(clippy::format_collect)]
    pub fn display_state(&self) -> String {
        // TODO: This should say PARSER, not COMPILER
        let mut result = "==== COMPILER ====\n".to_string();
        result.push_str("==== NAME ====\n");
        result.push_str(self.name_nodes.display_nodes().as_str());
        result.push_str("==== STRING ====\n");
        result.push_str(self.string_nodes.display_nodes().as_str());
        result.push_str("==== VARIABLE ====\n");
        result.push_str(self.variable_nodes.display_nodes().as_str());
        result.push_str("==== EXPRESSION ====\n");
        result.push_str(self.expression_nodes.display_nodes().as_str());
        result.push_str("==== AST_NODES ====\n");
        result.push_str(self.ast_nodes.display_nodes().as_str());
        result.push_str("==== STATEMENTS ====\n");
        result.push_str(self.statement_nodes.display_nodes().as_str());
        result.push_str("==== BLOCKS ====\n");
        result.push_str(self.block_nodes.display_nodes().as_str());

        result.push_str("==== NODE INDEXER ====\n");
        for (idx, indexer) in self.indexer.iter().enumerate() {
            let (node_dbg_string, span) = match indexer {
                NodeIndexer::Expression(i) => (
                    format!("{:?}", self.expression_nodes.get_node(i.0)),
                    self.expression_nodes.get_span(i.0),
                ),
                NodeIndexer::Statement(i) => (
                    format!("{:?}", self.statement_nodes.get_node(i.0)),
                    self.statement_nodes.get_span(i.0),
                ),
                NodeIndexer::General(i) => (
                    format!("{:?}", self.ast_nodes.get_node(i.0)),
                    self.ast_nodes.get_span(i.0),
                ),
                NodeIndexer::Block(i) => (
                    format!("{:?}", self.block_nodes.get_node(i.0)),
                    self.block_nodes.get_span(i.0),
                ),
                NodeIndexer::Pipeline(i) => (
                    format!("{:?}", self.pipeline_nodes.get_node(i.0)),
                    self.pipeline_nodes.get_span(i.0),
                ),
            };
            result.push_str(&format!(
                "{}: {} ({} to {})",
                idx, node_dbg_string, span.start, span.end
            ));

            if let NodeIndexer::Expression(i) = indexer {
                let node = self.expression_nodes.get_node(i.0);
                if matches!(
                    node,
                    ExpressionNode::Int
                        | ExpressionNode::Float
                        | ExpressionNode::Name(_)
                        | ExpressionNode::Variable(_)
                        | ExpressionNode::String(_)
                ) {
                    result.push_str(&format!(
                        " \"{}\"",
                        String::from_utf8_lossy(self.get_span_contents(*indexer))
                    ));
                }
            }

            result.push('\n');
        }

        if !self.errors.is_empty() {
            result.push_str("==== COMPILER ERRORS ====\n");
            for error in &self.errors {
                result.push_str(&format!(
                    "{:?} (NodeId {:?}): {}\n",
                    error.severity, error.node_id, error.message
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
        self.type_decls.extend(name_bindings.type_decls);
        self.type_resolution.extend(name_bindings.type_resolution);
        self.decls.extend(name_bindings.decls);
        self.decl_nodes.extend(name_bindings.decl_nodes);
        self.decl_resolution.extend(name_bindings.decl_resolution);
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

    pub fn get_node<T: NodeIdGetter>(&self, node_id: T) -> &T::Output {
        node_id.get_node(self)
    }

    pub fn get_node_mut<T: NodeIdGetter>(&mut self, node_id: T) -> &mut T::Output {
        node_id.get_node_mut(self)
    }

    pub fn push_node<T: NodePusher>(&mut self, span: Span, ast_node: T) -> T::Output {
        ast_node.push_node(span, self)
    }

    pub fn get_rollback_point(&self, token_pos: usize) -> RollbackPoint {
        RollbackPoint {
            idx_ast_nodes: self.ast_nodes.len(),
            idx_name_nodes: self.name_nodes.len(),
            idx_string_nodes: self.string_nodes.len(),
            idx_variable_nodes: self.variable_nodes.len(),
            idx_expression_nodes: self.expression_nodes.len(),
            idx_statment_nodes: self.statement_nodes.len(),
            idx_pipeline_nodes: self.pipeline_nodes.len(),
            idx_errors: self.errors.len(),
            idx_blocks: self.block_nodes.len(),
            token_pos,
        }
    }

    pub fn apply_compiler_rollback(&mut self, rbp: RollbackPoint) -> usize {
        self.block_nodes.truncate(rbp.idx_blocks);
        self.ast_nodes.truncate(rbp.idx_ast_nodes);
        self.name_nodes.truncate(rbp.idx_name_nodes);
        self.string_nodes.truncate(rbp.idx_string_nodes);
        self.variable_nodes.truncate(rbp.idx_variable_nodes);
        self.expression_nodes.truncate(rbp.idx_expression_nodes);
        self.statement_nodes.truncate(rbp.idx_statment_nodes);
        self.pipeline_nodes.truncate(rbp.idx_pipeline_nodes);

        self.errors.truncate(rbp.idx_errors);

        rbp.token_pos
    }

    /// Get span of node
    /// TODO: no need this.
    pub fn get_span(&self, node_indexer: NodeIndexer) -> Span {
        match node_indexer {
            NodeIndexer::General(i) => self.ast_nodes.get_span(i.0),
            NodeIndexer::Expression(i) => self.expression_nodes.get_span(i.0),
            NodeIndexer::Block(i) => self.block_nodes.get_span(i.0),
            NodeIndexer::Statement(i) => self.statement_nodes.get_span(i.0),
            NodeIndexer::Pipeline(i) => self.pipeline_nodes.get_span(i.0),
        }
    }

    /// Get the source contents of a span of a node
    /// TODO: no need this.
    pub fn get_span_contents(&self, node_indexer: NodeIndexer) -> &[u8] {
        let span = self.get_span(node_indexer);
        self.source
            .get(span.start..span.end)
            .expect("internal error: missing source of span")
    }

    /// Get the source contents of a span
    pub fn get_span_contents_manual(&self, span_start: usize, span_end: usize) -> &[u8] {
        self.source
            .get(span_start..span_end)
            .expect("internal error: missing source of span")
    }

    /// Get the source contents of a node
    /// TODO: use generic rather than NodeIndexer
    pub fn node_as_str(&self, node_indexer: NodeIndexer) -> &str {
        std::str::from_utf8(self.get_span_contents(node_indexer))
            .expect("internal error: expected utf8 string")
    }

    /// Get the source contents of a node as i64
    /// TODO: use generic rather than NodeIndexer
    pub fn node_as_i64(&self, node_indexer: NodeIndexer) -> i64 {
        self.node_as_str(node_indexer)
            .parse::<i64>()
            .expect("internal error: expected i64")
    }
}
