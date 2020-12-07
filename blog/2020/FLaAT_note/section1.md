# Mathematical Preliminaries and Formal Languages

\definition{Set}{
Set is defined as collection of objects.
- *Elements* are enclosed within brackets ${}$.
If $A$ is a set.
- $a \in A$ if $a$ is a element of $A$.
- $a \notin A$ if not.
A set with only one element is called *sngleton*.
}

Describing set
--------------
1. by listing all elements.(*list notion*)
2. by stating a property of its elements.(*predicate notion*, general form: $\{x|P(x)\}$)
3. by defining a set of rules that generates its elements.(*recursibe rules*)

### Recursive rules
Usually have
- Basis
- Recursion(generates elements from defined one)
- Restriction such like "Nothing else belongs to the set".
\\

\definition{Empty set}{
A set having no element in it.
Denoted by
- $A = \{\}$
- $\phi$
$|\epsilon| = 0 |\phi| = 1$ as empty string is present.
}

\definition{Identity between sets}{
Two sets are identical *iff* they have same members.\\
$A = B$ iff for every $x$, $x \in A \iff x \in B$.
}

\definition{cardinality of set}{
The number of elements in a set.\\
If $A$ is a set cardinality denoted as $|A|$.Cardinality of finite set is natural number.
}

\definition{subset}{
$A$ is *subset* of $B$ iff every element of A is also an element of B.\\
It denoted as $A \subseteq B$.
If $A \subseteq B$ and $A \neq B$ are both true, then we can denote as
$A\subset B$ and call it *proper subset* of $B$.
Empty set is subset of all sets.
}

\definition{power set}{
Power set of $A$ is set of all subset of $A$.
Power set of $A$ is denoted as
- $\wp(A)$
- $2^A$
}

\definition{operation on sets}{
*union*
$$A \cup B = \{x| x \in A \space or \space b \in B\}$$

*intersection*
$$A \cap B = \{x| x \in A \space and \space x \in B\}$$

*complement*
$$A' = \{x | x \notin A\}$$

*difference*(or *relative complement* of $B$  *relattive* to A)
$$A - B = \{x| x \in A \space and \space x \notin B\}$$
}

\definition{sequence}{
Same as set but
- order is important
- repetition is not allowed.
Sequence has K elements is called K-tuple.
}

\definition{ordered set}{
An ordered pair which has $a$ as the *first member* and $b$ as the *second
member*, is denoted as
$$\langle a, b \rangle$$
and can be defined as a set
$$ \langle a, b \rangle =_{def} \{\{a\}, \{a, b\}\} $$
}

\definition{cartesian product}{
The Cartesian product of two sets $A$ and $B$ is a set of all possible pairs first member from $A$ and second from $B$.
$$ A \space X \space B = \{(a, b) | a \in A \land b \in B\}$$
}

\definition{relations}{
When a bears $a$ relation $R$ to $b$
- $Rab$
- $aRb$

Relations formalized as sets of ordered pairs of elements.
$$\langle a, b \rangle \in R$$
}

Representation of relations
---------------------------

There are twe ways
1. As matrix
2. As graph

### Representing as Matrix

Let $R$ be a relation on sets $A$ and $B$. $A$ and $B$ has $m$ and $n$ elements. Then we can define relation matrix has $m \times n$ elements.
> $ M_{i,j} = 0$ if $R \notin (x_i, y_j)$. 1 if $R \in (x_i, y_j)$.

### Representing as a Graph
Let $R$ be a relation on set $X$. If $X$ has $n$ elements, then the graph will have $n$ nodes. The edges in the graph indecate the relation R.
```julia:snip
using GraphPlot, Compose, LightGraphs # hide
import Cairo, Fontconfig # hide
g = SimpleDiGraph(3)
nl = ["q", "p", "r"]
add_edge!(g, 1, 1)
add_edge!(g, 2, 1)
add_edge!(g, 2, 3)

draw(PNG(joinpath(@OUTPUT, "graph.png"), 16cm, 12cm), gplot(g, nodelabel=nl, arrowlengthfrac=0.1)) # hide
```
\show{snip}
\fig{graph}

