use crate::compiler::Span;
use crate::token::TokenType;

use tracy_client::span;

const BAREWORD_LUT: [bool; 256] = {
    let mut lut = [false; 256];
    let mut c: u8 = 0;

    while c < 128 {
        if !c.is_ascii_whitespace() && (!c.is_ascii_punctuation() || c == b'_') {
            lut[c as usize] = true;
        }
        c += 1;
    }

    lut
};

pub struct Lexer<'a> {
    source: &'a [u8],
    tokens: Vec<TokenType>,
    spans: Vec<Span>,
    span_offset: usize,
}

impl<'a> Lexer<'a> {
    pub fn new(source: &'a [u8], span_offset: usize) -> Self {
        Lexer {
            source,
            tokens: Vec::with_capacity(source.len()),
            spans: Vec::with_capacity(source.len()),
            span_offset,
        }
    }

    pub fn print(&self) {
        let output = self.display_state();
        print!("{output}");
    }

    pub fn display_state(&self) -> String {
        let mut result = String::new();

        for (i, (token, span)) in self.tokens.iter().zip(self.spans.iter()).enumerate() {
            result.push_str(&format!(
                "Token {i:4}: {:25} span: {:4} .. {:4} '{}'\n",
                format!("{:?}", token),
                span.start,
                span.end,
                String::from_utf8_lossy(
                    self.source
                        .get(span.start..span.end)
                        .expect("lexer: missing source for span"),
                )
                .replace("\r", "\\r")
                .replace("\n", "\\n")
            ));
        }

        result
    }

    fn push_token(&mut self, token_type: TokenType, start: usize, end: usize) {
        self.tokens.push(token_type);
        self.spans.push(Span { start, end });
    }

    fn next_token(&mut self) {
        let _span = span!();

        loop {
            let _span = span!("lexer::token");
            if self.span_offset >= self.source.len() {
                break;
            }

            let char = self.source[self.span_offset];

            if char.is_ascii_digit() {
                self.lex_number();
            } else if char == b'"' || char == b'\'' {
                self.lex_quoted_string();
            } else if char == b'#' {
                // Comment
                self.lex_comment();
            } else if self.try_symbol() {
                // } else if is_symbol(&self.source[self.span_offset..]) {
                //     self.lex_symbol();
            } else if char == b' ' || char == b'\t' {
                self.skip_space();
            } else if char == b'\r' || char == b'\n' {
                self.lex_newline();
            } else {
                self.lex_bareword2();
            }
        }
    }

    pub fn lex(&mut self) {
        let _span = span!();
        while self.span_offset < self.source.len() {
            self.next_token();
        }
        self.tokens.shrink_to_fit();
        self.spans.shrink_to_fit();
    }

    fn lex_number(&mut self) {
        let _span = span!();
        let span_start = self.span_offset;
        let mut span_position = span_start;
        while span_position < self.source.len() {
            if !self.source[span_position].is_ascii_digit() {
                break;
            }
            span_position += 1;
        }

        // Check to see if we have a hex/octal/binary number
        if span_position < self.source.len() && self.source[span_position] == b'x' {
            span_position += 1;
            while span_position < self.source.len() {
                if !self.source[span_position].is_ascii_hexdigit() {
                    break;
                }
                span_position += 1;
            }
        } else if span_position < self.source.len() && self.source[span_position] == b'o' {
            span_position += 1;
            while span_position < self.source.len() {
                if !(self.source[span_position] >= b'0' && self.source[span_position] <= b'7') {
                    break;
                }
                span_position += 1;
            }
        } else if span_position < self.source.len() && self.source[span_position] == b'b' {
            span_position += 1;
            while span_position < self.source.len() {
                if !(self.source[span_position] >= b'0' && self.source[span_position] <= b'1') {
                    break;
                }
                span_position += 1;
            }
        } else if span_position < self.source.len()
            && self.source[span_position] == b'.'
            && (span_position + 1 < self.source.len())
            && self.source[span_position + 1].is_ascii_digit()
        {
            // Looks like a float
            span_position += 1;
            while span_position < self.source.len() {
                if !self.source[span_position].is_ascii_digit() {
                    break;
                }
                span_position += 1;
            }

            if span_position < self.source.len()
                && (self.source[span_position] == b'e' || self.source[span_position] == b'E')
            {
                span_position += 1;

                if span_position < self.source.len() && self.source[span_position] == b'-' {
                    span_position += 1;
                }

                while span_position < self.source.len() {
                    if !self.source[span_position].is_ascii_digit() {
                        break;
                    }
                    span_position += 1;
                }
            }
        }

        self.span_offset = span_position;
        self.push_token(TokenType::Number, span_start, self.span_offset);
    }

