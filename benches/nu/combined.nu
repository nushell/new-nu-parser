def bar [ y: int ] {
    $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
}

def baz [ y: int ] {
    $y * 20 * (($y * 20 + $y * 20) - ($y * 20 * 20))
}

def foo [ x: bool, y: int, z: list<list<int>> ] {
    let res = if $x {
        bar $y
    } else {
        baz $y
    }

    mut out = [ $y ]

    for a in $z {
        for b in $a {
            $out = $out ++ $b
        }
    }

    $out = $out ++ $res
    $out
}
