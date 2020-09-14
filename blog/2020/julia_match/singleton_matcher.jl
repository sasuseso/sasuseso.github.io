#!/bin/julia
using BenchmarkTools, Match

module Machers
using MacroTools

macro singleton_macher(target::String, expr::Expr)
    @assert expr.head == :block
    for p in expr.args
        if !isa(p, LineNumberNode)
            @assert p.head == :call
            @assert p.args[1] == :(=>)
            # @assert p.args[3] isa Expr
            if p.args[2] == :_
                :(macher(v::Val) = $(p.args[3])) |> eval
            else
                @assert p.args[2] isa String
                :(macher(::Val{Symbol($(p.args[2]))}) = $(p.args[3])) |> eval
            end
        end
    end
    return :(Machers.macher(Val{Symbol($target)}()))
end

end

function main()
    BenchmarkTools.DEFAULT_PARAMETERS.samples=200000
    ex1 = @macroexpand Machers.@singleton_macher "t1LilSmM" begin
        "hIOtXvKt" => 0x5df0cb0a9308e200
        "jhOsBScf" => 0x49541fbf7bbc9402
        "zqWp4r2Q" => 0xc33ab95443563304
        "qx4Tg81C" => 0x448ec4e658abb307
        "C2Aa3Nak" => 0xe95b0e387f5b960a
        "c8UNVn6g" => 0x8036899ee354550a
        "Z6Uhv3xH" => 0xfa2283e808ac5110
        "j9uPe68V" => 0x0b7e0bf58b8ef412
        "0dkTde08" => 0xf519a60f8b609714
        "D2PdClmr" => 0x9ed1de9b23771f1d
        "GW7bhQYN" => 0xb4b008c87f558a1f
        "q7uyJTjp" => 0xc8f4a0989b3a3b20
        "msx4azuW" => 0xbe1fe9b648520222
        "3hwdBA5Y" => 0x7a8309aa16cee125
        "crEOPtGJ" => 0x1995d6f1ab0d0825
        "dfwH0hXm" => 0x5c184cb3f89c1227
        "6LKuZhDb" => 0xbc5abf60844cdb27
        "LjPWdVNy" => 0xdb55879c5f436528
        "1ytuu544" => 0x0adc281df2e9be2b
        "HXXtw4uC" => 0x989e9d853250b32c
        "08HG604H" => 0xb302065a81e3362d
        "NkGb4LPy" => 0xeda9ebeb2908092b
        "KHNqwO3Q" => 0x6e77d3980e51782b
        "hwK0ptNG" => 0xb4e65efd6ac3aa33
        "uHGBCAUS" => 0x1a14579ce4a2ce3d
        "FnnDohE4" => 0x2d0a0081f526443e
        "VPZ7Z0pu" => 0xced524eb01772141
        "mI7b3Hvz" => 0x5cc9b2f1ad73af42
        "HZfQ14qh" => 0xc06b501b7f738447
        "gFUO1eEs" => 0x5819bd2161f54349
        "lLmyZYGK" => 0x5b5e000855c5124e
        "fLDrD885" => 0x61032bb5337bd452
        "QWTZuLOQ" => 0xffe824de1474fa55
        "xtkA9add" => 0xe0af14f36bb43857
        "pTLywa2b" => 0x911eb7f7b882165b
        "SbuxAotV" => 0x4d82f346cc71465f
        "wp5ubpTc" => 0x30afbc1551c2f364
        "nHUsvw2B" => 0x305c9a0dc5eeec65
        "VDqplKSF" => 0x78e0c11238378664
        "Yh3SHlKK" => 0x3a28ddc063388e67
        "UCdj0uPU" => 0x564680ed123b1567
        "GJB95SbW" => 0x2f7854f55fcf326a
        "OMrTb9ff" => 0x2e8e2c7fb23c716c
        "PXAte63B" => 0x702c610d9249886d
        "1lbhrT5d" => 0x3d3df5dfcc3b956e
        "g7ejc7cy" => 0xd2206a0b46d69574
        "qsLJL1Mp" => 0x3727564ad65fd37a
        "ilhVKGuZ" => 0x825bf91885e7b67d
        "iOkTvlSc" => 0xe58145dd5e965c7f
        "gVnXpEfR" => 0x32bd39416cbafd7f
        "nCm3Y58a" => 0x763c580068319082
        "dP7w6tEp" => 0x62d21f410c622683
        "FRmOBDQR" => 0x326547c3874d5586
        "5WgxjS2e" => 0x7f97813fe2f39a88
        "RtymZBjy" => 0x4e275ec7c1bf188d
        "GNeKMJHA" => 0xaad329ae6595578e
        "4ee37QHC" => 0x5fd4c80d1f8a9d8e
        "ei446lhI" => 0xf5e7a77c79d78291
        "fc7i5FtD" => 0xed184e23909f3f93
        "FcxE9b3E" => 0x843946a172d07794
        "56qFsQMk" => 0x75bd349e96ec2895
        "rrLvC1sl" => 0x48ba49aa20723296
        "0J3wDxz3" => 0x31db22770b59da9e
        "eUwDgCAr" => 0x62b122b268db119e
        "1vVRBt06" => 0x2a3a37606b41c9a1
        "wuYJAkTX" => 0xdd1915dad749bea5
        "b4ET1nea" => 0xe0d88f5b5e615aaa
        "pCAdNI3p" => 0xf9b350d7c2aba3ad
        "s5NvIoAv" => 0x19785bc7a0f13fb0
        "Kd8XdbWV" => 0x1ed58934c9bd13b2
        "XwS9In6S" => 0xca3613a9a578e5b5
        "J7813Mim" => 0x58afbe2bd596c5b5
        "KGyYIo1f" => 0x1f79b9cf5823cdbc
        "2XM7cDRk" => 0x1df074d2d99926bc
        "s7B9JfDT" => 0x02ff03b836bcf0be
        "Q7Vq45nU" => 0x2cd3928edfa65dbd
        "r6ayWRY2" => 0x5c160a233045f6c4
        "aVRqUax9" => 0x8b3f63fc3ddd4fc6
        "zSKvRtSX" => 0x9a70ecafcc32bac8
        "dHffAhSl" => 0xe641514ba2612ecb
        "hVFN36KV" => 0x464fd7dfc43e75cd
        "Uej40HOK" => 0x394a6730da78bad2
        "0ZaQEEIH" => 0x01534364ca6b4bd4
        "NgtmIoyo" => 0x485a23d546aa67d6
        "DTzL90Al" => 0xa538c20e2265cdde
        "DnMJh3dP" => 0x309da85e9cf16be0
        "M6PMJWij" => 0x4ffe5c8dbec96fe1
        "yPTJcDjn" => 0x39481cdda65ecfe2
        "yYE6SRi3" => 0xb672547cc87e99e7
        "GLJmiG6Q" => 0x3daec552781c35ee
        "SE0nZfWb" => 0x5868b2a832e200f0
        "8RZMXqlW" => 0x4c67ff86cd5222f3
        "qChXRad1" => 0x5eabce048ffb1bf4
        "rSQRiljh" => 0x31da7fd2552b29f6
        "dKuWihQp" => 0xe53559731d9a42f7
        "KQHxjZOV" => 0x2cf1c371c316c3f8
        "mmtXJYJ6" => 0x4d96c0a3cd79e5f7
        "TzrnRE6G" => 0x381dc11f0a8fd9fb
        "MOv5BbQr" => 0xb066ddea6f36acfb
        "t1LilSmM" => 0x7b4ba8f7d284fafd
        _ => println("no maching string")
    end

    ex2 = @macroexpand @match "t1LilSmM" begin
        "hIOtXvKt" => 0x5df0cb0a9308e200
        "jhOsBScf" => 0x49541fbf7bbc9402
        "zqWp4r2Q" => 0xc33ab95443563304
        "qx4Tg81C" => 0x448ec4e658abb307
        "C2Aa3Nak" => 0xe95b0e387f5b960a
        "c8UNVn6g" => 0x8036899ee354550a
        "Z6Uhv3xH" => 0xfa2283e808ac5110
        "j9uPe68V" => 0x0b7e0bf58b8ef412
        "0dkTde08" => 0xf519a60f8b609714
        "D2PdClmr" => 0x9ed1de9b23771f1d
        "GW7bhQYN" => 0xb4b008c87f558a1f
        "q7uyJTjp" => 0xc8f4a0989b3a3b20
        "msx4azuW" => 0xbe1fe9b648520222
        "3hwdBA5Y" => 0x7a8309aa16cee125
        "crEOPtGJ" => 0x1995d6f1ab0d0825
        "dfwH0hXm" => 0x5c184cb3f89c1227
        "6LKuZhDb" => 0xbc5abf60844cdb27
        "LjPWdVNy" => 0xdb55879c5f436528
        "1ytuu544" => 0x0adc281df2e9be2b
        "HXXtw4uC" => 0x989e9d853250b32c
        "08HG604H" => 0xb302065a81e3362d
        "NkGb4LPy" => 0xeda9ebeb2908092b
        "KHNqwO3Q" => 0x6e77d3980e51782b
        "hwK0ptNG" => 0xb4e65efd6ac3aa33
        "uHGBCAUS" => 0x1a14579ce4a2ce3d
        "FnnDohE4" => 0x2d0a0081f526443e
        "VPZ7Z0pu" => 0xced524eb01772141
        "mI7b3Hvz" => 0x5cc9b2f1ad73af42
        "HZfQ14qh" => 0xc06b501b7f738447
        "gFUO1eEs" => 0x5819bd2161f54349
        "lLmyZYGK" => 0x5b5e000855c5124e
        "fLDrD885" => 0x61032bb5337bd452
        "QWTZuLOQ" => 0xffe824de1474fa55
        "xtkA9add" => 0xe0af14f36bb43857
        "pTLywa2b" => 0x911eb7f7b882165b
        "SbuxAotV" => 0x4d82f346cc71465f
        "wp5ubpTc" => 0x30afbc1551c2f364
        "nHUsvw2B" => 0x305c9a0dc5eeec65
        "VDqplKSF" => 0x78e0c11238378664
        "Yh3SHlKK" => 0x3a28ddc063388e67
        "UCdj0uPU" => 0x564680ed123b1567
        "GJB95SbW" => 0x2f7854f55fcf326a
        "OMrTb9ff" => 0x2e8e2c7fb23c716c
        "PXAte63B" => 0x702c610d9249886d
        "1lbhrT5d" => 0x3d3df5dfcc3b956e
        "g7ejc7cy" => 0xd2206a0b46d69574
        "qsLJL1Mp" => 0x3727564ad65fd37a
        "ilhVKGuZ" => 0x825bf91885e7b67d
        "iOkTvlSc" => 0xe58145dd5e965c7f
        "gVnXpEfR" => 0x32bd39416cbafd7f
        "nCm3Y58a" => 0x763c580068319082
        "dP7w6tEp" => 0x62d21f410c622683
        "FRmOBDQR" => 0x326547c3874d5586
        "5WgxjS2e" => 0x7f97813fe2f39a88
        "RtymZBjy" => 0x4e275ec7c1bf188d
        "GNeKMJHA" => 0xaad329ae6595578e
        "4ee37QHC" => 0x5fd4c80d1f8a9d8e
        "ei446lhI" => 0xf5e7a77c79d78291
        "fc7i5FtD" => 0xed184e23909f3f93
        "FcxE9b3E" => 0x843946a172d07794
        "56qFsQMk" => 0x75bd349e96ec2895
        "rrLvC1sl" => 0x48ba49aa20723296
        "0J3wDxz3" => 0x31db22770b59da9e
        "eUwDgCAr" => 0x62b122b268db119e
        "1vVRBt06" => 0x2a3a37606b41c9a1
        "wuYJAkTX" => 0xdd1915dad749bea5
        "b4ET1nea" => 0xe0d88f5b5e615aaa
        "pCAdNI3p" => 0xf9b350d7c2aba3ad
        "s5NvIoAv" => 0x19785bc7a0f13fb0
        "Kd8XdbWV" => 0x1ed58934c9bd13b2
        "XwS9In6S" => 0xca3613a9a578e5b5
        "J7813Mim" => 0x58afbe2bd596c5b5
        "KGyYIo1f" => 0x1f79b9cf5823cdbc
        "2XM7cDRk" => 0x1df074d2d99926bc
        "s7B9JfDT" => 0x02ff03b836bcf0be
        "Q7Vq45nU" => 0x2cd3928edfa65dbd
        "r6ayWRY2" => 0x5c160a233045f6c4
        "aVRqUax9" => 0x8b3f63fc3ddd4fc6
        "zSKvRtSX" => 0x9a70ecafcc32bac8
        "dHffAhSl" => 0xe641514ba2612ecb
        "hVFN36KV" => 0x464fd7dfc43e75cd
        "Uej40HOK" => 0x394a6730da78bad2
        "0ZaQEEIH" => 0x01534364ca6b4bd4
        "NgtmIoyo" => 0x485a23d546aa67d6
        "DTzL90Al" => 0xa538c20e2265cdde
        "DnMJh3dP" => 0x309da85e9cf16be0
        "M6PMJWij" => 0x4ffe5c8dbec96fe1
        "yPTJcDjn" => 0x39481cdda65ecfe2
        "yYE6SRi3" => 0xb672547cc87e99e7
        "GLJmiG6Q" => 0x3daec552781c35ee
        "SE0nZfWb" => 0x5868b2a832e200f0
        "8RZMXqlW" => 0x4c67ff86cd5222f3
        "qChXRad1" => 0x5eabce048ffb1bf4
        "rSQRiljh" => 0x31da7fd2552b29f6
        "dKuWihQp" => 0xe53559731d9a42f7
        "KQHxjZOV" => 0x2cf1c371c316c3f8
        "mmtXJYJ6" => 0x4d96c0a3cd79e5f7
        "TzrnRE6G" => 0x381dc11f0a8fd9fb
        "MOv5BbQr" => 0xb066ddea6f36acfb
        "t1LilSmM" => 0x7b4ba8f7d284fafd
        _ => println("no maching string")
    end
    @btime eval($ex1)
    @btime eval($ex2)
end

# if abspath(PROGRAM_FILE) == @__FILE__
    # main()
# end
