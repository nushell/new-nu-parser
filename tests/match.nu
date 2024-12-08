let x = 1

let foo = match $x {
  1 => "one"
  2 => {
    let w = 3
    2 + $w
  },
  3 => null,
  _ => ()
}
