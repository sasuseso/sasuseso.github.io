Finite Automata
===============

\definition{finite automaton}{
Finite automaton is defined as 5-tuple $(Q, \Sigma, \delta, q_0, F)$ where
- $Q$: Finite set of states.($Q \ne \phi$)
- $\Sigma$: Input alphabet.
- $q_0$: Initial state.
- $F$: A set of final states.($F \subseteq Q$)
- $\delta$: Transition(mapping) function $Q\times\Sigma \rightarrow Q$.
  Determines the next state depending on current input.
}

Properties of Transition Function
---------------------------------

Let transition function $\delta: Q \times \Sigma \rightarrow Q$, and states $q
\in Q$, $a \in \Sigma^*$ then
- $\delta(q, \epsilon) = q$. The states of  FA are changed only by an input
  symbol.
- For all strings **w** and i/p symbol a, $\delta(q, aw) = \delta(delta(q, a),
  w)$


Representation of FA
--------------------
1. Transition diagram
2. Transition table

### Transition diagram
A transition graph has
1. Set of states as circles
    - Start state $q_0$ with arrow.
    - Final state by doble circle.
2. A finite set of transitions(edges) that shows how to go from one state to another state.

### Transition table
Tabular representation such
- Rows: states 
- Columns: input.
- Start state denoted by $\rightarrow$
- Final state denoted by $*$

\definition{deterministic FA}{
FA has unique transition in any state on an input symbol.\\
It represented as quintuple $M = (Q, \Sigma, \delta, q_0, F)$ where
- $Q$: A non-empty finite set of states.
- $\Sigma$: Input alphabet.
- $q_0$: Initial state.
- $F$: Set of final states
- $\delta$: transition function that takes a state and an input symbol, and
  returns output as state.($\delta: Q \times \Sigma \rightarrow Q$)
}

\definition{non-deterministic FA}{
FA has more than one transition on input symbol.
It represented as quintuple $M = (Q, \Sigma, \delta, q_0, F)$ where
- $Q$: Non-empty finite set of state.
- $\Sigma$: Input alphabet.
- $q_0$: Initial state.
- $F$: Set of final states.
- $\delta$: transition function that takes a state and an input symbol, and
  returns output as state.($\delta: Q \times \Sigma \rightarrow 2^Q$)
}

