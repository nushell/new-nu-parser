use super::compiler::{Compiler, Span};
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

pub trait Tmp {
    type Output;
    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output;
    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output;
}

pub trait Tmp1 {
    type Output;
    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output;
}

impl Tmp for NameNodeId {
    type Output = NameNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.name_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.name_nodes.get_node_mut(self.0)
    }
}

impl Tmp1 for NameNode {
    type Output = NameNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.name_nodes.push(span, self);

        let result = NameNodeId(compiler.name_nodes.len() - 1);
        let indexer = NodeIndexer::Name(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl Tmp for StringNodeId {
    type Output = StringNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.string_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.string_nodes.get_node_mut(self.0)
    }
}

impl Tmp1 for StringNode {
    type Output = StringNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.string_nodes.push(span, self);

        let result = StringNodeId(compiler.string_nodes.len() - 1);
        let indexer = NodeIndexer::String(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl Tmp for VariableNodeId {
    type Output = VariableNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.variable_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.variable_nodes.get_node_mut(self.0)
    }
}

impl Tmp1 for VariableNode {
    type Output = VariableNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.variable_nodes.push(span, self);

        let result = VariableNodeId(compiler.variable_nodes.len() - 1);
        let indexer = NodeIndexer::Variable(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl Tmp for BlockId {
    type Output = Block;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.blocks.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.blocks.get_node_mut(self.0)
    }
}

impl Tmp1 for Block {
    type Output = BlockId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.blocks.push(span, self);

        let result = BlockId(compiler.blocks.len() - 1);
        let indexer = NodeIndexer::Block(result);
        compiler.indexer.push(indexer);

        result
    }
}

impl Tmp for StatementNodeId {
    type Output = StatementNode;

    fn get_node<'a>(&self, compiler: &'a Compiler) -> &'a Self::Output {
        compiler.statement_nodes.get_node(self.0)
    }

    fn get_node_mut<'a>(&self, compiler: &'a mut Compiler) -> &'a mut Self::Output {
        compiler.statement_nodes.get_node_mut(self.0)
    }
}

impl Tmp1 for StatementNode {
    type Output = StatementNodeId;

    fn push_node(self, span: Span, compiler: &mut Compiler) -> Self::Output {
        compiler.statement_nodes.push(span, self);

        let result = StatementNodeId(compiler.statement_nodes.len() - 1);
        let indexer = NodeIndexer::Statement(result);
        compiler.indexer.push(indexer);

        result
    }
}
