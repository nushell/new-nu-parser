use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::parser::{AstNode, BlockId, Expr, NodeId, Stmt, TypeAst};
use std::cmp::Ordering;
use std::collections::HashSet;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct TypeId(pub usize);

/// Input/output type pair of a closure/command
#[derive(Debug, Clone)]
pub struct InOutType {
    pub in_type: TypeId,
    pub out_type: TypeId,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct RecordTypeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct OneOfId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Type {
    /// Any node that hasn't been touched by the typechecker will have this type
    Unknown,
    /// Some nodes shouldn't be directly evaluated (like operators). These will have a "forbidden"
    /// to differentiate them from the "unknown" type.
    Forbidden,
    /// None type means that a node has no type. For example, statements like let x = ... do not
    /// output anything and thus don't have any type.
    None,
    Any,
    Top,
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
    OneOf(OneOfId),
    Error,
}

pub struct Types {
    pub types: Vec<Type>,
    pub node_types: Vec<TypeId>,
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

pub struct Typechecker<'a> {
    /// Immutable reference to a compiler after the name binding pass
    compiler: &'a Compiler,

    /// Types referenced by TypeId
    types: Vec<Type>,

    /// Types of nodes. Each type in this vector matches a node in compiler.ast_nodes at the same position.
    pub node_types: Vec<TypeId>,
    /// Record fields used for `RecordType`. Each value in this vector matches with the index in RecordTypeId.
    /// The individual field lists are stored sorted by field name.
    pub record_types: Vec<Vec<(NodeId, TypeId)>>,
    /// Types used for `OneOf`. Each value in this vector matches with the index in OneOfId
    pub oneof_types: Vec<HashSet<TypeId>>,
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
            ],
            node_types: vec![UNKNOWN_TYPE; compiler.ast_nodes.len()],
            record_types: Vec::new(),
            oneof_types: Vec::new(),
            variable_types: vec![UNKNOWN_TYPE; compiler.variables.len()],
            decl_types: vec![vec![]; compiler.decls.len()],
            errors: vec![],
        }
    }

    pub fn to_types(self) -> Types {
        Types {
            types: self.types,
            node_types: self.node_types,
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

        for (idx, node_type_id) in self.node_types.iter().enumerate() {
            result.push_str(&format!(
                "{}: {}\n",
                idx,
                self.type_to_string(*node_type_id)
            ));
        }

        if !self.errors.is_empty() {
            result.push_str("==== TYPE ERRORS ====\n");
            for error in &self.errors {
                result.push_str(&format!(
                    "{:?} (NodeId {}): {}\n",
                    error.severity, error.node_id.0, error.message
                ));
            }
        }

        result
    }

    /// Typecheck AST nodes, starting from the last node
    pub fn typecheck(&mut self) {
        if !self.compiler.ast_nodes.is_empty() {
            let last = self.compiler.ast_nodes.len() - 1;
            let last_node_id = NodeId(last);
            self.typecheck_node(last_node_id)
        }
    }

    /// Get type ID of a node
    pub fn type_id_of(&self, node_id: NodeId) -> TypeId {
        self.node_types[node_id.0]
    }

    /// Get type of node
    pub fn type_of(&self, node_id: NodeId) -> Type {
        let type_id = self.type_id_of(node_id);
        self.types[type_id.0]
    }

    fn typecheck_node(&mut self, node_id: NodeId) {
        match self.compiler.ast_nodes[node_id.0] {
            AstNode::Expr(ref expr) => {
                self.typecheck_expr(expr.clone(), node_id, UNKNOWN_TYPE);
            }
            AstNode::Stmt(ref stmt) => self.typecheck_stmt(stmt.clone(), node_id),
            AstNode::Params(ref params) => {
                for param in params {
                    self.typecheck_node(*param);
                }
                // Params are not supposed to be evaluated
                self.set_node_type_id(node_id, FORBIDDEN_TYPE);
            }
            AstNode::Param { name, ty } => {
                if let Some(ty) = ty {
                    self.typecheck_type(ty);

                    let var_id = self
                        .compiler
                        .var_resolution
                        .get(&name)
                        .expect("missing resolved variable");
                    self.variable_types[var_id.0] = self.type_id_of(ty);
                    self.set_node_type_id(node_id, self.type_id_of(ty));
                } else {
                    self.set_node_type_id(node_id, ANY_TYPE);
                }
            }
            AstNode::TypeArgs(ref args) => {
                for arg in args {
                    self.typecheck_type(*arg);
                }
                // Type argument lists are not supposed to be evaluated
                self.set_node_type_id(node_id, FORBIDDEN_TYPE);
            }
            _ => self.error(
                format!(
                    "unsupported ast node '{:?}' in typechecker",
                    self.compiler.ast_nodes[node_id.0]
                ),
                node_id,
            ),
        }
    }

    fn typecheck_block(&mut self, block_id: BlockId, expected: TypeId) -> TypeId {
        let block = &self.compiler.blocks[block_id.0];
        // Block type is the type of the last statement, since blocks
        // by themselves aren't supposed to be typed
        let mut block_type = NONE_TYPE;

        for inner_node_id in &block.nodes {
            if let AstNode::Stmt(Stmt::Def {
                name,
                params,
                in_out_types,
                ..
            }) = self.compiler.get_node(*inner_node_id)
            {
                self.add_def_signature(*name, *params, *in_out_types)
            }
        }

        for (i, inner_node_id) in block.nodes.iter().enumerate() {
            match self.compiler.get_node(*inner_node_id) {
                AstNode::Stmt(Stmt::Expr(expr_id)) => {
                    if i == block.nodes.len() - 1 {
                        block_type = self.typecheck_expr_id(*expr_id, expected);
                    } else {
                        self.typecheck_expr_id(*expr_id, TOP_TYPE);
                    }
                }
                AstNode::Expr(expr) => {
                    if i == block.nodes.len() - 1 {
                        block_type = self.typecheck_expr(expr.clone(), *inner_node_id, expected);
                    } else {
                        self.typecheck_expr(expr.clone(), *inner_node_id, TOP_TYPE);
                    }
                }
                AstNode::Stmt(stmt) => self.typecheck_stmt(stmt.clone(), *inner_node_id),
                x => panic!("Internal error: block did not contain statement: {:?}", x),
            }
        }

        block_type
    }

    fn typecheck_expr_id(&mut self, expr_id: NodeId, expected: TypeId) -> TypeId {
        match self.compiler.get_node(expr_id) {
            AstNode::Expr(ref expr) => self.typecheck_expr(expr.clone(), expr_id, expected),
            _ => panic!("Internal error: Node {} is not an expression", expr_id.0),
        }
    }

    /// Infer a type for an expression and update self.types
    fn typecheck_expr(&mut self, expr: Expr, node_id: NodeId, expected: TypeId) -> TypeId {
        let type_id = match expr {
            Expr::Null => NOTHING_TYPE,
            Expr::Int => INT_TYPE,
            Expr::Float => FLOAT_TYPE,
            Expr::True | Expr::False => BOOL_TYPE,
            Expr::String => STRING_TYPE,
            Expr::List(ref items) => {
                if let Some(first_id) = items.first() {
                    self.typecheck_node(*first_id);
                    let first_type = self.type_of(*first_id);

                    let mut all_numbers = self.is_type_compatible(first_type, Type::Number);
                    let mut all_same = true;

                    for item_id in items.iter().skip(1) {
                        self.typecheck_node(*item_id);
                        let item_type = self.type_of(*item_id);

                        if all_numbers && !self.is_type_compatible(item_type, Type::Number) {
                            all_numbers = false;
                        }

                        if all_same && item_type != first_type {
                            all_same = false;
                        }
                    }

                    if all_same {
                        self.push_type(Type::List(self.type_id_of(*first_id)))
                    } else if all_numbers {
                        self.push_type(Type::List(NUMBER_TYPE))
                    } else {
                        LIST_ANY_TYPE
                    }
                } else {
                    LIST_ANY_TYPE
                }
            }
            Expr::Block(block_id) => self.typecheck_block(block_id, expected),
            Expr::Record { ref pairs } => {
                let mut field_types = pairs
                    .iter()
                    .map(|(name, value)| {
                        self.typecheck_node(*value);
                        (*name, self.type_id_of(*value))
                    })
                    .collect::<Vec<_>>();
                field_types.sort_by_cached_key(|(name, _)| self.compiler.get_span_contents(*name));

                self.record_types.push(field_types);
                self.push_type(Type::Record(RecordTypeId(self.record_types.len() - 1)))
            }
            Expr::Closure { params, block } => {
                // TODO: input/output types
                if let Some(params_node_id) = params {
                    self.typecheck_node(params_node_id);
                }

                self.typecheck_node(block);
                CLOSURE_TYPE
            }
            Expr::BinaryOp { lhs, op, rhs } => self.typecheck_binary_op(lhs, op, rhs),
            Expr::VarRef => {
                let var_id = self
                    .compiler
                    .var_resolution
                    .get(&node_id)
                    .expect("missing resolved variable");

                self.variable_types[var_id.0]
            }
            Expr::If {
                condition,
                then_block,
                else_block,
            } => {
                self.typecheck_expr_id(condition, BOOL_TYPE);

                let then_type_id = self.typecheck_expr_id(then_block, expected);

                if let Some(else_blk) = else_block {
                    let else_type_id = self.typecheck_expr_id(else_blk, expected);
                    let mut types = HashSet::new();
                    types.insert(then_type_id);
                    types.insert(else_type_id);
                    self.create_oneof(types)
                } else {
                    then_type_id
                }
            }
            Expr::Call { ref parts } => self.typecheck_call(parts, node_id),
            Expr::Match {
                ref target,
                ref match_arms,
            } => {
                // Check all the output types of match
                let output_types = self.typecheck_match(target, match_arms);
                if output_types.is_empty() {
                    NOTHING_TYPE
                } else {
                    self.create_oneof(output_types)
                }
            }
            _ => {
                self.error(
                    format!(
                        "unsupported ast node '{:?}' in typechecker",
                        self.compiler.ast_nodes[node_id.0]
                    ),
                    node_id,
                );
                UNKNOWN_TYPE
            }
        };

        let got = self.types[type_id.0];
        let exp = self.types[expected.0];
        if !self.is_subtype(got, exp) {
            self.error(
                format!(
                    "Expected {}, got {}",
                    self.type_to_string(expected),
                    self.type_to_string(type_id)
                ),
                node_id,
            );
        }

        self.set_node_type_id(node_id, type_id);
        type_id
    }

    fn typecheck_stmt(&mut self, stmt: Stmt, node_id: NodeId) {
        match stmt {
            Stmt::Let {
                variable_name,
                ty,
                initializer,
                is_mutable: _,
            } => self.typecheck_let(variable_name, ty, initializer, node_id),
            Stmt::Def { name, block, .. } => self.typecheck_def(name, block, node_id),
            Stmt::Alias { new_name, old_name } => self.typecheck_alias(new_name, old_name, node_id),
            Stmt::For {
                variable,
                range,
                block,
            } => {
                // We don't need to typecheck variable after this
                self.typecheck_node(range);

                let var_id = self
                    .compiler
                    .var_resolution
                    .get(&variable)
                    .expect("missing resolved variable");
                if let Type::List(type_id) = self.type_of(range) {
                    self.variable_types[var_id.0] = type_id;
                    self.set_node_type_id(variable, type_id);
                } else {
                    self.variable_types[var_id.0] = ANY_TYPE;
                    self.set_node_type_id(variable, ERROR_TYPE);
                    self.error("For loop range is not a list", range);
                }

                self.typecheck_node(block);
                if self.type_id_of(block) != NONE_TYPE {
                    self.error("Blocks in looping constructs cannot return values", block);
                }

                if self.type_id_of(node_id) != ERROR_TYPE {
                    self.set_node_type_id(node_id, NONE_TYPE);
                }
            }
            Stmt::While { condition, block } => {
                self.typecheck_node(block);
                if self.type_id_of(block) != NONE_TYPE {
                    self.error("Blocks in looping constructs cannot return values", block);
                }

                self.typecheck_node(condition);

                // the condition should always evaluate to a boolean
                if self.type_of(condition) != Type::Bool {
                    self.error("The condition for while loop is not a boolean", condition);
                    self.set_node_type_id(node_id, ERROR_TYPE);
                } else {
                    self.set_node_type_id(node_id, self.type_id_of(block));
                }
            }
            Stmt::Expr(node) => self.typecheck_node(node),
            _ => self.error(
                format!(
                    "unsupported ast node '{:?}' in typechecker",
                    self.compiler.ast_nodes[node_id.0]
                ),
                node_id,
            ),
        }
    }

    fn typecheck_match(
        &mut self,
        target: &NodeId,
        match_arms: &Vec<(NodeId, NodeId)>,
    ) -> HashSet<TypeId> {
        self.typecheck_node(*target);

        let mut output_types = HashSet::new();
        // typecheck each node
        let target_id = self.type_id_of(*target);
        for (match_node, result_node) in match_arms {
            self.typecheck_node(*match_node);
            self.typecheck_node(*result_node);

            let match_id = self.type_id_of(*match_node);
            match (self.type_of(*target), self.type_of(*match_node)) {
                // First is of type Any which will always match
                (Type::Any, _) => {
                    self.add_resolved_types(&mut output_types, &self.type_id_of(*result_node));
                }
                // Same as above but for second
                (_, Type::Any) => {
                    self.add_resolved_types(&mut output_types, &self.type_id_of(*result_node));
                }
                // the second is one of the possible types of the first
                (Type::OneOf(id), _) if self.oneof_types[id.0].contains(&match_id) => {
                    self.add_resolved_types(&mut output_types, &self.type_id_of(*result_node));
                }
                // the first is one of the possible types of the second
                (_, Type::OneOf(id)) if self.oneof_types[id.0].contains(&target_id) => {
                    self.add_resolved_types(&mut output_types, &self.type_id_of(*result_node));
                }
                // the both the target and the one matched against are
                // oneof<many types> then we need to check if they have any type in common
                (Type::OneOf(id1), Type::OneOf(id2)) => {
                    if self.oneof_types[id1.0]
                        .intersection(&self.oneof_types[id2.0])
                        .count()
                        != 0
                    {
                        self.add_resolved_types(&mut output_types, &self.type_id_of(*result_node));
                    } else {
                        self.error("The target to be matched against and the possible types of the matched arm are completely disjoint", *match_node);
                    }
                }
                // Check if the two types can be matched
                (target_id, match_id) if self.is_type_compatible(target_id, match_id) => {
                    self.add_resolved_types(&mut output_types, &self.type_id_of(*result_node));
                }
                _ => {
                    self.error("The types do not match", *match_node);
                }
            }
        }
        output_types
    }

    fn typecheck_binary_op(&mut self, lhs: NodeId, op: NodeId, rhs: NodeId) -> TypeId {
        self.typecheck_node(lhs);
        self.typecheck_node(rhs);
        self.set_node_type_id(op, FORBIDDEN_TYPE);

        let lhs_type = self.type_of(lhs);
        let rhs_type = self.type_of(rhs);

        let out_type = match self.compiler.ast_nodes[op.0] {
            AstNode::Equal | AstNode::NotEqual => Some(Type::Bool),
            AstNode::LessThan
            | AstNode::GreaterThan
            | AstNode::LessThanOrEqual
            | AstNode::GreaterThanOrEqual => {
                if check_numeric_op(lhs_type, rhs_type) == Type::Unknown {
                    self.binary_op_err("comparison", lhs, op, rhs);
                    None
                } else {
                    Some(Type::Bool)
                }
            }
            AstNode::Minus
            | AstNode::Multiply
            | AstNode::Divide
            | AstNode::FloorDiv
            | AstNode::Modulo
            | AstNode::Pow => {
                let type_id = check_numeric_op(lhs_type, rhs_type);

                if type_id == Type::Unknown {
                    self.binary_op_err("math operation", lhs, op, rhs);
                    None
                } else {
                    Some(type_id)
                }
            }
            AstNode::RegexMatch | AstNode::NotRegexMatch => match (lhs_type, rhs_type) {
                (Type::String | Type::Any, Type::String | Type::Any) => Some(Type::Bool),
                _ => {
                    self.binary_op_err("string operation", lhs, op, rhs);
                    None
                }
            },
            AstNode::In => match rhs_type {
                Type::String => match lhs_type {
                    Type::String | Type::Any => Some(Type::Bool),
                    _ => {
                        self.binary_op_err("string operation", lhs, op, rhs);
                        None
                    }
                },
                Type::List(elem_ty) => {
                    if self.is_type_compatible(lhs_type, self.types[elem_ty.0]) {
                        Some(Type::Bool)
                    } else {
                        self.binary_op_err("list operation", lhs, op, rhs);
                        None
                    }
                }
                Type::Any => Some(Type::Bool),
                _ => {
                    self.binary_op_err("list/string operation", lhs, op, rhs);
                    None
                }
            },
            AstNode::And | AstNode::Xor | AstNode::Or => match (lhs_type, rhs_type) {
                (Type::Bool, Type::Bool) => Some(Type::Bool),
                _ => {
                    self.binary_op_err("logical operation", lhs, op, rhs);
                    None
                }
            },
            AstNode::Plus => {
                let ty = check_plus_op(lhs_type, rhs_type);

                if ty == Type::Unknown {
                    self.binary_op_err("addition", lhs, op, rhs);
                    None
                } else {
                    Some(ty)
                }
            }
            AstNode::Append => {
                let lhs_type = self.type_of(lhs);
                let rhs_type = self.type_of(rhs);

                match (lhs_type, rhs_type) {
                    (Type::List(lhs_item_id), Type::List(rhs_item_id)) => {
                        let lhs_item_type = self.types[lhs_item_id.0];
                        let rhs_item_type = self.types[rhs_item_id.0];
                        let common_type = self.least_common_type(lhs_item_type, rhs_item_type);
                        let common_type_id = self.push_type(common_type);
                        Some(Type::List(common_type_id))
                    }
                    (Type::List(item_id), rhs_type) => {
                        let item_type = self.types[item_id.0];
                        let common_type = self.least_common_type(item_type, rhs_type);
                        let common_type_id = self.push_type(common_type);
                        Some(Type::List(common_type_id))
                    }
                    (lhs_type, Type::List(item_id)) => {
                        let item_type = self.types[item_id.0];
                        let common_type = self.least_common_type(lhs_type, item_type);
                        let common_type_id = self.push_type(common_type);
                        Some(Type::List(common_type_id))
                    }
                    _ => {
                        self.binary_op_err("append", lhs, op, rhs);
                        None
                    }
                }
            }
            AstNode::Assignment
            | AstNode::AddAssignment
            | AstNode::SubtractAssignment
            | AstNode::MultiplyAssignment
            | AstNode::DivideAssignment
            | AstNode::AppendAssignment => Some(Type::None),
            _ => panic!("internal error: unsupported node passed as binary op: {op:?}"),
        };

        if let Some(ty) = out_type {
            self.push_type(ty)
        } else {
            ERROR_TYPE
        }
    }

    fn add_def_signature(&mut self, name: NodeId, params: NodeId, in_out_types: Option<NodeId>) {
        self.typecheck_node(params);
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
                            in_type: self.typecheck_type(*in_ty),
                            out_type: self.typecheck_type(*out_ty),
                        }
                    })
                    .collect::<Vec<_>>()
            })
            .unwrap_or_default();

        // set input/output types for the command
        let decl_id = self
            .compiler
            .decl_resolution
            .get(&name)
            .expect("missing declared decl");

        if !in_out_types.is_empty() {
            self.decl_types[decl_id.0] = in_out_types;
        }
    }

    fn typecheck_def(&mut self, name: NodeId, block: NodeId, node_id: NodeId) {
        self.set_node_type_id(node_id, NONE_TYPE);

        // set input/output types for the command
        let decl_id = self
            .compiler
            .decl_resolution
            .get(&name)
            .expect("missing declared decl");

        let in_out_types = &self.decl_types[decl_id.0];
        if in_out_types.is_empty() {
            let inferred = self.typecheck_expr_id(block, ANY_TYPE);
            self.decl_types[decl_id.0] = vec![InOutType {
                in_type: ANY_TYPE,
                out_type: inferred,
            }];
        } else {
            // TODO this doesn't match each input type to its corresponding output type,
            // just uses a union of all the output types as the expected type
            let expected = self.create_oneof(in_out_types.iter().map(|io| io.out_type).collect());
            self.typecheck_expr_id(block, expected);
        }
    }

    fn typecheck_alias(&mut self, new_name: NodeId, old_name: NodeId, node_id: NodeId) {
        self.set_node_type_id(node_id, NONE_TYPE);

        // set input/output types for the command
        let decl_id_new = self
            .compiler
            .decl_resolution
            .get(&new_name)
            .expect("missing declared new name for alias");

        let decl_id_old = self.compiler.decl_resolution.get(&old_name);

        self.decl_types[decl_id_new.0] = decl_id_old.map_or(
            vec![InOutType {
                in_type: ANY_TYPE,
                out_type: BYTE_STREAM_TYPE,
            }],
            |decl_id| self.decl_types[decl_id.0].clone(),
        );
    }

    fn typecheck_call(&mut self, parts: &[NodeId], node_id: NodeId) -> TypeId {
        if let Some(decl_id) = self.compiler.decl_resolution.get(&node_id) {
            let num_name_parts = self.compiler.decls[decl_id.0].name().split(' ').count();
            let decl_node_id = self.compiler.decl_nodes[decl_id.0];
            let AstNode::Stmt(Stmt::Def { params, .. }) = self.compiler.get_node(decl_node_id)
            else {
                panic!("Internal error: Expected def")
            };
            let AstNode::Params(params) = self.compiler.get_node(*params) else {
                panic!("Internal error: Expected def")
            };
            let num_args = parts.len() - num_name_parts;
            if params.len() != num_args {
                self.error(
                    format!("Expected {} argument(s), got {}", params.len(), num_args),
                    node_id,
                );
            }

            for (param, arg) in params.iter().zip(&parts[num_name_parts..]) {
                let expected = self.type_id_of(*param);
                if matches!(self.compiler.ast_nodes[arg.0], AstNode::Name) {
                    self.set_node_type_id(*arg, STRING_TYPE);
                    if !self.is_subtype(Type::String, self.types[expected.0]) {
                        self.error(
                            format!("Expected {}, got string", self.type_to_string(expected)),
                            *arg,
                        );
                    }
                } else {
                    self.typecheck_expr_id(*arg, expected);
                }
            }

            // TODO base this on pipeline input type
            self.create_oneof(
                self.decl_types[decl_id.0]
                    .iter()
                    .map(|io| io.out_type)
                    .collect(),
            )
        } else {
            // external call
            for part in &parts[1..] {
                if matches!(self.compiler.ast_nodes[part.0], AstNode::Name) {
                    self.set_node_type_id(*part, STRING_TYPE);
                } else {
                    self.typecheck_node(*part);
                }
            }
            BYTE_STREAM_TYPE
        }
    }

    fn typecheck_let(
        &mut self,
        variable_name: NodeId,
        ty: Option<NodeId>,
        initializer: NodeId,
        node_id: NodeId,
    ) {
        let expected = if let Some(node_id) = ty {
            self.typecheck_type(node_id)
        } else {
            ANY_TYPE
        };
        let init_ty_id = self.typecheck_expr_id(initializer, expected);
        let type_id = if ty.is_some() { expected } else { init_ty_id };

        let var_id = self
            .compiler
            .var_resolution
            .get(&variable_name)
            .expect("missing declared variable");

        self.variable_types[var_id.0] = type_id;
        self.set_node_type_id(variable_name, type_id);
        self.set_node_type_id(node_id, NONE_TYPE);
    }

    fn typecheck_type(&mut self, node_id: NodeId) -> TypeId {
        let AstNode::Type(ty) = self.compiler.get_node(node_id) else {
            panic!("internal error: Expected type");
        };
        let type_id = match ty {
            TypeAst::Ref {
                name: name_id,
                args: args_id,
                ..
            } => {
                let name = self.compiler.get_span_contents(*name_id);

                // taken from parse_shape_name() in Nushell:
                match name {
                    b"any" => ANY_TYPE,
                    // b"binary" => SyntaxShape::Binary,
                    // b"block" => // not possible to pass blocks
                    b"list" => {
                        if let Some(args_id) = *args_id {
                            self.typecheck_node(args_id);

                            if let AstNode::TypeArgs(args) = self.compiler.get_node(args_id) {
                                if args.len() > 1 {
                                    let types = String::from_utf8_lossy(
                                        self.compiler.get_span_contents(args_id),
                                    );
                                    self.error(format!("list must have only one type argument (to allow selection of types, use oneof{} -- WIP)", types), args_id);
                                    self.push_type(Type::List(UNKNOWN_TYPE))
                                } else if args.is_empty() {
                                    self.error("list must have one type argument", args_id);
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
                        UNKNOWN_TYPE
                        // }
                    }
                }
            }
            TypeAst::Record { fields, .. } => {
                let AstNode::Params(field_nodes) = self.compiler.get_node(*fields) else {
                    panic!("internal error: record fields aren't Params");
                };
                let mut fields = field_nodes
                    .iter()
                    .map(|field| {
                        let AstNode::Param { name, ty } = self.compiler.get_node(*field) else {
                            panic!("internal error: record field isn't Param");
                        };
                        let ty_id = match ty {
                            Some(ty) => self.typecheck_type(*ty),
                            None => ANY_TYPE,
                        };
                        (*name, ty_id)
                    })
                    .collect::<Vec<_>>();
                // Store fields sorted by name
                fields.sort_by_cached_key(|(name, _)| self.compiler.get_span_contents(*name));

                self.record_types.push(fields);
                self.push_type(Type::Record(RecordTypeId(self.record_types.len() - 1)))
            }
        };

        self.set_node_type_id(node_id, type_id);
        type_id
    }

    /// Add a new type and return its ID. To save space, common types are not pushed and their ID is
    /// returned directly.
    fn push_type(&mut self, ty: Type) -> TypeId {
        match ty {
            Type::Unknown => UNKNOWN_TYPE,
            Type::Forbidden => FORBIDDEN_TYPE,
            Type::None => NONE_TYPE,
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

    fn set_node_type_id(&mut self, node_id: NodeId, type_id: TypeId) {
        self.node_types[node_id.0] = type_id;
    }

    /// Finds a "supertype" of two types (e.g., number for float and int)
    fn least_common_type(&mut self, lhs: Type, rhs: Type) -> Type {
        match (lhs, rhs) {
            (Type::List(lhs_id), Type::List(rhs_id)) => {
                let item_type = self.least_common_type(self.types[lhs_id.0], self.types[rhs_id.0]);
                let item_type_id = self.push_type(item_type);
                Type::List(item_type_id)
            }
            (Type::Record(lhs_id), Type::Record(rhs_id)) => {
                let mut common_fields = Vec::new();

                let mut l = 0;
                let mut r = 0;
                while l < self.record_types[lhs_id.0].len() && r < self.record_types[rhs_id.0].len()
                {
                    let (lhs_name, lhs_ty) = self.record_types[lhs_id.0][l];
                    let (rhs_name, rhs_ty) = self.record_types[rhs_id.0][r];
                    let lhs_text = self.compiler.get_span_contents(lhs_name);
                    let rhs_text = self.compiler.get_span_contents(rhs_name);
                    match lhs_text.cmp(rhs_text) {
                        Ordering::Less => {
                            l += 1;
                        }
                        Ordering::Greater => {
                            r += 1;
                        }
                        Ordering::Equal => {
                            let field_ty =
                                self.least_common_type(self.types[lhs_ty.0], self.types[rhs_ty.0]);
                            let field_ty_id = self.push_type(field_ty);
                            common_fields.push((lhs_name, field_ty_id));
                            l += 1;
                            r += 1;
                        }
                    }
                }

                self.record_types.push(common_fields);
                Type::Record(RecordTypeId(self.record_types.len() - 1))
            }
            (Type::Int, Type::Float) => Type::Number,
            (Type::Int, Type::Number) => Type::Number,
            (Type::Float, Type::Float) => Type::Number,
            (Type::Float, Type::Number) => Type::Number,
            _ => {
                if lhs == rhs {
                    lhs
                } else {
                    Type::Any
                }
            }
        }
    }

    /// Check if `sub` is a subtype of `supe`
    fn is_subtype(&self, sub: Type, supe: Type) -> bool {
        match (sub, supe) {
            (_, Type::Top | Type::Any | Type::Unknown) => true,
            (Type::Any | Type::Unknown, _) => true,
            (Type::Int | Type::Float | Type::Number, Type::Number) => true,
            (Type::List(inner_sub), Type::List(inner_supe)) => {
                self.is_subtype(self.types[inner_sub.0], self.types[inner_supe.0])
            }
            (_, Type::OneOf(oneof_id)) => self.oneof_types[oneof_id.0]
                .iter()
                .any(|ty| self.is_subtype(sub, self.types[ty.0])),
            (_, _) => sub == supe,
        }
    }

    fn type_to_string(&self, type_id: TypeId) -> String {
        let ty = &self.types[type_id.0];

        match ty {
            Type::Unknown => "unknown".to_string(),
            Type::Forbidden => "forbidden".to_string(),
            Type::None => "()".to_string(),
            Type::Any => "any".to_string(),
            Type::Top => "top".to_string(),
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
                    fmt += &String::from_utf8_lossy(self.compiler.get_span_contents(*name));
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
            Type::Error => "error".to_string(),
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
                    let lhs_text = self.compiler.get_span_contents(lhs_name);
                    let rhs_text = self.compiler.get_span_contents(rhs_name);
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

    fn error(&mut self, msg: impl Into<String>, node_id: NodeId) {
        self.errors.push(SourceError {
            message: msg.into(),
            node_id,
            severity: Severity::Error,
        })
    }

    fn binary_op_err(&mut self, op_msg: &str, lhs: NodeId, op: NodeId, rhs: NodeId) {
        self.error(
            format!(
                "type mismatch: unsupported {} between {} and {}",
                op_msg,
                self.type_to_string(self.type_id_of(lhs)),
                self.type_to_string(self.type_id_of(rhs)),
            ),
            op,
        );
        self.set_node_type_id(op, ERROR_TYPE);
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
        if types.is_empty() {
            // TODO return bottom type instead?
            return ANY_TYPE;
        }

        let mut res = HashSet::<TypeId>::new();

        let mut flattened = HashSet::new();
        for ty_id in types {
            match self.types[ty_id.0] {
                Type::OneOf(oneof_id) => {
                    flattened.extend(&self.oneof_types[oneof_id.0]);
                }
                _ => {
                    flattened.insert(ty_id);
                }
            }
        }

        for ty_id in flattened {
            if res.contains(&ty_id) {
                continue;
            }

            let ty = self.types[ty_id.0];
            let mut add = true;
            let mut remove = HashSet::new();
            for other_id in res.iter() {
                let other = self.types[other_id.0];
                if self.is_subtype(ty, other) {
                    add = false;
                    break;
                }
                if self.is_subtype(other, ty) {
                    remove.insert(*other_id);
                }
            }

            if add {
                res.insert(ty_id);
                for other in remove {
                    res.remove(&other);
                }
            }
        }

        if res.len() == 1 {
            *res.iter().next().unwrap()
        } else {
            self.oneof_types.push(res);
            self.push_type(Type::OneOf(OneOfId(self.oneof_types.len() - 1)))
        }
    }
}

/// Check whether two types can perform common numeric operations
fn check_numeric_op(lhs: Type, rhs: Type) -> Type {
    match (rhs, lhs) {
        (Type::Int, Type::Int) => Type::Int,
        (Type::Int, Type::Float) => Type::Float,
        (Type::Int, Type::Number) => Type::Number,
        (Type::Float, Type::Int) => Type::Float,
        (Type::Float, Type::Float) => Type::Float,
        (Type::Float, Type::Number) => Type::Float,
        (Type::Number, Type::Int) => Type::Number,
        (Type::Number, Type::Float) => Type::Float,
        (Type::Number, Type::Number) => Type::Number,
        (Type::Any, _) => Type::Number,
        (_, Type::Any) => Type::Number,
        // TODO: Differentiate error based on whether LHS supports the op or not (see type_check.rs)
        _ => Type::Unknown,
    }
}

/// Check whether two types can perform addition
fn check_plus_op(lhs: Type, rhs: Type) -> Type {
    match (rhs, lhs) {
        (Type::String, Type::String) => Type::String,
        _ => check_numeric_op(lhs, rhs),
    }
}
