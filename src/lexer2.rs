use crate::compiler::Span;
use crate::token::{Token2, TokenType2};

use tracy_client::span;

pub struct Lexer2<'src> {
    source: &'src [u8], // null-terminated bytes of the source code
    cursor: usize,
}

enum State {
    Start,
    Int,
    IntHex,
    IntOct,
    IntBin,
    IntNoprefix,
    Float,
    Exponent,
    Unit,
    Bareword,
    HorizontalWhitespace,
    Newline,
    ExpectNewline,
    Invalid,
    Null,
}

impl<'a> Lexer2<'a> {
    pub fn new(source: &'a [u8]) -> Self {
        Lexer2 { source, cursor: 0 }
    }

    pub fn next(&mut self) -> Token2 {
        let _span = span!();
        let mut token_type = TokenType2::Invalid;

        let start = self.cursor;

        let mut state = State::Start;

        loop {
            match state {
                State::Start => match self.cur_byte() {
                    0 => state = State::Null,
                    b'0'..=b'9' | b'_' => {
                        token_type = TokenType2::Int;
                        self.cursor += 1;
                        state = State::Int;
                    }
                    b'\r' => {
                        token_type = TokenType2::Newline;
                        self.cursor += 1;
                        state = State::ExpectNewline;
                    }
                    b'\n' => {
                        token_type = TokenType2::Newline;
                        self.cursor += 1;
                        break;
                    }
                    b'.' => {
                        token_type = TokenType2::Float;
                        self.cursor += 1;
                        state = State::Float;
                    }
                    _ => unimplemented!(
                        "unimplemented start match, char '{}'",
                        self.cur_byte() as char
                    ),
                },
                State::Null => {
                    if self.cursor == self.source.len() - 1 {
                        return Token2 {
                            token_type: TokenType2::Eof,
                            span: Span {
                                start,
                                end: self.cursor,
                            },
                        };
                    } else {
                        state = State::Invalid;
                    }
                }
                State::Invalid => {
                    token_type = TokenType2::Invalid;
                    self.cursor += 1;
                    break;
                }
                State::Int => {
                    while matches!(self.cur_byte(), b'0'..=b'9' | b'_') {
                        self.cursor += 1;
                    }

                    match self.cur_byte() {
                        b'0'..=b'9' | b'_' => {
                            self.cursor += 1;
                        }
                        b'x' => {
                            // hex
                            self.cursor += 1;
                            state = State::IntHex;
                        }
                        b'o' => {
                            // octal
                            self.cursor += 1;
                            state = State::IntOct;
                        }
                        b'b' => {
                            // binary
                            self.cursor += 1;
                            state = State::IntBin;
                        }
                        b'e' | b'E' => {
                            // exponent
                            token_type = TokenType2::Float;
                            self.cursor += 1;
                            state = State::Exponent;
                        }
                        b'.' => {
                            token_type = TokenType2::Float;
                            self.cursor += 1;
                            state = State::Float;
                        }
                        _ => break,
                    }
                }
                State::IntHex => {
                    while matches!(
                        self.cur_byte(),
                            b'0'..=b'9' | b'A'..=b'F' | b'a'..=b'f' | b'_'
                    ) {
                        self.cursor += 1;
                    }
                    match self.cur_byte() {
                        b'0'..=b'9' | b'A'..=b'F' | b'a'..=b'f' | b'_' => {
                            self.cursor += 1;
                        }
                        _ => break,
                    }
                    break;
                }
                State::IntOct => {
                    while matches!(self.cur_byte(), b'0'..=b'7' | b'_') {
                        self.cursor += 1;
                    }
                    match self.cur_byte() {
                        b'0'..=b'7' | b'_' => {
                            self.cursor += 1;
                        }
                        _ => break,
                    }
                    break;
                }
                State::IntBin => {
                    while matches!(self.cur_byte(), b'0'..=b'1' | b'_') {
                        self.cursor += 1;
                    }
                    match self.cur_byte() {
                        b'0'..=b'1' | b'_' => {
                            self.cursor += 1;
                        }
                        _ => break,
                    }
                    break;
                }
                State::Exponent => {
                    if let b'+' | b'-' = self.cur_byte() {
                        self.cursor += 1;
                    }
                    state = State::IntNoprefix;
                }
                State::IntNoprefix => match self.cur_byte() {
                    b'0'..=b'9' | b'_' => {
                        self.cursor += 1;
                    }
                    b'.' => {
                        token_type = TokenType2::Float;
                        self.cursor += 1;
                        state = State::Float;
                    }
                    _ => break,
                },
                State::Float => match self.cur_byte() {
                    b'0'..=b'9' | b'_' => {
                        self.cursor += 1;
                    }
                    b'e' | b'E' => {
                        self.cursor += 1;
                        state = State::Exponent;
                    }
                    x if x.is_ascii_whitespace() => break,

                    _ => state = State::Invalid,
                },
                State::ExpectNewline => match self.cur_byte() {
                    0 => state = State::Null,
                    b'\n' => {
                        // \r must be followed by \n
                        token_type = TokenType2::Newline;
                        self.cursor += 1;
                        break;
                    }
                    _ => state = State::Invalid,
                },
                _ => unimplemented!("unimplemented state"),
            }
        }

        Token2 {
            token_type,
            span: Span {
                start,
                end: self.cursor,
            },
        }
    }

    #[inline]
    fn cur_byte(&self) -> u8 {
        // TODO: Try .get_unchecked()
        self.source[self.cursor]
        // *unsafe { self.source.get_unchecked(self.cursor) }
    }
}

#[cfg(test)]
mod lex_tests {
    use crate::token::TokenType2;

    fn test_lex(src: &[u8], expected: &[TokenType2]) {}
}
