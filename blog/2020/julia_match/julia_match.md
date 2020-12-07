@def title = "Julia のパターンマッチについて調べる"
@def tags = ["julia"]

# Julia のパターンマッチについて調べる

パターンマッチ構文をサポートしていない Julia でパターンマッチを実現するには 2 つの
アプローチがあります｡

## if ~ else ~ で頑張る

そのままです｡が,Julia にはマクロがあります｡マクロを使えば他言語のパターンマッチ
構文に近い形で感覚的にパターンマッチを実現するコードがかけます｡自分で書くことも
できますが,既存のパッケージにもあります｡

[Match.jl][1]は`@match`というパターンマッチのためのマクロを提供します｡

```julia:snip1
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
```

\show{snip1}

`macroexpand`マクロを使うとたしかに if-else 文を生成していることが分かります｡

型や範囲にマッチするなど高度な使い方もできます｡詳しくは[パッケージのドキュメント][2]
を参照してください｡またこちらのパッケージは現在メンテナンスがされていないようです｡

## Singlton Type Pattern

シングルトン型と Julia のマルチディスパッチを使ってパターンマッチができます｡
シングルトン型とはインスタンスを一つしか持たない型のことです｡(オブジェクト指向
ではクラスのインスタンス)

ここではこの性質を利用して,シングルトン型を引数に取る
メソッドを定義し,Julia のマルチディスパッチを使ってパターンマッチを実現します｡
Julia には Base に[Val][3]型というシングルトン型を扱うためのユーティリティがあります｡

```julia:snip3
v1 = Val(1) # Val{1}()
v2 = Val(2) # Val{2}()
@assert typeof(v1) != typeof(v2)
@assert Val(1) === Val(1)
@assert Val(:hogehoge) === Val(:hogehoge)
```

\show{snip3}

これを使って単純な文字列にマッチするマクロを書くことができます｡

```julia

module Machers
using MacroTools

macro singleton_macher(target::String, expr::Expr)
    for p in expr.args
        if !isa(p, LineNumberNode)
            if p.args[2] == :_
                :(macher(v::Val) = $(p.args[3])) |> eval
            else
                :(macher(::Val{Symbol($(p.args[2]))}) = $(p.args[3])) |> eval
            end
        end
    end
    return :(Machers.macher(Val{Symbol($target)}()))
end

end
```

マッチの腕となる`Val{T}`を取るメソッド(`macher`)が top-level スコープを汚さないよ
うにモジュールに入れてあります｡これで`Machers`モジュール内に`macher`関数を生成
します｡

以下のようにして使います｡

```julia:snip5
include("./blog/2020/julia_match/singleton_matcher.jl") # hide

show(Machers.@singleton_macher "b" begin
    "a" => UInt8('a')
    "b" => UInt8('b')
    _ => println("else")
end)

methods(Machers.macher)
```

\show{snip5}

`methods`の出力で分かるとおり,複数の`macher`が腕に記述した文字から生成したシン
グルトン型を引数に取る様に宣言されています｡`singleton_macher`マクロの最後の行で
`macher`を呼び出す`Expr`を返し,呼び出し元で評価されるとディスパッチが行われ適切
な`macher`が呼ばれます｡

## ベンチマーク

Match.jl の`match`マクロとの比較です｡

Singlton type

