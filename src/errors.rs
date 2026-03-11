use crate::{ast_nodes::NodeIndexer, parser::NodeId};

#[derive(Debug, Clone, Copy)]
pub enum Severity {
    Error,
    Note,
}

#[derive(Debug, Clone)]
pub struct SourceError {
    pub message: String,
    pub node_id: NodeIndexer,
    pub severity: Severity,
}
