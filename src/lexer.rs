use crate::compiler::Span;
use logos::Logos;

/// Average number of bytes per token used for estimating the tokens buffer size.
///
/// Estimated with this snippet:
/// let res = ls tests/**/*.nu | get name | each {|name|
///     let nbytes = open --raw $name | into binary | length
///     let ntokens = cargo run -- $name | lines | where $it starts-with 'Token3' | length
///     {
///         file: $name
///         nbytes: $nbytes
///         ntokens: $ntokens
///         bytes_per_token: ($nbytes / $ntokens)
///     }
/// }
///
/// TODO: Use larger and more representative codebase to estimate this
const AVG_BYTES_PER_TOKEN: usize = 2;

/// Lexed tokens
///
/// Tokens and spans are stored in separate vectors indexed by a position index (starting at 0).
pub struct Tokens {
    pos: usize,
    tokens: Vec<Token>,
    spans: Vec<Span>,
}

impl Tokens {
    /// Create a new Tokens with allocated storage for the tokens and spans
    pub fn new(source: &[u8]) -> Self {
        let estimated_num_tokens = source.len() / AVG_BYTES_PER_TOKEN;
        Tokens {
            pos: 0,
            tokens: Vec::with_capacity(estimated_num_tokens),
            spans: Vec::with_capacity(estimated_num_tokens),
        }
    }

    // Position-related methods

    /// Advance position to point at the next token
    ///
    /// Note that this can potentially point beyond the tokens if called enough times. The parser
    /// should correctly check for EOF and terminate without advancing further.
    pub fn advance(&mut self) {
        debug_assert!(self.pos < self.tokens.len());
        self.pos += 1;
    }

    /// Return current position
    pub fn pos(&self) -> usize {
        self.pos
    }

    /// Set current position
    pub fn set_pos(&mut self, pos: usize) {
        self.pos = pos;
    }

    // Adding and fetching tokens

    /// Push a spanned token to the internal storage
    pub fn push(&mut self, token: Token, span: Span) {
        self.tokens.push(token);
        self.spans.push(span);
    }

    /// Check the token at the current position
    pub fn peek(&self) -> (Token, Span) {
        (self.peek_token(), self.peek_span())
    }

    /// Same as peek() but return only the token
    pub fn peek_token(&self) -> Token {
        self.tokens[self.pos]
    }

    /// Same as peek() but return only the span
    pub fn peek_span(&self) -> Span {
        self.spans[self.pos]
    }

    // Printing

    /// Format the tokens into a human-readable output for debugging
    pub fn display(&self, source: &[u8]) -> String {
        let mut result = String::new();

        result.push_str("==== TOKENS ====\n");

        for (i, (token, span)) in self.tokens.iter().zip(self.spans.iter()).enumerate() {
            result.push_str(&format!(
                "Token3 {i:4}: {:25} span: {:4} .. {:4} '{}'\n",
                format!("{:?}", token),
                span.start,
                span.end,
                String::from_utf8_lossy(
                    source
                        .get(span.start..span.end)
                        .expect("missing source of token span")
                )
                .replace("\r", "\\r")
                .replace("\n", "\\n")
                .replace("\t", "\\t")
            ));
        }

        result
    }

    /// Print the output of display() to standard output
    pub fn print(&self, source: &[u8]) {
        let output = self.display(source);
        print!("{output}");
    }

    /// Print the output of display() to standard error
    pub fn eprint(&self, source: &[u8]) {
        let output = self.display(source);
        eprint!("{output}");
    }
}

/// Lex the source contents and return allocated Tokens.
///
/// In the case of error, you can look up the last stored token to get a clue what went wrong. The
/// last stored token is always End Of File (EOF), so there will always be at least one token.
pub fn lex(contents: &[u8], span_offset: usize) -> (Tokens, Result<(), ()>) {
    // TODO: We might require the contents to always end with a newline, in which case return an error
    let mut tokens = Tokens::new(contents);
    let lexer = Token::lexer(contents).spanned();

    for (res, span) in lexer {
        match res {
            Ok(token) => tokens.push(
                token,
                Span::new(span.start + span_offset, span.end + span_offset),
            ),
            Err(_) => {
                tokens.push(
                    Token::Eof,
                    Span::new(span.end + span_offset, span.end + span_offset),
                );
                return (tokens, Err(()));
            }
        }
    }

    tokens.push(
        Token::Eof,
        Span::new(contents.len() + span_offset, contents.len() + span_offset),
    );

    (tokens, Ok(()))
}

