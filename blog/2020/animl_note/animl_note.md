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
Let $\longrightarrow$ to be
$$ (\alpha \longrightarrow \beta) =_{df} (\lnot \alpha \lor \lnot \beta)$$

truth-table is

| $\longrightarrow$ |  1  |  0  |
| :---------------: | :-: | :-: |
|         1         |  1  |  0  |
|         0         |  1  |  1  |

}

\definition{operator iff sign}{
Let $\equiv$ to be
$$(\alpha \equiv \beta) =_{df} ((\alpha \longrightarrow \beta) \lor (\beta \longrightarrow \alpha))$$

truth-table is

| $\equiv$ |  1  |  0  |
| :------: | :-: | :-: |
|    1     |  1  |  0  |
|    0     |  0  |  1  |

}

\definition{primitive operator necessity}{
Let $L \alpha$ to be mean "must be $\alpha$".
}

\definition{operator possibility}{
Let $M \alpha$ to be mean "possibly $\alpha$".
}

The language of propositional modal logic(PML) consist of aforementioned operator
and brackets and infinity number of letters($p$, $q$, $r$...).

\definition{formation rules of PML}{
FR1: A propositional variable is a wff.\\
FR2: If $\alpha$ is a wff, so are $\lnot \alpha$ and $L \alpha$.\\
FR3: If $\alpha$ and $\beta$ are wff, so is $(\alpha \lor \beta)$.
}

\definition{K system}{
Define K system's axioms as all wff satisfying following conditions.\\

PC: If $\alpha$ is a valid wff of PC, then $\alpha$ is an axiom.\\

K: $L(p \longrightarrow q) \longrightarrow (L p \longrightarrow L q)$\\

And its transformation rules are following.

US(_Uniform Substituation_): The the result of uniformly replacing any variable
or variables $p_1$, $p_2$, $p_3$,... in the theorem by any wff $\beta_1$,
$\beta_2$, $\beta_3$,... is respectively is itself a theorem.

MP(_Modus Ponens_ or _Detachment_): If $\alpha$ and $\alpha \longrightarrow
\beta$ are theorems, so is $\beta$.

N(_Necessitation_): If $\alpha$ is a theorem, so is $L\alpha$.

}