<!--{{{-->

```julia:snip4
using BenchmarkTools, Match
include("./blog/2020/julia_match/singleton_matcher.jl") # hide
b1 = @benchmark Machers.@singleton_macher "t1LilSmM" begin
    "hIOtXvKt" => 0x5df0cb0a9308e200
    # 中略
    "jhOsBScf" => 0x49541fbf7bbc9402 # hide
    "zqWp4r2Q" => 0xc33ab95443563304 # hide
    "qx4Tg81C" => 0x448ec4e658abb307 # hide
    "C2Aa3Nak" => 0xe95b0e387f5b960a # hide
    "c8UNVn6g" => 0x8036899ee354550a # hide
    "Z6Uhv3xH" => 0xfa2283e808ac5110 # hide
    "j9uPe68V" => 0x0b7e0bf58b8ef412 # hide
    "0dkTde08" => 0xf519a60f8b609714 # hide
    "D2PdClmr" => 0x9ed1de9b23771f1d # hide
    "GW7bhQYN" => 0xb4b008c87f558a1f # hide
    "q7uyJTjp" => 0xc8f4a0989b3a3b20 # hide
    "msx4azuW" => 0xbe1fe9b648520222 # hide
    "3hwdBA5Y" => 0x7a8309aa16cee125 # hide
    "crEOPtGJ" => 0x1995d6f1ab0d0825 # hide
    "dfwH0hXm" => 0x5c184cb3f89c1227 # hide
    "6LKuZhDb" => 0xbc5abf60844cdb27 # hide
    "LjPWdVNy" => 0xdb55879c5f436528 # hide
    "1ytuu544" => 0x0adc281df2e9be2b # hide
    "HXXtw4uC" => 0x989e9d853250b32c # hide
    "08HG604H" => 0xb302065a81e3362d # hide
    "NkGb4LPy" => 0xeda9ebeb2908092b # hide
    "KHNqwO3Q" => 0x6e77d3980e51782b # hide
    "hwK0ptNG" => 0xb4e65efd6ac3aa33 # hide
    "uHGBCAUS" => 0x1a14579ce4a2ce3d # hide
    "FnnDohE4" => 0x2d0a0081f526443e # hide
    "VPZ7Z0pu" => 0xced524eb01772141 # hide
    "mI7b3Hvz" => 0x5cc9b2f1ad73af42 # hide
    "HZfQ14qh" => 0xc06b501b7f738447 # hide
    "gFUO1eEs" => 0x5819bd2161f54349 # hide
    "lLmyZYGK" => 0x5b5e000855c5124e # hide
    "fLDrD885" => 0x61032bb5337bd452 # hide
    "QWTZuLOQ" => 0xffe824de1474fa55 # hide
    "xtkA9add" => 0xe0af14f36bb43857 # hide
    "pTLywa2b" => 0x911eb7f7b882165b # hide
    "SbuxAotV" => 0x4d82f346cc71465f # hide
    "wp5ubpTc" => 0x30afbc1551c2f364 # hide
    "nHUsvw2B" => 0x305c9a0dc5eeec65 # hide
    "VDqplKSF" => 0x78e0c11238378664 # hide
    "Yh3SHlKK" => 0x3a28ddc063388e67 # hide
    "UCdj0uPU" => 0x564680ed123b1567 # hide
    "GJB95SbW" => 0x2f7854f55fcf326a # hide
    "OMrTb9ff" => 0x2e8e2c7fb23c716c # hide
    "PXAte63B" => 0x702c610d9249886d # hide
    "1lbhrT5d" => 0x3d3df5dfcc3b956e # hide
    "g7ejc7cy" => 0xd2206a0b46d69574 # hide
    "qsLJL1Mp" => 0x3727564ad65fd37a # hide
    "ilhVKGuZ" => 0x825bf91885e7b67d # hide
    "iOkTvlSc" => 0xe58145dd5e965c7f # hide
    "gVnXpEfR" => 0x32bd39416cbafd7f # hide
    "nCm3Y58a" => 0x763c580068319082 # hide
    "dP7w6tEp" => 0x62d21f410c622683 # hide
    "FRmOBDQR" => 0x326547c3874d5586 # hide
    "5WgxjS2e" => 0x7f97813fe2f39a88 # hide
    "RtymZBjy" => 0x4e275ec7c1bf188d # hide
    "GNeKMJHA" => 0xaad329ae6595578e # hide
    "4ee37QHC" => 0x5fd4c80d1f8a9d8e # hide
    "ei446lhI" => 0xf5e7a77c79d78291 # hide
    "fc7i5FtD" => 0xed184e23909f3f93 # hide
    "FcxE9b3E" => 0x843946a172d07794 # hide
    "56qFsQMk" => 0x75bd349e96ec2895 # hide
    "rrLvC1sl" => 0x48ba49aa20723296 # hide
    "0J3wDxz3" => 0x31db22770b59da9e # hide
    "eUwDgCAr" => 0x62b122b268db119e # hide
    "1vVRBt06" => 0x2a3a37606b41c9a1 # hide
    "wuYJAkTX" => 0xdd1915dad749bea5 # hide
    "b4ET1nea" => 0xe0d88f5b5e615aaa # hide
    "pCAdNI3p" => 0xf9b350d7c2aba3ad # hide
    "s5NvIoAv" => 0x19785bc7a0f13fb0 # hide
    "Kd8XdbWV" => 0x1ed58934c9bd13b2 # hide
    "XwS9In6S" => 0xca3613a9a578e5b5 # hide
    "J7813Mim" => 0x58afbe2bd596c5b5 # hide
    "KGyYIo1f" => 0x1f79b9cf5823cdbc # hide
    "2XM7cDRk" => 0x1df074d2d99926bc # hide
    "s7B9JfDT" => 0x02ff03b836bcf0be # hide
    "Q7Vq45nU" => 0x2cd3928edfa65dbd # hide
    "r6ayWRY2" => 0x5c160a233045f6c4 # hide
    "aVRqUax9" => 0x8b3f63fc3ddd4fc6 # hide
    "zSKvRtSX" => 0x9a70ecafcc32bac8 # hide
    "dHffAhSl" => 0xe641514ba2612ecb # hide
    "hVFN36KV" => 0x464fd7dfc43e75cd # hide
    "Uej40HOK" => 0x394a6730da78bad2 # hide
    "0ZaQEEIH" => 0x01534364ca6b4bd4 # hide
    "NgtmIoyo" => 0x485a23d546aa67d6 # hide
    "DTzL90Al" => 0xa538c20e2265cdde # hide
    "DnMJh3dP" => 0x309da85e9cf16be0 # hide
    "M6PMJWij" => 0x4ffe5c8dbec96fe1 # hide
    "yPTJcDjn" => 0x39481cdda65ecfe2 # hide
    "yYE6SRi3" => 0xb672547cc87e99e7 # hide
    "GLJmiG6Q" => 0x3daec552781c35ee # hide
    "SE0nZfWb" => 0x5868b2a832e200f0 # hide
    "8RZMXqlW" => 0x4c67ff86cd5222f3 # hide
    "qChXRad1" => 0x5eabce048ffb1bf4 # hide
    "rSQRiljh" => 0x31da7fd2552b29f6 # hide
    "dKuWihQp" => 0xe53559731d9a42f7 # hide
    "KQHxjZOV" => 0x2cf1c371c316c3f8 # hide
    "mmtXJYJ6" => 0x4d96c0a3cd79e5f7 # hide
    "TzrnRE6G" => 0x381dc11f0a8fd9fb # hide
    "MOv5BbQr" => 0xb066ddea6f36acfb # hide
    "t1LilSmM" => 0x7b4ba8f7d284fafd
    _ => println("no maching string")
end
```

<!--}}}-->

\show{snip4}

Match.jl

