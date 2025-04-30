use crate::protocol::{Command, Declaration};
use crate::{
    compiler::Compiler,
    errors::{Severity, SourceError},
    parser::{AstNode, BlockId, NodeId},
};
use std::collections::HashMap;

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct ScopeId(pub usize);

#[derive(Debug, PartialEq, Clone, Copy)]
pub enum FrameType {
    /// Default scope frame marking the scope of a block/closure
    Scope,
    /// Immutable frame brought in by an overlay
    Overlay,
    /// Mutable frame inserted after activating an overlay to prevent mutating the overlay frame
    Light,
}

#[derive(Debug, Clone)]
pub struct Frame {
    pub frame_type: FrameType,
    pub variables: HashMap<Vec<u8>, NodeId>,
    pub type_decls: HashMap<Vec<u8>, NodeId>,
    pub decls: HashMap<Vec<u8>, NodeId>,
    /// Node that defined the scope frame (e.g., a block or overlay)
    pub node_id: NodeId,
}

impl Frame {
    pub fn new(scope_type: FrameType, node_id: NodeId) -> Self {
        Frame {
            frame_type: scope_type,
            variables: HashMap::new(),
            type_decls: HashMap::new(),
            decls: HashMap::new(),
            node_id,
        }
    }
}

#[derive(Debug, Clone)]
pub struct Variable {
    pub is_mutable: bool,
}

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct VarId(pub usize);

#[derive(Debug, Clone)]
pub enum TypeDecl {
    /// A type parameter. Holds the parameter name node
    Param(NodeId),
    // In the future, we may have type aliases, user-defined classes, etc.
}

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct TypeDeclId(pub usize);

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct DeclId(pub usize);

/// Fields extracted from Resolver
pub struct NameBindings {
    pub scope: Vec<Frame>,
    pub scope_stack: Vec<ScopeId>,
    pub variables: Vec<Variable>,
    pub var_resolution: HashMap<NodeId, VarId>,
    pub type_decls: Vec<TypeDecl>,
    pub type_resolution: HashMap<NodeId, TypeDeclId>,
    pub decls: Vec<Box<dyn Command>>,
    pub decl_nodes: Vec<NodeId>,
    pub decl_resolution: HashMap<NodeId, DeclId>,
    pub errors: Vec<SourceError>,
}

impl NameBindings {
    pub fn new() -> Self {
        Self {
            scope: vec![],
            scope_stack: vec![],
            variables: vec![],
            var_resolution: HashMap::new(),
            type_decls: vec![],
            type_resolution: HashMap::new(),
            decls: vec![],
            decl_nodes: vec![],
            decl_resolution: HashMap::new(),
            errors: vec![],
        }
    }
}

impl Default for NameBindings {
    fn default() -> Self {
        Self::new()
    }
}

pub struct Resolver<'a> {
    // Immutable reference to a compiler after the first parsing pass
    compiler: &'a Compiler,

    /// All scope frames ever entered, indexed by ScopeId
    pub scope: Vec<Frame>,
    /// Stack of currently entered scope frames
    pub scope_stack: Vec<ScopeId>,
    /// Variables, indexed by VarId
    pub variables: Vec<Variable>,
    /// Mapping of variable's name node -> Variable
    pub var_resolution: HashMap<NodeId, VarId>,
    /// Type declarations, indexed by TypeDeclId
    pub type_decls: Vec<TypeDecl>,
    /// Mapping of type decl's name node -> TypeDecl
    pub type_resolution: HashMap<NodeId, TypeDeclId>,
    /// Declarations (commands, aliases, etc.), indexed by DeclId
    pub decls: Vec<Box<dyn Command>>,
    /// Declaration nodes, indexed by DeclId
    pub decl_nodes: Vec<NodeId>,
    /// Mapping of decl's name node -> Command
    pub decl_resolution: HashMap<NodeId, DeclId>,
    /// Errors encountered during name binding
    pub errors: Vec<SourceError>,
}