#[derive(Logos, Debug, Clone, Copy, PartialEq)]
#[logos(skip r"[ \t]+")]
#[logos(source = [u8])]
pub enum Token {
    #[regex("(?:0[xob])?[0-9][0-9_]*", priority = 10)]
    Int,
    #[regex(r"(:?[0-9][0-9_]*)*\.([0-9][0-9_]*)*(?:[eE][+-]?[0-9_]+)?")]
    Float,
    #[regex("\n|\r\n|\x0C")]
    Newline,
    #[regex(r#""(?:[^"\\]|\\["\\bnfrt])*""#)]
    DoubleQuotedString,
    #[regex(r#"'[^']*'"#)]
    SingleQuotedString,
    #[regex(r#"`[^`]*`"#)]
    BacktickBareword,
    // #[regex(r#"[ \t]+"#)]
    // HorizontalWhitespace,
    #[regex(r#"[0-9]{4}-[0-9]{2}-[0-9]{2}(?:T[0-9]{2}:[0-9]{2}:[0-9]{2}(?:\.[0-9]+)?)?(?:Z|[\+-][0-9]{2}:[0-9]{2})?"#)]
    Datetime,
    #[regex(r#"#[^\n]*"#, priority = 20)]
    Comment,
    // lower priority to avoid clashing with Int
    #[regex(r#"(_|[^\s[:punct:]])(#|_|[^\s[:punct:]])*"#, priority = 2)]
    Bareword,
    #[token("...")]
    DotDotDot,
    #[token("..")]
    DotDot,
    #[token(".", priority = 10)] // higher priority to avoid "." being tokenized as Float
    Dot,
    #[token("(")]
    LParen,
    #[token(")")]
    RParen,
    #[token("[")]
    LSquare,
    #[token("]")]
    RSquare,
    #[token("{")]
    LCurly,
    #[token("}")]
    RCurly,
    #[token("<=")]
    LessThanEqual,
    #[token("<")]
    LessThan,
    #[token(">=")]
    GreaterThanEqual,
    #[token(">")]
    GreaterThan,
    #[token("++")]
    PlusPlus,
    #[token("+=")]
    PlusEquals,
    #[token("+")]
    Plus,
    #[token("->")]
    ThinArrow,
    #[token("=>")]
    ThickArrow,
    #[token("-=")]
    DashEquals,
    #[token("-")]
    Dash,
    #[token("**")]
    AsteriskAsterisk,
    #[token("*=")]
    AsteriskEquals,
    #[token("*")]
    Asterisk,
    #[token("//")]
    ForwardSlashForwardSlash,
    #[token("/=")]
    ForwardSlashEquals,
    #[token("/")]
    ForwardSlash,
    #[token("==")]
    EqualsEquals,
    #[token("=~")]
    EqualsTilde,
    #[token("=")]
    Equals,
    #[token("::")]
    ColonColon,
    #[token(":")]
    Colon,
    #[token("$")]
    Dollar,
    #[token(";")]
    Semicolon,
    #[token("!=")]
    ExclamationEquals,
    #[token("!~")]
    ExclamationTilde,
    #[token("!")]
    Exclamation,
    #[token("&&")]
    AmpersandAmpersand,
    #[token("&")]
    Ampersand,
    #[token(",")]
    Comma,
    #[token("?")]
    QuestionMark,
    #[token("^")]
    Caret,
    #[token("@")]
    At,
    #[token("||")]
    PipePipe,
    #[token("|")]
    Pipe,
    #[token("o>")]
    OutGreaterThan,
    #[token("o>>")]
    OutGreaterGreaterThan,
    #[token("e>")]
    ErrGreaterThan,
    #[token("e>>")]
    ErrGreaterGreaterThan,
    #[token("o+e>")]
    OutErrGreaterThan,
    #[token("o+e>>")]
    OutErrGreaterGreaterThan,
    #[token("e>|")]
    ErrGreaterThanPipe,
    #[token("o+e>|")]
    OutErrGreaterThanPipe,
    /// End of file, doesn't match any syntax, but source code always end with it
    Eof,
}

#[cfg(test)]
mod test {
    /// Lexer tests useful for smaller sources, errors and corner cases
    use crate::compiler::Span;
    use crate::lexer::{lex, Token};

    fn test_lex(src: &[u8], expected_tokens: &[(Token, Span)], expected_result: Result<(), ()>) {
        let (mut actual_tokens, actual_result) = lex(src, 0);

        assert_eq!(expected_result, actual_result, "Lexing result mismatch");

        for (i, expected) in expected_tokens.iter().enumerate() {
            let actual = actual_tokens.peek();
            assert_eq!(expected, &actual, "Mismatch in token {}", i);
            actual_tokens.advance();
        }
    }

    fn span(start: usize, end: usize) -> Span {
        Span { start, end }
    }

    #[test]
    fn lex_last_eof() {
        test_lex(b"", &[(Token::Eof, span(0, 0))], Ok(()));
    }

    #[test]
    fn lex_unmatched_string() {
        // TODO: Make unmatched delimiters nicer
        test_lex(b"'unmatched string", &[(Token::Eof, span(17, 17))], Err(()));
    }
}