<!--{{{-->

```julia:snip2
b2 = @benchmark @match "t1LilSmM" begin
    "hIOtXvKt" => 0x5df0cb0a9308e200
    # 中略
    "jhOsBScf" => 0x49541fbf7bbc9402 # hide
    "zqWp4r2Q" => 0xc33ab95443563304 # hide
    "qx4Tg81C" => 0x448ec4e658abb307 # hide
    "C2Aa3Nak" => 0xe95b0e387f5b960a # hide
    "c8UNVn6g" => 0x8036899ee354550a # hide
    "Z6Uhv3xH" => 0xfa2283e808ac5110 # hide
    "j9uPe68V" => 0x0b7e0bf58b8ef412 # hide
    "0dkTde08" => 0xf519a60f8b609714 # hide
    "D2PdClmr" => 0x9ed1de9b23771f1d # hide
    "GW7bhQYN" => 0xb4b008c87f558a1f # hide
    "q7uyJTjp" => 0xc8f4a0989b3a3b20 # hide
    "msx4azuW" => 0xbe1fe9b648520222 # hide
    "3hwdBA5Y" => 0x7a8309aa16cee125 # hide
    "crEOPtGJ" => 0x1995d6f1ab0d0825 # hide
    "dfwH0hXm" => 0x5c184cb3f89c1227 # hide
    "6LKuZhDb" => 0xbc5abf60844cdb27 # hide
    "LjPWdVNy" => 0xdb55879c5f436528 # hide
    "1ytuu544" => 0x0adc281df2e9be2b # hide
    "HXXtw4uC" => 0x989e9d853250b32c # hide
    "08HG604H" => 0xb302065a81e3362d # hide
    "NkGb4LPy" => 0xeda9ebeb2908092b # hide
    "KHNqwO3Q" => 0x6e77d3980e51782b # hide
    "hwK0ptNG" => 0xb4e65efd6ac3aa33 # hide
    "uHGBCAUS" => 0x1a14579ce4a2ce3d # hide
    "FnnDohE4" => 0x2d0a0081f526443e # hide
    "VPZ7Z0pu" => 0xced524eb01772141 # hide
    "mI7b3Hvz" => 0x5cc9b2f1ad73af42 # hide
    "HZfQ14qh" => 0xc06b501b7f738447 # hide
    "gFUO1eEs" => 0x5819bd2161f54349 # hide
    "lLmyZYGK" => 0x5b5e000855c5124e # hide
    "fLDrD885" => 0x61032bb5337bd452 # hide
    "QWTZuLOQ" => 0xffe824de1474fa55 # hide
    "xtkA9add" => 0xe0af14f36bb43857 # hide
    "pTLywa2b" => 0x911eb7f7b882165b # hide
    "SbuxAotV" => 0x4d82f346cc71465f # hide
    "wp5ubpTc" => 0x30afbc1551c2f364 # hide
    "nHUsvw2B" => 0x305c9a0dc5eeec65 # hide
    "VDqplKSF" => 0x78e0c11238378664 # hide
    "Yh3SHlKK" => 0x3a28ddc063388e67 # hide
    "UCdj0uPU" => 0x564680ed123b1567 # hide
    "GJB95SbW" => 0x2f7854f55fcf326a # hide
    "OMrTb9ff" => 0x2e8e2c7fb23c716c # hide
    "PXAte63B" => 0x702c610d9249886d # hide
    "1lbhrT5d" => 0x3d3df5dfcc3b956e # hide
    "g7ejc7cy" => 0xd2206a0b46d69574 # hide
    "qsLJL1Mp" => 0x3727564ad65fd37a # hide
    "ilhVKGuZ" => 0x825bf91885e7b67d # hide
    "iOkTvlSc" => 0xe58145dd5e965c7f # hide
    "gVnXpEfR" => 0x32bd39416cbafd7f # hide
    "nCm3Y58a" => 0x763c580068319082 # hide
    "dP7w6tEp" => 0x62d21f410c622683 # hide
    "FRmOBDQR" => 0x326547c3874d5586 # hide
    "5WgxjS2e" => 0x7f97813fe2f39a88 # hide
    "RtymZBjy" => 0x4e275ec7c1bf188d # hide
    "GNeKMJHA" => 0xaad329ae6595578e # hide
    "4ee37QHC" => 0x5fd4c80d1f8a9d8e # hide
    "ei446lhI" => 0xf5e7a77c79d78291 # hide
    "fc7i5FtD" => 0xed184e23909f3f93 # hide
    "FcxE9b3E" => 0x843946a172d07794 # hide
    "56qFsQMk" => 0x75bd349e96ec2895 # hide
    "rrLvC1sl" => 0x48ba49aa20723296 # hide
    "0J3wDxz3" => 0x31db22770b59da9e # hide
    "eUwDgCAr" => 0x62b122b268db119e # hide
    "1vVRBt06" => 0x2a3a37606b41c9a1 # hide
    "wuYJAkTX" => 0xdd1915dad749bea5 # hide
    "b4ET1nea" => 0xe0d88f5b5e615aaa # hide
    "pCAdNI3p" => 0xf9b350d7c2aba3ad # hide
    "s5NvIoAv" => 0x19785bc7a0f13fb0 # hide
    "Kd8XdbWV" => 0x1ed58934c9bd13b2 # hide
    "XwS9In6S" => 0xca3613a9a578e5b5 # hide
    "J7813Mim" => 0x58afbe2bd596c5b5 # hide
    "KGyYIo1f" => 0x1f79b9cf5823cdbc # hide
    "2XM7cDRk" => 0x1df074d2d99926bc # hide
    "s7B9JfDT" => 0x02ff03b836bcf0be # hide
    "Q7Vq45nU" => 0x2cd3928edfa65dbd # hide
    "r6ayWRY2" => 0x5c160a233045f6c4 # hide
    "aVRqUax9" => 0x8b3f63fc3ddd4fc6 # hide
    "zSKvRtSX" => 0x9a70ecafcc32bac8 # hide
    "dHffAhSl" => 0xe641514ba2612ecb # hide
    "hVFN36KV" => 0x464fd7dfc43e75cd # hide
    "Uej40HOK" => 0x394a6730da78bad2 # hide
    "0ZaQEEIH" => 0x01534364ca6b4bd4 # hide
    "NgtmIoyo" => 0x485a23d546aa67d6 # hide
    "DTzL90Al" => 0xa538c20e2265cdde # hide
    "DnMJh3dP" => 0x309da85e9cf16be0 # hide
    "M6PMJWij" => 0x4ffe5c8dbec96fe1 # hide
    "yPTJcDjn" => 0x39481cdda65ecfe2 # hide
    "yYE6SRi3" => 0xb672547cc87e99e7 # hide
    "GLJmiG6Q" => 0x3daec552781c35ee # hide
    "SE0nZfWb" => 0x5868b2a832e200f0 # hide
    "8RZMXqlW" => 0x4c67ff86cd5222f3 # hide
    "qChXRad1" => 0x5eabce048ffb1bf4 # hide
    "rSQRiljh" => 0x31da7fd2552b29f6 # hide
    "dKuWihQp" => 0xe53559731d9a42f7 # hide
    "KQHxjZOV" => 0x2cf1c371c316c3f8 # hide
    "mmtXJYJ6" => 0x4d96c0a3cd79e5f7 # hide
    "TzrnRE6G" => 0x381dc11f0a8fd9fb # hide
    "MOv5BbQr" => 0xb066ddea6f36acfb # hide
    "t1LilSmM" => 0x7b4ba8f7d284fafd
    _ => println("no maching string")
end
```

<!--}}}-->

\show{snip2}

```julia:plot1
using Plots
plot([b1, b2], st=:bar)
@show joinpath(@OUTPUT, "match_plot1.svg")
savefig(joinpath(@OUTPUT, "match_plot1.svg")) # hide
```

\show{plot1}
\fig{match_plot1}

