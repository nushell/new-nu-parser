def foo [w x: int, y: list<list<int>>, z: record<a, b: int> ] { [ $w $x, $y, $z ] }

# define flag
def foo-with-flag [--bar: int = 3, --baz(-b), x, y: int] { [$bar, $baz, $x, $y] }

# define custom completion
def completion [] { [1, 2, 3] }
def foo-with-completion [--bar: int@completion, baz: int@completion] { [$bar, $baz] }

def foo-optional [x: int, y?: int] { [$x, $y] }