\definition{binary relation}{
Let $A$ and $B$ are sets and $R \subset A \times B$.
Then $R$ is a *binary relation* from $A$ to $B$.
A relation $R \subset A \times A$ is called a relation *in* or *on* $A$.
}

\definition{domain of relation}{
**dom** $R = \{a | \forall a.\forall b.\langle a, b \rangle \in R\}$
}

\definition{range of relation}{
**range** $R = \{b | \forall b.\forall a. \langle a, b \rangle \in R\}$
}

\definition{operations on relations}{
Let $R$ be a relation $R \subset A \times B$. \\
*complement*
$$ R' = (A \times B) - R $$

*inverse*
$$ R^{-1} \subset B \times A $$
}

\definition{properties of relations}{
Let $R$ be a relation.\\
1. *reflexive*
   If for each $a \in A$ holds $aRa$, $R$ is reflexive.\\
2. *irreflexive*
   If for each $a \in A$ not holds $aRa$, $R$ is irreflexive.
3. *symmetric*
   If $R$ is relation on $A$ and $iRj$ implies $jRi$, $R$ is symmetric.
4. anti*symmetric*
   If $R$ is relation on $A$ and $iRj$ not implies $jRi$, $R$ is antisymmetric.
5. *transitive*
   If $R$ is relation on $A$ and "if given $aRb$ and $bRc$ then $aRc$" holds, then  R is transitive.
5. *equivalant* If $R$ is reflexive, symmetric and transitive on set $S$, then $R$ is equivalant relation.
}

\definition{function}{
A relation $F$ from $A$ to $B$ is function from $A$ to $B$ iff satisfies following\\
1. $(\langle a, b \rangle \in F) \land (\langle a, c \rangle \in F) \implies b = c$
2. $dom \space F = A$

- Function from $A$ to $B$ is denoted as $F: A \rightarrow B$.\\
- Elements of domain of function is called *arguments*.
- Elements of range of function is called *values*.
}

\definition{types of functions}{
Let $F$ to be a function. $F: A \rightarrow B$
1. *one-to-one function*(or *injection*)
   No member of $B$ is assgined to more than one member of $A$.
2. *many-to-one function* 
   Many-to-one correspondence between the elements of $A$ and $B$.
3. *onto function*
   Every element of $B$ has at least one correspondence from member of $A$.\\
   If the function is both one-to-one and onto then is called *bijection.*\\
   If the function is both many-to-one and onto then is called *surjection*
4. *into function*
   There are at least one element that has no correspondence from $A$ in elements in $B$.
}

\definition{function composition}{
Let $F$ and $G$ be functions such as $F: A \rightarrow B$, $G: B \rightarrow C$. Then composition of $F$ and $G$ is defined as
$$ G \space O \space F = \{\langle x, z \rangle | \forall x.\forall z.\exists y.(\langle x, y \rangle \in F \land \langle y, z \rangle \in G)\}$$
}

\definition{symbol and alphabet}{
Symbol is an abstract entity.
}

\definition{alphabet}{
Finite collection of symbols denoted by $\Sigma$.
}

\definition{string and word}{
A set of symbols from alphabet.
*word* anything constructed from $\Sigma$. The set of all words over $\Sigma$ is denoted as $\Sigma^*$.\\
Empty word denoted with $\Lambda$ or $\epsilon$.
- Prefix of any string is any number of leading symbols of string.
- Suffix of any string is any number of trailing symbols of string.
- Proper substring is any substring except string itself.

*Language* is a set of words or sentences.
}

\definition{operations on language}{
1. *Union* union of two langage is denoted as $L_1 + L_2$ or $L_1$ U $L_2$.
2. *Concatenation* Concatenation of two language is denoted as $L_1 L_2$.
3. *Kleene's closure* $\Sigma^*$ the language consisting of all words that are concatenations of 0 or more words in the original language.
}

