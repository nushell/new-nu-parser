use crate::compiler::Compiler;
use crate::errors::{Severity, SourceError};
use crate::parser::{AstNode, NodeId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct TypeId(pub usize);

pub enum Type {
    Unknown,
    /// Unit type signifies "no type". For example, statemenets like let x = ... do not have any type.
    Unit,
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

// The below are predefined simple types hardcoded into the Typechecker to avoid re-adding them all over
pub const UNKNOWN_TYPE: TypeId = TypeId(0);
pub const UNIT_TYPE: TypeId = TypeId(1);
pub const ANY_TYPE: TypeId = TypeId(2);
pub const NUMBER_TYPE: TypeId = TypeId(3);
pub const NOTHING_TYPE: TypeId = TypeId(4);
pub const INT_TYPE: TypeId = TypeId(5);
pub const FLOAT_TYPE: TypeId = TypeId(6);
pub const BOOL_TYPE: TypeId = TypeId(7);
pub const STRING_TYPE: TypeId = TypeId(8);
pub const BLOCK_TYPE: TypeId = TypeId(9);
pub const CLOSURE_TYPE: TypeId = TypeId(10);
pub const LIST_ANY_TYPE: TypeId = TypeId(11);

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
                Type::Unit,
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

    pub fn typecheck(&mut self) {
        if !self.compiler.ast_nodes.is_empty() {
            let last = self.compiler.ast_nodes.len() - 1;
            let last_node_id = NodeId(last);
            self.typecheck_node(last_node_id)
        }
    }

    pub fn typecheck_node(&mut self, node_id: NodeId) {
        match self.compiler.ast_nodes[node_id.0] {
            AstNode::Null => {
                self.node_types[node_id.0] = NOTHING_TYPE;
            }
            AstNode::Int => {
                self.node_types[node_id.0] = INT_TYPE;
            }
            AstNode::Float => {
                self.node_types[node_id.0] = FLOAT_TYPE;
            }
            AstNode::True | AstNode::False => {
                self.node_types[node_id.0] = BOOL_TYPE;
            }
            AstNode::String => {
                self.node_types[node_id.0] = STRING_TYPE;
            }
            AstNode::Type {
                name,
                params: _params,
                optional: _optional,
            } => {
                // TODO: Add support for compound and optional types
                self.node_types[node_id.0] = self.name_to_type(name);
            }
            AstNode::List(ref items) => {
                if let Some(first_id) = items.first() {
                    self.typecheck_node(*first_id);
                    let first_type_id = self.node_types[first_id.0];

                    let mut all_numbers = self.is_type_compatible(first_type_id, NUMBER_TYPE);
                    let mut all_same = true;

                    for item_id in items.iter().skip(1) {
                        self.typecheck_node(*item_id);
                        let item_type_id = self.node_types[item_id.0];

                        if all_numbers && !self.is_type_compatible(item_type_id, NUMBER_TYPE) {
                            all_numbers = false;
                        }

                        if all_same && item_type_id != first_type_id {
                            all_same = false;
                        }
                    }

                    if all_same {
                        self.node_types[node_id.0] = self.push_type(Type::List(first_type_id));
                    } else if all_numbers {
                        self.node_types[node_id.0] = self.push_type(Type::List(NUMBER_TYPE));
                    } else {
                        self.node_types[node_id.0] = self.push_type(Type::List(ANY_TYPE));
                    }
                } else {
                    self.node_types[node_id.0] = LIST_ANY_TYPE;
                }
            }
            AstNode::Block(block_id) => {
                let block = &self.compiler.blocks[block_id.0];

                for inner_node_id in &block.nodes {
                    self.typecheck_node(*inner_node_id);
                }

                self.node_types[node_id.0] = UNIT_TYPE;
            }
            AstNode::Closure { params, block } => {
                if let Some(params_node_id) = params {
                    self.typecheck_node(params_node_id);
                }

                self.typecheck_node(block);

                self.node_types[node_id.0] = CLOSURE_TYPE;
            }
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

                self.node_types[node_id.0] = self.variable_types[var_id.0];
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

    fn push_type(&mut self, ty: Type) -> TypeId {
        self.types.push(ty);
        TypeId(self.types.len() - 1)
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

            if !self.is_type_compatible(self.node_types[ty.0], self.node_types[initializer.0]) {
                self.error("initializer does not match declared type", initializer)
            }
        }

        let var_id = self
            .compiler
            .var_resolution
            .get(&variable_name)
            .expect("missing declared variable");

        let ty = if let Some(ty) = ty {
            self.node_types[ty.0]
        } else {
            self.node_types[initializer.0]
        };

        self.variable_types[var_id.0] = ty;
        self.node_types[variable_name.0] = ty;

        self.node_types[node_id.0] = UNIT_TYPE;
    }

    pub fn error(&mut self, msg: impl Into<String>, node_id: NodeId) {
        self.errors.push(SourceError {
            message: msg.into(),
            node_id,
            severity: Severity::Error,
        })
    }

    pub fn name_to_type(&mut self, name_node_id: NodeId) -> TypeId {
        let name = self.compiler.get_span_contents(name_node_id);

        // taken from parse_shape_name() in Nushell:
        match name {
            b"any" => ANY_TYPE,
            // b"binary" => SyntaxShape::Binary,
            // b"block" => {
            //     working_set.error(ParseError::LabeledErrorWithHelp {
            //         error: "Blocks are not support as first-class values".into(),
            //         label: "blocks are not supported as values".into(),
            //         help: "Use 'closure' instead of 'block'".into(),
            //         span,
            //     });
            //     SyntaxShape::Any
            // }
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
                self.error("unknown type", name_node_id);
                UNKNOWN_TYPE
                // }
            }
        }
    }

    pub fn type_to_string(&self, type_id: TypeId) -> String {
        let ty = &self.types[type_id.0];

        match ty {
            Type::Unknown => "unknown".to_string(),
            Type::Unit => "()".to_string(),
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

    #[allow(clippy::match_like_matches_macro)]
    pub fn is_type_compatible(&self, lhs: TypeId, rhs: TypeId) -> bool {
        match (lhs, rhs) {
            (NOTHING_TYPE, NOTHING_TYPE) => true,
            (INT_TYPE, NUMBER_TYPE) => true,
            (INT_TYPE, INT_TYPE) => true,
            (FLOAT_TYPE, NUMBER_TYPE) => true,
            (FLOAT_TYPE, FLOAT_TYPE) => true,
            (BOOL_TYPE, BOOL_TYPE) => true,
            (STRING_TYPE, STRING_TYPE) => true,
            (BLOCK_TYPE, BLOCK_TYPE) => true,
            (CLOSURE_TYPE, CLOSURE_TYPE) => true,
            (NUMBER_TYPE, NUMBER_TYPE) => true,
            (NUMBER_TYPE, INT_TYPE) => true,
            (NUMBER_TYPE, FLOAT_TYPE) => true,
            (ANY_TYPE, _) => true,
            (_, ANY_TYPE) => true,
            _ => false,
        }
    }
}
