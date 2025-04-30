def f<T> [ x: T ] : nothing -> list<T> {
  let z: T = $x
  [$z]
}

let l1 = f 1

let l2 = f 2
let l3: list<number> = $l2
