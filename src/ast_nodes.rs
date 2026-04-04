use super::compiler::{Compiler, Span};


#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct NameNodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct NameNode;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct StringNodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct StringNode;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct VariableNodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct VariableNode;

// A helper enum for block compoments.  Compiler doesn't save
// this as an individual id.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum StatementOrExpression {
    Statement(StatementNodeId),
    Expression(ExpressionNodeId),
}

// A helper enum for block compoments.  Compiler doesn't save
// this as an individual id.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum NameOrString {
    Name(NameNodeId),
    String(StringNodeId),
}
impl NameOrString {
    pub fn into_indexer(self) -> NodeIndexer {
        match self {
            Self::Name(x) => x.into_indexer(),
            Self::String(x) => x.into_indexer(),
        }
    }
}

// A helper enum for block compoments.  Compiler doesn't save
// this as an individual id.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum NameOrVariable {
    Name(NameNodeId),
    Variable(VariableNodeId),
}

impl NameOrVariable {
    pub fn into_indexer(self) -> NodeIndexer {
        match self {
            Self::Name(x) => x.into_indexer(),
            Self::Variable(x) => x.into_indexer(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct BlockNode {
    pub nodes: Vec<StatementOrExpression>,
}

impl BlockNode {
    pub fn new(nodes: Vec<StatementOrExpression>) -> BlockNode {
        BlockNode { nodes }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct BlockId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct PipelineId(pub usize);

// Pipeline just contains a list of expressions
//
// It's not allowed if there is only one element in pipeline, in that
// case, it's just an expression.
//
// Making such restriction can reduce indirect access on expression, which
// can improve performance in parse time.
#[derive(Debug, Clone, PartialEq)]
pub struct PipelineNode {
    pub nodes: Vec<ExpressionNodeId>,
}

impl PipelineNode {
    pub fn new(nodes: Vec<ExpressionNodeId>) -> Self {
        debug_assert!(
            nodes.len() > 1,
            "a pipeline must contain at least 2 nodes, or else it's actually an expression"
        );
        Self { nodes }
    }

    pub fn get_expressions(&self) -> &Vec<ExpressionNodeId> {
        &self.nodes
    }
}
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum ExpressionNode {
    Int,
    Float,
    String(StringNodeId),
    Name(NameNodeId),
    Variable(VariableNodeId),

    // Booleans
    True,
    False,

    // Empty values
    Null,

    VarRef,

    Closure {
        params: Option<NodeId>,
        block: BlockId,
    },

    Call {
        head: Vec<NameNodeId>,
        parts: Vec<ExpressionNodeId>,
    },
    NamedValue {
        name: NodeId,
        value: NodeId,
    },
    BinaryOp {
        lhs: ExpressionNodeId,
        op: NodeId,
        rhs: ExpressionNodeId,
    },
    Range {
        lhs: ExpressionNodeId,
        rhs: ExpressionNodeId,
    },
    List(Vec<ExpressionNodeId>),
    Table {
        header: ExpressionNodeId,
        rows: Vec<ExpressionNodeId>,
    },
    Record {
        pairs: Vec<(ExpressionNodeId, ExpressionNodeId)>,
    },
    MemberAccess {
        target: ExpressionNodeId,
        field: ExpressionNodeId,
    },
    // Pipeline is also an expression, and it contains a list of expressions.
    Pipeline(PipelineId),
    If {
        condition: ExpressionNodeId,
        then_block: BlockId,
        else_block: Option<NodeIndexer>, // it can be a block, or another if expression (else if)
    },
    Try {
        try_block: BlockId,
        catch_block: Option<BlockId>,
        finally_block: Option<BlockId>,
    },
    Match {
        target: ExpressionNodeId,
        match_arms: Vec<(ExpressionNodeId, ExpressionNodeId)>,
    },
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct ExpressionNodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum StatementNode {
    // Definitions
    Def {
        name: NameOrString,
        type_params: Option<NodeId>,
        params: NodeId,
        in_out_types: Option<NodeId>,
        block: BlockId,
        env: bool,
        wrapped: bool,
    },
    Extern {
        name: NameOrString,
        params: NodeId,
    },
    Alias {
        new_name: NameOrString,
        old_name: NameOrString,
    },
    Let {
        variable_name: VariableNodeId,
        ty: Option<NodeId>,
        initializer: ExpressionNodeId,
        is_mutable: bool,
    },

    While {
        condition: ExpressionNodeId,
        block: BlockId,
    },
    For {
        variable: VariableNodeId,
        range: ExpressionNodeId,
        block: BlockId,
    },
    Loop {
        block: BlockId,
    },
    Return(Option<ExpressionNodeId>),
    Break,
    Continue,

    Expr(ExpressionNodeId),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct StatementNodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct NodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum NodeIndexer {
    Name(NameNodeId),
    String(StringNodeId),
    Variable(VariableNodeId),
    Expression(ExpressionNodeId),
    Statement(StatementNodeId),
    Block(BlockId),
    Pipeline(PipelineId),
    General(NodeId),
}

// TODO: All nodes with Vec<...> should be moved to their own ID (like BlockId) to allow Copy trait
#[derive(Debug, Clone, PartialEq)]
pub enum AstNode {
    Type {
        name: NameNodeId,
        args: Option<NodeId>,
        optional: bool,
    },
    TypeArgs(Vec<NodeId>),
    RecordType {
        /// Contains [AstNode::Params]
        fields: NodeId,
        optional: bool,
    },
    VarDecl,

    // Operators
    Pow,
    Multiply,
    Divide,
    FloorDiv,
    Modulo,
    Plus,
    Minus,
    Equal,
    NotEqual,
    LessThan,
    GreaterThan,
    LessThanOrEqual,
    GreaterThanOrEqual,
    RegexMatch,
    NotRegexMatch,
    In,
    Append,
    And,
    Xor,
    Or,

    // Assignments
    Assignment,
    AddAssignment,
    SubtractAssignment,
    MultiplyAssignment,
    DivideAssignment,
    AppendAssignment,

    TypeParams(Vec<NameNodeId>),
    /// Contains [AstNode::Param]
    Params(Vec<NodeId>),
    Param {
        name: NameNodeId,
        ty: Option<NodeId>,
    },
    InOutTypes(Vec<NodeId>),
    /// Input/output type pair for a command
    InOutType(NodeId, NodeId),

    /// Long flag ('--' + one or more letters)
    FlagLong,
    /// Short flag ('-' + single letter)
    FlagShort,
    /// Group of short flags ('-' + more than 1 letters)
    FlagShortGroup,

    // ??? should statement belongs to AstNode?
    Statement(StatementNodeId),

    Garbage,
}

pub trait NodeIdGetter {
    type Output;
    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output;
    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output;
    fn get_span(&self, compiler: &Compiler) -> Span;
    fn get_span_contents<'a>(&self, compiler: &'a Compiler) -> &'a [u8] {
        let span = self.get_span(compiler);
        compiler
            .source
            .get(span.start..span.end)
            .expect("internal error: missing source of span")
    }
    fn into_indexer(self) -> NodeIndexer;
}

pub trait NodePusher {
    type Output;
    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output;
}

impl NodeIdGetter for NameNodeId {
    type Output = NameNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.name_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.name_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.name_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::Name(self)
    }
}

impl NodePusher for NameNode {
    type Output = NameNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.name_nodes.push(span, self);

        let result = NameNodeId(compiler.name_nodes.len() - 1);
        // let's push expression to indexer.
        // let expr_node_id = ExpressionNode::Name(result).push_node(span, compiler);
        // let indexer = NodeIndexer::Expression(expr_node_id);
        // compiler.indexer.push(indexer);

        result
    }
}

impl NodeIdGetter for StringNodeId {
    type Output = StringNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.string_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.string_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.string_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::String(self)
    }
}

impl NodePusher for StringNode {
    type Output = StringNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.string_nodes.push(span, self);

        let result = StringNodeId(compiler.string_nodes.len() - 1);
        // let's push expression to Indexer.
        // let expr_node_id = ExpressionNode::String(result).push_node(span, compiler);
        // let indexer = NodeIndexer::Expression(expr_node_id);
        // compiler.indexer.push(indexer);

        result
    }
}

impl NodeIdGetter for VariableNodeId {
    type Output = VariableNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.variable_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.variable_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.variable_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::Variable(self)
    }
}

impl NodePusher for VariableNode {
    type Output = VariableNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.variable_nodes.push(span, self);

