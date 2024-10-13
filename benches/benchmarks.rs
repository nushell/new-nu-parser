use tango_bench::{benchmark_fn, tango_benchmarks, tango_main, Benchmark, IntoBenchmarks};

use std::process::exit;

use new_nu_parser::compiler::Compiler;
use new_nu_parser::parser::Parser;
use new_nu_parser::resolver::Resolver;
use new_nu_parser::typechecker::Typechecker;

/// Files in benches/nu/ we want to benchmark (without .nu suffix)
const BENCHMARKS: &[&str] = &["def", "if"];

enum Stage {
    Parse,
    Resolve,
    Typecheck,
    ResolveMerge,
    TypecheckMerge,
    Compile,
}

/// Stages of compilation we want to profile
const STAGES: &[Stage] = &[
    Stage::Parse,
    Stage::Resolve,
    Stage::Typecheck,
    Stage::ResolveMerge,
    Stage::TypecheckMerge,
    Stage::Compile,
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
            };

            benchmarks.push(bench);
        }
    }

    benchmarks
}

tango_benchmarks!(compiler_benchmarks());
tango_main!();
