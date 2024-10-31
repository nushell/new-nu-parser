#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum TokenType {
    Comment,
    Number,
    Comma,
    Caret,
    String,
    Dollar,
    Dot,
    DotDot,
    Name,
    Pipe,
    PipePipe,
    Colon,
    ColonColon,
    Semicolon,
    Plus,
    PlusPlus,
    PlusEquals,
    Dash,
    DashEquals,
    Exclamation,
    Asterisk,
    AsteriskAsterisk,
    AsteriskEquals,
    ForwardSlash,
    ForwardSlashForwardSlash,
    ForwardSlashEquals,
    Equals,
    EqualsEquals,
    EqualsTilde,
    ExclamationTilde,
    ExclamationEquals,
    LParen,
    LSquare,
    LCurly,
    LessThan,
    LessThanEqual,
    RParen,
    RSquare,
    RCurly,
    GreaterThan,
    GreaterThanEqual,
    Ampersand,
    AmpersandAmpersand,
    QuestionMark,
    ThinArrow,
    ThickArrow,
    Newline,
    ErrGreaterThanPipe,
    OutErrGreaterThanPipe,
    OutGreaterThan,
    OutGreaterGreaterThan,
    ErrGreaterThan,
    ErrGreaterGreaterThan,
    OutErrGreaterThan,
    OutErrGreaterGreaterThan,
}

#[derive(Clone, Copy, Debug)]
pub struct Token {
    pub token_type: TokenType,
    pub span_start: usize,
    pub span_end: usize,
}
