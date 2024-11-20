use std::process::exit;

use logos::Logos;
use new_nu_parser::lexer2::Lexer2;
use new_nu_parser::lexer3::Token3;
use new_nu_parser::token::TokenType2;
use nu_protocol::engine::{EngineState, StateWorkingSet};
use tango_bench::{benchmark_fn, tango_benchmarks, tango_main, Benchmark, IntoBenchmarks};

use new_nu_parser::compiler::Compiler;
use new_nu_parser::lexer::Lexer;
use new_nu_parser::parser::Parser;
use new_nu_parser::resolver::Resolver;
use new_nu_parser::typechecker::Typechecker;

/// Files in benches/nu/ we want to benchmark (without .nu suffix)
const BENCHMARKS: &[&str] = &[
    "def",
    "if",
    "combined",
    "combined10",
    "combined100",
    "combined1000",
    "int100",
];

enum Stage {
    ParseLex,
    Lex,
    NewLex,
    LexLogos,
    Parse,
    Resolve,
    Typecheck,
    ResolveMerge,
    TypecheckMerge,
    Compile,
    Nu,
}

/// Stages of compilation we want to profile
const STAGES: &[Stage] = &[
    Stage::Parse,
    Stage::ParseLex,
    Stage::Lex,
    Stage::NewLex,
    Stage::LexLogos,
    Stage::Resolve,
    Stage::Typecheck,
    Stage::ResolveMerge,
    Stage::TypecheckMerge,
    Stage::Compile,
    Stage::Nu,
];

/// Set up compiler with selected stages pre-run
fn setup_compiler(
    fname: &str,
    do_parse: bool,
    do_resolve: bool,
    do_typecheck: bool,
) -> Result<(Compiler, usize), String> {
    let mut compiler = Compiler::new();
    let span_offset = compiler.span_offset();

    let contents = std::fs::read(fname).map_err(|_| format!("Cannot find file {fname}"))?;
    compiler.add_file(&fname, &contents);

    if do_parse {
        let parser = Parser::new(compiler, span_offset);
        compiler = parser.parse();

        if !compiler.errors.is_empty() {
            return Err(format!("Error parsing file {fname}"));
        }
    }

    if do_resolve {
        let mut resolver = Resolver::new(&compiler);
        resolver.resolve();

        if !compiler.errors.is_empty() {
            return Err(format!("Error resolving file {fname}"));
        }

        compiler.merge_name_bindings(resolver.to_name_bindings());
    }

    if do_typecheck {
        let mut typechecker = Typechecker::new(&compiler);
        typechecker.typecheck();

        if !compiler.errors.is_empty() {
            return Err(format!("Error typechecking file {fname}"));
        }

        compiler.merge_types(typechecker.to_types());
    }

    Ok((compiler, span_offset))
}

/// Lex only
pub fn parse_lex(compiler: Compiler, span_offset: usize) {
    let mut parser = Parser::new(compiler, span_offset);
    parser.lex();
}

/// Lex only
pub fn lex(compiler: Compiler, span_offset: usize) {
    let mut lexer = Lexer::new(&compiler.source, span_offset);
    lexer.lex();
}

/// Parse only
pub fn parse(mut compiler: Compiler, span_offset: usize) {
    let parser = Parser::new(compiler, span_offset);
    compiler = parser.parse();

    if !compiler.errors.is_empty() {
        eprintln!("Error resolving def.");
        exit(1);
    }
}

/// Resolve only
pub fn resolve(mut compiler: Compiler, do_merge: bool) {
    let mut resolver = Resolver::new(&compiler);
    resolver.resolve();

    if !compiler.errors.is_empty() {
        eprintln!("Error resolving def.");
        exit(1);
    }

    if do_merge {
        compiler.merge_name_bindings(resolver.to_name_bindings());
    }
}

/// Typecheck only
pub fn typecheck(mut compiler: Compiler, do_merge: bool) {
    let mut typechecker = Typechecker::new(&compiler);
    typechecker.typecheck();

    if !compiler.errors.is_empty() {
        eprintln!("Error typechecking def.");
        exit(1);
    }

    if do_merge {
        compiler.merge_types(typechecker.to_types());
    }
}

/// Run all compiler stages
pub fn compile(mut compiler: Compiler, span_offset: usize) {
    let parser = Parser::new(compiler, span_offset);
    compiler = parser.parse();

    if !compiler.errors.is_empty() {
        eprintln!("Error resolving def.");
        exit(1);
    }

    let mut resolver = Resolver::new(&compiler);
    resolver.resolve();

    if !compiler.errors.is_empty() {
        eprintln!("Error resolving def.");
        exit(1);
    }

    compiler.merge_name_bindings(resolver.to_name_bindings());

    let mut typechecker = Typechecker::new(&compiler);
    typechecker.typecheck();

    if !compiler.errors.is_empty() {
        eprintln!("Error typechecking def.");
        exit(1);
    }

    compiler.merge_types(typechecker.to_types());
}

