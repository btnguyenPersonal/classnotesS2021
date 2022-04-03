# Problem Set 5

Ben Nguyen

## 7.15 (15 pts)
Use resolution to prove the sentence ¬A∧¬B¬A∧¬B from the clauses in Exercise 7.25
## 7.16 (5+5+5 = 15 pts)
This exercise looks into the relationship between clauses and implication sentences.
1. Show that the clause 

$(¬P1∨⋯∨¬Pm∨Q)(¬P1∨⋯∨¬Pm∨Q)$

is logically equivalent to the implication sentence 

$(P1∧⋯∧Pm)⇒Q(P1∧⋯∧Pm)⇒Q$.

2. Show that every clause (regardless of the number of positive literals) can be written in the form $(P1∧⋯∧Pm)⇒(Q1∨⋯∨Qn)(P1∧⋯∧Pm)⇒(Q1∨⋯∨Qn)$, where the PPs and QQs are proposition symbols. A knowledge base consisting of such sentences is in implicative normal form or Kowalski form Kowalski:1979.
3. Write down the full resolution rule for sentences in implicative normal form.
## 7.21 (3+4+3+3 = 13 pts)
A propositional 2-CNF expression is a conjunction of clauses, each containing exactly 2 literals, e.g.,

(A∨B)∧(¬A∨C)∧(¬B∨D)∧(¬C∨G)∧(¬D∨G).

1. Prove using resolution that the above sentence entails GG.
2. Two clauses are semantically distinct if they are not logically equivalent. How many semantically distinct 2-CNF clauses can be constructed from nn proposition symbols?
3. Using your answer to (b), prove that propositional resolution always terminates in time polynomial in nn given a 2-CNF sentence containing no more than nn distinct symbols.
4. Explain why your argument in (c) does not apply to 3-CNF.
## 7.22 (4+4+4 = 12 pts)
Prove each of the following assertions:
1. Every pair of propositional clauses either has no resolvents, or all their resolvents are logically equivalent.
2. There is no clause that, when resolved with itself, yields (after factoring) the clause (¬P∨¬Q)(¬P∨¬Q).
3. If a propositional clause CC can be resolved with a copy of itself, it must be logically equivalent to TrueTrue.
## 7.23 (5+5+5 = 15 pts)
Consider the following sentence:
[(Food⇒Party)∨(Drinks⇒Party)]⇒[(Food∧Drinks)⇒Party].
[(Food⇒Party)∨(Drinks⇒Party)]⇒[(Food∧Drinks)⇒Party].
1. Determine, using enumeration, whether this sentence is valid, satisfiable (but not valid), or unsatisfiable.
2. Convert the left-hand and right-hand sides of the main implication into CNF, showing each step, and explain how the results confirm your answer to (a).
3. Prove your answer to (a) using resolution.
## 7.26 (10 pts)
Convert the following set of sentences to clausal form.
1. S1: A⇔(B∨E)A⇔(B∨E).
2. S2: E⇒DE⇒D.
3. S3: C∧F⇒¬BC∧F⇒¬B.
4. S4: E⇒BE⇒B.
5. S5: B⇒FB⇒F.
6. S6: B⇒CB⇒C
Give a trace of the execution of DPLL on the conjunction of these clauses.
