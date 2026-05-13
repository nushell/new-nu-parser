let x = 123

let z = if $x < 50 {
  null
} else if $x > 100 {
  10
} else {
  [1 2 "foo"]
}

let y = if $x < 100 {
  5
} else if $x > 200 {
  "foo"
} else {
  null
}

let $y = $z

$y