圧倒的な速さですが Match.jl はかなりリッチなパターンマッチ構文をサポートしている
ので,コード生成のオーバーヘッドを考慮する必要がありそうです｡

`@macroexpand`でコード生成のオーバーヘッドを排除しようと試みたもの｡

Singlton type

<!--{{{-->

```julia:snip8
using BenchmarkTools, Match
include("./blog/2020/julia_match/singleton_matcher.jl")
ex = @macroexpand Machers.@singleton_macher "t1LilSmM" begin
    "hIOtXvKt" => 0x5df0cb0a9308e200
    # 中略
    "jhOsBScf" => 0x49541fbf7bbc9402 # hide
    "zqWp4r2Q" => 0xc33ab95443563304 # hide
    "qx4Tg81C" => 0x448ec4e658abb307 # hide
    "C2Aa3Nak" => 0xe95b0e387f5b960a # hide
    "c8UNVn6g" => 0x8036899ee354550a # hide
    "Z6Uhv3xH" => 0xfa2283e808ac5110 # hide
    "j9uPe68V" => 0x0b7e0bf58b8ef412 # hide
    "0dkTde08" => 0xf519a60f8b609714 # hide
    "D2PdClmr" => 0x9ed1de9b23771f1d # hide
    "GW7bhQYN" => 0xb4b008c87f558a1f # hide
    "q7uyJTjp" => 0xc8f4a0989b3a3b20 # hide
    "msx4azuW" => 0xbe1fe9b648520222 # hide
    "3hwdBA5Y" => 0x7a8309aa16cee125 # hide
    "crEOPtGJ" => 0x1995d6f1ab0d0825 # hide
    "dfwH0hXm" => 0x5c184cb3f89c1227 # hide
    "6LKuZhDb" => 0xbc5abf60844cdb27 # hide
    "LjPWdVNy" => 0xdb55879c5f436528 # hide
    "1ytuu544" => 0x0adc281df2e9be2b # hide
    "HXXtw4uC" => 0x989e9d853250b32c # hide
    "08HG604H" => 0xb302065a81e3362d # hide
    "NkGb4LPy" => 0xeda9ebeb2908092b # hide
    "KHNqwO3Q" => 0x6e77d3980e51782b # hide
    "hwK0ptNG" => 0xb4e65efd6ac3aa33 # hide
    "uHGBCAUS" => 0x1a14579ce4a2ce3d # hide
    "FnnDohE4" => 0x2d0a0081f526443e # hide
    "VPZ7Z0pu" => 0xced524eb01772141 # hide
    "mI7b3Hvz" => 0x5cc9b2f1ad73af42 # hide
    "HZfQ14qh" => 0xc06b501b7f738447 # hide
    "gFUO1eEs" => 0x5819bd2161f54349 # hide
    "lLmyZYGK" => 0x5b5e000855c5124e # hide
    "fLDrD885" => 0x61032bb5337bd452 # hide
    "QWTZuLOQ" => 0xffe824de1474fa55 # hide
    "xtkA9add" => 0xe0af14f36bb43857 # hide
    "pTLywa2b" => 0x911eb7f7b882165b # hide
    "SbuxAotV" => 0x4d82f346cc71465f # hide
    "wp5ubpTc" => 0x30afbc1551c2f364 # hide
    "nHUsvw2B" => 0x305c9a0dc5eeec65 # hide
    "VDqplKSF" => 0x78e0c11238378664 # hide
    "Yh3SHlKK" => 0x3a28ddc063388e67 # hide
    "UCdj0uPU" => 0x564680ed123b1567 # hide
    "GJB95SbW" => 0x2f7854f55fcf326a # hide
    "OMrTb9ff" => 0x2e8e2c7fb23c716c # hide
    "PXAte63B" => 0x702c610d9249886d # hide
    "1lbhrT5d" => 0x3d3df5dfcc3b956e # hide
    "g7ejc7cy" => 0xd2206a0b46d69574 # hide
    "qsLJL1Mp" => 0x3727564ad65fd37a # hide
    "ilhVKGuZ" => 0x825bf91885e7b67d # hide
    "iOkTvlSc" => 0xe58145dd5e965c7f # hide
    "gVnXpEfR" => 0x32bd39416cbafd7f # hide
    "nCm3Y58a" => 0x763c580068319082 # hide
    "dP7w6tEp" => 0x62d21f410c622683 # hide
    "FRmOBDQR" => 0x326547c3874d5586 # hide
    "5WgxjS2e" => 0x7f97813fe2f39a88 # hide
    "RtymZBjy" => 0x4e275ec7c1bf188d # hide
    "GNeKMJHA" => 0xaad329ae6595578e # hide
    "4ee37QHC" => 0x5fd4c80d1f8a9d8e # hide
    "ei446lhI" => 0xf5e7a77c79d78291 # hide
    "fc7i5FtD" => 0xed184e23909f3f93 # hide
    "FcxE9b3E" => 0x843946a172d07794 # hide
    "56qFsQMk" => 0x75bd349e96ec2895 # hide
    "rrLvC1sl" => 0x48ba49aa20723296 # hide
    "0J3wDxz3" => 0x31db22770b59da9e # hide
    "eUwDgCAr" => 0x62b122b268db119e # hide
    "1vVRBt06" => 0x2a3a37606b41c9a1 # hide
    "wuYJAkTX" => 0xdd1915dad749bea5 # hide
    "b4ET1nea" => 0xe0d88f5b5e615aaa # hide
    "pCAdNI3p" => 0xf9b350d7c2aba3ad # hide
    "s5NvIoAv" => 0x19785bc7a0f13fb0 # hide
    "Kd8XdbWV" => 0x1ed58934c9bd13b2 # hide
    "XwS9In6S" => 0xca3613a9a578e5b5 # hide
    "J7813Mim" => 0x58afbe2bd596c5b5 # hide
    "KGyYIo1f" => 0x1f79b9cf5823cdbc # hide
    "2XM7cDRk" => 0x1df074d2d99926bc # hide
    "s7B9JfDT" => 0x02ff03b836bcf0be # hide
    "Q7Vq45nU" => 0x2cd3928edfa65dbd # hide
    "r6ayWRY2" => 0x5c160a233045f6c4 # hide
    "aVRqUax9" => 0x8b3f63fc3ddd4fc6 # hide
    "zSKvRtSX" => 0x9a70ecafcc32bac8 # hide
    "dHffAhSl" => 0xe641514ba2612ecb # hide
    "hVFN36KV" => 0x464fd7dfc43e75cd # hide
    "Uej40HOK" => 0x394a6730da78bad2 # hide
    "0ZaQEEIH" => 0x01534364ca6b4bd4 # hide
    "NgtmIoyo" => 0x485a23d546aa67d6 # hide
    "DTzL90Al" => 0xa538c20e2265cdde # hide
    "DnMJh3dP" => 0x309da85e9cf16be0 # hide
    "M6PMJWij" => 0x4ffe5c8dbec96fe1 # hide
    "yPTJcDjn" => 0x39481cdda65ecfe2 # hide
    "yYE6SRi3" => 0xb672547cc87e99e7 # hide
    "GLJmiG6Q" => 0x3daec552781c35ee # hide
    "SE0nZfWb" => 0x5868b2a832e200f0 # hide
    "8RZMXqlW" => 0x4c67ff86cd5222f3 # hide
    "qChXRad1" => 0x5eabce048ffb1bf4 # hide
    "rSQRiljh" => 0x31da7fd2552b29f6 # hide
    "dKuWihQp" => 0xe53559731d9a42f7 # hide
    "KQHxjZOV" => 0x2cf1c371c316c3f8 # hide
    "mmtXJYJ6" => 0x4d96c0a3cd79e5f7 # hide
    "TzrnRE6G" => 0x381dc11f0a8fd9fb # hide
    "MOv5BbQr" => 0xb066ddea6f36acfb # hide
    "t1LilSmM" => 0x7b4ba8f7d284fafd
    _ => println("no maching string")
end

@benchmark $ex
```

<!--}}}-->

