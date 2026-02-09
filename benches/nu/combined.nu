def foo_BENCH_ITERATION [ x: bool, y: int, z: list<list<int>> ] {
    def bar_BENCH_ITERATION [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz_BENCH_ITERATION [ y: int ] {
        $y * 20 * (($y * 20 + $y * 20) - ($y * 20 * 20))
    }

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
