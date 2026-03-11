use nu_protocol::{ast::Expression, engine::Variable};

use crate::parser::PipelineId;

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

#[derive(Debug, Clone)]
pub struct Block {
    pub nodes: Vec<NodeIndexer>,
}

impl Block {
    pub fn new(nodes: Vec<NodeIndexer>) -> Block {
        Block { nodes }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct BlockId(pub usize);

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
    // Pipeline is also an expression, and it contains a list of expressions.
    Pipeline(PipelineId),
    If {
        condition: NodeId,
        then_block: BlockId,
        else_block: Option<BlockId>,
    },
    Try {
        try_block: BlockId,
        catch_block: Option<BlockId>,
        finally_block: Option<BlockId>,
    },
    Match {
        target: NodeId,
        match_arms: Vec<(NodeId, NodeId)>,
    },
    // Pipeline is also an expression, and it contains a list of expressions.
    Pipeline(PipelineId),
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct ExpressionNodeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum StatementNode {
    // Definitions
    Def {
        name: NodeIndexer,
        type_params: Option<NodeId>,
        params: NodeId,
        in_out_types: Option<NodeId>,
        block: BlockId,
        env: bool,
        wrapped: bool,
    },
    Extern {
        name: NodeId,
        params: NodeId,
    },
    Alias {
        new_name: NodeIndexer,
        old_name: NodeIndexer,
    },
    Let {
        variable_name: VariableNodeId,
        ty: Option<NodeId>,
        initializer: NodeId,
        is_mutable: bool,
    },

    While {
        condition: NodeId,
        block: BlockId,
    },
    For {
        variable: VariableNodeId,
        range: NodeId,
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

    Params(Vec<NodeId>),
    Param {
        name: NodeId,
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
