//! See typechecking.md in the contributing/ folder for more information on
//! how the typechecker works

use crate::ast_nodes::{
    AstNode, BlockId, ExpressionNode, ExpressionNodeId, NameNodeId, NameOrString, NameOrVariable,
    NodeId, NodeIdGetter, NodeIndexer, PipelineId, StatementNode, StatementNodeId,
    StatementOrExpression, StringNodeId, VariableNodeId,
};
use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::resolver::{TypeDecl, TypeDeclId};
use std::cmp::Ordering;
use std::collections::{HashMap, HashSet};

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct TypeId(pub usize);

/// Input/output type pair of a closure/command
#[derive(Debug, Clone)]
pub struct InOutType {
    pub in_type: TypeId,
    pub out_type: TypeId,
}

/// A type variable used for type inference
pub struct TypeVar {
    lower_bound: TypeId,
    upper_bound: TypeId,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct TypeVarId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct RecordTypeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct OneOfId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct AllOfId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Type {
    /// Any node that hasn't been touched by the typechecker will have this type
    Unknown,
    /// Some nodes shouldn't be directly evaluated (like operators). These will have a "forbidden"
    /// to differentiate them from the "unknown" type.
    Forbidden,
    Error,
    /// None type means that a node has no type. For example, statements like let x = ... do not
    /// output anything and thus don't have any type.
    None,
    /// Supertype of all types
    Top,
    /// Subtype of all types
    Bottom,
    Any,
    Number,
    Nothing,
    Int,
    Float,
    Bool,
    String,
    Binary,
    Closure,
    List(TypeId),
    Stream(TypeId),
    Record(RecordTypeId),
    /// Union type. OneOf types should not be nested and should have at least two elements.
    /// They can contain allof types.
    OneOf(OneOfId),
    /// Intersection type. AllOf types should not be nested and should have at least two elements.
    /// They also cannot contain oneof types.
    AllOf(AllOfId),
    /// A reference to a type declaration such as a type parameter
    Ref(TypeDeclId),
    /// A type variable that must be solved
    Var(TypeVarId),
}

pub struct Types {
    pub types: Vec<Type>,
    pub name_node_types: Vec<TypeId>,
    pub string_node_types: Vec<TypeId>,
    pub variable_node_types: Vec<TypeId>,
    pub node_types: Vec<TypeId>,
    pub expression_node_types: Vec<TypeId>,
    pub statement_node_types: Vec<TypeId>,
    pub block_node_types: Vec<TypeId>,
    pub pipeline_node_types: Vec<TypeId>,
    pub errors: Vec<SourceError>,
}

// The below are predefined simple types hardcoded into the Typechecker to avoid re-adding them all
// the time:

pub const UNKNOWN_TYPE: TypeId = TypeId(0);
pub const FORBIDDEN_TYPE: TypeId = TypeId(1);
pub const NONE_TYPE: TypeId = TypeId(2);
pub const ANY_TYPE: TypeId = TypeId(3);
pub const NUMBER_TYPE: TypeId = TypeId(4);
pub const NOTHING_TYPE: TypeId = TypeId(5);
pub const INT_TYPE: TypeId = TypeId(6);
pub const FLOAT_TYPE: TypeId = TypeId(7);
pub const BOOL_TYPE: TypeId = TypeId(8);
pub const STRING_TYPE: TypeId = TypeId(9);
pub const BINARY_TYPE: TypeId = TypeId(10);
pub const CLOSURE_TYPE: TypeId = TypeId(11);

// Common composite types can be hardcoded as well, like list<any>:

pub const LIST_ANY_TYPE: TypeId = TypeId(12);
pub const BYTE_STREAM_TYPE: TypeId = TypeId(13);
pub const ERROR_TYPE: TypeId = TypeId(14);
pub const TOP_TYPE: TypeId = TypeId(15);
pub const BOTTOM_TYPE: TypeId = TypeId(16);

pub struct Typechecker<'a> {
    /// Immutable reference to a compiler after the name binding pass
    compiler: &'a Compiler,

    /// Types referenced by TypeId
    types: Vec<Type>,

    /// Types of nodes. Each type in this vector matches a node in compiler.ast_nodes at the same position.
    pub name_node_types: Vec<TypeId>,
    pub string_node_types: Vec<TypeId>,
    pub variable_node_types: Vec<TypeId>,
    pub node_types: Vec<TypeId>,
    pub expression_node_types: Vec<TypeId>,
    pub statement_node_types: Vec<TypeId>,
    pub block_node_types: Vec<TypeId>,
    pub pipeline_node_types: Vec<TypeId>,
    /// Record fields used for `RecordType`. Each value in this vector matches with the index in RecordTypeId.
    /// The individual field lists are stored sorted by field name.
    pub record_types: Vec<Vec<(ExpressionNodeId, TypeId)>>,
    /// Types used for `OneOf`. Each value in this vector matches with the index in OneOfId.
    pub oneof_types: Vec<HashSet<TypeId>>,
    /// Types used for `AllOf`. Each value in this vector matches with the index in AllOfId.
    pub allof_types: Vec<HashSet<TypeId>>,
    /// Type variables, indexed by TypeVarId
    pub type_vars: Vec<TypeVar>,
    /// Type of each Variable in compiler.variables, indexed by VarId
    pub variable_types: Vec<TypeId>,
    /// Input/output type pairs of each declaration in compiler.decls, indexed by DeclId
    pub decl_types: Vec<Vec<InOutType>>,
    /// Errors encountered during type checking
    pub errors: Vec<SourceError>,
}

impl<'a> Typechecker<'a> {
    pub fn new(compiler: &'a Compiler) -> Self {
        Self {
            compiler,
            types: vec![
                // The order must be the same as with the xxx_TYPE constants above
                Type::Unknown,
                Type::Forbidden,
                Type::None,
                Type::Any,
                Type::Number,
                Type::Nothing,
                Type::Int,
                Type::Float,
                Type::Bool,
                Type::String,
                Type::Binary,
                Type::Closure,
                Type::List(ANY_TYPE),
                Type::Stream(BINARY_TYPE),
                Type::Error,
                Type::Top,
                Type::Bottom,
            ],
            name_node_types: vec![UNKNOWN_TYPE; compiler.name_nodes.len()],
            string_node_types: vec![STRING_TYPE; compiler.string_nodes.len()],
            variable_node_types: vec![UNKNOWN_TYPE; compiler.variable_nodes.len()],
            node_types: vec![UNKNOWN_TYPE; compiler.ast_nodes.len()],
            expression_node_types: vec![UNKNOWN_TYPE; compiler.expression_nodes.len()],
            statement_node_types: vec![UNKNOWN_TYPE; compiler.statement_nodes.len()],
            block_node_types: vec![UNKNOWN_TYPE; compiler.block_nodes.len()],
            pipeline_node_types: vec![UNKNOWN_TYPE; compiler.pipeline_nodes.len()],
            record_types: Vec::new(),
            oneof_types: Vec::new(),
            allof_types: Vec::new(),
            type_vars: Vec::new(),
            variable_types: vec![UNKNOWN_TYPE; compiler.variables.len()],
            decl_types: vec![
                vec![InOutType {
                    in_type: ANY_TYPE,
                    out_type: ANY_TYPE,
                }];
                compiler.decls.len()
            ],
            errors: vec![],
        }
    }

    pub fn to_types(self) -> Types {
        Types {
            types: self.types,
            name_node_types: self.name_node_types,
            string_node_types: self.string_node_types,
            variable_node_types: self.variable_node_types,
            node_types: self.node_types,
            expression_node_types: self.expression_node_types,
            statement_node_types: self.statement_node_types,
            block_node_types: self.block_node_types,
            pipeline_node_types: self.pipeline_node_types,
            errors: self.errors,
        }
    }

    pub fn print(&self) {
        let output = self.display_state();
        print!("{output}");
    }

    pub fn display_state(&self) -> String {
        let mut result = String::new();

        result.push_str("==== TYPES ====\n");

        for (idx, node_indexer) in self.compiler.indexer.iter().enumerate() {
            let node_type_id = match node_indexer {
                NodeIndexer::General(node_id) => self.node_types[node_id.0],
                NodeIndexer::Expression(expr_id) => self.expression_node_types[expr_id.0],
                NodeIndexer::Statement(stmt_id) => self.statement_node_types[stmt_id.0],
                NodeIndexer::Block(block_id) => self.block_node_types[block_id.0],
            };
            result.push_str(&format!(
                "{} -- {:?}: {}\n",
                idx,
                node_indexer,
                self.type_to_string(node_type_id)
            ));
        }

        if !self.errors.is_empty() {
            result.push_str("==== TYPE ERRORS ====\n");
            for error in &self.errors {
                result.push_str(&format!(
                    "{:?} (NodeId {:?}): {}\n",
                    error.severity, error.node_id, error.message
                ));
            }
        }

        result
    }

