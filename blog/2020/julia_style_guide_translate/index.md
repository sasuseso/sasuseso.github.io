@def title = "Julia Style Guide (japanese)"
@def tags = ["julia"]

Julia Style Guide
=================

Juliaのスタイルガイドを和訳しました｡誤訳などありましたらTwitterのDMなどで教えて
頂けると助かります｡原文<https://docs.julialang.org/en/v1/manual/style-guide/index.html>  

以下はJuliaの慣用的なコーディングスタイルをまとめたものです｡このガイドは絶対で
はなくJulia言語の上達の助けであり,設計の幅を広げるための提案です｡


関数にまとめる
--------------

Top-levelスコープにロジックを書きなぐれば問題自体は早く解決しますが,それらはで
きるだけ早く関数にまとめるべきです｡関数にすることで書かれている処理が明確になり
,再利用とテストが簡単になります｡更にJuliaのコンパイラによって関数内の処理は
top-levelのものより実行が高速になります｡また関数はできるだけ引数を取るように設
計してグローバル変数へのアクセスは押さえるべきです｡([pi][1]などの定数は例外)


型を制限しすぎない
------------------

コードは可能な限り一般化されるべきです
```julia
Complex{Float64}(x)
```
上記より以下のように書かれるべきです
```julia
complex(float(x))
```
2つ目のコードは自動的に`x`を適切な型に変換します｡  

これは関数の引数についても言えます｡任意の整数を引数に取りたい場合`Int`や`Int32`
ではなく抽象型である`Integer`を使うべきです｡とは言えほとんどの場合関数の引数に
は型注釈をつける必要はありません｡指定された型を引数に取るメソッドが宣言されてい
なければ`MethodError`が投げられます｡

以下は例です｡`addone`は与えられた数値型の1と引数の和を返します｡
```julia
addone(x::Int) = x + 1
addone(x::Integer) = x + oneunit(x)
addone(x::Number) = x + oneunit(x)
addone(x) = x + oneunit(x)
```
`addone`は`oneunit`がサポートするすべての型を受け付けます｡


[1]: https://docs.julialang.org/en/v1/base/numbers/#Base.MathConstants.pi
