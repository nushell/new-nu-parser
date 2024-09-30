# New Nushell Parser

Experimental new parser for Nushell with the aim to eventually replace the old parser (including related data structures, such as EngineState).

To test it, run the parser on some file, e.g., `cargo run -- spam.nu`.

## Goals

The goals of the new parser are:
1. Readability, maintainability (making it easier for contributors to grasp and improve)
2. Performance (we need faster parsing such that, for example, parsing standard library on Nushell startup should be instantaneous)
3. Correctness (thanks to 1., it should be easier to iron out quirks of the old parser)

## Structure

Unlike the old parser, the new parser processes the source file in three stages:
1. Parsing: Splitting the source file into tokens (lexing) and arranging them into AST nodes.
2. Resolving: Binding symbol names to definitions such as commands or variables and making sure these names are visible in the scopes they are supposed to.
3. Typechecking: Resolving / inferring types of values and making sure they match their expected types.
   
(TBD) Codegen: Emitting Nushell's IR

This stage-based approach clearly separates what is being done and makes it easier to contribute.
For example, one can implement a syntax parsing for X inside the parsing stage without needing to worry about type checking just yet.
That can be added as an improvement.
In the old parser, all these stages were intertwined 

The Compiler data structure holds the AST, similar to EngineState in the current Nushell (the Compiler might as well morph into EngineState over time).
Unlike the old parser where AST was arranged in a tree structure, the new AST is just a flat vector of nodes, indexed by their position (NodeId) in the vector.
This new flat structure should bring better performance and makes the AST more inspectable.

## Plans

The parser is mostly incomplete, whole swaths of features are missing.
Once we are able to emit some Nushell IR, we should start moving the parser to the main Nushell codebase behind a feature / CLI flag and work on integration with the rest of the engine etc.
(To avoid engine-q situation as much as possible, for those who remember :-).)

## Tests

With a great success we've used [`cargo insta`](https://github.com/mitsuhiko/insta).
It takes a bit used to working with the snapshots, but they are really useful for reviewing the impact of your changes.

## Contributing

You can just start hacking, the code should be more approachable than the old parser, and the stage-based structure makes it possible to split adding a feature into separate steps.
It's better to start small and keep the PRs focused.

Apart from coding the parser directly, we could use more tests, and organize the current ones better.
Perhaps the test output can be printed better?
Also, old parser's tests can be brought over and in general, harmonizing the tests with the current Nushell's codebase would be a wise idea.
The CI can be expanded to include Windows.
Benchmarks are missing (and should be added since our goal is performance!).
In other words, even if you don't want to code the parser directly, there are plenty other ways to contribute!
