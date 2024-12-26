use crate::{compiler::Span, token::TokenType};
use logos::Logos;

pub struct Tokens {
    pos: usize,
    pub tokens: Vec<TokenType3>,
    pub spans: Vec<Span>,
}

impl Tokens {
    pub fn new(source: &[u8]) -> Self {
        let estimated_num_tokens = source.len() / 8; // TODO: find out average bytes per token
        Tokens {
            pos: 0,
            tokens: Vec::with_capacity(estimated_num_tokens),
            spans: Vec::with_capacity(estimated_num_tokens),
        }
    }

    // Position-related methods

    pub fn advance(&mut self) {
        // TODO: See if removing this check would make it faster and we'd rely on parser detectinf Eof.
        if self.pos < self.tokens.len() - 1 {
            self.pos += 1;
        }
    }

    pub fn pos(&self) -> usize {
        self.pos
    }

    pub fn set_pos(&mut self, pos: usize) {
        self.pos = pos;
    }

    // Adding and fetching tokens

    pub fn push(&mut self, token: TokenType3, span: Span) {
        self.tokens.push(token);
        self.spans.push(span);
    }

    // pub fn peek(&self) -> (Option<TokenType3>, Span) {
    //     (self.peek_token(), self.peek_span())
    // }

    // pub fn peek_token(&self) -> Option<TokenType3> {
    //     let token = self.tokens[self.pos];
    //     // TODO: Remove Option casting of EOF
    //     if let TokenType3::Eof = token {
    //         None
    //     } else {
    //         Some(token)
    //     }
    // }

    pub fn peek(&self) -> (TokenType3, Span) {
        (self.peek_token(), self.peek_span())
    }

    pub fn peek_token(&self) -> TokenType3 {
        self.tokens[self.pos]
    }

    pub fn peek_span(&self) -> Span {
        self.spans[self.pos]
    }

    // pub fn next(&mut self) -> (Option<TokenType3>, Span) {
    //     let (token, span) = self.peek();
    //     self.advance();
    //     (token, span)
    // }

    // // TODO: Make this into next()
    // pub fn next_internal(&mut self) -> (TokenType3, Span) {
    //     let (token, span) = self.peek();
    //     self.advance();
    //     (token, span)
    // }

    // pub fn next_token(&mut self) -> Option<TokenType3> {
    //     let token = self.peek_token();
    //     self.advance();
    //     token
    // }

    // pub fn next_span(&mut self) -> Span {
    //     let span = self.peek_span();
    //     self.advance();
    //     span
    // }

    // Token variants matching

    // /// Whether the next token is a primitive (single-token) value
    // pub fn is_primitive_value(&self) -> bool {
    //     matches!(
    //         self.peek_token_internal(),
    //         TokenType3::Int
    //             | TokenType3::Float
    //             | TokenType3::DoubleQuotedString
    //             | TokenType3::SingleQuotedString
    //     )
    // }

    // /// Whether the next token is a primitive (single-token) keyword value
    // pub fn is_primitive_keyword_value(&self, source: &[u8]) -> bool {
    //     let (token, span) = self.peek_internal();
    //     let src = &source[span.start..span.end];
    //     token == TokenType3::Bareword && (src == b"true" || src == b"false" || src == b"null")
    // }

    // /// Whether the next token is an integer
    // pub fn is_int(&self) -> bool {
    //     self.peek_token_internal() == TokenType3::Int
    // }

    // /// Whether the next token is a float
    // pub fn is_float(&self) -> bool {
    //     self.peek_token_internal() == TokenType3::Float
    // }

    // Printing

    pub fn print(&self, source: &[u8]) {
        let output = self.display(source);
        print!("{output}");
    }

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
}

/// Lex the file contents and store the resulting tokens into a provided buffer.
///
/// In the case of error, you can look up the last stored token to get a clue what went wrong. The
/// last stored token is always End Of File (EOF), therefore the will always be at least one token
/// stored in `tokens`.
pub fn lex_old(contents: &[u8], span_offset: usize, tokens: &mut Vec<Token3>) -> Result<(), ()> {
    let mut lexer = TokenType3::lexer(contents).spanned();

    while let Some((res, span)) = lexer.next() {
        match res {
            Ok(token) => tokens.push(Token3 {
                token_type: token,
                span: Span::new(span.start + span_offset, span.end + span_offset),
            }),
            Err(_) => {
                tokens.push(Token3 {
                    token_type: TokenType3::Eof,
                    span: Span::new(span.end + span_offset, span.end + span_offset),
                });
                return Err(());
            }
        }
    }

    tokens.push(Token3 {
        token_type: TokenType3::Eof,
        span: Span::new(contents.len() + span_offset, contents.len() + span_offset),
    });

    Ok(())
}

/// Lex the file contents and return allocated Tokens
///
/// In the case of error, you can look up the last stored token to get a clue what went wrong. The
/// last stored token is always End Of File (EOF), therefore the will always be at least one token
/// stored in `tokens`.
pub fn lex(contents: &[u8], span_offset: usize) -> (Tokens, Result<(), ()>) {
    let mut tokens = Tokens::new(contents);
    let mut lexer = TokenType3::lexer(contents).spanned();

    while let Some((res, span)) = lexer.next() {
        match res {
            Ok(token) => tokens.push(
                token,
                Span::new(span.start + span_offset, span.end + span_offset),
            ),
            Err(_) => {
                tokens.push(
                    TokenType3::Eof,
                    Span::new(span.end + span_offset, span.end + span_offset),
                );
                return (tokens, Err(()));
            }
        }
    }

    tokens.push(
        TokenType3::Eof,
        Span::new(contents.len() + span_offset, contents.len() + span_offset),
    );

    (tokens, Ok(()))
}

