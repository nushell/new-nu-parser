def f<T> [ x: T ] : nothing -> list<T> {
  let z: T = $x
  [$z]
}
