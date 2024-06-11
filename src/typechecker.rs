use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::parser::{AstNode, NodeId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct TypeId(pub usize);

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Type {
    /// Any node that hasn't been touched by the typechecker will have this type
    Unknown,
    /// Some nodes shouldn't be directly evaluated (like operators). These will have a "forbidden"
    /// to differentiate them from the "unknown" type.
    Forbidden,
    /// None type means that a note has no type. For example, statemenets like let x = ... do not
    /// output anything and thus don't have any type.
    None,
    Any,
    Number,
    Nothing,
    Int,
    Float,
    Bool,
    String,
    Block,
    Closure,
    List(TypeId),
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
pub const BLOCK_TYPE: TypeId = TypeId(10);
pub const CLOSURE_TYPE: TypeId = TypeId(11);

// Common composite types can be hardcoded as well, like list<any>:

pub const LIST_ANY_TYPE: TypeId = TypeId(12);

pub struct Typechecker<'a> {
    /// Immutable reference to a compiler after the name binding pass
    compiler: &'a Compiler,

    /// Types referenced by TypeId
    types: Vec<Type>,

    /// Types of nodes. Each type in this vector matches a node in compiler.ast_nodes at the same position.
    pub node_types: Vec<TypeId>,
    /// Type of each Variable in compiler.variables, indexed by VarId
    pub variable_types: Vec<TypeId>,
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
                Type::Block,
                Type::Closure,
                Type::List(ANY_TYPE),
            ],
            node_types: vec![UNKNOWN_TYPE; compiler.ast_nodes.len()],
            variable_types: vec![UNKNOWN_TYPE; compiler.variables.len()],
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
            AstNode::Null => {
                self.set_node_type_id(node_id, NOTHING_TYPE);
            }
            AstNode::Int => {
                self.set_node_type_id(node_id, INT_TYPE);
            }
            AstNode::Float => {
                self.set_node_type_id(node_id, FLOAT_TYPE);
            }
            AstNode::True | AstNode::False => {
                self.set_node_type_id(node_id, BOOL_TYPE);
            }
            AstNode::String => {
                self.set_node_type_id(node_id, STRING_TYPE);
            }
            AstNode::Type {
                name,
                params: _params,
                optional: _optional,
            } => {
                // TODO: Add support for compound and optional types
                self.set_node_type_id(node_id, self.name_to_type(name));
            }
            AstNode::List(ref items) => {
                if let Some(first_id) = items.first() {
                    self.typecheck_node(*first_id);
                    let first_type = self.type_of(*first_id);

                    let mut all_numbers = is_type_compatible(first_type, Type::Number);
                    let mut all_same = true;

                    for item_id in items.iter().skip(1) {
                        self.typecheck_node(*item_id);
                        let item_type = self.type_of(*item_id);

                        if all_numbers && !is_type_compatible(item_type, Type::Number) {
                            all_numbers = false;
                        }

                        if all_same && item_type != first_type {
                            all_same = false;
                        }
                    }

                    if all_same {
                        self.set_node_type(node_id, Type::List(self.type_id_of(*first_id)));
                    } else if all_numbers {
                        self.set_node_type(node_id, Type::List(NUMBER_TYPE));
                    } else {
                        self.set_node_type_id(node_id, LIST_ANY_TYPE);
                    }
                } else {
                    self.set_node_type_id(node_id, LIST_ANY_TYPE);
                }
            }
            AstNode::Block(block_id) => {
                let block = &self.compiler.blocks[block_id.0];

                for inner_node_id in &block.nodes {
                    self.typecheck_node(*inner_node_id);
                }

                self.set_node_type_id(node_id, NONE_TYPE);
            }
            AstNode::Closure { params, block } => {
                if let Some(params_node_id) = params {
                    self.typecheck_node(params_node_id);
                }

                self.typecheck_node(block);
                self.set_node_type_id(node_id, CLOSURE_TYPE);
            }
            AstNode::BinaryOp { lhs, op, rhs } => self.typecheck_binary_op(lhs, op, rhs, node_id),
            AstNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable: _,
            } => self.typecheck_let(variable_name, ty, initializer, node_id),
            AstNode::Variable => {
                let var_id = self
                    .compiler
                    .var_resolution
                    .get(&node_id)
                    .expect("missing resolved variable");

                self.set_node_type_id(node_id, self.variable_types[var_id.0]);
            }
            AstNode::If {
                condition,
                then_block,
                else_block,
            } => {
                self.typecheck_node(condition);
                self.typecheck_node(then_block);

                if let Some(else_blk) = else_block {
                    self.typecheck_node(else_blk);
                }
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

    fn typecheck_binary_op(&mut self, lhs: NodeId, op: NodeId, rhs: NodeId, node_id: NodeId) {
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
            AstNode::Minus | AstNode::Multiply | AstNode::Divide | AstNode::Pow => {
                let type_id = check_numeric_op(lhs_type, rhs_type);

                if type_id == Type::Unknown {
                    self.binary_op_err("math operation", lhs, op, rhs);
                    None
                } else {
                    Some(type_id)
                }
            }
            AstNode::And | AstNode::Or => match (lhs_type, rhs_type) {
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
            | AstNode::DivideAssignment => Some(Type::None),
            _ => panic!("internal error: unsupported node passed as binary op: {op:?}"),
        };

        if let Some(ty) = out_type {
            self.set_node_type(node_id, ty);
        }
    }

    fn typecheck_let(
        &mut self,
        variable_name: NodeId,
        ty: Option<NodeId>,
        initializer: NodeId,
        node_id: NodeId,
    ) {
        self.typecheck_node(initializer);

        if let Some(ty) = ty {
            self.typecheck_node(ty);

            if !is_type_compatible(self.type_of(ty), self.type_of(initializer)) {
                self.error("initializer does not match declared type", initializer)
            }
        }

        let var_id = self
            .compiler
            .var_resolution
            .get(&variable_name)
            .expect("missing declared variable");

        let type_id = if let Some(ty) = ty {
            self.type_id_of(ty)
        } else {
            self.type_id_of(initializer)
        };

        self.variable_types[var_id.0] = type_id;
        self.set_node_type_id(variable_name, type_id);
        self.set_node_type_id(node_id, NONE_TYPE);
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
            Type::Block => BLOCK_TYPE,
            Type::Closure => CLOSURE_TYPE,
            Type::List(ANY_TYPE) => LIST_ANY_TYPE,
            _ => {
                self.types.push(ty);
                TypeId(self.types.len() - 1)
            }
        }
    }

    fn set_node_type(&mut self, node_id: NodeId, ty: Type) {
        let type_id = self.push_type(ty);
        self.node_types[node_id.0] = type_id;
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

    fn name_to_type(&self, name_node_id: NodeId) -> TypeId {
        let name = self.compiler.get_span_contents(name_node_id);

        // taken from parse_shape_name() in Nushell:
        match name {
            b"any" => ANY_TYPE,
            // b"binary" => SyntaxShape::Binary,
            // b"block" => // not possible to pass blocks
            b"list" => LIST_ANY_TYPE, // TODO: List subtypes
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

    fn type_to_string(&self, type_id: TypeId) -> String {
        let ty = &self.types[type_id.0];

        match ty {
            Type::Unknown => "unknown".to_string(),
            Type::Forbidden => "forbidden".to_string(),
            Type::None => "()".to_string(),
            Type::Any => "any".to_string(),
            Type::Number => "number".to_string(),
            Type::Nothing => "nothing".to_string(),
            Type::Int => "int".to_string(),
            Type::Float => "float".to_string(),
            Type::Bool => "bool".to_string(),
            Type::String => "string".to_string(),
            Type::Block => "block".to_string(),
            Type::Closure => "closure".to_string(),
            Type::List(subtype_id) => {
                format!("list<{}>", self.type_to_string(*subtype_id))
            }
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
    }
}

/// Check if one type can be cast to another type
fn is_type_compatible(lhs: Type, rhs: Type) -> bool {
    match (lhs, rhs) {
        (Type::Int, Type::Number) => true,
        (Type::Float, Type::Number) => true,
        (Type::Number, Type::Int) => true,
        (Type::Number, Type::Float) => true,
        (Type::Any, _) => true,
        (_, Type::Any) => true,
        _ => lhs == rhs,
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