impl<'a> Resolver<'a> {
    pub fn new(compiler: &'a Compiler) -> Self {
        Self {
            compiler,
            scope: vec![],
            scope_stack: vec![],
            variables: vec![],
            var_resolution: HashMap::new(),
            type_decls: vec![],
            type_resolution: HashMap::new(),
            decls: vec![],
            decl_nodes: vec![],
            decl_resolution: HashMap::new(),
            errors: vec![],
        }
    }

    pub fn to_name_bindings(self) -> NameBindings {
        NameBindings {
            scope: self.scope,
            scope_stack: self.scope_stack,
            variables: self.variables,
            var_resolution: self.var_resolution,
            type_decls: self.type_decls,
            type_resolution: self.type_resolution,
            decls: self.decls,
            decl_nodes: self.decl_nodes,
            decl_resolution: self.decl_resolution,
            errors: self.errors,
        }
    }

    pub fn print(&self) {
        let output = self.display_state();
        print!("{output}");
    }

    #[allow(clippy::format_collect)]
    pub fn display_state(&self) -> String {
        let mut result = String::new();

        result.push_str("==== SCOPE ====\n");
        for (i, scope) in self.scope.iter().enumerate() {
            result.push_str(&format!(
                "{i}: Frame {0:?}, node_id: {1:?}",
                scope.frame_type, scope.node_id
            ));

            let mut vars: Vec<String> = scope
                .variables
                .iter()
                .map(|(name, id)| format!("{0}: {id:?}", String::from_utf8_lossy(name)))
                .collect();

            let mut types: Vec<String> = scope
                .type_decls
                .iter()
                .map(|(name, id)| format!("{0}: {id:?}", String::from_utf8_lossy(name)))
                .collect();

            let mut decls: Vec<String> = scope
                .decls
                .iter()
                .map(|(name, id)| format!("{0}: {id:?}", String::from_utf8_lossy(name)))
                .collect();

            if vars.is_empty() && types.is_empty() && decls.is_empty() {
                result.push_str(" (empty)\n");
                continue;
            }

            result.push('\n');

            if !vars.is_empty() {
                vars.sort();
                let line_var = format!("  variables: [ {0} ]\n", vars.join(", "));
                result.push_str(&line_var);
            }

            if !types.is_empty() {
                types.sort();
                let line_type = format!("  type decls: [ {0} ]\n", types.join(", "));
                result.push_str(&line_type);
            }

            if !decls.is_empty() {
                decls.sort();
                let line_decl = format!("      decls: [ {0} ]\n", decls.join(", "));
                result.push_str(&line_decl);
            }
        }

        if !self.errors.is_empty() {
            result.push_str("==== SCOPE ERRORS ====\n");
            for error in &self.errors {
                result.push_str(&format!(
                    "{:?} (NodeId {}): {}\n",
                    error.severity, error.node_id.0, error.message
                ));
            }
        }

        result
    }

    pub fn resolve(&mut self) {
        if !self.compiler.ast_nodes.is_empty() {
            let last = self.compiler.ast_nodes.len() - 1;
            let last_node_id = NodeId(last);
            self.resolve_node(last_node_id)
        }
    }

