# exact matches
1 == 1
[true] ++ false
1 + 1
1.0 + 1.0
true and false # TODO: "and" marked as Name

# subtype matches
1 == 1.0
"a" == 1.0
1 + 1.0
[1] ++ 1.0
[1.0 1] ++ "a"
[[1] [2]] ++ [[3]]
[[1] [2]] ++ [[3.0]]

# errors
"a" + 1.0
"a" ++ 1.0
true and "a"
