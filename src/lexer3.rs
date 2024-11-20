use logos::Logos;

#[derive(Logos, Debug, PartialEq)]
#[logos(skip r"[ \t]+")]
#[logos(source = [u8])]
pub enum Token3 {
    #[regex("(?:0[xob])?[0-9][0-9_]*")]
    Int,
    #[regex("(?:0[xob])?[0-9][0-9_]*[a-zA-Z]+")]
    IntWithUnit,
    // #[regex(r"(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?")]
    // Float,
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
    #[regex(r#"(?:_|[^\s[:punct:]])+"#, priority = 1)]
    Bareword,
    #[token("...")]
    DotDotDot,
    #[token("..")]
    DotDot,
    #[token(".")]
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
}

#[cfg(test)]
mod test {
    use crate::lexer3::Token3;
    use logos::{Logos, Span};

    fn test_lex(src: &[u8], expected: &[Option<(Result<Token3, ()>, Span)>]) {
        let mut lexer = Token3::lexer(src).spanned();

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