    pub fn resolve_node(&mut self, node_id: NodeId) {
        // TODO: Move node_id param to the end, same as in typechecker
        match self.compiler.ast_nodes[node_id.0] {
            AstNode::Variable => self.resolve_variable(node_id),
            AstNode::Call { ref parts } => self.resolve_call(node_id, parts),
            AstNode::Block(block_id) => self.resolve_block(node_id, block_id, None),
            AstNode::Closure { params, block } => {
                // making sure the closure parameters and body end up in the same scope frame
                let closure_scope = if let Some(params) = params {
                    self.enter_scope(block);
                    self.resolve_node(params);
                    Some(self.exit_scope())
                } else {
                    None
                };

                let AstNode::Block(block_id) = self.compiler.ast_nodes[block.0] else {
                    panic!("internal error: closure's body is not a block");
                };

                self.resolve_block(block, block_id, closure_scope);
            }
            AstNode::Def {
                name,
                type_params,
                params,
                in_out_types,
                block,
            } => {
                // define the command before the block to enable recursive calls
                self.define_decl(name, node_id);

                // making sure the def parameters and body end up in the same scope frame
                self.enter_scope(block);
                if let Some(type_params) = type_params {
                    let AstNode::Params(type_params) = self.compiler.get_node(type_params) else {
                        panic!("Internal error: expected type params")
                    };
                    for type_param_id in type_params {
                        self.define_type_decl(*type_param_id, TypeDecl::Param(*type_param_id));
                    }
                }
                self.resolve_node(params);
                if let Some(in_out_types) = in_out_types {
                    self.resolve_node(in_out_types);
                }
                let def_scope = self.exit_scope();

                let AstNode::Block(block_id) = self.compiler.ast_nodes[block.0] else {
                    panic!("internal error: command definition's body is not a block");
                };

                self.resolve_block(block, block_id, Some(def_scope));
            }
            AstNode::Alias {
                new_name,
                old_name: _,
            } => {
                self.define_decl(new_name, node_id);
            }
            AstNode::Params(ref params) => {
                for param in params {
                    let AstNode::Param { name, ty } = self.compiler.ast_nodes[param.0] else {
                        panic!("param is not a param");
                    };
                    self.define_variable(name, false);
                    if let Some(ty) = ty {
                        self.resolve_node(ty);
                    }
                }
            }
            AstNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable,
            } => {
                if let Some(ty) = ty {
                    self.resolve_node(ty);
                }
                self.resolve_node(initializer);
                self.define_variable(variable_name, is_mutable)
            }
            AstNode::While { condition, block } => {
                self.resolve_node(condition);
                self.resolve_node(block);
            }
            AstNode::For {
                variable,
                range,
                block,
            } => {
                // making sure the for loop variable and body end up in the same scope frame
                self.enter_scope(block);
                self.define_variable(variable, false);
                let for_body_scope = self.exit_scope();

                self.resolve_node(range);

                let AstNode::Block(block_id) = self.compiler.ast_nodes[block.0] else {
                    panic!("internal error: for's body is not a block");
                };

                self.resolve_block(block, block_id, Some(for_body_scope));
            }
            AstNode::Loop { block } => {
                self.resolve_node(block);
            }
            AstNode::BinaryOp { lhs, op: _, rhs } => {
                self.resolve_node(lhs);
                self.resolve_node(rhs);
            }
            AstNode::Range { lhs, rhs } => {
                self.resolve_node(lhs);
                self.resolve_node(rhs);
            }
            AstNode::List(ref nodes) => {
                for node in nodes {
                    self.resolve_node(*node);
                }
            }
            AstNode::Table { header, ref rows } => {
                self.resolve_node(header);
                for row in rows {
                    self.resolve_node(*row);
                }
            }
            AstNode::Record { ref pairs } => {
                for (key, val) in pairs {
                    self.resolve_node(*key);
                    self.resolve_node(*val);
                }
            }
            AstNode::MemberAccess { target, field } => {
                self.resolve_node(target);
                self.resolve_node(field);
            }
            AstNode::If {
                condition,
                then_block,
                else_block,
            } => {
                self.resolve_node(condition);
                self.resolve_node(then_block);
                if let Some(block) = else_block {
                    self.resolve_node(block);
                }
            }
            AstNode::Match {
                target,
                ref match_arms,
            } => {
                self.resolve_node(target);
                for (arm_lhs, arm_rhs) in match_arms {
                    self.resolve_node(*arm_lhs);
                    self.resolve_node(*arm_rhs);
                }
            }
            AstNode::Statement(node) => self.resolve_node(node),
            AstNode::Type { name, args, .. } => {
                self.resolve_type(name);
                if let Some(args) = args {
                    self.resolve_node(args);
                }
            }
            AstNode::RecordType { fields, .. } => {
                let AstNode::Params(fields) = self.compiler.get_node(fields) else {
                    panic!("Internal error: expected params for record field types");
                };
                for field in fields {
                    if let AstNode::Param { ty: Some(ty), .. } = self.compiler.get_node(*field) {
                        self.resolve_node(*ty);
                    }
                }
            }
            AstNode::TypeArgs(ref args) => {
                for arg in args {
                    self.resolve_node(*arg);
                }
            }
            AstNode::InOutTypes(ref in_out_types) => {
                for in_out_ty in in_out_types {
                    self.resolve_node(*in_out_ty);
                }
            }
            AstNode::InOutType(in_ty, out_ty) => {
                self.resolve_node(in_ty);
                self.resolve_node(out_ty);
            }
            AstNode::Param { .. } => (/* seems unused for now */),
            AstNode::NamedValue { .. } => (/* seems unused for now */),
            // All remaining matches do not contain NodeId => there is nothing to resolve
            _ => (),
        }
    }

    pub fn resolve_variable(&mut self, unbound_node_id: NodeId) {
        let var_name = trim_var_name(self.compiler.get_span_contents(unbound_node_id));

        if let Some(node_id) = self.find_variable(var_name) {
            let var_id = self
                .var_resolution
                .get(&node_id)
                .expect("internal error: missing resolved variable");

            self.var_resolution.insert(unbound_node_id, *var_id);
        } else {
            self.errors.push(SourceError {
                message: format!("variable `{}` not found", String::from_utf8_lossy(var_name)),
                node_id: unbound_node_id,
                severity: Severity::Error,
            })
        }
    }

    pub fn resolve_type(&mut self, unbound_node_id: NodeId) {
        let type_name = self.compiler.get_span_contents(unbound_node_id);

        match type_name {
            b"any" | b"list" | b"bool" | b"closure" | b"float" | b"int" | b"nothing"
            | b"number" | b"string" => return,
            _ => {}
        }

        if let Some(node_id) = self.find_type(type_name) {
            let type_id = self
                .type_resolution
                .get(&node_id)
                .expect("internal error: missing resolved type");

            self.type_resolution.insert(unbound_node_id, *type_id);
        } else {
            self.errors.push(SourceError {
                message: format!("type `{}` not found", String::from_utf8_lossy(type_name)),
                node_id: unbound_node_id,
                severity: Severity::Error,
            })
        }
    }

    pub fn resolve_call(&mut self, unbound_node_id: NodeId, parts: &[NodeId]) {
        // Find out the potentially longest command name
        let max_name_parts = parts
            .iter()
            .position(|part| matches!(self.compiler.ast_nodes[part.0], AstNode::Name))
            .expect("call does not have any name")
            + 1;

        // Try to find the longest matching subcommand
        let first_start = self.compiler.spans[parts[0].0].start;

        for n in (0..max_name_parts).rev() {
            let last_end = self.compiler.spans[parts[n].0].end;
            let name = self
                .compiler
                .get_span_contents_manual(first_start, last_end);

            if let Some(node_id) = self.find_decl(name) {
                let decl_id = self
                    .decl_resolution
                    .get(&node_id)
                    .expect("internal error: missing resolved decl");

                self.decl_resolution.insert(unbound_node_id, *decl_id);
                break;
            }
        }

        // TODO? If the call does not correspond to any existing decl, it is an external call

        // Resolve args
        for part in &parts[max_name_parts..] {
            self.resolve_node(*part);
        }
    }

    pub fn resolve_block(
        &mut self,
        node_id: NodeId,
        block_id: BlockId,
        reused_scope: Option<ScopeId>,
    ) {
        let block = self
            .compiler
            .blocks
            .get(block_id.0)
            .expect("internal error: missing block");

        if let Some(scope_id) = reused_scope {
            self.enter_existing_scope(scope_id);
        } else {
            self.enter_scope(node_id);
        }

        for inner_node_id in &block.nodes {
            self.resolve_node(*inner_node_id);
        }
        self.exit_scope();
    }

    /// Enter an existing scope frame, e.g., a block or a closure
    pub fn enter_existing_scope(&mut self, scope_id: ScopeId) {
        self.scope_stack.push(scope_id);
    }

    /// Enter a new scope frame, e.g., a block or a closure
    pub fn enter_scope(&mut self, node_id: NodeId) {
        self.scope.push(Frame::new(FrameType::Scope, node_id));
        self.scope_stack.push(ScopeId(self.scope.len() - 1));
    }

    /// Exit a scope frame, e.g., when reaching the end of a block or a closure
    ///
    /// When exiting a scope frame, all overlays (and corresponding light frames) are removed along
    /// with the removed frame.
    pub fn exit_scope(&mut self) -> ScopeId {
        match self
            .scope_stack
            .iter()
            .rposition(|scope_id| self.scope[scope_id.0].frame_type == FrameType::Scope)
        {
            None => panic!("internal error: no scope frame to exit"),
            Some(pos) => {
                let scope_id = self.scope_stack[pos];
                self.scope_stack.truncate(pos);
                scope_id
            }
        }
    }

    pub fn define_variable(&mut self, var_name_id: NodeId, is_mutable: bool) {
        let var_name = self.compiler.get_span_contents(var_name_id);
        let var_name = trim_var_name(var_name).to_vec();

        let current_scope_id = self
            .scope_stack
            .last()
            .expect("internal error: missing scope frame id");

        self.scope[current_scope_id.0]
            .variables
            .insert(var_name, var_name_id);

        let var = Variable { is_mutable };
        self.variables.push(var);
        let var_id = VarId(self.variables.len() - 1);

        // let the definition of a variable also count as its use
        self.var_resolution.insert(var_name_id, var_id);
    }

    pub fn define_type_decl(&mut self, type_name_id: NodeId, type_decl: TypeDecl) {
        let type_name = self.compiler.get_span_contents(type_name_id).to_vec();

        let current_scope_id = self
            .scope_stack
            .last()
            .expect("internal error: missing scope frame id");

        self.scope[current_scope_id.0]
            .type_decls
            .insert(type_name, type_name_id);

        self.type_decls.push(type_decl);
        let type_id = TypeDeclId(self.type_decls.len() - 1);

        // let the definition of a type also count as its use
        self.type_resolution.insert(type_name_id, type_id);
    }

    pub fn define_decl(&mut self, decl_name_id: NodeId, decl_node_id: NodeId) {
        // TODO: Deduplicate code with define_variable()
        let decl_name = self.compiler.get_span_contents(decl_name_id);
        let decl_name = trim_decl_name(decl_name).to_vec();
        let decl = Declaration::new(String::from_utf8_lossy(&decl_name).to_string());

        let current_scope_id = self
            .scope_stack
            .last()
            .expect("internal error: missing scope frame id");

        self.scope[current_scope_id.0]
            .decls
            .insert(decl_name, decl_name_id);

        self.decls.push(Box::new(decl));
        self.decl_nodes.push(decl_node_id);

        let decl_id = DeclId(self.decls.len() - 1);
        // let the definition of a decl also count as its use
        self.decl_resolution.insert(decl_name_id, decl_id);
    }

    pub fn find_variable(&self, var_name: &[u8]) -> Option<NodeId> {
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].variables.get(var_name) {
                return Some(*id);
            }
        }

        None
    }

    pub fn find_type(&self, type_name: &[u8]) -> Option<NodeId> {
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].type_decls.get(type_name) {
                return Some(*id);
            }
        }

        None
    }

    pub fn find_decl(&self, var_name: &[u8]) -> Option<NodeId> {
        // TODO: Deduplicate code with find_variable()
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].decls.get(var_name) {
                return Some(*id);
            }
        }

        None
    }
}

fn trim_var_name(name: &[u8]) -> &[u8] {
    if name.starts_with(b"$") && name.len() > 1 {
        &name[1..]
    } else {
        name
    }
}
fn trim_decl_name(name: &[u8]) -> &[u8] {
    if (name.starts_with(b"'") && name.ends_with(b"'"))
        || (name.starts_with(b"\"") && name.ends_with(b"\""))
        || (name.starts_with(b"`") && name.ends_with(b"`"))
    {
        &name[1..name.len() - 1]
    } else {
        name
    }
}
