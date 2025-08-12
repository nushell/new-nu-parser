# Typechecking

The current typechecker is based on the paper [Complete and Easy Bidirectional Typechecking for Higher-Rank Polymorphism](https://arxiv.org/abs/1306.6032), although we've had to make some modifications because their type system is pretty different from ours. Mainly, we've added gradual typing and subtyping while ignoring the higher-rank polymorphism stuff.

The following are types used by the typechecker:

- The top type: the supertype of all types (similar to Java's `Object`, which is the supertype of all reference types)
- The bottom type: the subtype of all types (same as TypeScript's `never`).  You can never construct an instance of the bottom type.
  - This is useful for indicating that a command will never return (due to throwing an error or looping infinitely).
- The `oneof` type: for creating union types. `oneof<int, string>` can be used as the type for a value that's either an integer or a string.
- The `allof` type: for creating intersection types. `allof<A, B, C, ...>` represents a type that is simultaneously the subtype of `A`, `B`, and `C`.
  - This isn't particularly useful in Nushell, so users won't be able to construct `allof` types themselves.
  - However, the typechecker does use this internally.

## How type checking/inference work

The `typecheck_expr` method takes the expected type of the expression it is currently processing and provides an inferred type for every expression it visits. This way, we both check against the expected type and infer a type for the expression at the same time. Below is an example program using generics.

```nu
def f<T> [ x: T ] : nothing -> list<T> {
  let z = $x
  [$z]
}
f 123 # Inferred to be of type list<int>
```

For generics to work, the algorithm requires creating and solving type variables. These type variables have a lower bound and an upper bound. As we move through the program, these bounds are tightened further. At the end of the program, the lower bound of each type variable is chosen as its value.

Every time we come across a call to a custom command with type parameters, we instantiate new type variables corresponding to those type parameters. For example, for the expression `f 123` above, we instantiate a new type variable `'0` with lower bound `bottom` and upper bound `top` (essentially unbounded). Because of the signature of `f`, we know that `123: '0` and `f 123: list<'0>`.

So we first call `typecheck_expr` to check/infer the type of `123`, providing `'0` as its expected type. Since it's just an integer literal, we infer the type to be `int`. Then, to ensure that this type matches the expected type (`'0`), we call the `constrain_subtype` method to ensure that `int <: '0`. The existing lower bound for `'0` was `bottom`, so we set the new lower bound to `oneof<bottom, int> = int`.

Then we set the type of `f 123` to `list<'0>`. After all expressions have been processed, we replace all occurrences of `'0` with `int`. So this becomes `list<int>`.

Recursive bounds are not allowed. The bounds for a type variable (say, `'5`) can only refer to type variables created before it (here, `'0` through `'4`).
- If, during typechecking, we find ourselves setting the upper bound of `'5` to `'6`, then we instead set the upper bound of `'5` to whatever the lower bound of `'6` is at that point. This behavior can be improved upon somewhat in the future (in this particular example, we could instead update `'6`'s lower bound to include `'5`), but I think it's good enough for now.
