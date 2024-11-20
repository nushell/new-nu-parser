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
    #[token(".")]
    Dot,
    #[regex(r#"[0-9]{4}-[0-9]{2}-[0-9]{2}(?:T[0-9]{2}:[0-9]{2}:[0-9]{2}(?:\.[0-9]+)?)?(?:Z|[\+-][0-9]{2}:[0-9]{2})?"#)]
    Datetime,
    #[regex(r#"(?:_|[^\s[:punct:]])+"#, priority = 1)]
    Bareword,
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