        let result = VariableNodeId(compiler.variable_nodes.len() - 1);
        // let's push expression to indexer.
        // let expr_node_id = ExpressionNode::Variable(result).push_node(span, compiler);
        // let indexer = NodeIndexer::Expression(expr_node_id);
        // compiler.indexer.push(indexer);

        result
    }
}

impl NodeIdGetter for BlockId {
    type Output = BlockNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.block_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.block_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.block_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::Block(self)
    }
}

impl NodePusher for BlockNode {
    type Output = BlockId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.block_nodes.push(span, self);

        let result = BlockId(compiler.block_nodes.len() - 1);
        let indexer = NodeIndexer::Block(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl NodeIdGetter for StatementNodeId {
    type Output = StatementNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.statement_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.statement_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.statement_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::Statement(self)
    }
}

impl NodePusher for StatementNode {
    type Output = StatementNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.statement_nodes.push(span, self);

        let result = StatementNodeId(compiler.statement_nodes.len() - 1);
        let indexer = NodeIndexer::Statement(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl NodeIdGetter for PipelineId {
    type Output = PipelineNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.pipeline_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.pipeline_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.pipeline_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::Pipeline(self)
    }
}

impl NodePusher for PipelineNode {
    type Output = PipelineId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.pipeline_nodes.push(span, self);

        let result = PipelineId(compiler.pipeline_nodes.len() - 1);
        let indexer = NodeIndexer::Pipeline(result);
        compiler.indexer.push(indexer);

        result
    }
}
impl NodePusher for ExpressionNode {
    type Output = ExpressionNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.expression_nodes.push(span, self);

        let result = ExpressionNodeId(compiler.expression_nodes.len() - 1);
        let indexer = NodeIndexer::Expression(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl NodeIdGetter for ExpressionNodeId {
    type Output = ExpressionNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.expression_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.expression_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.expression_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::Expression(self)
    }
}
impl NodePusher for AstNode {
    type Output = NodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.ast_nodes.push(span, self);

        let result = NodeId(compiler.ast_nodes.len() - 1);
        let indexer = NodeIndexer::General(result);
        compiler.indexer.push(indexer);

        result
    }
}
impl NodeIdGetter for NodeId {
    type Output = AstNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.ast_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.ast_nodes.get_node_mut(self.0)
    }

    fn get_span(&self, compiler: &Compiler) -> Span {
        compiler.ast_nodes.get_span(self.0)
    }

    fn into_indexer(self) -> NodeIndexer {
        NodeIndexer::General(self)
    }
}