\definition{grammers}{
Grammer is 4-tuple $(V, T, P, S)$
where
- $V$: A set of non-terminals(variables)
- $T$: A set of terminals(primitive symbols)
- $P$: A set of productions (rules) that relate the non_terminals and terminals.
- $S$: start symbol.

}

\definition{chomsky's hierarchy}{
1. *Unrestricted grammars*(URG): Every grammar that has at least one non-terminal on the LHS is included. Production rules are form of $\alpha \rightarrow \beta$ where $\alpha$ and $\beta$ has any number of terminals and non-terminals.
2. *Context-sensitive grammars*(CSG): Same as URG but length of $\alpha$ is less than or equals to $\beta$(i.e. $|\alpha| \leq |\beta|$)
3. *Context-free grammar*(CFG): Same as CSG but $|\alpha| = 1$ and $\alpha$ is non-terminal.
4. *Regular grammars*(RG): RG restricts its rule to be LHS is single non-terminal and RHS is either a single terminal or string of terminals with single non-terminal on left or right end.

| Grammar   | Language               | Automaton              | Production rules                                                                         |
| :-------- | :---------             | :----------            | :-----------------                                                                       |
| URG       | Recursively enumerable | Turing machin          | $\alpha \rightarrow \beta$                                                               |
| CSG       | Context-sensitive      | Liner bounded automata | $\alpha \rightarrow \beta$, $  |\alpha|  \leq  |\beta| $                                 |
| CFG       | Context-free           | Pushdown automaton     | $\alpha \rightarrow \beta$, $|\alpha| = 1$                                               |
| RG        | Regular                | Finite state automata  | $\alpha \rightarrow \beta$, $\alpha = \{V\}$ and\\$\beta = V\{T\}*$ or $\{T\}*V$ or $T*$ |
}

\definition{graph}{
*graph* $G$ is a pair $(V, E)$ where
- $V$: A finite set
- $E$: A relation on $V$

*nodes*(*vertices*): elements of $V$.\\
*edges*(*arcs*): elements of $E$.

If $\langle u, v \rangle \in E$ ($\langle u,v \rangle$ is an *edge*)
- $u$ is a *predecessor* of $v$.
- $v$ is a *successor* of $u$.
\\
- *path*: sequence $v_1, \dots ,v_n$ of nodes such $v_i$ is is a successor of $v_{i-1}$ for $i = 2,\dots,n$.
- *cycle path*: path such that $n > 1 \land v_n = v_1$.
- *subgraph*: Let $G_1 = (V_1, E_1)$,$G_2 = (V_1, E_1)$. $G_1$ is a subgraph of $G_2$ if $V_1 \subset V_2$ and $E_1 \subset E_2$.
}

\definition{directed graph}{
Graphs that edges are given by ordered pair.
}

\definition{degree of graph node}{
*Degree* of a graph node:
- undirected graph: Number of edges connected to the vertex.
- directed graph:
  - *Indegree*: Number of edges entering to the vertex.
  - *Outdegree*: Number of edges outgoing from the vertex.
- Self loop is counted twice.(in both directed and undirected graphs)
}

\definition{tree}{
Tree is a collection of vertices and edges which
- has one *root* node such that
    - has no predecessor.
    - has path to every vertex in the collection.
- from this root node, all the successors are ordered from the left.
\\
- *child*: successor vertex
- *parent*: predecessor vertex
- if there is path from $V_1$ to $V_2$
    - $V_1$ is *ancestor* to $V_2$
    - $V_2$ is *descendant* to $V_1$
- *leaf node*: a vertex has no children.
- *interior nodes*: a vertex that isn't leaf node.
}

\definition{binary tree}{
A tree that each nodes has at most two children. 
- *depth*: length of path from root.
- *height*: maximum depth of the tree.
- *complete binary tree*: binary tree which has $2^K$ nodes at every depth $K$ where $K < height$.
}
