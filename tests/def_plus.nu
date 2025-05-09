def mysterious<T> [ x: int ] : nothing -> T {}

let m: any = mysterious 0

$m + "foo"
$m + 123
