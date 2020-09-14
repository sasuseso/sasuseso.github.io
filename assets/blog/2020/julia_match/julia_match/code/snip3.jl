# This file was generated, do not modify it. # hide
v1 = Val(1) # Val{1}()
v2 = Val(2) # Val{2}()
@assert typeof(v1) != typeof(v2)
@assert Val(1) === Val(1)
@assert Val(:hogehoge) === Val(:hogehoge)