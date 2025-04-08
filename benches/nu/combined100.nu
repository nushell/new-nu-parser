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

def foo11 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo12 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo13 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo14 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo15 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo16 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo17 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo18 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo19 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo20 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo21 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo22 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo23 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo24 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo25 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo26 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo27 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo28 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo29 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo30 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo31 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo32 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo33 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo34 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo35 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo36 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo37 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo38 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo39 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo40 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo41 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo42 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo43 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo44 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo45 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo46 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo47 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo48 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo49 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo50 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo51 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo52 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo53 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo54 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo55 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo56 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo57 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo58 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo59 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo60 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo61 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo62 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo63 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo64 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo65 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo66 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo67 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo68 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo69 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo70 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo71 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo72 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo73 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo74 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo75 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo76 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo77 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo78 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo79 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo80 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo81 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo82 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo83 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo84 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo85 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo86 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo87 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo88 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo89 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo90 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo91 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo92 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo93 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo94 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo95 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo96 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo97 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo98 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo99 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo100 [ x: bool, y: int, z: list<list<int>> ] {
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
