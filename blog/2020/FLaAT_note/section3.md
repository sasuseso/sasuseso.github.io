Regular Expression and Reqular Grammers
========================================

\definition{regular-expression}{
Regular expression over alphabet $\Sigma$ is defined follows
- Any terminals or element of $\Sigma$ is RE
    - i.e $\phi, \epsilon, a\in\Sigma$
        - $\phi$ is RE and denotes the empty set.
        - $\epsilon$ is RE and denotes the set $\{\epsilon\}$
        - $a\in\Sigma$ is RE and denotes the set $\{a\}$
- Union of two RE is RE($R = R_1 + R_2$)
    - Let $a$ and $b$ be REs $a+b$ is RE has element $\{a, b\}$
- Concatenation of two RE($R_1 \cdot R_2)$ is RE.
    - Let $a$ and $b$ be REs $a\cdot b$ is RE has element $\{ab\}$
- Iteration of RE $R$ is RE.(denoted as $R^*$)
    - If $L$ is language represented by RE $R$ then *Kleene closure* of $L$ is denoted as $L^*$ 
        - $L^* = \displaystyle\bigcup_{i=0}^{n}{L^i}$
    - positive closure of $L$ is $L^+$
        - $L^+ = \displaystyle\bigcup_{i=1}^{n}{L^i}$
- If R is RE then $(R)*$ is also RE
}

\definition{regular set}{
Any set represented by a regular expression is *regular set*.
Let $a,b\in\Sigma$ then REs,
- $a$ denotes set $\{a\}$
- $a+b$ denotes the set $\{a, b\}$
- $ab$ denotes the set $\{ab\}$
- $a^*$ denotes the set $\{\epsilon,a,aa,\dots\}$
- $(a+b)^*$ denotes the set $\{\epsilon,a,b,aa,ab,ba,bb,aaa,\dots\}$
}
