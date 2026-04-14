use crate::ast_nodes::{
    AstNode, BlockId, ExpressionNode, ExpressionNodeId, NameNodeId, NameOrString, NameOrVariable,
    NodeId, NodeIdGetter, NodeIndexer, PipelineId, StatementNode, StatementNodeId,
    StatementOrExpression, VariableNodeId,
};
use crate::protocol::{Command, Declaration};
use crate::{
    compiler::Compiler,
    errors::{Severity, SourceError},
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
    pub variables: HashMap<Vec<u8>, NameOrVariable>,
    pub type_decls: HashMap<Vec<u8>, NameOrVariable>,
    pub decls: HashMap<Vec<u8>, NameOrString>,
    /// Node that defined the scope frame (e.g., a block or overlay)
    pub node_id: BlockId,
}

impl Frame {
    pub fn new(scope_type: FrameType, node_id: BlockId) -> Self {
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
    Param(NameNodeId),
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
    pub var_resolution: HashMap<NameOrVariable, VarId>,
    pub type_decls: Vec<TypeDecl>,
    pub type_resolution: HashMap<NameOrVariable, TypeDeclId>,
    pub decls: Vec<Box<dyn Command>>,
    pub decl_nodes: Vec<StatementNodeId>,
    pub decl_resolution: HashMap<NodeIndexer, DeclId>,
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
    pub var_resolution: HashMap<NameOrVariable, VarId>,
    /// Type declarations, indexed by TypeDeclId
    pub type_decls: Vec<TypeDecl>,
    /// Mapping of type decl's name node -> TypeDecl
    pub type_resolution: HashMap<NameOrVariable, TypeDeclId>,
    /// Declarations (commands, aliases, etc.), indexed by DeclId
    pub decls: Vec<Box<dyn Command>>,
    /// Declaration nodes, indexed by DeclId
    pub decl_nodes: Vec<StatementNodeId>,
    /// Mapping of decl's name node -> Command
    /// It can be NameOrString, or an AstNode::Call.
    // NOTE: not sure why it can be ExpressionNode::Call, but let's keep the original behavior.
    pub decl_resolution: HashMap<NodeIndexer, DeclId>,
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
                    "{:?} (NodeId {:?}): {}\n",
                    error.severity, error.node_id, error.message
                ));
            }
        }

        result
    }

    pub fn resolve(&mut self) {
        if !self.compiler.indexer.is_empty() {
            let length = self.compiler.indexer.len();
            let last_indexer = self.compiler.indexer[length - 1];
            match last_indexer {
                NodeIndexer::General(node_id) => self.resolve_node(&node_id),
                NodeIndexer::Block(block_id) => self.resolve_block(&block_id, None),
                NodeIndexer::Expression(expr_id) => self.resolve_expression(&expr_id),
                NodeIndexer::Statement(stmt_id) => self.resolve_statement(&stmt_id),
            }
        }
        // if !self.compiler.ast_nodes.is_empty() {
        //     let last = self.compiler.ast_nodes.len() - 1;
        //     let last_node_id = NodeId(last);
        //     self.resolve_node(last_node_id)
        // }
    }

    pub fn resolve_expression(&mut self, expr_id: &ExpressionNodeId) {
        let node = expr_id.get_node(self.compiler);
        match node {
            ExpressionNode::Variable(node_id) => self.resolve_variable(node_id),
            ExpressionNode::Call { head, parts } => self.resolve_call(expr_id, head, parts),
            ExpressionNode::Closure { params, block } => {
                // making sure the closure parameters and body end up in the same scope frame
                let closure_scope = if let Some(params) = params {
                    self.enter_scope(block);
                    self.resolve_node(params);
                    Some(self.exit_scope())
                } else {
                    None
                };

                self.resolve_block(block, closure_scope);
            }
            ExpressionNode::BinaryOp { lhs, op: _, rhs } => {
                self.resolve_expression(lhs);
                self.resolve_expression(rhs);
            }
            ExpressionNode::Range { lhs, rhs } => {
                self.resolve_expression(lhs);
                self.resolve_expression(rhs);
            }
            ExpressionNode::List(ref nodes) => {
                for node in nodes {
                    self.resolve_expression(node);
                }
            }
            ExpressionNode::Table { header, ref rows } => {
                self.resolve_expression(header);
                for row in rows {
                    self.resolve_expression(row);
                }
            }
            ExpressionNode::Record { ref pairs } => {
                for (key, val) in pairs {
                    self.resolve_expression(key);
                    self.resolve_expression(val);
                }
            }
            ExpressionNode::MemberAccess { target, field } => {
                self.resolve_expression(target);
                self.resolve_expression(field);
            }
            ExpressionNode::If {
                condition,
                then_block,
                else_block,
            } => {
                self.resolve_expression(condition);
                self.resolve_block(then_block, None);
                if let Some(block) = else_block {
                    match block {
                        NodeIndexer::Block(block_id) => self.resolve_block(block_id, None),
                        NodeIndexer::Expression(expr_id) => self.resolve_expression(expr_id),
                        _ => panic!("internal error: invalid else block indexer"),
                    }
                }
            }
            ExpressionNode::Match {
                target,
                ref match_arms,
            } => {
                self.resolve_expression(target);
                for (arm_lhs, arm_rhs) in match_arms {
                    self.resolve_expression(arm_lhs);
                    self.resolve_expression(arm_rhs);
                }
            }
            ExpressionNode::Pipeline(pipeline_id) => self.resolve_pipeline(pipeline_id),
            ExpressionNode::NamedValue { .. } => (/* seems unused for now */),
            _ => { // TODO: handle for remaining expression types.
            }
        }
    }

    pub fn resolve_statement(&mut self, stmt_id: &StatementNodeId) {
        let node = stmt_id.get_node(self.compiler);
        match node {
            StatementNode::Def {
                name,
                type_params,
                params,
                in_out_types,
                block,
                env: _,
                wrapped: _,
            } => {
                // define the command before the block to enable recursive calls
                self.define_decl(name, stmt_id);

                // making sure the def parameters and body end up in the same scope frame
                self.enter_scope(block);
                if let Some(type_params) = type_params {
                    let AstNode::TypeParams(type_params) = type_params.get_node(self.compiler)
                    else {
                        panic!("Internal error: expected type params")
                    };
                    for type_param_id in type_params {
                        self.define_type_decl(type_param_id, TypeDecl::Param(*type_param_id));
                    }
                }
                self.resolve_node(params);
                if let Some(in_out_types) = in_out_types {
                    self.resolve_node(in_out_types);
                }
                let def_scope = self.exit_scope();

                self.resolve_block(block, Some(def_scope));
            }
            StatementNode::Alias {
                new_name,
                old_name: _,
            } => {
                self.define_decl(new_name, stmt_id);
            }
            StatementNode::Let {
                variable_name,
                ty,
                initializer,
                is_mutable,
            } => {
                if let Some(ty) = ty {
                    self.resolve_node(ty);
                }
                self.resolve_expression(initializer);
                self.define_variable(&NameOrVariable::Variable(*variable_name), *is_mutable)
            }
            StatementNode::While { condition, block } => {
                self.resolve_expression(condition);
                self.resolve_block(block, None);
            }
            StatementNode::For {
                variable,
                range,
                block,
            } => {
                // making sure the for loop variable and body end up in the same scope frame
                self.enter_scope(block);
                self.define_variable(&NameOrVariable::Variable(*variable), false);
                let for_body_scope = self.exit_scope();

                self.resolve_expression(range);
                self.resolve_block(block, Some(for_body_scope));
            }
            StatementNode::Loop { block } => {
                self.resolve_block(block, None);
            }
            _ => {
                // TODO: handle for remaining statement types.
            }
        }
    }
    pub fn resolve_node(&mut self, node_id: &NodeId) {
        // TODO: Move node_id param to the end, same as in typechecker
        let node = node_id.get_node(self.compiler);
        match node {
            AstNode::Params(ref params) => {
                for param in params {
                    let AstNode::Param { name, ty } = param.get_node(self.compiler) else {
                        panic!("param is not a param");
                    };
                    self.define_variable(&NameOrVariable::Name(*name), false);
                    if let Some(ty) = ty {
                        self.resolve_node(ty);
                    }
                }
            }
            AstNode::Type { name, args, .. } => {
                self.resolve_type(name);
                if let Some(args) = args {
                    self.resolve_node(args);
                }
            }
            AstNode::RecordType { fields, .. } => {
                let AstNode::Params(fields) = fields.get_node(self.compiler) else {
                    panic!("Internal error: expected params for record field types");
                };
                for field in fields {
                    if let AstNode::Param { ty: Some(ty), .. } = field.get_node(self.compiler) {
                        self.resolve_node(ty);
                    }
                }
            }
            AstNode::TypeArgs(ref args) => {
                for arg in args {
                    self.resolve_node(arg);
                }
            }
            AstNode::InOutTypes(ref in_out_types) => {
                for in_out_ty in in_out_types {
                    self.resolve_node(in_out_ty);
                }
            }
            AstNode::InOutType(in_ty, out_ty) => {
                self.resolve_node(in_ty);
                self.resolve_node(out_ty);
            }
            AstNode::Param { .. } => (/* seems unused for now */),
            // All remaining matches do not contain NodeId => there is nothing to resolve
            _ => (),
        }
    }

    pub fn resolve_pipeline(&mut self, pipeline_id: &PipelineId) {
        let pipeline = pipeline_id.get_node(self.compiler);

        for exp in pipeline.get_expressions() {
            self.resolve_expression(exp)
        }
    }

    pub fn resolve_variable(&mut self, unbound_node_id: &VariableNodeId) {
        let var_name = trim_var_name(unbound_node_id.get_span_contents(self.compiler));

        if let Some(node_id) = self.find_variable(var_name) {
            let var_id = self
                .var_resolution
                .get(&node_id)
                .expect("internal error: missing resolved variable");

            self.var_resolution
                .insert(NameOrVariable::Variable(*unbound_node_id), *var_id);
        } else {
            self.errors.push(SourceError {
                message: format!("variable `{}` not found", String::from_utf8_lossy(var_name)),
                node_id: unbound_node_id.into_indexer(self.compiler),
                severity: Severity::Error,
            })
        }
    }

    pub fn resolve_type(&mut self, unbound_node_id: &NameNodeId) {
        let type_name = unbound_node_id.get_span_contents(self.compiler);

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

            self.type_resolution
                .insert(NameOrVariable::Name(*unbound_node_id), *type_id);
        } else {
            self.errors.push(SourceError {
                message: format!("type `{}` not found", String::from_utf8_lossy(type_name)),
                node_id: unbound_node_id.into_indexer(self.compiler),
                severity: Severity::Error,
            })
        }
    }

    pub fn resolve_call(
        &mut self,
        unbound_node_id: &ExpressionNodeId,
        head: &[NameNodeId],
        parts: &[ExpressionNodeId],
    ) {
        // Try to find the longest matching subcommand
        let first_start = head[0].get_span(self.compiler).start;

        // TODO: There must be an issue while resolving call
        // It should not required `take(1)`, but to keep logic the same, we keep it for now.
        for head_node in head.iter().take(1).rev() {
            let last_end = head_node.get_span(self.compiler).end;
            let name = self
                .compiler
                .get_span_contents_manual(first_start, last_end);

            if let Some(node_id) = self.find_decl(name) {
                let decl_id = self
                    .decl_resolution
                    .get(&node_id)
                    .expect("internal error: missing resolved decl");

                self.decl_resolution
                    .insert(unbound_node_id.into_indexer(self.compiler), *decl_id);
                break;
            }
        }

        // TODO? If the call does not correspond to any existing decl, it is an external call

        // Resolve args
        for part in parts {
            self.resolve_expression(part);
        }
    }

    pub fn resolve_block(&mut self, block_id: &BlockId, reused_scope: Option<ScopeId>) {
        let block = block_id.get_node(self.compiler);

        if let Some(scope_id) = reused_scope {
            self.enter_existing_scope(scope_id);
        } else {
            self.enter_scope(block_id);
        }

        for inner_node_id in &block.nodes {
            match inner_node_id {
                StatementOrExpression::Expression(expr_id) => self.resolve_expression(expr_id),
                StatementOrExpression::Statement(stmt_id) => self.resolve_statement(stmt_id),
            }
        }
        self.exit_scope();
    }

    /// Enter an existing scope frame, e.g., a block or a closure
    pub fn enter_existing_scope(&mut self, scope_id: ScopeId) {
        self.scope_stack.push(scope_id);
    }

    /// Enter a new scope frame, e.g., a block or a closure
    pub fn enter_scope(&mut self, node_id: &BlockId) {
        self.scope.push(Frame::new(FrameType::Scope, *node_id));
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

    pub fn define_variable(&mut self, var_name_id: &NameOrVariable, is_mutable: bool) {
        let var_name = match var_name_id {
            NameOrVariable::Name(name_node_id) => name_node_id.get_span_contents(self.compiler),
            NameOrVariable::Variable(var_node_id) => var_node_id.get_span_contents(self.compiler),
        };
        let var_name = trim_var_name(var_name).to_vec();

        let current_scope_id = self
            .scope_stack
            .last()
            .expect("internal error: missing scope frame id");

        self.scope[current_scope_id.0]
            .variables
            .insert(var_name, *var_name_id);

        let var = Variable { is_mutable };
        self.variables.push(var);
        let var_id = VarId(self.variables.len() - 1);

        // let the definition of a variable also count as its use
        self.var_resolution.insert(*var_name_id, var_id);
    }

    pub fn define_type_decl(&mut self, type_name_id: &NameNodeId, type_decl: TypeDecl) {
        let type_name = type_name_id.get_span_contents(self.compiler).to_vec();

        let current_scope_id = self
            .scope_stack
            .last()
            .expect("internal error: missing scope frame id");

        self.scope[current_scope_id.0]
            .type_decls
            .insert(type_name, NameOrVariable::Name(*type_name_id));

        self.type_decls.push(type_decl);
        let type_id = TypeDeclId(self.type_decls.len() - 1);

        // let the definition of a type also count as its use
        self.type_resolution
            .insert(NameOrVariable::Name(*type_name_id), type_id);
    }

    pub fn define_decl(&mut self, decl_name_id: &NameOrString, decl_node_id: &StatementNodeId) {
        // TODO: Deduplicate code with define_variable()
        let decl_name = match decl_name_id {
            NameOrString::Name(name_node_id) => {
                trim_decl_name(name_node_id.get_span_contents(self.compiler))
            }
            NameOrString::String(string_node_id) => {
                trim_decl_name(string_node_id.get_span_contents(self.compiler))
            }
        };
        let decl = Declaration::new(String::from_utf8_lossy(decl_name).to_string());

        let current_scope_id = self
            .scope_stack
            .last()
            .expect("internal error: missing scope frame id");

        self.scope[current_scope_id.0]
            .decls
            .insert(decl_name.to_vec(), *decl_name_id);

        self.decls.push(Box::new(decl));
        self.decl_nodes.push(*decl_node_id);

        let decl_id = DeclId(self.decls.len() - 1);
        // let the definition of a decl also count as its use
        self.decl_resolution
            .insert(decl_name_id.into_indexer(self.compiler), decl_id);
    }

    pub fn find_variable(&self, var_name: &[u8]) -> Option<NameOrVariable> {
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].variables.get(var_name) {
                return Some(*id);
            }
        }

        None
    }

    pub fn find_type(&self, type_name: &[u8]) -> Option<NameOrVariable> {
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].type_decls.get(type_name) {
                return Some(*id);
            }
        }

        None
    }

    pub fn find_decl(&self, var_name: &[u8]) -> Option<NodeIndexer> {
        // TODO: Deduplicate code with find_variable()
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].decls.get(var_name) {
                return Some(id.into_indexer(self.compiler));
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