    /// Typecheck AST nodes, starting from the last node
    pub fn typecheck(&mut self) {
        if !self.compiler.indexer.is_empty() {
            let length = self.compiler.indexer.len();
            let last_indexer = self.compiler.indexer[length - 1];
            match last_indexer {
                NodeIndexer::General(node_id) => self.typecheck_node(&node_id),
                NodeIndexer::Block(block_id) => {
                    self.typecheck_block(&block_id, TOP_TYPE);
                }
                _ => return,
            }
            for i in 0..self.type_vars.len() {
                let var = &self.type_vars[i];
                let bound = var.lower_bound;
                let cleaned = self.eliminate_type_vars(bound, TypeVarId(0), true);
                self.types[bound.0] = self.types[cleaned.0];
            }

            for i in 0..self.types.len() {
                if let Type::Var(var_id) = &self.types[i] {
                    let bound = self.type_vars[var_id.0].lower_bound;
                    self.types[i] = self.types[bound.0];
                }
            }
        }
    }

    /// Get type ID of a node
    pub fn type_id_of(&self, node_id: NodeId) -> TypeId {
        self.node_types[node_id.0]
    }

    /// Get type of node
    fn type_of<T: NodeTypeSetter>(&self, node_id: &T) -> Type {
        let type_id = node_id.type_id_of(self);
        self.types[type_id.0]
    }

    fn typecheck_node(&mut self, node_id: &NodeId) {
        let node = node_id.get_node(self.compiler);
        match node {
            AstNode::Params(ref params) => {
                for param in params {
                    self.typecheck_node(param);
                }
                // Params are not supposed to be evaluated
                node_id.set_node_type_id(self, FORBIDDEN_TYPE);
            }
            AstNode::Param { name, ty } => {
                if let Some(ty) = ty {
                    let ty_id = self.typecheck_type(ty);

                    let var_id = self
                        .compiler
                        .var_resolution
                        .get(&NameOrVariable::Name(*name))
                        .expect("missing resolved variable");
                    self.variable_types[var_id.0] = ty_id;
                    node_id.set_node_type_id(self, ty_id);
                } else {
                    node_id.set_node_type_id(self, ANY_TYPE);
                }
            }
            AstNode::TypeArgs(ref args) => {
                for arg in args {
                    self.typecheck_type(arg);
                }
                // Type argument lists are not supposed to be evaluated
                node_id.set_node_type_id(self, FORBIDDEN_TYPE);
            }
            // NOTE: what about AstNode::TypeParams?
            _ => self.error(
                format!(
                    "unsupported/unexpected ast node '{:?}' in typechecker",
                    node
                ),
                node_id.into_indexer(self.compiler),
            ),
        }
    }

    fn typecheck_block(&mut self, node_id: &BlockId, expected: TypeId) -> TypeId {
        let block = node_id.get_node(self.compiler);

        for (i, inner_node_id) in block.nodes.iter().enumerate() {
            let expected_type = if i == block.nodes.len() - 1 {
                expected
            } else {
                TOP_TYPE
            };
            match inner_node_id {
                StatementOrExpression::Statement(stmt_id) => self.typecheck_stmt(*stmt_id),
                StatementOrExpression::Expression(expr_id) => {
                    self.typecheck_expr(expr_id, expected_type);
                }
            }
        }

        // Block type is the type of the last statement, since blocks
        // by themselves aren't supposed to be typed
        let block_type = block
            .nodes
            .last()
            .map_or(NONE_TYPE, |node_id| node_id.type_id_of(self));
        node_id.set_node_type_id(self, block_type);
        block_type
    }