\show{snip8}

Match.jl

<!--{{{-->

```julia:snip7
ex = @macroexpand Match.@match "t1LilSmM" begin
    "hIOtXvKt" => 0x5df0cb0a9308e200
    # 中略
    "jhOsBScf" => 0x49541fbf7bbc9402 # hide
    "zqWp4r2Q" => 0xc33ab95443563304 # hide
    "qx4Tg81C" => 0x448ec4e658abb307 # hide
    "C2Aa3Nak" => 0xe95b0e387f5b960a # hide
    "c8UNVn6g" => 0x8036899ee354550a # hide
    "Z6Uhv3xH" => 0xfa2283e808ac5110 # hide
    "j9uPe68V" => 0x0b7e0bf58b8ef412 # hide
    "0dkTde08" => 0xf519a60f8b609714 # hide
    "D2PdClmr" => 0x9ed1de9b23771f1d # hide
    "GW7bhQYN" => 0xb4b008c87f558a1f # hide
    "q7uyJTjp" => 0xc8f4a0989b3a3b20 # hide
    "msx4azuW" => 0xbe1fe9b648520222 # hide
    "3hwdBA5Y" => 0x7a8309aa16cee125 # hide
    "crEOPtGJ" => 0x1995d6f1ab0d0825 # hide
    "dfwH0hXm" => 0x5c184cb3f89c1227 # hide
    "6LKuZhDb" => 0xbc5abf60844cdb27 # hide
    "LjPWdVNy" => 0xdb55879c5f436528 # hide
    "1ytuu544" => 0x0adc281df2e9be2b # hide
    "HXXtw4uC" => 0x989e9d853250b32c # hide
    "08HG604H" => 0xb302065a81e3362d # hide
    "NkGb4LPy" => 0xeda9ebeb2908092b # hide
    "KHNqwO3Q" => 0x6e77d3980e51782b # hide
    "hwK0ptNG" => 0xb4e65efd6ac3aa33 # hide
    "uHGBCAUS" => 0x1a14579ce4a2ce3d # hide
    "FnnDohE4" => 0x2d0a0081f526443e # hide
    "VPZ7Z0pu" => 0xced524eb01772141 # hide
    "mI7b3Hvz" => 0x5cc9b2f1ad73af42 # hide
    "HZfQ14qh" => 0xc06b501b7f738447 # hide
    "gFUO1eEs" => 0x5819bd2161f54349 # hide
    "lLmyZYGK" => 0x5b5e000855c5124e # hide
    "fLDrD885" => 0x61032bb5337bd452 # hide
    "QWTZuLOQ" => 0xffe824de1474fa55 # hide
    "xtkA9add" => 0xe0af14f36bb43857 # hide
    "pTLywa2b" => 0x911eb7f7b882165b # hide
    "SbuxAotV" => 0x4d82f346cc71465f # hide
    "wp5ubpTc" => 0x30afbc1551c2f364 # hide
    "nHUsvw2B" => 0x305c9a0dc5eeec65 # hide
    "VDqplKSF" => 0x78e0c11238378664 # hide
    "Yh3SHlKK" => 0x3a28ddc063388e67 # hide
    "UCdj0uPU" => 0x564680ed123b1567 # hide
    "GJB95SbW" => 0x2f7854f55fcf326a # hide
    "OMrTb9ff" => 0x2e8e2c7fb23c716c # hide
    "PXAte63B" => 0x702c610d9249886d # hide
    "1lbhrT5d" => 0x3d3df5dfcc3b956e # hide
    "g7ejc7cy" => 0xd2206a0b46d69574 # hide
    "qsLJL1Mp" => 0x3727564ad65fd37a # hide
    "ilhVKGuZ" => 0x825bf91885e7b67d # hide
    "iOkTvlSc" => 0xe58145dd5e965c7f # hide
    "gVnXpEfR" => 0x32bd39416cbafd7f # hide
    "nCm3Y58a" => 0x763c580068319082 # hide
    "dP7w6tEp" => 0x62d21f410c622683 # hide
    "FRmOBDQR" => 0x326547c3874d5586 # hide
    "5WgxjS2e" => 0x7f97813fe2f39a88 # hide
    "RtymZBjy" => 0x4e275ec7c1bf188d # hide
    "GNeKMJHA" => 0xaad329ae6595578e # hide
    "4ee37QHC" => 0x5fd4c80d1f8a9d8e # hide
    "ei446lhI" => 0xf5e7a77c79d78291 # hide
    "fc7i5FtD" => 0xed184e23909f3f93 # hide
    "FcxE9b3E" => 0x843946a172d07794 # hide
    "56qFsQMk" => 0x75bd349e96ec2895 # hide
    "rrLvC1sl" => 0x48ba49aa20723296 # hide
    "0J3wDxz3" => 0x31db22770b59da9e # hide
    "eUwDgCAr" => 0x62b122b268db119e # hide
    "1vVRBt06" => 0x2a3a37606b41c9a1 # hide
    "wuYJAkTX" => 0xdd1915dad749bea5 # hide
    "b4ET1nea" => 0xe0d88f5b5e615aaa # hide
    "pCAdNI3p" => 0xf9b350d7c2aba3ad # hide
    "s5NvIoAv" => 0x19785bc7a0f13fb0 # hide
    "Kd8XdbWV" => 0x1ed58934c9bd13b2 # hide
    "XwS9In6S" => 0xca3613a9a578e5b5 # hide
    "J7813Mim" => 0x58afbe2bd596c5b5 # hide
    "KGyYIo1f" => 0x1f79b9cf5823cdbc # hide
    "2XM7cDRk" => 0x1df074d2d99926bc # hide
    "s7B9JfDT" => 0x02ff03b836bcf0be # hide
    "Q7Vq45nU" => 0x2cd3928edfa65dbd # hide
    "r6ayWRY2" => 0x5c160a233045f6c4 # hide
    "aVRqUax9" => 0x8b3f63fc3ddd4fc6 # hide
    "zSKvRtSX" => 0x9a70ecafcc32bac8 # hide
    "dHffAhSl" => 0xe641514ba2612ecb # hide
    "hVFN36KV" => 0x464fd7dfc43e75cd # hide
    "Uej40HOK" => 0x394a6730da78bad2 # hide
    "0ZaQEEIH" => 0x01534364ca6b4bd4 # hide
    "NgtmIoyo" => 0x485a23d546aa67d6 # hide
    "DTzL90Al" => 0xa538c20e2265cdde # hide
    "DnMJh3dP" => 0x309da85e9cf16be0 # hide
    "M6PMJWij" => 0x4ffe5c8dbec96fe1 # hide
    "yPTJcDjn" => 0x39481cdda65ecfe2 # hide
    "yYE6SRi3" => 0xb672547cc87e99e7 # hide
    "GLJmiG6Q" => 0x3daec552781c35ee # hide
    "SE0nZfWb" => 0x5868b2a832e200f0 # hide
    "8RZMXqlW" => 0x4c67ff86cd5222f3 # hide
    "qChXRad1" => 0x5eabce048ffb1bf4 # hide
    "rSQRiljh" => 0x31da7fd2552b29f6 # hide
    "dKuWihQp" => 0xe53559731d9a42f7 # hide
    "KQHxjZOV" => 0x2cf1c371c316c3f8 # hide
    "mmtXJYJ6" => 0x4d96c0a3cd79e5f7 # hide
    "TzrnRE6G" => 0x381dc11f0a8fd9fb # hide
    "MOv5BbQr" => 0xb066ddea6f36acfb # hide
    "t1LilSmM" => 0x7b4ba8f7d284fafd
    _ => println("no maching string")
end
@benchmark $ex
```

<!--}}}-->

