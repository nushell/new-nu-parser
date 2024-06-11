use std::process::exit;

use new_nu_parser::compiler::Compiler;
use new_nu_parser::parser::Parser;
use new_nu_parser::resolver::Resolver;
use new_nu_parser::typechecker::Typechecker;

fn main() {
    let mut compiler = Compiler::new();

    for fname in std::env::args().skip(1) {
        let contents = std::fs::read(&fname);

        let Ok(contents) = contents else {
            eprintln!("can't find {}", fname);
            exit(1);
        };

        let span_offset = compiler.span_offset();
        compiler.add_file(&fname, &contents);

        let parser = Parser::new(compiler, span_offset);
        compiler = parser.parse();

        compiler.print();

        if !compiler.errors.is_empty() {
            exit(1);
        }

        let mut resolver = Resolver::new(&compiler);
        resolver.resolve();
        resolver.print();

        compiler.merge_name_bindings(resolver.to_name_bindings());

        if !compiler.errors.is_empty() {
            exit(1);
        }

        let mut typechecker = Typechecker::new(&compiler);
        typechecker.typecheck();
        typechecker.print();

        compiler.merge_types(typechecker.to_types());
    }
}
