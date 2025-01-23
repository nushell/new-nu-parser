use std::process::exit;

use new_nu_parser::lexer::{lex, Tokens};
use nu_cmd_lang::{
    Break, Collect, Def, Echo, ExportCommand, ExportDef, For, If, Let, Module, Mut, Use,
};
use nu_protocol::engine::{EngineState, StateWorkingSet};
use nu_protocol::report_parse_error;
use tango_bench::{benchmark_fn, tango_benchmarks, tango_main, Benchmark, IntoBenchmarks};

use new_nu_parser::compiler::Compiler;
use new_nu_parser::parser::Parser;
use new_nu_parser::resolver::Resolver;
use new_nu_parser::typechecker::Typechecker;

/// Files in benches/nu/ we want to benchmark (without .nu suffix)
const BENCHMARKS: &[&str] = &[
    "def",
    "def10",
    "def100",
    "def1000",
    "if",
    "combined",
    "combined10",
    "combined100",
    "combined1000",
    "int100",
];

enum Stage {
    Lex,
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
    Stage::Lex,
    Stage::Parse,
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

    let (tokens, err) = lex(&contents, span_offset);
    if let Err(e) = err {
        tokens.eprint(&compiler.source);
        eprintln!("Lexing error. Error: {:?}", e);
        exit(1);
    }

    if do_parse {
        let parser = Parser::new(compiler, tokens);
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

/// Parse only
pub fn parse(mut compiler: Compiler, tokens: Tokens) {
    let parser = Parser::new(compiler, tokens);
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
    let (tokens, err) = lex(&compiler.source, span_offset);
    if let Err(e) = err {
        tokens.eprint(&compiler.source);
        eprintln!("Lexing error. Error: {:?}", e);
        exit(1);
    }

    let parser = Parser::new(compiler, tokens);
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

fn make_engine_state() -> Box<EngineState> {
    let mut engine_state = Box::new(EngineState::new());

    let delta = {
        let mut working_set = StateWorkingSet::new(&engine_state);
        working_set.add_decl(Box::new(Break));
        working_set.add_decl(Box::new(Collect));
        working_set.add_decl(Box::new(Def));
        working_set.add_decl(Box::new(Echo));
        working_set.add_decl(Box::new(ExportCommand));
        working_set.add_decl(Box::new(ExportDef));
        working_set.add_decl(Box::new(For));
        working_set.add_decl(Box::new(If));
        working_set.add_decl(Box::new(Let));
        working_set.add_decl(Box::new(Module));
        working_set.add_decl(Box::new(Mut));
        working_set.add_decl(Box::new(Use));

        working_set.render()
    };

    engine_state
        .merge_delta(delta)
        .expect("Error merging delta");
    engine_state
}

fn parse_nu_old(engine_state: &EngineState, contents: &[u8]) {
    let mut working_set = StateWorkingSet::new(engine_state);
    let _ = nu_parser::parse(&mut working_set, None, contents, false);

    // if any errors, report them and panic
    for error in working_set.parse_errors.iter() {
        report_parse_error(&working_set, error);
    }
    assert!(working_set.parse_errors.is_empty());
}

fn compiler_benchmarks() -> impl IntoBenchmarks {
    let mut benchmarks: Vec<Benchmark> = vec![];

    for bench_name in BENCHMARKS {
        for stage in STAGES {
            let bench_file = format!("benches/nu/{bench_name}.nu");
            let bench_contents =
                std::fs::read(&bench_file).expect(&format!("Cannot find file {bench_file}"));

            let bench = match stage {
                Stage::Lex => {
                    let name = format!("{bench_name}_lex");
                    benchmark_fn(name, move |b| {
                        let contents = bench_contents.clone();
                        b.iter(move || {
                            let (tokens, err) = lex(&contents, 0);
                            if let Err(e) = err {
                                tokens.eprint(&contents);
                                eprintln!("Lexing error. Error: {:?}", e);
                                exit(1);
                            }
                        })
                    })
                }
                Stage::Parse => {
                    let name = format!("{bench_name}_parse");
                    benchmark_fn(name, move |b| {
                        let (compiler_def_init, span_offset) =
                            setup_compiler(&bench_file, false, false, false)
                                .expect("Error setting up compiler");
                        let contents = bench_contents.clone();
                        let (tokens, err) = lex(&contents, span_offset);
                        if let Err(e) = err {
                            tokens.eprint(&contents);
                            eprintln!("Lexing error. Error: {:?}", e);
                            exit(1);
                        }
                        b.iter(move || parse(compiler_def_init.clone(), tokens.clone()))
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
                        let engine_state = make_engine_state();
                        let contents = bench_contents.clone();
                        b.iter(move || parse_nu_old(&engine_state, &contents))
                    })
                }
            };

            benchmarks.push(bench);
        }
    }

    benchmarks.push(benchmark_fn(format!("nu_old_empty"), move |b| {
        let engine_state = make_engine_state();
        b.iter(move || parse_nu_old(&engine_state, &[]))
    }));

    benchmarks
}

tango_benchmarks!(compiler_benchmarks());
tango_main!();