\theorem{equivalance of DFA and NFA}{
Let $L$ be a set accepted by a NFA. Then there exists a DFA that accepts $L$.
}{
Let $M = (Q, \Sigma, \delta, q_0, F)$ be a NFA accepting $L$. \\
Define DFA $M^1 = (Q^1, \Sigma^1, \delta^1, q_0^1, F^1)$ as below
- $Q^1 = 2^Q$ (e.g. $Q = \{A, B\}$ then $Q^1 = \{\phi, [A], [B], [AB]\}$
    - $[q_1,\dots,q_i] \in Q^1$ where $q_1 \in Q, \dots, q_i \in Q$
- $F^1$: All states such that $s \in Q^1$ and $s \in F$.(e.g. $F = \{B\}$ then $F^1 = \{[B], [AB]\}$)
- $q_0^1 = [q_0]$
- $\delta^1([q_1,\dots,q_i], a) = [P_1,\dots,P_i] \\ \iff \delta(\{q_1,\dots,q_i\}, a) = \{P_1,\dots,P_i\}$

Show that
$$ \delta^1(q_0^1, x) = [q_1,\dots,q_i] \iff \delta(q_0, x) = \{q_1,\dots,q_i\}$$

by induction on length of $x$.\\
Basis: When $|x| = 0$ then by definition $$\delta(q_0^1, \epsilon) = [q_0] \implies q_0^1 = [q_0]$$

Induction: Assume that the hypothesis is true for $|x| \leq m$. Let $xa$ to be string such $|xa| = m + 1$. then
$$\delta^1(q_0, xa) = \delta^1(\delta^1(q_0, x), a)$$
By inductive hypothesis
$$ \delta^1(q_0, x) = [P_1,\dots,P_j] \iff \delta(q_0, x) = \{P_1,\dots,P_j\}$$
by the definition of $\delta^1$
$$ \delta^1([P_1,\dots, P_j], a) = [r_1,\dots,r_k] $$

Thus
$$ \delta^1(q_0^1, xa) = [r_1,\dots, r_k] \iff \delta(q_0, xa) = \{r_1,\dots,r_k\}$$

Now prove $L(M) = L(M^1)$.\\
For $x$ in NFA, let $\delta(q_0, x) = P$ where $P \in F$. Then $\delta^1(q_0, x) = [P]$ where $[P] \in F^1$. Hence, the string x is accepted by DFA if it is accepted by NFA.

- Everty language that can be described by NFA can be described by some DFA.
- DFA in practice has more states than NFA.
- DFA equivalent to NFA can have at most $2^n$ states where as NFA has $n$ states.
}

Converting NFA to DFA
---------------------

Let $M_N= (Q_N, \Sigma_N, \delta_N, q_{0N}, F_N)$ be the NFA. Converting this to DFA, define $M_D$ as below.
1. $Q_D = 2^Q$: If $M_N$ has $n$ states, $M_D$ has at most $2^n$ states.
2. $\Sigma_N = \Sigma_D$
3. $[q_0] = \{q_N\}$
4. $F_D$: Set of all states of $Q_D$ that contains at least one of the final states of $F_N$.
5. $\delta((q_1, q_2, q_3), a) = \delta_N(q_1, a) \cup \delta_N(q_2, a) \cup \delta_N(q_3, a) = {P_1, P_2, P_3}$ say add the state $[P_1, P_2, P_3]$ to $Q_D$ if not there.

### To get simplified DFA
To eliminate unnecessary states
1. Start with the initial. Don't add all subset of states here.
2. After finding transition on this initial, include only the resultant states.
3. Declare the states as final if they have at least one final state of the NFA.

\definition{NFA with epsilon-moves}{
NFA with epsilon-moves is $M = (Q, \Sigma, \delta, q_0, F)$ \\
where $\delta: Q \times \Sigma \cup \{\epsilon\} \rightarrow 2^Q$
}

\definition{epsilon-closure}{
Epsilon closure is set of all states that can reach by $\epsilon$ input. Denoted as
- $\hat{\epsilon}(q)$
- $\epsilon$-closure (q)
}

\definition{transition function for NFA with epsilon-moves}{
Induction step for regular NFA:\\
- $\hat{\delta}(q, w) = \{p_1, \dots, p_k\}$
- $\hat{\delta}(p_i, a) = S_i$ for $i = 1, 2,\dots, k$.
to extend this, change the definition of $\hat{\delta}(q, wa)$ as:\\
$\hat{\delta}(q, wa) = \cup \hat{\epsilon}(S_1 \cup S_2 \cup \dots \cup S_k)$
}

## Converting NFA with $\epsilon$-transition to without
1. Find $\epsilon$-closure for each state.
2. Find the transition on each state for each element.

<!-- ## Converting NFA with $\epsilon$-transition to DFA -->

\definition{equivalent-class}{
Let $a \in \Sigma$ to be an alphabet in language sigma.
- *0-equivalent*: when both $\delta(q_1, a)$ and $\delta(q_2, a)$ are final states or non-final states for all $a$. 
    - Denoted as $q_1 \equiv q_2$
- *K-equivalent*: when both $\delta(q_1, x)$ and $\delta(q_2, x)$ are final
  states or non-final states for all $x$(string of alphabet in $\Sigma$)
  that has length $K$ or less. 
}

## Minimization of DFA

1. Construct 0-equivalance class by $\Pi_0 = \{Q_1^0, Q_2^0\}$ where
    - $Q_1^0$: set of final states
    - $Q_2^0$: set of non-final states
2. Construct $\Pi_{K+1}$ from $\Pi_K$ by partioning $\Pi_K$ further
    1. Let $Q_1^K \in \Pi_K$ and $q_1,q_2 \in Q_1^K$. Then if $\delta(q_1, a)$ and $\delta(q_2, a)$ are K-equivalent then $q_1$ and $q_2$ are (K+1)-equivalent.
    2. Check whether $\delta(q_1, a)$ and $\delta(q_2, a)$ are in the same equivalence class in $\Pi_K$ for every $a \in \Sigma$. If so $q_1$ and $q_2$ are (K + 1)-equivalent. This divide $Q_i^K$ into (K + 1)-equivalence classes. Repeat it for every $Q_i^K \in \Pi_K$ to get all elements of $\Pi_{K+1}$.
3. Construct $\Pi_n$ for $n = 1, 2,\dots$ until $\Pi_n = \Pi_{n+1}$.
4. Construct the minimum state DFA with the states obtained by equivalent classes $\Pi_n$.

\definition{moore-machine}{
A Moore machine is represented as a six-tuple $M = \{Q,\Sigma,\Delta,\delta,\lambda,q_0\}$ where
- $Q$: Set of finite states
- $\Sigma$: Set of finite input symbols
- $\Delta$: Set of finite output symbols
- $\delta$: A mapping function $Q\times\Sigma$ to $Q$.($\delta:Q\times\Sigma\rightarrow Q$)
- $\lambda$: A mapping function which maps $Q$ to $\Delta$.($Q\rightarrow\Delta$)
- $q_0$: The initial state
The *state* is associated with output. Whenever Moore machine enters any state, it generates an output.
}

\definition{mealy-machine}{
A Mealy machine is represented as a six-tuple $M = \{Q,\Sigma,\Delta,\delta,\lambda,q_0\}$ where
- $Q$: Set of finite states
- $\Sigma$: Set of finite input symbols
- $\Delta$: Set of finite output symbols
- $\delta$: A mapping function $Q\times\Sigma$ to $Q$.($\delta:Q\times\Sigma\rightarrow Q$)
- $\lambda$: A mapping function which maps $Q\times\Sigma$ to $\Delta$.($Q\times\Sigma\rightarrow\Delta$)
- $q_0$: The initial state
The *transition* is associated with output. Whenever Mealy machine enters any state on a particular input, it generates output.
}

\theorem{equivalance-between-moore-and-mealy-machines}{
1. If $M_1 = \{Q,\Sigma,\Delta,\lambda,q_0\}$ is a Moore machine, then there is a Mealy machine $M_2$ equivalent to $M_1$.
2. If $M_1 = \{Q,\Sigma,\Delta,\lambda,q_0\}$ is a Mealy machine, then there is a Moore machine $M_2$ equivalent to $M_1$.
}{
### 1. Moore machin to Mealy machine part
------------------------------------------
Let $M_1 = \{Q,\Sigma,\Delta,\lambda',q_0\}$ be a Mealy machine where
$$ \lambda'(q, a) = \lambda(\delta(q, a)) $$
Give input $x$ to $M_1$ that generates $q_1,\dots,q_n$ then the same sequence would be generated in $M_2$.

### 2. Mealy machine to Moore machine part
Let $M_2 = \{\{Q\times\Delta\},\Sigma,\Delta,\delta',\lambda',[q_0,b_0]\}$ where
- $b_0\in\Delta$
- states in $M_2$ be pairs $[q, b]$ where
    - $q\in Q$ and $b\in\Delta$.
- $\delta'([q,b],a) = [\delta(q,a),\lambda(q,a)]$
- $\lambda([q,b]) = b$
by induction
}

# Equivalence of two automata
1. When two FAs accept same set of strings over $\Sigma$ they are equivalent.
2. If two FAs are not equivalent, there are exists string $w$(over $\Sigma$) that one FA accepts and one not.
