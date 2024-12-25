use crate::{compiler::Span, token::TokenType};
use logos::Logos;

/// Lex the file contents and store the resulting tokens into a provided buffer.
///
/// In the case of error, you can look up the last stored token to get a clue what went wrong. The
/// last stored token is always End Of File (EOF), therefore the will always be at least one token
/// stored in `tokens`.
pub fn lex(contents: &[u8], span_offset: usize, tokens: &mut Vec<Token3>) -> Result<(), ()> {
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

pub fn print_tokens(tokens: &[Token3], contents: &[u8]) {
    let output = display_tokens(tokens, contents);
    print!("{output}");
}

pub fn display_tokens(tokens: &[Token3], contents: &[u8]) -> String {
    let mut result = String::new();

    result.push_str("==== TOKENS ====\n");

    for (i, token) in tokens.iter().enumerate() {
        result.push_str(&format!(
            "Token3 {i:4}: {:25} span: {:4} .. {:4} '{}'\n",
            format!("{:?}", token.token_type),
            token.span.start,
            token.span.end,
            String::from_utf8_lossy(
                contents
                    .get(token.span.start..token.span.end)
                    .expect("missing source of token span")
            )
            .replace("\r", "\\r")
            .replace("\n", "\\n")
            .replace("\t", "\\t")
        ));
    }

    result
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
    LessThanEquals,
    #[token("<")]
    LessThan,
    #[token(">=")]
    GreaterThanEquals,
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
    BangEquals,
    #[token("!~")]
    BangTilde,
    #[token("!")]
    Bang,
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
            Self::LessThanEquals => TokenType::LessThanEqual,
            Self::LessThan => TokenType::LessThan,
            Self::GreaterThanEquals => TokenType::GreaterThanEqual,
            Self::GreaterThan => TokenType::GreaterThan,
            Self::PlusPlus => TokenType::PlusPlus,
            Self::Plus => TokenType::Plus,
            Self::PlusEquals => TokenType::PlusEquals,
            Self::ThinArrow => TokenType::ThinArrow,
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
            Self::BangEquals => TokenType::ExclamationEquals,
            Self::BangTilde => TokenType::ExclamationTilde,
            Self::Bang => TokenType::Exclamation,
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
