//! Naming is hard
//!
//! The intent for this file is to store all naming-related code in one place.

pub const STRING_STRICT: BarewordContext = BarewordContext {
    as_string: true,
    strictness: NameStrictness::Strict,
};

pub const NAME_STRICT: BarewordContext = BarewordContext {
    as_string: false,
    strictness: NameStrictness::Strict,
};

/// Defines how barewords should be handled when parsing expressions
#[derive(Debug, Copy, Clone)]
pub struct BarewordContext {
    /// Bareword is a string (e.g., in `[ a b c ]`)
    pub as_string: bool,
    /// Which characters are allowed / forbidden for the bareeword
    pub strictness: NameStrictness,
}

/// Defines which characters are allowed for names and barewords
///
/// All of thee variants disallow whitespace
#[derive(Debug, Copy, Clone)]
pub enum NameStrictness {
    /// Only letters and '_' are allowed (no punctuation)
    Strict,
    /// All characters except those in the list are allowed
    AllCharsExcept(&'static [u8]),
}
