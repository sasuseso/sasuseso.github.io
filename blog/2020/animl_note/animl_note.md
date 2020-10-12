@def title = "A New Introduction to Modal Logic 読書メモ"
@def tags = ["logic", "reading note", "modal logic"]

# A New Introduction to Modal Logic 読書メモ

Using for convention operator $A =_{df} B$ as "A defined as B".

\definition{primitive operator negation sigin}{
Expression $\lnot A$ interpreted as "it's not the case that $A$".

truth-table of $\lnot$.

| in  | $\lnot$ |
| :-: | :-----: |
| $1$ |   $0$   |
| $0$ |   $1$   |

}

\definition{primitive operator or}{
Expression $A \lor B$ interpreted as "either $A$ or $B$".\\
truth-table of $\lor$.

| $\lor$ |  1  |  0  |
| :----- | :-: | :-: |
| 1      |  1  |  1  |
| 0      |  1  |  1  |

}

\definition{operator and}{
Let $\land$ to be
$$(\alpha \land \beta) =_{df} \lnot(\lnot \alpha \lor \lnot \beta)$$

truth-table is

| $\land$ |  1  |  0  |
| :-----: | :-: | :-: |
|    1    |  1  |  0  |
|    0    |  0  |  0  |

}

\definition{operator implies}{
Let $\implies$ to be
$$ (\alpha \implies \beta) =_{df} (\lnot \alpha \lor \lnot \beta)$$

truth-table is

| $\implies$ |  1  |  0  |
| :--------: | :-: | :-: |
|     1      |  1  |  0  |
|     0      |  1  |  1  |

}

\definition{operator iff sign}{
Let $\equiv$ to be
$$(\alpha \equiv \beta) =_{df} ((\alpha \implies \beta) \lor (\beta \implies \alpha))$$

truth-table is

| $\equiv$ |  1  |  0  |
| :------: | :-: | :-: |
|    1     |  1  |  0  |
|    0     |  0  |  1  |

}