    fn typecheck_stmt(&mut self, node_id: StatementNodeId) {
        let node = node_id.get_node(self.compiler);
        match node {
            StatementNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable: _,
            } => self.typecheck_let(variable_name, ty, initializer, node_id),
            StatementNode::Def {
                name,
                params,
                in_out_types,
                block,
                ..
            } => self.typecheck_def(name, params, in_out_types, block, node_id),
            StatementNode::Alias { new_name, old_name } => {
                self.typecheck_alias(new_name, old_name, node_id)
            }
            StatementNode::For {
                variable,
                range,
                block,
            } => {
                // We don't need to typecheck variable after this
                self.typecheck_expr(range, TOP_TYPE);

                let var_id = self
                    .compiler
                    .var_resolution
                    .get(&NameOrVariable::Variable(*variable))
                    .expect("missing resolved variable");
                if let Type::List(type_id) = self.type_of(range) {
                    self.variable_types[var_id.0] = type_id;
                    variable.set_node_type_id(self, type_id);
                } else {
                    self.variable_types[var_id.0] = ANY_TYPE;
                    variable.set_node_type_id(self, ERROR_TYPE);
                    self.error(
                        "For loop range is not a list",
                        range.into_indexer(self.compiler),
                    );
                }

                self.typecheck_block(block, TOP_TYPE);
                if block.type_id_of(self) != NONE_TYPE {
                    self.error(
                        "Blocks in looping constructs cannot return values",
                        block.into_indexer(self.compiler),
                    );
                }

                if node_id.type_id_of(self) != ERROR_TYPE {
                    node_id.set_node_type_id(self, NONE_TYPE);
                }
            }
            StatementNode::While { condition, block } => {
                self.typecheck_expr(condition, BOOL_TYPE);
                self.typecheck_block(block, TOP_TYPE);
                node_id.set_node_type_id(self, NONE_TYPE);
            }
            StatementNode::Loop { block } => {
                self.typecheck_block(block, TOP_TYPE);
                node_id.set_node_type_id(self, NONE_TYPE);
            }
            StatementNode::Break | StatementNode::Continue => {
                // TODO make sure we're in a loop
                node_id.set_node_type_id(self, NONE_TYPE);
            }
            _ => self.error(
                format!("unsupported statement node '{:?}' in typechecker", node),
                node_id.into_indexer(self.compiler),
            ),
        }
    }

    fn typecheck_expr(&mut self, node_id: &ExpressionNodeId, expected: TypeId) -> TypeId {
        let node = node_id.get_node(self.compiler);
        let ty_id = match node {
            ExpressionNode::Null => NOTHING_TYPE,
            ExpressionNode::Int => INT_TYPE,
            ExpressionNode::Float => FLOAT_TYPE,
            ExpressionNode::True | ExpressionNode::False => BOOL_TYPE,
            ExpressionNode::String(_) => STRING_TYPE,
            ExpressionNode::List(ref items) => {
                // TODO infer a union type instead
                if let Some(first_id) = items.first() {
                    let expected_elem = self.extract_elem_type(expected);
                    self.typecheck_expr(first_id, expected_elem.unwrap_or(TOP_TYPE));
                    let first_type = self.type_of(first_id);

                    let mut all_numbers = self.is_type_compatible(first_type, Type::Number);
                    let mut all_same = true;

                    for item_id in items.iter().skip(1) {
                        self.typecheck_expr(item_id, TOP_TYPE);
                        let item_type = self.type_of(item_id);

                        if all_numbers && !self.is_type_compatible(item_type, Type::Number) {
                            all_numbers = false;
                        }

                        if all_same && item_type != first_type {
                            all_same = false;
                        }
                    }

                    if all_same {
                        self.push_type(Type::List(first_id.type_id_of(self)))
                    } else if all_numbers {
                        self.push_type(Type::List(NUMBER_TYPE))
                    } else {
                        LIST_ANY_TYPE
                    }
                } else {
                    LIST_ANY_TYPE
                }
            }
            ExpressionNode::Record { ref pairs } => {
                // TODO take expected type into account
                let mut field_types = pairs
                    .iter()
                    .map(|(name, value)| (*name, self.typecheck_expr(value, TOP_TYPE)))
                    .collect::<Vec<_>>();
                field_types.sort_by_cached_key(|(name, _)| {
                    self.compiler
                        .get_span_contents(name.into_indexer(self.compiler))
                });

                self.record_types.push(field_types);
                self.push_type(Type::Record(RecordTypeId(self.record_types.len() - 1)))
            }
            ExpressionNode::Pipeline(pipeline_id) => {
                let pipeline = self.compiler.pipeline_nodes.get_node(pipeline_id.0);
                let expressions = pipeline.get_expressions();
                for inner in expressions {
                    self.typecheck_expr(inner, TOP_TYPE);
                }

                // pipeline type is the type of the last expression, since blocks
                // by themselves aren't supposed to be typed
                expressions
                    .last()
                    .map_or(NONE_TYPE, |node_id| node_id.type_id_of(self))
            }
            ExpressionNode::Closure { params, block } => {
                // TODO: input/output types
                if let Some(params_node_id) = params {
                    self.typecheck_node(params_node_id);
                }

                self.typecheck_block(block, expected);
                CLOSURE_TYPE
            }
            ExpressionNode::BinaryOp { lhs, op, rhs } => self.typecheck_binary_op(lhs, op, rhs),
            ExpressionNode::Variable(variable_node_id) => {
                let var_id = self
                    .compiler
                    .var_resolution
                    .get(&NameOrVariable::Variable(*variable_node_id))
                    .expect("missing resolved variable");

                self.variable_types[var_id.0]
            }
            ExpressionNode::If {
                condition,
                then_block,
                else_block,
            } => {
                self.typecheck_expr(condition, BOOL_TYPE);

                let then_type_id = self.typecheck_block(then_block, expected);

                if let Some(else_blk) = else_block {
                    let else_type_id = match else_blk {
                        NodeIndexer::Expression(else_expr_id) => {
                            self.typecheck_expr(else_expr_id, expected)
                        }
                        NodeIndexer::Block(else_block_id) => {
                            self.typecheck_block(else_block_id, expected)
                        }
                        _ => {
                            self.error("Else block of an if expression must be either a block or an expression", *else_blk);
                            return ERROR_TYPE;
                        }
                    };
                    let mut types = HashSet::new();
                    types.insert(then_type_id);
                    types.insert(else_type_id);
                    self.create_oneof(types)
                } else {
                    // If there's no else block, the if expression is a statement
                    NONE_TYPE
                }
            }
            ExpressionNode::Call { head, parts } => {
                // need to make sure that the node_id is either Name or String.
                self.typecheck_call(head, parts, node_id)
            }
            ExpressionNode::Match {
                ref target,
                ref match_arms,
            } => {
                // Check all the output types of match
                let output_types = self.typecheck_match(target, match_arms, expected);
                if output_types.is_empty() {
                    NOTHING_TYPE
                } else {
                    self.create_oneof(output_types)
                }
            }
            _ => {
                self.error(
                    format!("Expected an expression to typecheck, got '{:?}'", node),
                    node_id.into_indexer(self.compiler),
                );
                ERROR_TYPE
            }
        };
        node_id.set_node_type_id(self, ty_id);

        if !self.constrain_subtype(ty_id, expected) {
            self.error(
                format!(
                    "Expected {}, got {}",
                    self.type_to_string(expected),
                    self.type_to_string(ty_id)
                ),
                node_id.into_indexer(self.compiler),
            );
        }

        ty_id
    }

    fn typecheck_match(
        &mut self,
        target: &ExpressionNodeId,
        match_arms: &Vec<(ExpressionNodeId, ExpressionNodeId)>,
        expected: TypeId,
    ) -> HashSet<TypeId> {
        self.typecheck_expr(target, TOP_TYPE);

        let mut output_types = HashSet::new();
        // typecheck each node
        let target_id = target.type_id_of(self);
        for (match_node, result_node) in match_arms {
            self.typecheck_expr(match_node, expected);
            self.typecheck_expr(result_node, expected);

            let match_id = match_node.type_id_of(self);
            match (self.type_of(target), self.type_of(match_node)) {
                // First is of type Any which will always match
                (Type::Any, _) => {
                    self.add_resolved_types(&mut output_types, &result_node.type_id_of(self));
                }
                // Same as above but for second
                (_, Type::Any) => {
                    self.add_resolved_types(&mut output_types, &result_node.type_id_of(self));
                }
                // the second is one of the possible types of the first
                (Type::OneOf(id), _) if self.oneof_types[id.0].contains(&match_id) => {
                    self.add_resolved_types(&mut output_types, &result_node.type_id_of(self));
                }
                // the first is one of the possible types of the second
                (_, Type::OneOf(id)) if self.oneof_types[id.0].contains(&target_id) => {
                    self.add_resolved_types(&mut output_types, &result_node.type_id_of(self));
                }
                // the both the target and the one matched against are
                // oneof<many types> then we need to check if they have any type in common
                (Type::OneOf(id1), Type::OneOf(id2)) => {
                    if self.oneof_types[id1.0]
                        .intersection(&self.oneof_types[id2.0])
                        .count()
                        != 0
                    {
                        self.add_resolved_types(&mut output_types, &result_node.type_id_of(self));
                    } else {
                        self.error("The target to be matched against and the possible types of the matched arm are completely disjoint", NodeIndexer::Expression(*match_node));
                    }
                }
                // Check if the two types can be matched
                (target_id, match_id) if self.is_type_compatible(target_id, match_id) => {
                    self.add_resolved_types(&mut output_types, &result_node.type_id_of(self));
                }
                _ => self.error(
                    "The types do not match",
                    match_node.into_indexer(self.compiler),
                ),
            }
        }
        output_types
    }

    fn typecheck_binary_op(
        &mut self,
        lhs: &ExpressionNodeId,
        op: &NodeId,
        rhs: &ExpressionNodeId,
    ) -> TypeId {
        op.set_node_type_id(self, FORBIDDEN_TYPE);

        // TODO: better error messages for type mismatches, the previous messages were better
        let node = op.get_node(self.compiler);
        match node {
            AstNode::Equal | AstNode::NotEqual => {
                let lhs_ty = self.typecheck_expr(lhs, TOP_TYPE);
                let rhs_ty = self.typecheck_expr(rhs, TOP_TYPE);
                if !(self.is_subtype(lhs_ty, rhs_ty)
                    || self.is_subtype(rhs_ty, lhs_ty)
                    || (self.is_subtype(lhs_ty, NUMBER_TYPE)
                        && self.is_subtype(rhs_ty, NUMBER_TYPE)))
                {
                    self.binary_op_err("incompatible types for equal", lhs, op, rhs);
                }
                BOOL_TYPE
            }
            AstNode::LessThan
            | AstNode::GreaterThan
            | AstNode::LessThanOrEqual
            | AstNode::GreaterThanOrEqual => {
                self.typecheck_expr(lhs, NUMBER_TYPE);
                self.typecheck_expr(rhs, NUMBER_TYPE);
                BOOL_TYPE
            }
            AstNode::Minus
            | AstNode::Multiply
            | AstNode::Divide
            | AstNode::FloorDiv
            | AstNode::Modulo
            | AstNode::Pow => {
                let lhs_ty = self.typecheck_expr(lhs, NUMBER_TYPE);
                let rhs_ty = self.typecheck_expr(rhs, NUMBER_TYPE);

                match (self.types[lhs_ty.0], self.types[rhs_ty.0]) {
                    (Type::Int, Type::Int) => INT_TYPE,
                    (Type::Int, Type::Float) => FLOAT_TYPE,
                    (Type::Float, Type::Int) => FLOAT_TYPE,
                    (Type::Float, Type::Float) => FLOAT_TYPE,
                    _ => NUMBER_TYPE,
                }
            }
            AstNode::RegexMatch | AstNode::NotRegexMatch => {
                self.typecheck_expr(lhs, STRING_TYPE);
                self.typecheck_expr(rhs, STRING_TYPE);
                BOOL_TYPE
            }
            AstNode::In => {
                let rhs_type = self.typecheck_expr(rhs, TOP_TYPE);
                match self.types[rhs_type.0] {
                    Type::String => {
                        self.typecheck_expr(lhs, STRING_TYPE);
                        BOOL_TYPE
                    }
                    Type::List(elem_ty) => {
                        self.typecheck_expr(lhs, elem_ty);
                        BOOL_TYPE
                    }
                    Type::Any | Type::Bottom => {
                        self.typecheck_expr(lhs, TOP_TYPE);
                        BOOL_TYPE
                    }
                    _ => {
                        self.binary_op_err("list/string operation", lhs, op, rhs);
                        ERROR_TYPE
                    }
                }
            }
            AstNode::And | AstNode::Xor | AstNode::Or => {
                self.typecheck_expr(lhs, BOOL_TYPE);
                self.typecheck_expr(rhs, BOOL_TYPE);
                BOOL_TYPE
            }
            AstNode::Plus => {
                let mut types = HashSet::new();
                types.insert(STRING_TYPE);
                types.insert(NUMBER_TYPE);
                let common_ty = self.create_oneof(types);

                let lhs_ty = self.typecheck_expr(lhs, common_ty);
                let lhs_bottom = self.is_subtype(lhs_ty, BOTTOM_TYPE);
                if !lhs_bottom && self.is_subtype(lhs_ty, STRING_TYPE) {
                    self.typecheck_expr(rhs, STRING_TYPE);
                    STRING_TYPE
                } else if !lhs_bottom && self.is_subtype(lhs_ty, NUMBER_TYPE) {
                    let rhs_ty = self.typecheck_expr(rhs, NUMBER_TYPE);
                    self.numeric_op_type(lhs_ty, rhs_ty)
                } else {
                    let rhs_ty = self.typecheck_expr(rhs, common_ty);
                    let rhs_bottom = self.is_subtype(rhs_ty, BOTTOM_TYPE);
                    if !rhs_bottom && self.is_subtype(rhs_ty, STRING_TYPE) {
                        if !self.constrain_subtype(lhs_ty, STRING_TYPE) {
                            self.error(
                                format!("Expected string, got {}", self.type_to_string(lhs_ty)),
                                lhs.into_indexer(self.compiler),
                            );
                        }
                        STRING_TYPE
                    } else if !rhs_bottom && self.is_subtype(rhs_ty, NUMBER_TYPE) {
                        if !self.constrain_subtype(lhs_ty, NUMBER_TYPE) {
                            self.error(
                                format!("Expected number, got {}", self.type_to_string(lhs_ty)),
                                lhs.into_indexer(self.compiler),
                            );
                        }
                        self.numeric_op_type(lhs_ty, rhs_ty)
                    } else if lhs_bottom && rhs_bottom {
                        common_ty
                    } else {
                        ERROR_TYPE
                    }
                }
            }
            AstNode::Append => {
                // TODO cache these two types
                let top_list = self.push_type(Type::List(TOP_TYPE));
                let bottom_list = self.push_type(Type::List(BOTTOM_TYPE));

                let res_var = self.new_typevar(bottom_list, top_list);
                let res_type = self.push_type(Type::Var(res_var));
                let lhs_type = self.typecheck_expr(lhs, res_type);
                let rhs_type = self.typecheck_expr(rhs, res_type);

                if self.is_subtype(lhs_type, LIST_ANY_TYPE)
                    && self.is_subtype(rhs_type, LIST_ANY_TYPE)
                {
                    res_type
                } else {
                    self.binary_op_err("append", lhs, op, rhs);
                    ERROR_TYPE
                }
            }
            AstNode::Assignment
            | AstNode::AddAssignment
            | AstNode::SubtractAssignment
            | AstNode::MultiplyAssignment
            | AstNode::DivideAssignment
            | AstNode::AppendAssignment => {
                // TODO: actually check if operands are right for operator
                self.typecheck_expr(lhs, TOP_TYPE);
                self.typecheck_expr(rhs, TOP_TYPE);
                NONE_TYPE
            }
            _ => panic!("internal error: unsupported node passed as binary op: {op:?}"),
        }
    }

    fn numeric_op_type(&self, lhs: TypeId, rhs: TypeId) -> TypeId {
        match (self.types[lhs.0], self.types[rhs.0]) {
            (Type::Int, Type::Int) => INT_TYPE,
            (Type::Int, Type::Float) => FLOAT_TYPE,
            (Type::Float, Type::Int) => FLOAT_TYPE,
            (Type::Float, Type::Float) => FLOAT_TYPE,
            _ => NUMBER_TYPE,
        }
    }

    fn typecheck_def(
        &mut self,
        name: &NameOrString,
        params: &NodeId,
        in_out_types: &Option<NodeId>,
        block: &BlockId,
        node_id: StatementNodeId,
    ) {
        let in_out_types = in_out_types
            .map(|ty| {
                let AstNode::InOutTypes(types) = self.compiler.get_node(ty) else {
                    panic!("internal error: return type is not a return type");
                };
                types
                    .iter()
                    .map(|ty| {
                        let AstNode::InOutType(in_ty, out_ty) = self.compiler.get_node(*ty) else {
                            panic!("internal error: return type is not a return type");
                        };
                        InOutType {
                            in_type: self.typecheck_type(in_ty),
                            out_type: self.typecheck_type(out_ty),
                        }
                    })
                    .collect::<Vec<_>>()
            })
            .unwrap_or_default();

        self.typecheck_node(params);
        self.typecheck_block(block, TOP_TYPE);
        node_id.set_node_type_id(self, NONE_TYPE);

        // set input/output types for the command
        let decl_id = self
            .compiler
            .decl_resolution
            .get(&name.into_indexer(self.compiler))
            .expect("missing declared decl");

        if in_out_types.is_empty() {
            self.decl_types[decl_id.0] = vec![InOutType {
                in_type: ANY_TYPE,
                out_type: block.type_id_of(self),
            }];
        } else {
            // TODO check that block output type matches expected type
            self.decl_types[decl_id.0] = in_out_types;
        }
    }

    fn typecheck_alias(
        &mut self,
        new_name: &NameOrString,
        old_name: &NameOrString,
        node_id: StatementNodeId,
    ) {
        node_id.set_node_type_id(self, NONE_TYPE);

        // set input/output types for the command
        let decl_id_new = self
            .compiler
            .decl_resolution
            .get(&new_name.into_indexer(self.compiler))
            .expect("missing declared new name for alias");

        let decl_id_old = self
            .compiler
            .decl_resolution
            .get(&old_name.into_indexer(self.compiler));

        self.decl_types[decl_id_new.0] = decl_id_old.map_or(
            vec![InOutType {
                in_type: ANY_TYPE,
                out_type: BYTE_STREAM_TYPE,
            }],
            |decl_id| self.decl_types[decl_id.0].clone(),
        );
    }

    // TODO: something strange inside this function.
    // The type of `self.compiler.deco_resolution` is unclear.
    fn typecheck_call(
        &mut self,
        head: &[NameNodeId],
        parts: &[ExpressionNodeId],
        node_id: &ExpressionNodeId,
    ) -> TypeId {
        if let Some(decl_id) = self
            .compiler
            .decl_resolution
            .get(&node_id.into_indexer(self.compiler))
        {
            let decl_node_id = self.compiler.decl_nodes[decl_id.0];
            let StatementNode::Def {
                type_params,
                params,
                ..
            } = decl_node_id.get_node(&self.compiler)
            else {
                panic!("Internal error: Expected def")
            };
            let AstNode::Params(params) = params.get_node(self.compiler) else {
                panic!("Internal error: Expected params")
            };

            let type_substs = if let Some(type_params) = type_params {
                let AstNode::TypeParams(type_params) = type_params.get_node(self.compiler) else {
                    panic!("Internal error: expected type params");
                };
                let mut type_substs = HashMap::new();
                for type_param in type_params.iter() {
                    let type_decl_id = *self
                        .compiler
                        .type_resolution
                        .get(&NameOrVariable::Name(*type_param))
                        .expect("should already resolved in resolver");
                    let var = self.new_typevar(BOTTOM_TYPE, TOP_TYPE);
                    type_substs.insert(type_decl_id, var);
                }
                type_substs
            } else {
                HashMap::new()
            };

            let num_args = parts.len() - head.len();
            if params.len() != num_args {
                self.error(
                    format!("Expected {} argument(s), got {}", params.len(), num_args),
                    node_id.into_indexer(self.compiler),
                );
            }
            for (param, arg) in params.iter().zip(parts) {
                let expected = self.type_id_of(*param);
                let expected = self.subst(expected, &type_substs);
                if matches!(arg.get_node(&self.compiler), ExpressionNode::Name(_)) {
                    arg.set_node_type_id(self, STRING_TYPE);
                    if !self.constrain_subtype(STRING_TYPE, expected) {
                        self.error(
                            format!("Expected {}, got string", self.type_to_string(expected)),
                            arg.into_indexer(self.compiler),
                        );
                    }
                } else {
                    self.typecheck_expr(arg, expected);
                }
            }
            if num_args > params.len() {
                // Typecheck extra arguments too
                for arg in &parts[params.len()..] {
                    if matches!(arg.get_node(&self.compiler), ExpressionNode::Name(_)) {
                        arg.set_node_type_id(self, STRING_TYPE);
                    } else {
                        self.typecheck_expr(arg, TOP_TYPE);
                    }
                }
            }

            // TODO base this on pipeline input type
            let out_types = self.decl_types[decl_id.0]
                .clone()
                .iter()
                .map(|io| self.subst(io.out_type, &type_substs))
                .collect();
            self.create_oneof(out_types)
        } else {
            // external call
            for h in head {
                h.set_node_type_id(self, STRING_TYPE);
            }
            for part in parts {
                self.typecheck_expr(part, TOP_TYPE);
            }

            BYTE_STREAM_TYPE
        }
    }

    fn typecheck_let(
        &mut self,
        variable_name: &VariableNodeId,
        ty: &Option<NodeId>,
        initializer: &ExpressionNodeId,
        node_id: StatementNodeId,
    ) {
        let type_id = if let Some(ty) = ty {
            let ty_id = self.typecheck_type(ty);
            self.typecheck_expr(initializer, ty_id);
            ty_id
        } else {
            self.typecheck_expr(initializer, TOP_TYPE)
        };

        let var_id = self
            .compiler
            .var_resolution
            .get(&NameOrVariable::Variable(*variable_name))
            .expect("missing declared variable");

        self.variable_types[var_id.0] = type_id;
        variable_name.set_node_type_id(self, type_id);
        node_id.set_node_type_id(self, NONE_TYPE);
    }

    fn typecheck_type(&mut self, node_id: &NodeId) -> TypeId {
        let ty_id = match node_id.get_node(&self.compiler) {
            AstNode::Type {
                name,
                args,
                optional,
            } => self.typecheck_type_ref(name, args, optional),
            AstNode::RecordType {
                fields,
                optional: _, // TODO handle optional record types
            } => {
                let AstNode::Params(field_nodes) = fields.get_node(&self.compiler) else {
                    panic!("internal error: record fields aren't Params");
                };
                let mut fields = field_nodes
                    .iter()
                    .map(|field| {
                        let AstNode::Param { name, ty } = field.get_node(&self.compiler) else {
                            panic!("internal error: record field isn't Param");
                        };
                        let ty_id = match ty {
                            Some(ty) => {
                                self.typecheck_type(ty);
                                self.type_id_of(*ty)
                            }
                            None => ANY_TYPE,
                        };
                        let expr_node_id = self
                            .compiler
                            .name_to_expression
                            .get(name)
                            .expect("the Expression::Name should exist");
                        (ExpressionNodeId(expr_node_id.0), ty_id)
                    })
                    .collect::<Vec<_>>();
                // Store fields sorted by name
                fields.sort_by_cached_key(|(name, _)| name.get_span_contents(&self.compiler));

                self.record_types.push(fields);
                self.push_type(Type::Record(RecordTypeId(self.record_types.len() - 1)))
            }
            _ => {
                self.error(
                    format!(
                        "Internal error: expected type, got '{:?}'",
                        node_id.get_node(&self.compiler)
                    ),
                    node_id.into_indexer(self.compiler),
                );
                ERROR_TYPE
            }
        };
        node_id.set_node_type_id(self, ty_id);
        ty_id
    }

    fn typecheck_type_ref(
        &mut self,
        name_id: &NameNodeId,
        args_id: &Option<NodeId>,
        _optional: &bool,
    ) -> TypeId {
        let name = name_id.get_span_contents(&self.compiler);

        // taken from parse_shape_name() in Nushell:
        match name {
            b"any" => ANY_TYPE,
            // b"binary" => SyntaxShape::Binary,
            // b"block" => // not possible to pass blocks
            b"list" => {
                if let Some(args_id) = args_id {
                    self.typecheck_node(args_id);

                    if let AstNode::TypeArgs(args) = args_id.get_node(&self.compiler) {
                        if args.len() > 1 {
                            let types =
                                String::from_utf8_lossy(args_id.get_span_contents(&self.compiler));
                            self.error(format!("list must have only one type argument (to allow selection of types, use oneof{} -- WIP)", types), args_id.into_indexer(self.compiler));
                            self.push_type(Type::List(UNKNOWN_TYPE))
                        } else if args.is_empty() {
                            self.error(
                                "list must have one type argument",
                                args_id.into_indexer(self.compiler),
                            );
                            self.push_type(Type::List(UNKNOWN_TYPE))
                        } else {
                            let args_ty_id = self.type_id_of(args[0]);
                            self.push_type(Type::List(args_ty_id))
                        }
                    } else {
                        panic!("args are not args");
                    }
                } else {
                    LIST_ANY_TYPE
                }
            }
            b"bool" => BOOL_TYPE,
            // b"cell-path" => SyntaxShape::CellPath,
            b"closure" => CLOSURE_TYPE, //FIXME: Closures should have known output types
            // b"datetime" => SyntaxShape::DateTime,
            // b"directory" => SyntaxShape::Directory,
            // b"duration" => SyntaxShape::Duration,
            // b"error" => SyntaxShape::Error,
            b"float" => FLOAT_TYPE,
            // b"filesize" => SyntaxShape::Filesize,
            // b"glob" => SyntaxShape::GlobPattern,
            b"int" => INT_TYPE,
            // _ if bytes.starts_with(b"list") => parse_list_shape(working_set, bytes, span, use_loc),
            b"nothing" => NOTHING_TYPE,
            b"number" => NUMBER_TYPE,
            // b"path" => SyntaxShape::Filepath,
            // b"range" => SyntaxShape::Range,
            // _ if bytes.starts_with(b"record") => {
            //     parse_collection_shape(working_set, bytes, span, use_loc)
            // }
            b"string" => STRING_TYPE,
            // _ if bytes.starts_with(b"table") => {
            //     parse_collection_shape(working_set, bytes, span, use_loc)
            // }
            _ => {
                // if bytes.contains(&b'@') {
                //     // type with completion
                // } else {
                if let Some(type_decl) = self
                    .compiler
                    .type_resolution
                    .get(&NameOrVariable::Name(*name_id))
                {
                    self.push_type(Type::Ref(*type_decl))
                } else {
                    UNKNOWN_TYPE
                }
                // }
            }
        }
    }

    /// Add a new type and return its ID. To save space, common types are not pushed and their ID is
    /// returned directly.
    fn push_type(&mut self, ty: Type) -> TypeId {
        match ty {
            Type::Unknown => UNKNOWN_TYPE,
            Type::Forbidden => FORBIDDEN_TYPE,
            Type::Error => ERROR_TYPE,
            Type::None => NONE_TYPE,
            Type::Top => TOP_TYPE,
            Type::Bottom => BOTTOM_TYPE,
            Type::Any => ANY_TYPE,
            Type::Number => NUMBER_TYPE,
            Type::Nothing => NOTHING_TYPE,
            Type::Int => INT_TYPE,
            Type::Float => FLOAT_TYPE,
            Type::Bool => BOOL_TYPE,
            Type::String => STRING_TYPE,
            Type::Closure => CLOSURE_TYPE,
            Type::List(ANY_TYPE) => LIST_ANY_TYPE,
            _ => {
                self.types.push(ty);
                TypeId(self.types.len() - 1)
            }
        }
    }

    /// Replace type parameters (universal type variables) with existential type variables that can be solved
    fn subst(&mut self, ty_id: TypeId, substs: &HashMap<TypeDeclId, TypeVarId>) -> TypeId {
        if substs.is_empty() {
            return ty_id;
        }
        match self.types[ty_id.0] {
            Type::Unknown
            | Type::Forbidden
            | Type::Error
            | Type::None
            | Type::Top
            | Type::Bottom
            | Type::Any
            | Type::Number
            | Type::Nothing
            | Type::Int
            | Type::Float
            | Type::Bool
            | Type::String
            | Type::Binary
            | Type::Var(_) => ty_id,
            Type::Closure => todo!(),
            Type::List(elem_ty) => {
                let new_elem = self.subst(elem_ty, substs);
                if elem_ty == new_elem {
                    ty_id
                } else {
                    self.push_type(Type::List(new_elem))
                }
            }
            Type::Stream(elem_ty) => {
                let new_elem = self.subst(elem_ty, substs);
                if elem_ty == new_elem {
                    ty_id
                } else {
                    self.push_type(Type::Stream(new_elem))
                }
            }
            Type::Record(record_type_id) => {
                let mut fields = self.record_types[record_type_id.0].clone();
                for (_, ty) in fields.iter_mut() {
                    *ty = self.subst(*ty, substs);
                }
                self.record_types.push(fields);
                self.push_type(Type::Record(RecordTypeId(self.record_types.len() - 1)))
            }
            Type::OneOf(id) => {
                let orig_types = self.oneof_types[id.0].clone();
                let mut new_types = HashSet::new();
                for ty in orig_types.iter() {
                    new_types.insert(self.subst(*ty, substs));
                }
                self.oneof_types.push(new_types);
                self.push_type(Type::OneOf(OneOfId(self.oneof_types.len() - 1)))
            }
            Type::AllOf(id) => {
                let orig_types = self.allof_types[id.0].clone();
                let mut new_types = HashSet::new();
                for ty in orig_types.iter() {
                    new_types.insert(self.subst(*ty, substs));
                }
                self.allof_types.push(new_types);
                self.push_type(Type::AllOf(AllOfId(self.allof_types.len() - 1)))
            }
            Type::Ref(type_decl_id) => {
                if let Some(var) = substs.get(&type_decl_id) {
                    self.push_type(Type::Var(*var))
                } else {
                    ty_id
                }
            }
        }
    }

    /// Given the type for a list, extract the type of its elements
    fn extract_elem_type(&mut self, list_ty: TypeId) -> Option<TypeId> {
        match self.types[list_ty.0] {
            Type::List(elem) => Some(elem),
            Type::Top => Some(TOP_TYPE),
            Type::Bottom => Some(BOTTOM_TYPE),
            Type::Any => Some(ANY_TYPE),
            Type::Unknown => Some(UNKNOWN_TYPE),
            _ => None,
        }
    }

    fn new_typevar(&mut self, lower_bound: TypeId, upper_bound: TypeId) -> TypeVarId {
        self.type_vars.push(TypeVar {
            lower_bound,
            upper_bound,
        });
        TypeVarId(self.type_vars.len() - 1)
    }

    /// Check if `sub` is a subtype of `supe`
    ///
    /// Returns `false` if there is a type mismatch, `true` otherwise
    /// TODO: return a Result with a message about constraints not being solvable or something
    fn constrain_subtype(&mut self, sub_id: TypeId, supe_id: TypeId) -> bool {
        if sub_id == supe_id {
            return true;
        }
        match (self.types[sub_id.0], self.types[supe_id.0]) {
            (_, Type::Top | Type::Any | Type::Unknown) => true,
            (Type::Bottom | Type::Any | Type::Unknown, _) => true,
            (Type::Int | Type::Float | Type::Number, Type::Number) => true,
            (Type::List(inner_sub), Type::List(inner_supe)) => {
                self.constrain_subtype(inner_sub, inner_supe)
            }
            (Type::Record(sub_rec_id), Type::Record(supe_rec_id)) => {
                let sub_fields = self.record_types[sub_rec_id.0].clone();
                let supe_fields = self.record_types[supe_rec_id.0].clone();

                let mut i = 0;
                let mut j = 0;
                while i < sub_fields.len() && j < supe_fields.len() {
                    let (sub_name, sub_ty) = sub_fields[i];
                    let (supe_name, supe_ty) = supe_fields[j];
                    let sub_text = sub_name.get_span_contents(self.compiler);
                    let supe_text = supe_name.get_span_contents(self.compiler);
                    match sub_text.cmp(supe_text) {
                        Ordering::Less => {
                            i += 1;
                        }
                        Ordering::Greater => {
                            // The field is in the supertype but not the subtype
                            return false;
                        }
                        Ordering::Equal => {
                            if !self.constrain_subtype(sub_ty, supe_ty) {
                                return false;
                            }
                            i += 1;
                            j += 1;
                        }
                    }
                }

                true
            }
            (Type::Var(var_id), _) => {
                let lb = self.type_vars[var_id.0].lower_bound;
                let ub = self.type_vars[var_id.0].upper_bound;
                let mut types = HashSet::new();
                types.insert(ub);
                types.insert(supe_id);
                let new_ub = self.create_allof(types);
                // Prevent forward references/cycles
                let new_ub = self.eliminate_type_vars(new_ub, var_id, true);

                if self.constrain_subtype(lb, new_ub) {
                    let var = self
                        .type_vars
                        .get_mut(var_id.0)
                        .expect("type variable must exist");
                    var.upper_bound = new_ub;
                    true
                } else {
                    false
                }
            }
            (_, Type::Var(var_id)) => {
                let lb = self.type_vars[var_id.0].lower_bound;
                let ub = self.type_vars[var_id.0].upper_bound;
                let mut types = HashSet::new();
                types.insert(lb);
                types.insert(sub_id);
                let new_lb = self.create_oneof(types);
                // Prevent forward references/cycles
                let new_lb = self.eliminate_type_vars(new_lb, var_id, false);

                if self.constrain_subtype(new_lb, ub) {
                    let var = self
                        .type_vars
                        .get_mut(var_id.0)
                        .expect("type variable must exist");
                    var.lower_bound = new_lb;
                    true
                } else {
                    false
                }
            }
            (Type::OneOf(id), _) => self.oneof_types[id.0]
                .clone()
                .iter()
                .all(|ty| self.constrain_subtype(*ty, supe_id)),
            (_, Type::OneOf(id)) => {
                // TODO: actually add constraints?
                self.oneof_types[id.0]
                    .clone()
                    .iter()
                    .any(|ty| self.is_subtype(sub_id, *ty))
            }
            (sub, supe) if sub == supe => true,
            _ => false,
        }
    }

    /// Check if `sub` is a subtype of `supe`
    /// TODO: reduce duplication between this and constrain_subtype
    fn is_subtype(&self, sub: TypeId, supe: TypeId) -> bool {
        if sub == supe {
            return true;
        }
        match (self.types[sub.0], self.types[supe.0]) {
            (_, Type::Top | Type::Any | Type::Unknown) => true,
            (Type::Bottom | Type::Any | Type::Unknown, _) => true,
            (Type::Int | Type::Float | Type::Number, Type::Number) => true,
            (Type::List(inner_sub), Type::List(inner_supe)) => {
                self.is_subtype(inner_sub, inner_supe)
            }
            (Type::Record(sub_rec_id), Type::Record(supe_rec_id)) => {
                let sub_fields = self.record_types[sub_rec_id.0].clone();
                let supe_fields = self.record_types[supe_rec_id.0].clone();

                let mut i = 0;
                let mut j = 0;
                while i < sub_fields.len() && j < supe_fields.len() {
                    let (sub_name, sub_ty) = sub_fields[i];
                    let (supe_name, supe_ty) = supe_fields[j];
                    let sub_text = sub_name.get_span_contents(self.compiler);
                    let supe_text = supe_name.get_span_contents(self.compiler);
                    match sub_text.cmp(supe_text) {
                        Ordering::Less => {
                            i += 1;
                        }
                        Ordering::Greater => {
                            // The field is in the supertype but not the subtype
                            return false;
                        }
                        Ordering::Equal => {
                            if !self.is_subtype(sub_ty, supe_ty) {
                                return false;
                            }
                            i += 1;
                            j += 1;
                        }
                    }
                }

                true
            }
            (Type::Var(var_id), _) => {
                let var = &self.type_vars[var_id.0];
                self.is_subtype(var.upper_bound, supe)
            }
            (_, Type::Var(var_id)) => {
                let var = &self.type_vars[var_id.0];
                self.is_subtype(sub, var.lower_bound)
            }
            (Type::OneOf(id), _) => self.oneof_types[id.0]
                .clone()
                .iter()
                .all(|ty| self.is_subtype(*ty, supe)),
            (_, Type::OneOf(id)) => self.oneof_types[id.0]
                .iter()
                .any(|ty| self.is_subtype(sub, *ty)),
            (sub, supe) => sub == supe,
        }
    }

    /// Eliminate all type variables that are greater than or equal to `max_var`
    /// * `use_lower`: If true, replace type variables with their lower bound.
    ///   Otherwise, replace with their upper bound
    fn eliminate_type_vars(
        &mut self,
        ty_id: TypeId,
        max_var: TypeVarId,
        use_lower: bool,
    ) -> TypeId {
        match self.types[ty_id.0] {
            Type::Unknown
            | Type::Forbidden
            | Type::Error
            | Type::None
            | Type::Top
            | Type::Bottom
            | Type::Any
            | Type::Number
            | Type::Nothing
            | Type::Int
            | Type::Float
            | Type::Bool
            | Type::String
            | Type::Binary
            | Type::Ref(_) => ty_id,
            Type::Closure => ty_id,
            Type::List(inner_ty) => {
                let new_inner = self.eliminate_type_vars(inner_ty, max_var, use_lower);
                if inner_ty == new_inner {
                    ty_id
                } else {
                    self.push_type(Type::List(new_inner))
                }
            }
            Type::Stream(inner_ty) => {
                let new_inner = self.eliminate_type_vars(inner_ty, max_var, use_lower);
                if inner_ty == new_inner {
                    ty_id
                } else {
                    self.push_type(Type::Stream(new_inner))
                }
            }
            Type::Record(record_type_id) => {
                let mut changed = false;
                let mut fields = self.record_types[record_type_id.0].clone();
                for (_, ty) in fields.iter_mut() {
                    let res = self.eliminate_type_vars(*ty, max_var, use_lower);
                    if res != *ty {
                        *ty = res;
                        changed = true;
                    }
                }
                if changed {
                    self.record_types.push(fields);
                    self.push_type(Type::Record(RecordTypeId(self.record_types.len() - 1)))
                } else {
                    ty_id
                }
            }
            Type::OneOf(id) => {
                let orig_types = self.oneof_types[id.0].clone();
                let mut new_types = HashSet::new();
                for ty in orig_types.iter() {
                    new_types.insert(self.eliminate_type_vars(*ty, max_var, use_lower));
                }
                self.oneof_types.push(new_types);
                self.push_type(Type::OneOf(OneOfId(self.oneof_types.len() - 1)))
            }
            Type::AllOf(id) => {
                let orig_types = self.allof_types[id.0].clone();
                let mut new_types = HashSet::new();
                for ty in orig_types.iter() {
                    new_types.insert(self.eliminate_type_vars(*ty, max_var, use_lower));
                }
                self.allof_types.push(new_types);
                self.push_type(Type::AllOf(AllOfId(self.allof_types.len() - 1)))
            }
            Type::Var(var_id) => {
                if var_id.0 < max_var.0 {
                    ty_id
                } else {
                    let var = &self.type_vars[var_id.0];
                    let repl = if use_lower {
                        var.lower_bound
                    } else {
                        var.upper_bound
                    };
                    self.eliminate_type_vars(repl, max_var, use_lower)
                }
            }
        }
    }

    fn type_to_string(&self, type_id: TypeId) -> String {
        let ty = &self.types[type_id.0];

        match ty {
            Type::Unknown => "unknown".to_string(),
            Type::Forbidden => "forbidden".to_string(),
            Type::None => "()".to_string(),
            Type::Error => "error".to_string(),
            Type::Top => "top".to_string(),
            Type::Bottom => "bottom".to_string(),
            Type::Any => "any".to_string(),
            Type::Number => "number".to_string(),
            Type::Nothing => "nothing".to_string(),
            Type::Int => "int".to_string(),
            Type::Float => "float".to_string(),
            Type::Bool => "bool".to_string(),
            Type::Binary => "binary".to_string(),
            Type::String => "string".to_string(),
            Type::Closure => "closure".to_string(),
            Type::List(subtype_id) => {
                format!("list<{}>", self.type_to_string(*subtype_id))
            }
            Type::Stream(subtype_id) => {
                format!("stream<{}>", self.type_to_string(*subtype_id))
            }
            Type::Record(id) => {
                let mut fmt = "record<".to_string();
                let types = &self.record_types[id.0];
                for (name, ty) in types {
                    fmt += &String::from_utf8_lossy(name.get_span_contents(&self.compiler));
                    fmt += ": ";
                    fmt += &self.type_to_string(*ty);
                    fmt += ", ";
                }
                if !types.is_empty() {
                    fmt.pop();
                    fmt.pop();
                }
                fmt.push('>');
                fmt
            }
            Type::OneOf(id) => {
                let mut fmt = "oneof<".to_string();
                let mut types: Vec<_> = self.oneof_types[id.0]
                    .iter()
                    .map(|ty| self.type_to_string(*ty) + ", ")
                    .collect();
                types.sort();
                for ty in &types {
                    fmt += ty;
                }
                if !types.is_empty() {
                    fmt.pop();
                    fmt.pop();
                }
                fmt.push('>');
                fmt
            }
            Type::AllOf(id) => {
                let mut fmt = "allof<".to_string();
                let mut types: Vec<_> = self.allof_types[id.0]
                    .iter()
                    .map(|ty| self.type_to_string(*ty) + ", ")
                    .collect();
                types.sort();
                for ty in &types {
                    fmt += ty;
                }
                if !types.is_empty() {
                    fmt.pop();
                    fmt.pop();
                }
                fmt.push('>');
                fmt
            }
            Type::Ref(type_decl_id) => match self.compiler.type_decls[type_decl_id.0] {
                TypeDecl::Param(name_node) => {
                    String::from_utf8_lossy(name_node.get_span_contents(&self.compiler)).to_string()
                }
            },
            Type::Var(type_var_id) => {
                let var = &self.type_vars[type_var_id.0];
                format!(
                    "{} <: '{} <: {}",
                    self.type_to_string(var.lower_bound),
                    type_var_id.0,
                    self.type_to_string(var.upper_bound)
                )
            }
        }
    }

    /// Check if one type can be cast to another type
    fn is_type_compatible(&self, lhs: Type, rhs: Type) -> bool {
        match (lhs, rhs) {
            (Type::Int, Type::Number) => true,
            (Type::Float, Type::Number) => true,
            (Type::Number, Type::Int) => true,
            (Type::Number, Type::Float) => true,
            (Type::Any, _) => true,
            (_, Type::Any) => true,
            (Type::Record(lhs_id), Type::Record(rhs_id)) => {
                let lhs_fields = &self.record_types[lhs_id.0];
                let rhs_fields = &self.record_types[rhs_id.0];

                let mut l = 0;
                let mut r = 0;
                while l < lhs_fields.len() && r < rhs_fields.len() {
                    let (lhs_name, lhs_ty) = lhs_fields[l];
                    let (rhs_name, rhs_ty) = rhs_fields[r];
                    let lhs_text = lhs_name.get_span_contents(&self.compiler);
                    let rhs_text = rhs_name.get_span_contents(&self.compiler);
                    match lhs_text.cmp(rhs_text) {
                        Ordering::Less => {
                            l += 1;
                        }
                        Ordering::Greater => {
                            r += 1;
                        }
                        Ordering::Equal => {
                            if !self.is_type_compatible(self.types[lhs_ty.0], self.types[rhs_ty.0])
                            {
                                return false;
                            }
                            l += 1;
                            r += 1;
                        }
                    }
                }
                true
            }
            _ => lhs == rhs,
        }
    }

    fn error(&mut self, msg: impl Into<String>, node_id: NodeIndexer) {
        self.errors.push(SourceError {
            message: msg.into(),
            node_id,
            severity: Severity::Error,
        })
    }

    fn binary_op_err(
        &mut self,
        op_msg: &str,
        lhs: &ExpressionNodeId,
        op: &NodeId,
        rhs: &ExpressionNodeId,
    ) {
        self.error(
            format!(
                "type mismatch: unsupported {} between {} and {}",
                op_msg,
                self.type_to_string(lhs.type_id_of(self)),
                self.type_to_string(rhs.type_id_of(self)),
            ),
            op.into_indexer(self.compiler),
        );
        op.set_node_type_id(self, ERROR_TYPE);
    }

    fn add_resolved_types(&mut self, types: &mut HashSet<TypeId>, ty: &TypeId) {
        if let Type::OneOf(id) = self.types[ty.0] {
            types.extend(self.oneof_types[id.0].clone());
        } else {
            types.insert(*ty);
        }
    }

    /// Use this to create any union types, to ensure that the created union type
    /// is as simple as possible
    fn create_oneof(&mut self, types: HashSet<TypeId>) -> TypeId {
        let mut flattened = HashSet::new();
        for ty_id in types {
            match self.types[ty_id.0] {
                Type::Top | Type::Any | Type::Unknown => return ty_id,
                Type::Bottom => {}
                Type::OneOf(id) => {
                    flattened.extend(&self.oneof_types[id.0]);
                }
                _ => {
                    flattened.insert(ty_id);
                }
            }
        }

        if flattened.is_empty() {
            return BOTTOM_TYPE;
        }

        let mut simple_types = HashSet::<TypeId>::new();
        let mut list_elems = HashSet::new();
        let mut record_fields = HashMap::<&[u8], (ExpressionNodeId, HashSet<TypeId>)>::new();
        for ty_id in flattened {
            if simple_types.contains(&ty_id) {
                continue;
            }

            let ty = self.types[ty_id.0];

            if ty == Type::Int && simple_types.contains(&FLOAT_TYPE) {
                simple_types.remove(&FLOAT_TYPE);
                simple_types.insert(NUMBER_TYPE);
                continue;
            }
            if ty == Type::Float && simple_types.contains(&INT_TYPE) {
                simple_types.remove(&INT_TYPE);
                simple_types.insert(NUMBER_TYPE);
                continue;
            }

            match ty {
                Type::Int if simple_types.contains(&FLOAT_TYPE) => {
                    simple_types.remove(&FLOAT_TYPE);
                    simple_types.insert(NUMBER_TYPE);
                }
                Type::Float if simple_types.contains(&INT_TYPE) => {
                    simple_types.remove(&INT_TYPE);
                    simple_types.insert(NUMBER_TYPE);
                }
                Type::List(elem_ty) => {
                    list_elems.insert(elem_ty);
                }
                Type::Record(rec_ty_id) => {
                    let new_fields = &self.record_types[rec_ty_id.0];
                    for (name_node, ty) in new_fields.iter() {
                        let name = name_node.get_span_contents(&self.compiler);
                        if let Some((_, types)) = record_fields.get_mut(&name) {
                            types.insert(*ty);
                        } else {
                            let mut types = HashSet::new();
                            types.insert(*ty);
                            record_fields.insert(name, (*name_node, types));
                        }
                    }
                }
                _ => {
                    let mut add = true;
                    let mut remove = HashSet::new();
                    for other_id in simple_types.iter() {
                        if self.is_subtype(ty_id, *other_id) {
                            add = false;
                            break;
                        }
                        if self.is_subtype(*other_id, ty_id) {
                            remove.insert(*other_id);
                        }
                    }

                    if add {
                        simple_types.insert(ty_id);
                        for other in remove {
                            simple_types.remove(&other);
                        }
                    }
                }
            }
        }

        if !list_elems.is_empty() {
            let elem_oneof = self.create_oneof(list_elems);
            simple_types.insert(self.push_type(Type::List(elem_oneof)));
        }

        if !record_fields.is_empty() {
            let mut fields = Vec::new();
            for (_, (node, types)) in record_fields.into_iter() {
                fields.push((node, self.create_oneof(types)));
            }
            fields.sort_by_cached_key(|(name_node, _)| name_node.get_span_contents(&self.compiler));

            let rec_ty_id = RecordTypeId(self.record_types.len());
            self.record_types.push(fields);
            simple_types.insert(self.push_type(Type::Record(rec_ty_id)));
        }

        if simple_types.len() == 1 {
            *simple_types
                .iter()
                .next()
                .expect("should have exactly 1 element")
        } else {
            self.oneof_types.push(simple_types);
            self.push_type(Type::OneOf(OneOfId(self.oneof_types.len() - 1)))
        }
    }

    /// Use this to create any intersection types, to ensure that the created intersection type
    /// is as simple as possible
    fn create_allof(&mut self, types: HashSet<TypeId>) -> TypeId {
        let mut flattened = HashSet::new();
        for ty_id in types {
            match self.types[ty_id.0] {
                Type::AllOf(id) => {
                    flattened.extend(&self.allof_types[id.0]);
                }
                _ => {
                    flattened.insert(ty_id);
                }
            }
        }

        if flattened.is_empty() {
            return TOP_TYPE;
        }

        let mut vars = HashMap::<TypeVarId, TypeId>::new();
        let mut refs = HashMap::<TypeDeclId, TypeId>::new();
        let mut simple_type: Option<TypeId> = None;
        let mut list_elems = HashSet::new();
        let mut record_fields = HashMap::<&[u8], (ExpressionNodeId, HashSet<TypeId>)>::new();
        let mut oneof_ids = Vec::new();
        for ty_id in flattened {
            let ty = self.types[ty_id.0];

            match ty {
                Type::Any => return ANY_TYPE,
                Type::Unknown => return UNKNOWN_TYPE,
                Type::Top => {}
                Type::Bottom => return BOTTOM_TYPE,
                Type::Var(var_id) => {
                    vars.insert(var_id, ty_id);
                }
                Type::Ref(decl_id) => {
                    refs.insert(decl_id, ty_id);
                }
                Type::List(elem_ty) => {
                    if simple_type.is_some() || !record_fields.is_empty() {
                        return BOTTOM_TYPE;
                    }
                    list_elems.insert(elem_ty);
                }
                Type::Record(rec_ty_id) => {
                    if simple_type.is_some() || !list_elems.is_empty() {
                        return BOTTOM_TYPE;
                    }
                    let new_fields = &self.record_types[rec_ty_id.0];
                    for (name_node, ty) in new_fields.iter() {
                        let name = name_node.get_span_contents(&self.compiler);
                        if let Some((_, types)) = record_fields.get_mut(&name) {
                            types.insert(*ty);
                        } else {
                            let mut types = HashSet::new();
                            types.insert(*ty);
                            record_fields.insert(name, (*name_node, types));
                        }
                    }
                }
                Type::OneOf(id) => {
                    oneof_ids.push(id);
                }
                _ => {
                    if !list_elems.is_empty() && !record_fields.is_empty() {
                        return BOTTOM_TYPE;
                    }
                    if let Some(other_id) = &simple_type {
                        if self.is_subtype(ty_id, *other_id) {
                            simple_type = Some(ty_id);
                        } else if self.is_subtype(*other_id, ty_id) {
                        } else {
                            return BOTTOM_TYPE;
                        }
                    } else {
                        simple_type = Some(ty_id);
                    }
                }
            }
        }

        let mut res = HashSet::new();
        res.extend(vars.values());
        res.extend(refs.values());

        if let Some(ty) = simple_type {
            res.insert(ty);
        }
        if !list_elems.is_empty() {
            let elem_allof = self.create_allof(list_elems);
            res.insert(self.push_type(Type::List(elem_allof)));
        }
        if !record_fields.is_empty() {
            let mut fields = Vec::new();
            for (_, (node, types)) in record_fields.into_iter() {
                fields.push((node, self.create_oneof(types)));
            }
            fields.sort_by_cached_key(|(name_node, _)| name_node.get_span_contents(&self.compiler));

            let rec_ty_id = RecordTypeId(self.record_types.len());
            self.record_types.push(fields);
            res.insert(self.push_type(Type::Record(rec_ty_id)));
        }

        let single_res = if res.is_empty() {
            TOP_TYPE
        } else if res.len() == 1 {
            *res.iter().next().expect("should have exactly 1 element")
        } else {
            self.allof_types.push(res);
            self.push_type(Type::AllOf(AllOfId(self.allof_types.len() - 1)))
        };

        if oneof_ids.is_empty() {
            return single_res;
        }

        let mut first_inter = HashSet::new();
        first_inter.insert(single_res);
        let mut inters = vec![first_inter];

        for oneof_id in oneof_ids {
            let mut new_inters = vec![];
            let types = &self.oneof_types[oneof_id.0];
            for ty in types.iter() {
                for mut inter in inters.clone() {
                    inter.insert(*ty);
                    new_inters.push(inter);
                }
            }
            inters = new_inters;
        }

        let inters = inters
            .into_iter()
            .map(|inter| self.create_allof(inter))
            .collect::<HashSet<_>>();

        self.create_oneof(inters)
    }
}

