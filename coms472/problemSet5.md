# Problem Set 5

Ben Nguyen

## 7.15 (15 pts)
Use resolution to prove the sentence ¬A∧¬B from the clauses in Exercise 7.25

Exercise 7.25
Convert the following set of sentences to clausal form.

1. S1: A⇔(B∨E).

(¬A∨(B∨E))∧(¬(B∨E)∨A)

(¬A∨B∨E)∧((¬B∧¬E)∨A)

(¬A∨B∨E)∧(¬B∨A)∧(¬E∨A)

2. S2: E⇒D.

¬E∨D

3. S3: C∧F⇒¬B.

¬(C∧F)∨¬B

¬C∨¬F∨¬B

4. S4: E⇒B.

¬E∨B

5. S5: B⇒F.

¬B∨F

6. S6: B⇒C.

¬B∨C

Give a trace of the execution of DPLL on the conjunction of these clauses.

Proof by Contradiction: ¬(¬A∧¬B) = A∨B

|||
|:---:|:---:|
| A∨B | ¬B∨A |
| A∨A | Simplify |
| A | ¬A∨B∨E |
| B∨E | ¬E∨B |
| B | ¬B∨C |
| C | ¬C∨¬F∨¬B |
| ¬F∨¬B | ¬B∨F |
| ¬B∨¬B | Simplify |
| ¬B | B |
| $\empty$ | |

Contradiction - B must be true because it is correct given the steps, then ¬B must also be true given the steps

## 7.16 (5+5+5 = 15 pts)
This exercise looks into the relationship between clauses and implication sentences.
1. Show that the clause $(¬P_1∨⋯∨¬P_m∨Q)$ is logically equivalent to the implication sentence $(P_1∧⋯∧P_m)⇒Q$.

$(¬P_1∨⋯∨¬P_m∨Q)$

$(¬(P_1)∨¬P_2∨⋯∨¬P_m∨Q)$

$(¬(P_1∧P_2)∨¬P_3∨⋯∨¬P_m∨Q)$

...

$(¬(P_1∧P_2∧⋯∧P_m)∨Q)$

$(P_1∧⋯∧P_m)⇒Q$

2. Show that every clause (regardless of the number of positive literals) can be written in the form $(P_1∧⋯∧P_m)⇒(Q_1∨⋯∨Q_n)$, where the P's and Q's are proposition symbols. A knowledge base consisting of such sentences is in implicative normal form or Kowalski form.

$(P_1∧⋯∧P_m)⇒(Q_1∨⋯∨Q_n)$,

$¬(P_1∧⋯∧P_m)∨(Q_1∨⋯∨Q_n)$,

$(¬P_1∨⋯∨¬P_m)∨(Q_1∨⋯∨Q_n)$,

$(¬P_1∨⋯∨¬P_m)∨(Q_1∨⋯∨Q_n)$,

3. Write down the full resolution rule for sentences in implicative normal form.

wtf is implicative normal form?????? do I have to know for test?

## 7.21 (3+4+3+3 = 13 pts)
A propositional 2-CNF expression is a conjunction of clauses, each containing exactly 2 literals, e.g.,

(A∨B)∧(¬A∨C)∧(¬B∨D)∧(¬C∨G)∧(¬D∨G).

1. Prove using resolution that the above sentence entails G.

(A∨B)

(¬A∨C)

(¬B∨D)

(¬C∨G)

(¬D∨G)

Proof by Contradiction: Assume ¬G

|||
|:---:|:---:|
|(¬G)|(¬C∨G)|
|(¬C)|(¬A∨C)|
|(¬A)|(A∨B)|
|(B)|(¬B∨G)|
|(G)|(¬G)|
|$\empty$||

2. Two clauses are semantically distinct if they are not logically equivalent. How many semantically distinct 2-CNF clauses can be constructed from n proposition symbols?

n=1 &rarr; 3

n=2 &rarr; 10

3. Using your answer to (b), prove that propositional resolution always terminates in time polynomial in n given a 2-CNF sentence containing no more than n distinct symbols.
4. Explain why your argument in c does not apply to 3-CNF.

## 7.22 (4+4+4 = 12 pts)
Prove each of the following assertions:
1. Every pair of propositional clauses either has no resolvents, or all their resolvents are logically equivalent.

Show that if one resolvent is true, all must be true

2. There is no clause that, when resolved with itself, yields (after factoring) the clause (¬P∨¬Q).
3. If a propositional clause C can be resolved with a copy of itself, it must be logically equivalent to True.

## 7.23 (5+5+5 = 15 pts)
Consider the following sentence:

[(Food⇒Party)∨(Drinks⇒Party)]⇒[(Food∧Drinks)⇒Party].

1. Determine, using enumeration, whether this sentence is valid, satisfiable (but not valid), or unsatisfiable.

Truth Table for everything

|Food|Party|Drinks|[(Food⇒Party)∨(Drinks⇒Party)]⇒[(Food∧Drinks)⇒Party]|
|:---:|:---:|:---:|:---:|
|T|T|T|T|
|T|T|F|T|
|T|F|T|T|
|T|F|F|T|
|F|T|T|T|
|F|T|F|T|
|F|F|T|T|
|F|F|F|T|

Since all possible valid inputs satisfy the sentence, it will work.

2. Convert the left-hand and right-hand sides of the main implication into CNF, showing each step, and explain how the results confirm your answer to (a).

[(Food⇒Party)∨(Drinks⇒Party)]⇒[(Food∧Drinks)⇒Party]

[(F⇒P)∨(D⇒P)]⇒[(F∧D)⇒P]

[(¬F∨P)∨(¬D∨P)]⇒[¬(F∧D)∨P]

[¬F∨P∨¬D∨P]⇒[¬(F∧D)∨P]

[¬F∨¬D∨P]⇒[¬(F∧D)∨P]

[¬(F∧D)∨P]⇒[¬(F∧D)∨P]

[¬F∨¬D∨P]⇒[¬F∨¬D∨P]

Therefore, this sentence is satisfiable because both sides compile down to the same CNF

3. Prove your answer to (a) using resolution.

??? what is resolution //TODO

## 7.26 (10 pts)
Convert the following set of sentences to clausal form.
Give a trace of the execution of DPLL on the conjunction of these clauses.

1. A⇔(B∨E).

(¬A∨(B∨E))∧(¬(B∨E)∨A)

(¬A∨B∨E)∧((¬B∧¬E)∨A)

(¬A∨B∨E)∧(¬B∨A)∧(¬E∨A)

2. E⇒D.

¬E∨D

3. C∧F⇒¬B.

¬(C∧F)∨¬B

¬C∨¬F∨¬B

4. E⇒B.

¬E∨B

5. B⇒F.

¬B∨F

6. B⇒C.

¬B∨C

```
function DPLL_Satisfiable(s) returns true or false
    inputs: s, a sentence in propositional logic
    clauses <- the set of clases in the CNF representation of s
    symbols <- a list of the proposition symbols in s
    return DPLL(clauses, symbols, {})

function DPLL(clauses, symbols, model) returns true or false
    if every clause in clauses is true in model then return true
    if some clause in clauses is false in model then return false
    P,value <- Find-Pure-Symbol(symbols, clauses, model)
    if P is non-null then return DPLL(clauses, symbols - P, model \union {P=value})
    P,value <- Find-Unit-Clause(clauses, model)
    if P is non-null then return DPLL(clauses, symbols - P, model \union {P=value})
    P <- First(symbols); rest <- Rest(symbols)
    return DPLL(clauses, rest, model \union {P=true}) or
        DPLL(clauses, rest, model \union {P=false}) or
```