\show{snip7}

コード生成のハンディを考慮しても if-else より Julia の動的ディスパッチの方が速そうですね｡

## 追記

他にもパッケージを見つけたのでベンチマークを加えておきました｡

### [MLStyle.jl][4]

---

```julia:snip8
using MLStyle
ex = @macroexpand MLStyle.@match "t1LilSmM" begin
    "hIOtXvKt" => 0x5df0cb0a9308e200
    # 中略
    "jhOsBScf" => 0x49541fbf7bbc9402 # hide
    "zqWp4r2Q" => 0xc33ab95443563304 # hide
    "qx4Tg81C" => 0x448ec4e658abb307 # hide
    "C2Aa3Nak" => 0xe95b0e387f5b960a # hide
    "c8UNVn6g" => 0x8036899ee354550a # hide
    "Z6Uhv3xH" => 0xfa2283e808ac5110 # hide
    "j9uPe68V" => 0x0b7e0bf58b8ef412 # hide
    "0dkTde08" => 0xf519a60f8b609714 # hide
    "D2PdClmr" => 0x9ed1de9b23771f1d # hide
    "GW7bhQYN" => 0xb4b008c87f558a1f # hide
    "q7uyJTjp" => 0xc8f4a0989b3a3b20 # hide
    "msx4azuW" => 0xbe1fe9b648520222 # hide
    "3hwdBA5Y" => 0x7a8309aa16cee125 # hide
    "crEOPtGJ" => 0x1995d6f1ab0d0825 # hide
    "dfwH0hXm" => 0x5c184cb3f89c1227 # hide
    "6LKuZhDb" => 0xbc5abf60844cdb27 # hide
    "LjPWdVNy" => 0xdb55879c5f436528 # hide
    "1ytuu544" => 0x0adc281df2e9be2b # hide
    "HXXtw4uC" => 0x989e9d853250b32c # hide
    "08HG604H" => 0xb302065a81e3362d # hide
    "NkGb4LPy" => 0xeda9ebeb2908092b # hide
    "KHNqwO3Q" => 0x6e77d3980e51782b # hide
    "hwK0ptNG" => 0xb4e65efd6ac3aa33 # hide
    "uHGBCAUS" => 0x1a14579ce4a2ce3d # hide
    "FnnDohE4" => 0x2d0a0081f526443e # hide
    "VPZ7Z0pu" => 0xced524eb01772141 # hide
    "mI7b3Hvz" => 0x5cc9b2f1ad73af42 # hide
    "HZfQ14qh" => 0xc06b501b7f738447 # hide
    "gFUO1eEs" => 0x5819bd2161f54349 # hide
    "lLmyZYGK" => 0x5b5e000855c5124e # hide
    "fLDrD885" => 0x61032bb5337bd452 # hide
    "QWTZuLOQ" => 0xffe824de1474fa55 # hide
    "xtkA9add" => 0xe0af14f36bb43857 # hide
    "pTLywa2b" => 0x911eb7f7b882165b # hide
    "SbuxAotV" => 0x4d82f346cc71465f # hide
    "wp5ubpTc" => 0x30afbc1551c2f364 # hide
    "nHUsvw2B" => 0x305c9a0dc5eeec65 # hide
    "VDqplKSF" => 0x78e0c11238378664 # hide
    "Yh3SHlKK" => 0x3a28ddc063388e67 # hide
    "UCdj0uPU" => 0x564680ed123b1567 # hide
    "GJB95SbW" => 0x2f7854f55fcf326a # hide
    "OMrTb9ff" => 0x2e8e2c7fb23c716c # hide
    "PXAte63B" => 0x702c610d9249886d # hide
    "1lbhrT5d" => 0x3d3df5dfcc3b956e # hide
    "g7ejc7cy" => 0xd2206a0b46d69574 # hide
    "qsLJL1Mp" => 0x3727564ad65fd37a # hide
    "ilhVKGuZ" => 0x825bf91885e7b67d # hide
    "iOkTvlSc" => 0xe58145dd5e965c7f # hide
    "gVnXpEfR" => 0x32bd39416cbafd7f # hide
    "nCm3Y58a" => 0x763c580068319082 # hide
    "dP7w6tEp" => 0x62d21f410c622683 # hide
    "FRmOBDQR" => 0x326547c3874d5586 # hide
    "5WgxjS2e" => 0x7f97813fe2f39a88 # hide
    "RtymZBjy" => 0x4e275ec7c1bf188d # hide
    "GNeKMJHA" => 0xaad329ae6595578e # hide
    "4ee37QHC" => 0x5fd4c80d1f8a9d8e # hide
    "ei446lhI" => 0xf5e7a77c79d78291 # hide
    "fc7i5FtD" => 0xed184e23909f3f93 # hide
    "FcxE9b3E" => 0x843946a172d07794 # hide
    "56qFsQMk" => 0x75bd349e96ec2895 # hide
    "rrLvC1sl" => 0x48ba49aa20723296 # hide
    "0J3wDxz3" => 0x31db22770b59da9e # hide
    "eUwDgCAr" => 0x62b122b268db119e # hide
    "1vVRBt06" => 0x2a3a37606b41c9a1 # hide
    "wuYJAkTX" => 0xdd1915dad749bea5 # hide
    "b4ET1nea" => 0xe0d88f5b5e615aaa # hide
    "pCAdNI3p" => 0xf9b350d7c2aba3ad # hide
    "s5NvIoAv" => 0x19785bc7a0f13fb0 # hide
    "Kd8XdbWV" => 0x1ed58934c9bd13b2 # hide
    "XwS9In6S" => 0xca3613a9a578e5b5 # hide
    "J7813Mim" => 0x58afbe2bd596c5b5 # hide
    "KGyYIo1f" => 0x1f79b9cf5823cdbc # hide
    "2XM7cDRk" => 0x1df074d2d99926bc # hide
    "s7B9JfDT" => 0x02ff03b836bcf0be # hide
    "Q7Vq45nU" => 0x2cd3928edfa65dbd # hide
    "r6ayWRY2" => 0x5c160a233045f6c4 # hide
    "aVRqUax9" => 0x8b3f63fc3ddd4fc6 # hide
    "zSKvRtSX" => 0x9a70ecafcc32bac8 # hide
    "dHffAhSl" => 0xe641514ba2612ecb # hide
    "hVFN36KV" => 0x464fd7dfc43e75cd # hide
    "Uej40HOK" => 0x394a6730da78bad2 # hide
    "0ZaQEEIH" => 0x01534364ca6b4bd4 # hide
    "NgtmIoyo" => 0x485a23d546aa67d6 # hide
    "DTzL90Al" => 0xa538c20e2265cdde # hide
    "DnMJh3dP" => 0x309da85e9cf16be0 # hide
    "M6PMJWij" => 0x4ffe5c8dbec96fe1 # hide
    "yPTJcDjn" => 0x39481cdda65ecfe2 # hide
    "yYE6SRi3" => 0xb672547cc87e99e7 # hide
    "GLJmiG6Q" => 0x3daec552781c35ee # hide
    "SE0nZfWb" => 0x5868b2a832e200f0 # hide
    "8RZMXqlW" => 0x4c67ff86cd5222f3 # hide
    "qChXRad1" => 0x5eabce048ffb1bf4 # hide
    "rSQRiljh" => 0x31da7fd2552b29f6 # hide
    "dKuWihQp" => 0xe53559731d9a42f7 # hide
    "KQHxjZOV" => 0x2cf1c371c316c3f8 # hide
    "mmtXJYJ6" => 0x4d96c0a3cd79e5f7 # hide
    "TzrnRE6G" => 0x381dc11f0a8fd9fb # hide
    "MOv5BbQr" => 0xb066ddea6f36acfb # hide
    "t1LilSmM" => 0x7b4ba8f7d284fafd
end
@benchmark $ex
```

