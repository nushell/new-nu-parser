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

def foo101 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo102 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo103 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo104 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo105 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo106 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo107 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo108 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo109 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo110 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo111 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo112 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo113 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo114 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo115 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo116 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo117 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo118 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo119 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo120 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo121 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo122 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo123 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo124 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo125 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo126 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo127 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo128 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo129 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo130 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo131 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo132 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo133 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo134 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo135 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo136 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo137 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo138 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo139 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo140 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo141 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo142 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo143 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo144 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo145 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo146 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo147 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo148 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo149 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo150 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo151 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo152 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo153 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo154 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo155 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo156 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo157 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo158 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo159 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo160 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo161 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo162 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo163 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo164 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo165 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo166 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo167 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo168 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo169 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo170 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo171 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo172 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo173 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo174 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo175 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo176 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo177 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo178 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo179 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo180 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo181 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo182 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo183 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo184 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo185 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo186 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo187 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo188 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo189 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo190 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo191 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo192 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo193 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo194 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo195 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo196 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo197 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo198 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo199 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo200 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo201 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo202 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo203 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo204 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo205 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo206 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo207 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo208 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo209 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo210 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo211 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo212 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo213 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo214 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo215 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo216 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo217 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo218 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo219 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo220 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo221 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo222 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo223 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo224 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo225 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo226 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo227 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo228 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo229 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo230 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo231 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo232 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo233 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo234 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo235 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo236 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo237 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo238 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo239 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo240 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo241 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo242 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo243 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo244 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo245 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo246 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo247 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo248 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo249 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo250 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo251 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo252 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo253 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo254 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo255 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo256 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo257 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo258 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo259 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo260 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo261 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo262 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo263 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo264 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo265 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo266 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo267 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo268 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo269 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo270 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo271 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo272 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo273 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo274 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo275 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo276 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo277 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo278 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo279 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo280 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo281 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo282 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo283 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo284 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo285 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo286 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo287 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo288 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo289 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo290 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo291 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo292 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo293 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo294 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo295 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo296 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo297 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo298 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo299 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo300 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo301 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo302 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo303 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo304 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo305 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo306 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo307 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo308 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo309 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo310 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo311 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo312 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo313 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo314 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo315 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo316 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo317 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo318 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo319 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo320 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo321 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo322 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo323 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo324 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo325 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo326 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo327 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo328 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo329 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo330 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo331 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo332 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo333 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo334 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo335 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo336 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo337 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo338 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo339 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo340 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo341 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo342 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo343 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo344 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo345 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo346 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo347 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo348 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo349 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo350 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo351 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo352 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo353 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo354 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo355 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo356 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo357 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo358 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo359 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo360 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo361 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo362 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo363 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo364 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo365 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo366 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo367 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo368 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo369 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo370 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo371 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo372 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo373 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo374 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo375 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo376 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo377 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo378 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo379 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo380 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo381 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo382 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo383 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo384 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo385 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo386 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo387 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo388 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo389 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo390 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo391 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo392 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo393 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo394 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo395 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo396 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo397 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo398 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo399 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo400 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo401 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo402 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo403 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo404 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo405 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo406 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo407 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo408 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo409 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo410 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo411 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo412 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo413 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo414 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo415 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo416 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo417 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo418 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo419 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo420 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo421 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo422 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo423 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo424 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo425 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo426 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo427 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo428 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo429 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo430 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo431 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo432 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo433 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo434 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo435 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo436 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo437 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo438 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo439 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo440 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo441 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo442 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo443 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo444 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo445 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo446 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo447 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo448 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo449 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo450 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo451 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo452 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo453 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo454 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo455 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo456 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo457 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo458 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo459 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo460 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo461 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo462 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo463 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo464 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo465 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo466 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo467 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo468 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo469 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo470 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo471 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo472 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo473 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo474 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo475 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo476 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo477 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo478 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo479 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo480 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo481 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo482 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo483 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo484 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo485 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo486 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo487 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo488 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo489 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo490 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo491 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo492 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo493 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo494 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo495 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo496 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo497 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo498 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo499 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo500 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo501 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo502 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo503 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo504 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo505 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo506 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo507 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo508 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo509 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo510 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo511 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo512 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo513 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo514 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo515 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo516 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo517 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo518 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo519 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo520 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo521 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo522 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo523 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo524 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo525 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo526 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo527 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo528 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo529 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo530 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo531 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo532 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo533 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo534 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo535 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo536 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo537 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo538 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo539 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo540 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo541 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo542 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo543 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo544 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo545 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo546 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo547 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo548 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo549 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo550 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo551 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo552 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo553 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo554 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo555 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo556 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo557 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo558 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo559 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo560 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo561 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo562 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo563 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo564 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo565 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo566 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo567 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo568 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo569 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo570 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo571 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo572 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo573 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo574 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo575 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo576 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo577 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo578 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo579 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo580 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo581 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo582 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo583 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo584 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo585 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo586 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo587 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo588 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo589 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo590 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo591 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo592 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo593 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo594 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo595 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo596 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo597 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo598 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo599 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo600 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo601 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo602 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo603 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo604 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo605 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo606 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo607 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo608 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo609 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo610 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo611 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo612 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo613 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo614 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo615 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo616 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo617 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo618 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo619 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo620 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo621 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo622 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo623 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo624 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo625 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo626 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo627 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo628 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo629 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo630 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo631 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo632 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo633 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo634 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo635 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo636 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo637 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo638 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo639 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo640 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo641 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo642 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo643 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo644 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo645 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo646 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo647 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo648 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo649 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo650 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo651 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo652 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo653 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo654 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo655 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo656 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo657 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo658 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo659 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo660 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo661 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo662 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo663 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo664 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo665 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo666 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo667 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo668 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo669 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo670 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo671 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo672 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo673 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo674 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo675 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo676 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo677 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo678 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo679 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo680 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo681 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo682 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo683 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo684 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo685 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo686 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo687 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo688 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo689 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo690 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo691 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo692 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo693 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo694 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo695 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo696 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo697 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo698 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo699 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo700 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo701 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo702 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo703 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo704 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo705 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo706 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo707 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo708 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo709 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo710 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo711 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo712 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo713 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo714 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo715 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo716 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo717 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo718 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo719 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo720 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo721 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo722 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo723 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo724 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo725 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo726 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo727 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo728 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo729 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo730 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo731 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo732 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo733 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo734 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo735 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo736 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo737 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo738 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo739 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo740 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo741 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo742 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo743 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo744 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo745 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo746 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo747 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo748 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo749 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo750 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo751 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo752 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo753 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo754 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo755 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo756 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo757 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo758 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo759 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo760 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo761 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo762 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo763 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo764 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo765 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo766 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo767 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo768 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo769 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo770 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo771 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo772 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo773 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo774 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo775 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo776 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo777 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo778 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo779 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo780 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo781 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo782 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo783 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo784 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo785 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo786 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo787 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo788 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo789 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo790 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo791 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo792 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo793 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo794 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo795 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo796 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo797 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo798 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo799 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo800 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo801 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo802 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo803 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo804 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo805 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo806 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo807 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo808 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo809 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo810 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo811 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo812 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo813 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo814 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo815 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo816 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo817 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo818 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo819 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo820 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo821 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo822 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo823 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo824 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo825 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo826 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo827 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo828 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo829 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo830 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo831 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo832 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo833 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo834 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo835 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo836 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo837 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo838 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo839 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo840 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo841 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo842 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo843 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo844 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo845 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo846 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo847 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo848 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo849 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo850 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo851 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo852 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo853 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo854 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo855 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo856 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo857 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo858 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo859 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo860 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo861 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo862 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo863 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo864 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo865 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo866 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo867 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo868 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo869 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo870 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo871 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo872 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo873 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo874 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo875 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo876 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo877 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo878 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo879 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo880 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo881 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo882 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo883 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo884 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo885 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo886 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo887 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo888 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo889 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo890 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo891 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo892 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo893 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo894 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo895 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo896 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo897 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo898 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo899 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo900 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo901 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo902 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo903 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo904 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo905 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo906 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo907 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo908 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo909 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo910 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo911 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo912 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo913 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo914 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo915 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo916 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo917 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo918 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo919 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo920 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo921 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo922 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo923 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo924 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo925 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo926 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo927 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo928 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo929 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo930 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo931 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo932 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo933 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo934 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo935 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo936 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo937 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo938 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo939 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo940 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo941 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo942 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo943 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo944 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo945 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo946 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo947 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo948 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo949 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo950 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo951 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo952 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo953 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo954 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo955 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo956 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo957 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo958 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo959 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo960 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo961 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo962 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo963 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo964 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo965 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo966 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo967 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo968 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo969 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo970 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo971 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo972 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo973 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo974 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo975 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo976 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo977 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo978 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo979 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo980 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo981 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo982 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo983 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo984 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo985 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo986 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo987 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo988 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo989 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo990 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo991 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo992 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo993 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo994 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo995 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo996 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo997 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo998 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo999 [ x: bool, y: int, z: list<list<int>> ] {
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

def foo1000 [ x: bool, y: int, z: list<list<int>> ] {
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
