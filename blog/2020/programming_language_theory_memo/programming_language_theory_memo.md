@def title = "プログラミング言語の基礎理論読書メモ"
<!--@def tags = [""]-->

プログラミング言語の基礎理論読書メモ
====================================

記法メモ
--------

A, Bは任意の集合とする｡

| 記法                                      | 定義                                                                                                                                                                              | 備考                   |
| :----------------:                        | :-------------------------------:                                                                                                                                                 | :------:               |
| $A \backslash B$                          | $\{x | x \in{A}, x \notin{B}\}$                                                                                                                                                   | 差集合                 |
| $A_1 \times A_2 \times \ldots \times A_n$ | $\{(a_1,\ldots,a_n) | a_i \in{A_i} (1 \leq i \leq n)\}$                                                                                                                           | 直積                   |
| $A^*$                                     | $a\in{A}$なる$a$の有限列｡必ず空列$\epsilon$を含む｡
| $ab$                                      | $a,b\in{A^*}$のとき$a$と$b$の連結｡$\epsilon$は連結操作における単位元となる｡
| $r$                                       | $A \times B$の部分集合                                                                                                                                                            | $A$と$B$の(二項)関係   |
| $a \> r \> b$                             | $(a, b)\in{r}$
| $a \> r \> a$                             |                                                                                                                                                                                   | 反射的                 |
| $r$は推移的                               | $a, b, c\in{A}$のとき$a \> r \> c \land b \> r \> c$
| $r^+(r^*),\overset{+}{r}(\overset{*}{r})$ | $r$を含み推移的かつ反射的な最小の関係                                                                                                                                             | $r$の推移的閉包        |
| $f : A \rightarrow B $                    | $f \subseteq  A \times B \land \\\forall a. (a\in{A} \rightarrow \exists b.((b \in{B} \land (a, b) \in{f}) \\\rightarrow ((a, b) \in{f} \land (a, c) \in{f} \rightarrow b = c)))$ | 集合$A$から$B$への関数 |
| $dom(f)$                                  |                                                                                                                                                                                   | 関数$f$の定義域        |
| $f(a),f a$                                |                                                                                                                                                                                   | $f$が写す$a$の値       |
| $\lambda a \in{A.X}$                      | 任意の$a\in{A}$に対して$f(a)$の値が$a$を含む式$X$で表される様な関数                                                                                                               |                        |
| $g \circ f$ | $\lambda x \in{A.g(f(x))}$ | $f : A \rightarrow B$と$f : B \rightarrow C$の合成 |
| $f(X)$ | $X \subseteq dom(f)$のとき集合$\{f(x)|x\in{X}\}$のこと | |
| $f|_X$ | $\{(a, b)|(a, b) \in{f}, a \in{X}\}$ | 関数$f$の$X$への制限 |
| $f|_{\overline{x}}$ | $f|_{dom(f)\backslash\{x\}}$
| $f\{x:v\}$ | $dom(f') = dom(f) \cup{\{x\}}$かつ$f'(y) =$ $\begin{cases} f(y) & (x \neq y のとき)\\ v & (x=yのとき) \end{cases}$ | ここでは$x \in{dom(f)}$である必要はない

その他定義など
--------------

