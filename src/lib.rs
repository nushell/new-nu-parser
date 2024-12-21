pub mod compiler;
pub mod errors;
pub mod ir_generator;
pub mod naming;
pub mod parser;
pub mod protocol;
pub mod resolver;
#[cfg(test)]
mod test;
mod token;
pub mod typechecker;
