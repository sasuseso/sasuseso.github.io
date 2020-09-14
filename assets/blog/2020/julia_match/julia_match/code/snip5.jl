# This file was generated, do not modify it. # hide
include("./blog/2020/julia_match/singleton_matcher.jl") # hide

show(Machers.@singleton_macher "b" begin
    "a" => UInt8('a')
    "b" => UInt8('b')
    _ => println("else")
end)

methods(Machers.macher)