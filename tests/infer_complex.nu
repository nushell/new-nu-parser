def f<A, B> [ x: record<a: A, b: B>, y: record<a: A, b: B> ] : nothing -> record<a: A, b: B> {
  $x
}
def mysterious<T> [ x: int ] : nothing -> T {}

let m = mysterious 0
let a: record<a: number> = f { a: 123, b: $m } { a: 12.3, b: "foo" }
