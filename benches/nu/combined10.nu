def foo1 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo2 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo3 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo4 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo5 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo6 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo7 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo8 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo9 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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

def foo10 [ x: bool, y: int, z: list<list<int>> ] {
    def bar [ y: int ] {
        $y * 10 * (($y * 10 + $y * 10) - ($y * 10 * 10))
    }

    def baz [ y: int ] {
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
