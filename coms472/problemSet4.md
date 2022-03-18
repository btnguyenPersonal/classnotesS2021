
Com S 472/572 Spring 2022
Problem Set 4 (65 pts)

Due at 11:59pm 
Thursday, Mar 24

All exercises are from https://aimacode.github.io/aima-exercises/


6.1 (5 pts)

How many solutions are there for the map-coloring problem in Figure 6.1? How many solutions if four colors are allowed? Two colors?

---

![](../pic/australia-figure.png)

---

6.6 (10 pts)

Show how a single ternary constraint such as $A+B=C$ can be turned into three binary constraints by using an auxiliary variable. You may assume finite domains. (*Hint:* Consider a new variable that takes on values that are pairs of other values, and consider constraints such as $X$ is the first element of the pair $Y$.) Next, show how constraints with more than three variables can be treated similarly. Finally, show how unary constraints can be eliminated by altering the domains of variables. This completes the demonstration that any CSP can be transformed into a CSP with only binary constraints.

6.11 (10 pts)

- partial assignment {WA = green, V = red}

- Use the AC-3 algorithm to show that arc consistency can detect the inconsistency of the partial assignment green, red for the problem shown in Figure 6.1.

6.20 (2+2+2+2=8 pts)

Consider the problem of tiling a surface (completely and exactly covering it) with n dominoes (2×1 rectangles). The surface is an arbitrary edge-connected (i.e., adjacent along an edge, not just a corner) collection of 2n 1×1 squares (e.g., a checkerboard, a checkerboard with some squares missing, a 10×1 row of squares, etc.).
1. Formulate this problem precisely as a CSP where the dominoes are the variables.
2. Formulate this problem precisely as a CSP where the squares are the variables, keeping the state space as small as possible. (*Hint:* does it matter which particular domino goes on a given pair of squares?)
3. Construct a surface consisting of 6 squares such that your CSP formulation from part (b) has a *tree-structured* constraint graph.
4. Describe exactly the set of solvable instances that have a tree-structured constraint graph.

7.4 (12 X 1 = 12 pts) 

Which of the following are correct?
1. False⊨True.
2. True⊨False.
3. (A∧B)⊨(A⇔B).
4. A⇔B⊨A∨B.
5. A⇔B⊨¬A∨B.
6. (A∧B)⇒C⊨(A⇒C)∨(B⇒C).
7. (C∨(¬A∧¬B))≡((A⇒C)∧(B⇒C)).
8. (A∨B)∧(¬C∨¬D∨E)⊨(A∨B).
9. (A∨B)∧(¬C∨¬D∨E)⊨(A∨B)∧(¬D∨E).
10. (A∨B)∧¬(A⇒B) is satisfiable.
11. (A⇔B)∧(¬A∨B) is satisfiable.
12. (A⇔B)⇔C has the same number of models as (A⇔B) for any fixed set of proposition symbols that includes A, B, C.

7.6a, b, e (4+3+3 = 10 pts)

Prove each of the following assertions:
1. α is valid if and only if True⊨α.
2. For any α, False⊨α.
5. α⊨β if and only if the sentence (α∧¬β) is unsatisfiable.

7.7 (2+4+4 = 10 pts)

Prove, or find a counterexample to, each of the following assertions:
1. If α⊨γ or β⊨γ (or both) then (α∧β)⊨γ
2. If (α∧β)⊨γ then α⊨γ or β⊨γ (or both).
3. If α⊨(β∨γ) then α⊨β or α⊨γ (or both).