\show{snip7}

### [Rematch.jl][5]

```julia:snip8
using Rematch
ex = @macroexpand Rematch.@match "t1LilSmM" begin
    "hIOtXvKt" => 0x5df0cb0a9308e200
    # 中略
    "jhOsBScf" => 0x49541fbf7bbc9402 # hide
    "zqWp4r2Q" => 0xc33ab95443563304 # hide
    "qx4Tg81C" => 0x448ec4e658abb307 # hide
    "C2Aa3Nak" => 0xe95b0e387f5b960a # hide
    "c8UNVn6g" => 0x8036899ee354550a # hide
    "Z6Uhv3xH" => 0xfa2283e808ac5110 # hide
    "j9uPe68V" => 0x0b7e0bf58b8ef412 # hide
    "0dkTde08" => 0xf519a60f8b609714 # hide
    "D2PdClmr" => 0x9ed1de9b23771f1d # hide
    "GW7bhQYN" => 0xb4b008c87f558a1f # hide
    "q7uyJTjp" => 0xc8f4a0989b3a3b20 # hide
    "msx4azuW" => 0xbe1fe9b648520222 # hide
    "3hwdBA5Y" => 0x7a8309aa16cee125 # hide
    "crEOPtGJ" => 0x1995d6f1ab0d0825 # hide
    "dfwH0hXm" => 0x5c184cb3f89c1227 # hide
    "6LKuZhDb" => 0xbc5abf60844cdb27 # hide
    "LjPWdVNy" => 0xdb55879c5f436528 # hide
    "1ytuu544" => 0x0adc281df2e9be2b # hide
    "HXXtw4uC" => 0x989e9d853250b32c # hide
    "08HG604H" => 0xb302065a81e3362d # hide
    "NkGb4LPy" => 0xeda9ebeb2908092b # hide
    "KHNqwO3Q" => 0x6e77d3980e51782b # hide
    "hwK0ptNG" => 0xb4e65efd6ac3aa33 # hide
    "uHGBCAUS" => 0x1a14579ce4a2ce3d # hide
    "FnnDohE4" => 0x2d0a0081f526443e # hide
    "VPZ7Z0pu" => 0xced524eb01772141 # hide
    "mI7b3Hvz" => 0x5cc9b2f1ad73af42 # hide
    "HZfQ14qh" => 0xc06b501b7f738447 # hide
    "gFUO1eEs" => 0x5819bd2161f54349 # hide
    "lLmyZYGK" => 0x5b5e000855c5124e # hide
    "fLDrD885" => 0x61032bb5337bd452 # hide
    "QWTZuLOQ" => 0xffe824de1474fa55 # hide
    "xtkA9add" => 0xe0af14f36bb43857 # hide
    "pTLywa2b" => 0x911eb7f7b882165b # hide
    "SbuxAotV" => 0x4d82f346cc71465f # hide
    "wp5ubpTc" => 0x30afbc1551c2f364 # hide
    "nHUsvw2B" => 0x305c9a0dc5eeec65 # hide
    "VDqplKSF" => 0x78e0c11238378664 # hide
    "Yh3SHlKK" => 0x3a28ddc063388e67 # hide
    "UCdj0uPU" => 0x564680ed123b1567 # hide
    "GJB95SbW" => 0x2f7854f55fcf326a # hide
    "OMrTb9ff" => 0x2e8e2c7fb23c716c # hide
    "PXAte63B" => 0x702c610d9249886d # hide
    "1lbhrT5d" => 0x3d3df5dfcc3b956e # hide
    "g7ejc7cy" => 0xd2206a0b46d69574 # hide
    "qsLJL1Mp" => 0x3727564ad65fd37a # hide
    "ilhVKGuZ" => 0x825bf91885e7b67d # hide
    "iOkTvlSc" => 0xe58145dd5e965c7f # hide
    "gVnXpEfR" => 0x32bd39416cbafd7f # hide
    "nCm3Y58a" => 0x763c580068319082 # hide
    "dP7w6tEp" => 0x62d21f410c622683 # hide
    "FRmOBDQR" => 0x326547c3874d5586 # hide
    "5WgxjS2e" => 0x7f97813fe2f39a88 # hide
    "RtymZBjy" => 0x4e275ec7c1bf188d # hide
    "GNeKMJHA" => 0xaad329ae6595578e # hide
    "4ee37QHC" => 0x5fd4c80d1f8a9d8e # hide
    "ei446lhI" => 0xf5e7a77c79d78291 # hide
    "fc7i5FtD" => 0xed184e23909f3f93 # hide
    "FcxE9b3E" => 0x843946a172d07794 # hide
    "56qFsQMk" => 0x75bd349e96ec2895 # hide
    "rrLvC1sl" => 0x48ba49aa20723296 # hide
    "0J3wDxz3" => 0x31db22770b59da9e # hide
    "eUwDgCAr" => 0x62b122b268db119e # hide
    "1vVRBt06" => 0x2a3a37606b41c9a1 # hide
    "wuYJAkTX" => 0xdd1915dad749bea5 # hide
    "b4ET1nea" => 0xe0d88f5b5e615aaa # hide
    "pCAdNI3p" => 0xf9b350d7c2aba3ad # hide
    "s5NvIoAv" => 0x19785bc7a0f13fb0 # hide
    "Kd8XdbWV" => 0x1ed58934c9bd13b2 # hide
    "XwS9In6S" => 0xca3613a9a578e5b5 # hide
    "J7813Mim" => 0x58afbe2bd596c5b5 # hide
    "KGyYIo1f" => 0x1f79b9cf5823cdbc # hide
    "2XM7cDRk" => 0x1df074d2d99926bc # hide
    "s7B9JfDT" => 0x02ff03b836bcf0be # hide
    "Q7Vq45nU" => 0x2cd3928edfa65dbd # hide
    "r6ayWRY2" => 0x5c160a233045f6c4 # hide
    "aVRqUax9" => 0x8b3f63fc3ddd4fc6 # hide
    "zSKvRtSX" => 0x9a70ecafcc32bac8 # hide
    "dHffAhSl" => 0xe641514ba2612ecb # hide
    "hVFN36KV" => 0x464fd7dfc43e75cd # hide
    "Uej40HOK" => 0x394a6730da78bad2 # hide
    "0ZaQEEIH" => 0x01534364ca6b4bd4 # hide
    "NgtmIoyo" => 0x485a23d546aa67d6 # hide
    "DTzL90Al" => 0xa538c20e2265cdde # hide
    "DnMJh3dP" => 0x309da85e9cf16be0 # hide
    "M6PMJWij" => 0x4ffe5c8dbec96fe1 # hide
    "yPTJcDjn" => 0x39481cdda65ecfe2 # hide
    "yYE6SRi3" => 0xb672547cc87e99e7 # hide
    "GLJmiG6Q" => 0x3daec552781c35ee # hide
    "SE0nZfWb" => 0x5868b2a832e200f0 # hide
    "8RZMXqlW" => 0x4c67ff86cd5222f3 # hide
    "qChXRad1" => 0x5eabce048ffb1bf4 # hide
    "rSQRiljh" => 0x31da7fd2552b29f6 # hide
    "dKuWihQp" => 0xe53559731d9a42f7 # hide
    "KQHxjZOV" => 0x2cf1c371c316c3f8 # hide
    "mmtXJYJ6" => 0x4d96c0a3cd79e5f7 # hide
    "TzrnRE6G" => 0x381dc11f0a8fd9fb # hide
    "MOv5BbQr" => 0xb066ddea6f36acfb # hide
    "t1LilSmM" => 0x7b4ba8f7d284fafd
end
@benchmark $ex
```

\show{snip8}

[1]: https://github.com/kmsquire/Match.jl
[2]: http://kmsquire.github.io/Match.jl/latest/
[3]: https://docs.julialang.org/en/v1/base/base/#Base.Val
[4]: https://thautwarm.github.io/MLStyle.jl/latest/
[5]: https://github.com/RelationalAI-oss/Rematch.jl