#[derive(Clone, Copy, Debug)]
pub struct Token3 {
    pub token_type: TokenType3,
    pub span: Span,
}

#[derive(Logos, Debug, Clone, Copy, PartialEq)]
#[logos(skip r"[ \t]+")]
#[logos(source = [u8])]
pub enum TokenType3 {
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
    Eof,
}

// TODO: Remove this
impl TokenType3 {
    pub fn to_type_tmp(self) -> TokenType {
        match self {
            Self::Int => TokenType::Number,
            Self::Float => TokenType::Number,
            Self::Newline => TokenType::Newline,
            Self::DoubleQuotedString => TokenType::String,
            Self::SingleQuotedString => TokenType::String,
            Self::BacktickBareword => TokenType::Name,
            Self::Datetime => unimplemented!("datetime not implemented"),
            Self::Comment => TokenType::Comment,
            Self::Bareword => TokenType::Name,
            Self::DotDotDot => unimplemented!("dotdotdot not implemented"),
            Self::DotDot => TokenType::DotDot,
            Self::Dot => TokenType::Dot,
            Self::LParen => TokenType::LParen,
            Self::RParen => TokenType::RParen,
            Self::LSquare => TokenType::LSquare,
            Self::RSquare => TokenType::RSquare,
            Self::LCurly => TokenType::LCurly,
            Self::RCurly => TokenType::RCurly,
            Self::LessThanEqual => TokenType::LessThanEqual,
            Self::LessThan => TokenType::LessThan,
            Self::GreaterThanEqual => TokenType::GreaterThanEqual,
            Self::GreaterThan => TokenType::GreaterThan,
            Self::PlusPlus => TokenType::PlusPlus,
            Self::Plus => TokenType::Plus,
            Self::PlusEquals => TokenType::PlusEquals,
            Self::ThinArrow => TokenType::ThinArrow,
            Self::ThickArrow => TokenType::ThickArrow,
            Self::DashEquals => TokenType::DashEquals,
            Self::Dash => TokenType::Dash,
            Self::AsteriskAsterisk => TokenType::AsteriskAsterisk,
            Self::AsteriskEquals => TokenType::AsteriskEquals,
            Self::Asterisk => TokenType::Asterisk,
            Self::ForwardSlashForwardSlash => TokenType::ForwardSlashForwardSlash,
            Self::ForwardSlashEquals => TokenType::ForwardSlashEquals,
            Self::ForwardSlash => TokenType::ForwardSlash,
            Self::EqualsEquals => TokenType::EqualsEquals,
            Self::EqualsTilde => TokenType::EqualsTilde,
            Self::Equals => TokenType::Equals,
            Self::ColonColon => TokenType::ColonColon,
            Self::Colon => TokenType::Colon,
            Self::Dollar => TokenType::Dollar,
            Self::Semicolon => TokenType::Semicolon,
            Self::ExclamationEquals => TokenType::ExclamationEquals,
            Self::ExclamationTilde => TokenType::ExclamationTilde,
            Self::Exclamation => TokenType::Exclamation,
            Self::AmpersandAmpersand => TokenType::AmpersandAmpersand,
            Self::Ampersand => TokenType::Ampersand,
            Self::Comma => TokenType::Comma,
            Self::QuestionMark => TokenType::QuestionMark,
            Self::Caret => TokenType::Caret,
            Self::At => unimplemented!("at"),
            Self::PipePipe => TokenType::PipePipe,
            Self::Pipe => TokenType::Pipe,
            Self::OutGreaterThan => TokenType::OutGreaterThan,
            Self::OutGreaterGreaterThan => TokenType::OutGreaterGreaterThan,
            Self::ErrGreaterThan => TokenType::ErrGreaterThan,
            Self::ErrGreaterGreaterThan => TokenType::ErrGreaterGreaterThan,
            Self::OutErrGreaterThan => TokenType::OutErrGreaterThan,
            Self::OutErrGreaterGreaterThan => TokenType::OutErrGreaterGreaterThan,
            Self::ErrGreaterThanPipe => TokenType::ErrGreaterThanPipe,
            Self::OutErrGreaterThanPipe => TokenType::OutErrGreaterThanPipe,
            Self::Eof => unimplemented!("eof"),
        }
    }
}

#[cfg(test)]
mod test {
    use crate::lexer::TokenType3;
    use logos::{Logos, Span};

    fn test_lex(src: &[u8], expected: &[Option<(Result<TokenType3, ()>, Span)>]) {
        let mut lexer = TokenType3::lexer(src).spanned();

        for exp in expected.iter() {
            let next = lexer.next();
            assert_eq!(exp, &next);

            if matches!(next, Some((Err(..), ..))) {
                return;
            }
        }

        assert_eq!(None, lexer.next());
    }

    fn span(start: usize, end: usize) -> Span {
        Span { start, end }
    }

    #[test]
    fn lex_int() {
        // TODO: test failing cases
    }

    #[test]
    fn lex_bareword() {
        // TODO: test failing cases
    }

    #[test]
    fn lex_datetime() {
        // TODO: test failing cases
    }
}