fn parse_nu_old(engine_state: &EngineState, contents: &[u8]) {
    let mut working_set = StateWorkingSet::new(engine_state);
    let _ = nu_parser::parse(&mut working_set, None, contents, false);
}

fn parse_nu_old_empty(engine_state: &EngineState) {
    let mut working_set = StateWorkingSet::new(engine_state);
    let _ = nu_parser::parse(&mut working_set, None, b"", false);
}

fn compiler_benchmarks() -> impl IntoBenchmarks {
    let mut benchmarks: Vec<Benchmark> = vec![];

    for bench_name in BENCHMARKS {
        for stage in STAGES {
            let bench_file = format!("benches/nu/{bench_name}.nu");

            let bench = match stage {
                Stage::Parse => {
                    let name = format!("{bench_name}_parse");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_init, span_offset) =
                            setup_compiler(&bench_file, false, false, false)
                                .expect("Error setting up compiler");
                        b.iter(move || parse(compiler_def_init.clone(), span_offset))
                    })
                }
                Stage::ParseLex => {
                    let name = format!("{bench_name}_parse_lex");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_init, span_offset) =
                            setup_compiler(&bench_file, false, false, false)
                                .expect("Error setting up compiler");
                        b.iter(move || parse_lex(compiler_def_init.clone(), span_offset))
                    })
                }
                Stage::Lex => {
                    let name = format!("{bench_name}_lex");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_init, span_offset) =
                            setup_compiler(&bench_file, false, false, false)
                                .expect("Error setting up compiler");
                        b.iter(move || lex(compiler_def_init.clone(), span_offset))
                    })
                }
                Stage::NewLex => {
                    if *bench_name != "int100" {
                        continue;
                    }
                    let name = format!("{bench_name}_new_lex");
                    benchmark_fn(name, move |b| {
                        let mut contents = std::fs::read(&bench_file)
                            .expect(&format!("Cannot find file {bench_file}"));
                        contents.push(0);
                        b.iter(move || {
                            let mut tokens = Vec::with_capacity(contents.len());
                            let mut lexer2 = Lexer2::new(&contents);
                            let mut token = lexer2.next();
                            tokens.push(token);
                            while !matches!(token.token_type, TokenType2::Eof | TokenType2::Invalid)
                            {
                                token = lexer2.next();
                                tokens.push(token);
                            }
                        })
                    })
                }
                Stage::LexLogos => {
                    let name = format!("{bench_name}_lex_logos");
                    benchmark_fn(name, move |b| {
                        let contents = std::fs::read(&bench_file)
                            .expect(&format!("Cannot find file {bench_file}"));
                        b.iter(move || {
                            let mut tokens = Vec::with_capacity(contents.len());
                            let mut lexer3 = Token3::lexer(&contents);

                            while let Some(token) = lexer3.next() {
                                tokens.push(token);
                            }
                        })
                    })
                }
                Stage::Resolve => {
                    let name = format!("{bench_name}_resolve");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_parsed, _) =
                            setup_compiler(&bench_file.clone(), true, false, false)
                                .expect("Error setting up compiler");
                        b.iter(move || resolve(compiler_def_parsed.clone(), false))
                    })
                }
                Stage::ResolveMerge => {
                    let name = format!("{bench_name}_resolve_merge");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_parsed, _) =
                            setup_compiler(&bench_file.clone(), true, false, false)
                                .expect("Error setting up compiler");
                        b.iter(move || resolve(compiler_def_parsed.clone(), true))
                    })
                }
                Stage::Typecheck => {
                    let name = format!("{bench_name}_typecheck");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_parsed, _) =
                            setup_compiler(&bench_file.clone(), true, true, false)
                                .expect("Error setting up compiler");
                        b.iter(move || typecheck(compiler_def_parsed.clone(), false))
                    })
                }
                Stage::TypecheckMerge => {
                    let name = format!("{bench_name}_typecheck_merge");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_parsed, _) =
                            setup_compiler(&bench_file.clone(), true, true, false)
                                .expect("Error setting up compiler");
                        b.iter(move || typecheck(compiler_def_parsed.clone(), true))
                    })
                }
                Stage::Compile => {
                    let name = format!("{bench_name}_compile");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_init, span_offset) =
                            setup_compiler(&bench_file.clone(), false, false, false)
                                .expect("Error setting up compiler");
                        b.iter(move || compile(compiler_def_init.clone(), span_offset))
                    })
                }
                Stage::Nu => {
                    let name = format!("{bench_name}_nu_old");
                    benchmark_fn(name, move |b| {
                        let engine_state = EngineState::new();
                        let contents = std::fs::read(bench_file.clone())
                            .expect(&format!("Cannot find file {bench_file}"));
                        b.iter(move || parse_nu_old(&engine_state, &contents))
                    })
                }
            };

            benchmarks.push(bench);
        }
    }

    benchmarks.push(benchmark_fn(format!("nu_old_empty"), move |b| {
        let engine_state = EngineState::new();
        b.iter(move || parse_nu_old_empty(&engine_state))
    }));

    benchmarks
}

tango_benchmarks!(compiler_benchmarks());
tango_main!();
