use std::process::exit;

use logos::Logos;
use new_nu_parser::compiler::Compiler;
use new_nu_parser::lexer::Lexer;
use new_nu_parser::lexer2::Lexer2;
use new_nu_parser::lexer3::Token3;
use new_nu_parser::parser::Parser;
use new_nu_parser::resolver::Resolver;
use new_nu_parser::token::TokenType2;
use new_nu_parser::typechecker::Typechecker;

fn main() {
    let mut compiler = Compiler::new();
    let mut do_print = true;

    for arg in std::env::args().skip(1) {
        if arg == "--no-print" {
            do_print = false;
        }
    }

    for fname in std::env::args().skip(1) {
        if fname == "--no-print" {
            continue;
        }

        let contents = std::fs::read(&fname);

        let Ok(contents) = contents else {
            eprintln!("can't find {}", fname);
            exit(1);
        };

        // let mut contents2 = contents.clone();
        // contents2.push(0); // null-terminated string
        // let mut lexer2 = Lexer2::new(&contents2);
        // let mut token = lexer2.next();
        // println!("t2: {:?}", token);
        // while !matches!(token.token_type, TokenType2::Eof | TokenType2::Invalid) {
        //     token = lexer2.next();
        //     // println!("t2: {:?}", token)
        // }

        let contents3 = contents.clone();
        let contents3_str = String::from_utf8(contents.clone()).expect("invalid utf8");
        let mut lexer3 = Token3::lexer(&contents3).spanned();
        let mut tokens = Vec::with_capacity(contents3.len());
        let mut i = 0;
        println!("Tokens3");
        while let Some((token, span)) = lexer3.next() {
            let Ok(tok) = token else {
                println!("Token3 Error: {:?} {:?}", token, span);
                break;
            };

            println!(
                "Token3 {i:4}: {:25} span: {:4} .. {:4} '{}'",
                format!("{:?}", tok),
                span.start,
                span.end,
                String::from_utf8_lossy(
                    contents3
                        .get(span.start..span.end)
                        .expect("lexer: missing source for span"),
                )
                .replace("\r", "\\r")
                .replace("\n", "\\n")
                .replace("\t", "\\t")
            );
            i += 1;
            tokens.push(tok);
        }

        println!("Done");
        break;

        let mut lexer = Lexer::new(&contents, 0);
        lexer.lex();
        if do_print {
            lexer.print();
        }

        let span_offset = compiler.span_offset();
        compiler.add_file(&fname, &contents);

        let parser = Parser::new(compiler, span_offset);

        compiler = parser.parse();

        if do_print {
            compiler.print();
        }

        if !compiler.errors.is_empty() {
            exit(1);
        }

        let mut resolver = Resolver::new(&compiler);
        resolver.resolve();

        if do_print {
            resolver.print();
        }

        compiler.merge_name_bindings(resolver.to_name_bindings());

        if !compiler.errors.is_empty() {
            exit(1);
        }

        let mut typechecker = Typechecker::new(&compiler);
        typechecker.typecheck();

        if do_print {
            typechecker.print();
        }

        compiler.merge_types(typechecker.to_types());
    }
}