    fn lex_quoted_string(&mut self) {
        let _span = span!();
        let span_start = self.span_offset;
        let mut span_position = span_start + 1;
        let mut is_escaped = false;
        while span_position < self.source.len() {
            if is_escaped {
                is_escaped = false;
            } else if self.source[span_position] == b'\\' {
                is_escaped = true;
            } else if self.source[span_position] == b'"' || self.source[span_position] == b'\'' {
                span_position += 1;
                break;
            }
            span_position += 1;
        }

        self.span_offset = span_position;
        self.push_token(TokenType::String, span_start, self.span_offset);
    }

    fn lex_comment(&mut self) {
        let _span = span!();
        let span_start = self.span_offset;
        let mut span_position = span_start;
        while span_position < self.source.len() && self.source[span_position] != b'\n' {
            span_position += 1;
        }

        self.span_offset = span_position;
        self.push_token(TokenType::Comment, span_start, self.span_offset);
    }

    fn try_symbol(&mut self) -> bool {
        let _span = span!();
        let span_start = self.span_offset;

        let (token_type, length) = match self.source[span_start] {
            b'(' => (TokenType::LParen, 1),
            b'[' => (TokenType::LSquare, 1),
            b'{' => (TokenType::LCurly, 1),
            b'<' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::LessThanEqual, 2)
                } else {
                    (TokenType::LessThan, 1)
                }
            }
            b')' => (TokenType::RParen, 1),
            b']' => (TokenType::RSquare, 1),
            b'}' => (TokenType::RCurly, 1),
            b'>' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::GreaterThanEqual, 2)
                } else {
                    (TokenType::GreaterThan, 1)
                }
            }
            b'+' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'+'
                {
                    (TokenType::PlusPlus, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::PlusEquals, 2)
                } else {
                    (TokenType::Plus, 1)
                }
            }
            b'-' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'>'
                {
                    (TokenType::ThinArrow, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::DashEquals, 2)
                } else {
                    (TokenType::Dash, 1)
                }
            }
            b'*' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'*'
                {
                    (TokenType::AsteriskAsterisk, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::AsteriskEquals, 2)
                } else {
                    (TokenType::Asterisk, 1)
                }
            }
            b'/' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'/'
                {
                    (TokenType::ForwardSlashForwardSlash, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::ForwardSlashEquals, 2)
                } else {
                    (TokenType::ForwardSlash, 1)
                }
            }
            b'=' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::EqualsEquals, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'~'
                {
                    (TokenType::EqualsTilde, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'>'
                {
                    (TokenType::ThickArrow, 2)
                } else {
                    (TokenType::Equals, 1)
                }
            }
            b':' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b':'
                {
                    (TokenType::ColonColon, 2)
                } else {
                    (TokenType::Colon, 1)
                }
            }
            b'$' => (TokenType::Dollar, 1),
            b';' => (TokenType::Semicolon, 1),
            b'.' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'.'
                {
                    (TokenType::DotDot, 2)
                } else {
                    (TokenType::Dot, 1)
                }
            }
            b'!' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::ExclamationEquals, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'~'
                {
                    (TokenType::ExclamationTilde, 2)
                } else {
                    (TokenType::Exclamation, 1)
                }
            }
            b'|' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'|'
                {
                    (TokenType::PipePipe, 2)
                } else {
                    (TokenType::Pipe, 1)
                }
            }
            b'&' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'&'
                {
                    (TokenType::AmpersandAmpersand, 2)
                } else {
                    (TokenType::Ampersand, 1)
                }
            }
            b',' => (TokenType::Comma, 1),
            b'?' => (TokenType::QuestionMark, 1),
            b'o' | b'e' => {
                return self.try_redirect_symbol();
            }
            _ => return false,
        };

        self.span_offset = span_start + length;
        self.push_token(token_type, span_start, self.span_offset);

        true
    }

    fn lex_symbol(&mut self) {
        let _span = span!();
        let span_start = self.span_offset;

        if self.source[span_start] == b'o' || self.source[span_start] == b'e' {
            // try span redirection symbol
            self.lex_redirect_symbol();
            return;
        }

        let (token_type, length) = match self.source[span_start] {
            b'(' => (TokenType::LParen, 1),
            b'[' => (TokenType::LSquare, 1),
            b'{' => (TokenType::LCurly, 1),
            b'<' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::LessThanEqual, 2)
                } else {
                    (TokenType::LessThan, 1)
                }
            }
            b')' => (TokenType::RParen, 1),
            b']' => (TokenType::RSquare, 1),
            b'}' => (TokenType::RCurly, 1),
            b'>' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::GreaterThanEqual, 2)
                } else {
                    (TokenType::GreaterThan, 1)
                }
            }
            b'+' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'+'
                {
                    (TokenType::PlusPlus, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::PlusEquals, 2)
                } else {
                    (TokenType::Plus, 1)
                }
            }
            b'-' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'>'
                {
                    (TokenType::ThinArrow, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::DashEquals, 2)
                } else {
                    (TokenType::Dash, 1)
                }
            }
            b'*' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'*'
                {
                    (TokenType::AsteriskAsterisk, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::AsteriskEquals, 2)
                } else {
                    (TokenType::Asterisk, 1)
                }
            }
            b'/' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'/'
                {
                    (TokenType::ForwardSlashForwardSlash, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::ForwardSlashEquals, 2)
                } else {
                    (TokenType::ForwardSlash, 1)
                }
            }
            b'=' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::EqualsEquals, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'~'
                {
                    (TokenType::EqualsTilde, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'>'
                {
                    (TokenType::ThickArrow, 2)
                } else {
                    (TokenType::Equals, 1)
                }
            }
            b':' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b':'
                {
                    (TokenType::ColonColon, 2)
                } else {
                    (TokenType::Colon, 1)
                }
            }
            b'$' => (TokenType::Dollar, 1),
            b';' => (TokenType::Semicolon, 1),
            b'.' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'.'
                {
                    (TokenType::DotDot, 2)
                } else {
                    (TokenType::Dot, 1)
                }
            }
            b'!' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'='
                {
                    (TokenType::ExclamationEquals, 2)
                } else if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'~'
                {
                    (TokenType::ExclamationTilde, 2)
                } else {
                    (TokenType::Exclamation, 1)
                }
            }
            b'|' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'|'
                {
                    (TokenType::PipePipe, 2)
                } else {
                    (TokenType::Pipe, 1)
                }
            }
            b'&' => {
                if self.span_offset < (self.source.len() - 1)
                    && self.source[self.span_offset + 1] == b'&'
                {
                    (TokenType::AmpersandAmpersand, 2)
                } else {
                    (TokenType::Ampersand, 1)
                }
            }
            b',' => (TokenType::Comma, 1),
            b'?' => (TokenType::QuestionMark, 1),
            x => {
                panic!(
                    "Internal compiler error: symbol character mismatched in lexer: {}",
                    x as char
                )
            }
        };

        self.span_offset = span_start + length;
        self.push_token(token_type, span_start, self.span_offset);
    }

    fn try_redirect_symbol(&mut self) -> bool {
        let _span = span!();
        let span_start = self.span_offset;
        let content = &self.source[span_start..];
        let redirect_tokens: [(&[u8], TokenType); 8] = [
            (b"o>", TokenType::OutGreaterThan),
            (b"o>>", TokenType::OutGreaterGreaterThan),
            (b"e>", TokenType::ErrGreaterThan),
            (b"e>>", TokenType::ErrGreaterGreaterThan),
            (b"o+e>", TokenType::OutErrGreaterThan),
            (b"o+e>>", TokenType::OutErrGreaterGreaterThan),
            (b"e>|", TokenType::ErrGreaterThanPipe),
            (b"o+e>|", TokenType::OutErrGreaterThanPipe),
        ];

        for (bytes, token_type) in redirect_tokens {
            if content.starts_with(bytes) {
                self.span_offset = span_start + bytes.len();
                self.push_token(token_type, span_start, self.span_offset);
                return true;
            }
        }

        false
    }

    fn lex_redirect_symbol(&mut self) {
        let _span = span!();
        let span_start = self.span_offset;
        let content = &self.source[span_start..];
        let redirect_tokens: [(&[u8], TokenType); 8] = [
            (b"o>", TokenType::OutGreaterThan),
            (b"o>>", TokenType::OutGreaterGreaterThan),
            (b"e>", TokenType::ErrGreaterThan),
            (b"e>>", TokenType::ErrGreaterGreaterThan),
            (b"o+e>", TokenType::OutErrGreaterThan),
            (b"o+e>>", TokenType::OutErrGreaterGreaterThan),
            (b"e>|", TokenType::ErrGreaterThanPipe),
            (b"o+e>|", TokenType::OutErrGreaterThanPipe),
        ];

        for (bytes, token_type) in redirect_tokens {
            if content.starts_with(bytes) {
                self.span_offset = span_start + bytes.len();
                self.push_token(token_type, span_start, self.span_offset);
                return;
            }
        }
    }

    fn skip_space(&mut self) {
        let _span = span!();
        let mut span_position = self.span_offset;
        let whitespace: &[u8] = b" \t";
        while span_position < self.source.len() {
            if !whitespace.contains(&self.source[span_position]) {
                break;
            }
            span_position += 1;
        }
        self.span_offset = span_position;
    }

    fn lex_newline(&mut self) {
        let _span = span!();
        let mut span_position = self.span_offset;
        let whitespace: &[u8] = b"\r\n";
        while span_position < self.source.len() {
            if !whitespace.contains(&self.source[span_position]) {
                break;
            }
            span_position += 1;
        }

        if self.span_offset != span_position {
            self.push_token(TokenType::Newline, self.span_offset, span_position);
            self.span_offset = span_position;
        }
    }

    fn lex_bareword2(&mut self) {
        let _span = span!();

        let count = self.source[self.span_offset..]
            .iter()
            .copied()
            .take_while(|&byte| BAREWORD_LUT[byte as usize])
            .count();
        let span_position = self.span_offset + count;

        self.push_token(TokenType::Name, self.span_offset, span_position);
        self.span_offset = span_position;
    }

    fn lex_bareword(&mut self) {
        let _span = span!();
        let span_start = self.span_offset;
        let mut span_position = span_start;

        while span_position < self.source.len()
            && !self.source[span_position].is_ascii_whitespace()
            && (!self.source[span_position].is_ascii_punctuation()
                || self.source[span_position] == b'_')
        {
            span_position += 1;
        }

        self.span_offset = span_position;
        self.push_token(TokenType::Name, span_start, self.span_offset);
    }
}

fn is_symbol(source: &[u8]) -> bool {
    let _span = span!();
    let first_byte = source[0];
    if [
        b'+', b'-', b'*', b'/', b'.', b',', b'(', b'[', b'{', b'<', b')', b']', b'}', b'>', b':',
        b';', b'=', b'$', b'|', b'!', b'~', b'&', b'\'', b'"', b'?',
    ]
    .contains(&first_byte)
    {
        return true;
    }

    let redirect_symbols: [&[u8]; 8] = [
        b"o>", b"e>", b"o>>", b"e>>", b"o+e>", b"o+e>>", b"e>|", b"o+e>|",
    ];
    for s in redirect_symbols {
        if source.starts_with(s) {
            return true;
        }
    }

    false
}