trait NodeTypeSetter {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId);
    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId;
}

impl NodeTypeSetter for NameNodeId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.name_node_types[self.0] = type_id;
        // should also set relative expression type.
        let exp_node = typechecker
            .compiler
            .name_to_expression
            .get(self)
            .expect("should exists");
        typechecker.expression_node_types[exp_node.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.name_node_types[self.0]
    }
}

impl NodeTypeSetter for StringNodeId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        // should also set relative expression type.
        let exp_node = typechecker
            .compiler
            .string_to_expression
            .get(self)
            .expect("should exists");
        typechecker.expression_node_types[exp_node.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.string_node_types[self.0]
    }
}

impl NodeTypeSetter for VariableNodeId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.variable_node_types[self.0] = type_id;
        // should also set relative expression type.
        let exp_node = typechecker
            .compiler
            .variable_to_expression
            .get(self)
            .expect("should exists");
        typechecker.expression_node_types[exp_node.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.variable_node_types[self.0]
    }
}

impl NodeTypeSetter for NodeId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.node_types[self.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.node_types[self.0]
    }
}

impl NodeTypeSetter for ExpressionNodeId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.expression_node_types[self.0] = type_id;
        // NOTE: is it necessary to set underlying name_node_types or variable_node_types?
        let node = self.get_node(&typechecker.compiler);
        match node {
            ExpressionNode::Name(name_id) => typechecker.name_node_types[name_id.0] = type_id,
            ExpressionNode::Variable(var_id) => typechecker.variable_node_types[var_id.0] = type_id,
            _ => (),
        }
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.expression_node_types[self.0]
    }
}

impl NodeTypeSetter for StatementNodeId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.statement_node_types[self.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.statement_node_types[self.0]
    }
}

impl NodeTypeSetter for BlockId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.block_node_types[self.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.block_node_types[self.0]
    }
}

impl NodeTypeSetter for PipelineId {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        typechecker.pipeline_node_types[self.0] = type_id;
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        typechecker.pipeline_node_types[self.0]
    }
}

impl NodeTypeSetter for StatementOrExpression {
    fn set_node_type_id(&self, typechecker: &mut Typechecker, type_id: TypeId) {
        match self {
            StatementOrExpression::Statement(stmt_id) => {
                stmt_id.set_node_type_id(typechecker, type_id)
            }
            StatementOrExpression::Expression(expr_id) => {
                expr_id.set_node_type_id(typechecker, type_id)
            }
        }
    }

    fn type_id_of(&self, typechecker: &Typechecker) -> TypeId {
        match self {
            StatementOrExpression::Statement(stmt_id) => stmt_id.type_id_of(typechecker),
            StatementOrExpression::Expression(expr_id) => expr_id.type_id_of(typechecker),
        }
    }
}
