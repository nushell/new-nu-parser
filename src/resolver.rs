use crate::{
    compiler::Compiler,
    errors::{Severity, SourceError},
    parser::{AstNode, BlockId, NodeId},
};
use std::collections::HashMap;

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct ScopeId(pub usize);

#[derive(Debug, PartialEq)]
pub enum FrameType {
    /// Default scope frame marking the scope of a block/closure
    Scope,
    /// Immutable frame brought in by an overlay
    Overlay,
    /// Mutable frame inserted after activating an overlay to prevent mutating the overlay frame
    Light,
}

#[derive(Debug)]
pub struct Frame {
    pub frame_type: FrameType,
    pub variables: HashMap<Vec<u8>, NodeId>,
    /// Node that defined the scope frame (e.g., a block or overlay)
    pub node_id: NodeId,
}

impl Frame {
    pub fn new(scope_type: FrameType, node_id: NodeId) -> Self {
        Frame {
            frame_type: scope_type,
            variables: HashMap::new(),
            node_id,
        }
    }
}

#[derive(Debug)]
pub struct Variable {
    pub is_mutable: bool,
}

#[derive(Debug, Clone, Copy, Hash, PartialEq, Eq)]
pub struct VarId(pub usize);

pub struct NameBindings {
    /// All scope frames ever entered, indexed by ScopeId
    pub scope: Vec<Frame>,
    /// Stack of currently entered scope frames
    pub scope_stack: Vec<ScopeId>,
    /// Variables, indexed by VarId
    pub variables: Vec<Variable>,
    /// Mapping of variable's name node -> Variable
    pub var_resolution: HashMap<NodeId, VarId>,
    pub errors: Vec<SourceError>,
}

impl NameBindings {
    pub fn new() -> Self {
        Self {
            scope: vec![],
            scope_stack: vec![],
            variables: vec![],
            var_resolution: HashMap::new(),
            errors: vec![],
        }
    }
}

impl Default for NameBindings {
    fn default() -> Self {
        Self::new()
    }
}

#[derive(Debug)]
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
            errors: vec![],
        }
    }

    pub fn to_name_bindings(self) -> NameBindings {
        NameBindings {
            scope: self.scope,
            scope_stack: self.scope_stack,
            variables: self.variables,
            var_resolution: self.var_resolution,
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
            let mut vars: Vec<String> = scope
                .variables
                .iter()
                .map(|(name, id)| format!("{0}: {id:?}", String::from_utf8_lossy(name)))
                .collect();

            vars.sort();

            let line = format!(
                "{i}: Frame {0:?}, variables: [ {1} ], node_id: {2:?}\n",
                scope.frame_type,
                vars.join(", "),
                scope.node_id
            );
            result.push_str(&line);
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
        match self.compiler.ast_nodes[node_id.0] {
            AstNode::Variable => self.resolve_variable(node_id),
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
                name: _,
                params,
                return_ty: _,
                block,
            } => {
                // making sure the def parameters and body end up in the same scope frame
                self.enter_scope(block);
                self.resolve_node(params);
                let def_scope = self.exit_scope();

                let AstNode::Block(block_id) = self.compiler.ast_nodes[block.0] else {
                    panic!("internal error: command definition's body is not a block");
                };

                self.resolve_block(block, block_id, Some(def_scope));
            }
            AstNode::Params(ref params) => {
                for param in params {
                    if let AstNode::Param { name, .. } = self.compiler.ast_nodes[param.0] {
                        self.define_variable(name, false);
                    } else {
                        panic!("param is not a param");
                    }
                }
            }
            AstNode::Let {
                variable_name,
                ty: _,
                initializer,
                is_mutable,
            } => {
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
            AstNode::Call { head: _, ref args } => {
                for arg in args {
                    self.resolve_node(*arg);
                }
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
            AstNode::Param { .. } => (/* seems unused for now */),
            AstNode::Type { .. } => ( /* probably doesn't make sense to resolve? */ ),
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

    pub fn find_variable(&self, var_name: &[u8]) -> Option<NodeId> {
        for scope_id in self.scope_stack.iter().rev() {
            if let Some(id) = self.scope[scope_id.0].variables.get(var_name) {
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
