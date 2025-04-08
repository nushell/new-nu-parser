use crate::ir_generator::IrGenerator;
use crate::lexer::lex;
use crate::resolver::Resolver;
use crate::typechecker::Typechecker;
use crate::{compiler::Compiler, parser::Parser};

use std::path::Path;

fn evaluate_example(fname: &Path) -> String {
    let mut compiler = Compiler::new();
    let contents = std::fs::read(fname).expect("We only run tests found by glob");

    let span_offset = compiler.span_offset();
    compiler.add_file(&fname.to_string_lossy(), &contents);

    let (tokens, err) = lex(&contents, span_offset);
    if let Err(e) = err {
        tokens.eprint(&contents);
        eprintln!("Lexing error. Error: {:?}", e);
        std::process::exit(1);
    }

    let parser = Parser::new(compiler, tokens);
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

    let mut ir_generator = IrGenerator::new(&compiler);
    ir_generator.generate();
    result.push_str(&ir_generator.display_state());

    result
}

fn evaluate_lexer(fname: &Path) -> String {
    let contents = std::fs::read(fname);

    let Ok(contents) = contents else {
        panic!("Lexer: can't find file {}", fname.to_string_lossy());
    };

    let (tokens, err) = lex(&contents, 0);
    let mut res = tokens.display(&contents);

    if let Err(e) = err {
        res.push_str(&format!("Lexing error. Error: {:?}", e));
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
