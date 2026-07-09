let x = 123

let z: oneof<string, int> = if $x < 50 {
  "foo"
} else {
  100
}

# should resolve to a single type
let y: oneof<int> = if $x < 50 {
  100
} else {
  10
}

$z
