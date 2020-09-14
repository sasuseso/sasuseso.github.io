# This file was generated, do not modify it. # hide
using Match
t = rand(1:4)
ex = @macroexpand @match t begin
    1 => println("mached 1")
    2 => println("mached 2")
    _ => println("something else")
end
@show ex
print("\n\nmatch result: \n\t")
eval(ex)