use crate::lexer::Lexer;
use crate::lexer3::Token3;
use crate::resolver::Resolver;
use crate::typechecker::Typechecker;
use crate::{compiler::Compiler, parser::Parser};

use logos::Logos;

use std::path::Path;

fn evaluate_example(fname: &Path) -> String {
    let mut compiler = Compiler::new();
    let contents = std::fs::read(fname).expect("We only run tests found by glob");

    let span_offset = compiler.span_offset();
    compiler.add_file(&fname.to_string_lossy(), &contents);

    let parser = Parser::new(compiler, span_offset);
    compiler = parser.parse();

    let mut result = compiler.display_state();

    if !compiler.errors.is_empty() {
        return result;
    }

    let mut resolver = Resolver::new(&compiler);
    resolver.resolve();
    result.push_str(&resolver.display_state());

    compiler.merge_name_bindings(resolver.to_name_bindings());

    if !compiler.errors.is_empty() {
        return result;
    }

    let mut typechecker = Typechecker::new(&compiler);
    typechecker.typecheck();
    result.push_str(&typechecker.display_state());

    compiler.merge_types(typechecker.to_types());

    result
}

fn evaluate_lexer(fname: &Path) -> String {
    let contents = std::fs::read(fname);

    let Ok(contents) = contents else {
        panic!("Lexer: can't find file {}", fname.to_string_lossy());
    };

    let mut lexer = Lexer::new(&contents, 0);
    lexer.lex();
    lexer.display_state()
}

fn evaluate_lexer3(fname: &Path) -> String {
    let contents = std::fs::read(fname);

    let Ok(contents) = contents else {
        panic!("Lexer: can't find file {}", fname.to_string_lossy());
    };

    let mut lexer3 = Token3::lexer(&contents).spanned();
    let mut tokens = Vec::with_capacity(contents.len());
    let mut i = 0;
    let mut res = String::new();
    while let Some((token, span)) = lexer3.next() {
        let Ok(tok) = token else {
            res.push_str(&format!(
                "Token {i:4}: {:25?} {:4} .. {:4}\n",
                token, span.start, span.end,
            ));
            break;
        };

        res.push_str(&format!(
            "Token {i:4}: {:25} span: {:4} .. {:4} '{}'\n",
            format!("{:?}", tok),
            span.start,
            span.end,
            String::from_utf8_lossy(
                contents
                    .get(span.start..span.end)
                    .expect("lexer: missing source for span"),
            )
            .replace("\r", "\\r")
            .replace("\n", "\\n")
            .replace("\t", "\\t")
        ));
        i += 1;
        tokens.push(tok);
    }

    res
}

#[test]
fn test_node_output() {
    insta::glob!("../tests", "*.nu", |path| {
        insta::assert_snapshot!(evaluate_example(path));
    });
}

#[test]
fn test_lexer() {
    insta::glob!("../tests/lex", "*.nu", |path| {
        insta::assert_snapshot!(evaluate_lexer(path));
    });
}

#[test]
fn test_lexer3() {
    insta::glob!("../tests/lex", "*.nu", |path| {
        insta::assert_snapshot!(evaluate_lexer3(path));
    });
}
