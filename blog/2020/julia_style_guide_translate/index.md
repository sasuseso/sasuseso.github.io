@def title = "Julia Style Guide (japanese)"
@def tags = ["julia"]

Julia Style Guide
=================

Juliaのスタイルガイドを和訳しました｡誤訳などありましたらTwitterのDMなどで教えて
頂けると助かります｡原文<https://docs.julialang.org/en/v1/manual/style-guide/index.html>  

以下はJuliaの慣用的なコーディングスタイルをまとめたものです｡このガイドは絶対で
はなくJulia言語の上達の助けであり,設計の幅を広げるための提案です｡


スクリプトとしてだけではなく関数をかく
--------------------------------------

Top-levelスコープにロジックを書きなぐれば問題自体は早く解決しますが,それらはで
きるだけ早く関数にまとめるべきです｡関数にすることで書かれている処理が明確になり
,再利用とテストが簡単になります｡更にJuliaのコンパイラによって関数内の処理は
top-levelのものより実行が高速になります｡また関数はできるだけ引数を取るように設
計してグローバル変数へのアクセスは押さえるべきです｡([pi][1]などの定数は例外)


不必要な型注釈を避ける
----------------------

コードは可能な限り一般化されるべきです
```julia
Complex{Float64}(x)
```
より↓のように書かれるべきです
```julia
complex(float(x))
```

[1]: https://docs.julialang.org/en/v1/base/numbers/#Base.MathConstants.pi
