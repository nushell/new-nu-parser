//! Naming is hard
//!
//! The intent for this file is to store all naming-related code in one place.

pub const BAREWORD_STRING: BarewordContext = BarewordContext { as_string: true };

pub const BAREWORD_NAME: BarewordContext = BarewordContext { as_string: false };

/// Defines how barewords should be handled when parsing expressions
#[derive(Debug, Copy, Clone)]
pub struct BarewordContext {
    /// Bareword is a string (e.g., in `[ a b c ]`)
    pub as_string: bool,
}
