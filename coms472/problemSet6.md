8.11 (7 X 2 = 14 pts)

Consider a vocabulary with the following symbols:
- Occupation(p,o): Predicate. Person p has occupation o.
- Customer(p1,p2): Predicate. Person p1 is a customer of person p2.
- Boss(p1,p2): Predicate. Person p1 is a boss of person p2.
- Doctor, Surgeon, Lawyer, Actor: Constants denoting occupations.
- Emily, Joe: Constants denoting people. Use these symbols to write the following assertions in first-order logic:
1. Emily is either a surgeon or a lawyer.
2. Joe is an actor, but he also holds another job.
3. All surgeons are doctors.
4. Joe does not have a lawyer (i.e., is not a customer of any lawyer).
5. Emily has a boss who is a lawyer.
6. There exists a lawyer all of whose customers are doctors.
7. Every surgeon has a lawyer.

8.23 (5 X 2 = 10 pts)

Assuming predicates Parent(p,q) and Female(p) and constants Joan and Kevin, with the obvious meanings, express each of the following sentences in first-order logic. (You may use the abbreviation ∃1 to mean “there exists exactly one.”)
1. Joan has a daughter (possibly more than one, and possibly sons as well).
2. Joan has exactly one daughter (but may have sons as well).
3. Joan has exactly one child, a daughter.
4. Joan and Kevin have exactly one child together.
5. Joan has at least one child with Kevin, and no children with anyone else.

8.29 (3 X 3 = 9 pts)

For each of the following sentences in English, decide if the accompanying first-order logic sentence is a good translation. If not, explain why not and correct it.
1. Any apartment in London has lower rent than some apartments in Paris.
∀x[Apt(x)∧In(x,London)]⟹∃y([Apt(y)∧In(y,Paris)]⟹(Rent(x)<Rent(y)))
2. There is exactly one apartment in Paris with rent below $1000.
∃xApt(x)∧In(x,Paris)∧∀y[Apt(y)∧In(y,Paris)∧(Rent(y)<Dollars(1000))]⟹(y=x)
3. If an apartment is more expensive than all apartments in London, it must be in Moscow.
∀xApt(x)∧[∀yApt(y)∧In(y,London)∧(Rent(x)>Rent(y))]⟹In(x,Moscow).

9.4  (4 X 3 = 12 pts)

For each pair of atomic sentences, give the most general unifier if it exists:
1. P(A,B,B), P(x,y,z).
2. Q(y,G(A,B)), Q(G(x,x),y).
3. Older(Father(y),y), Older(Father(x),John).
4. Knows(Father(y),y), Knows(x,x).

9.9  (5 X 2 = 10 pts)

This question considers Horn KBs, such as the following:
P(F(x))⇒P(x)Q(x)⇒P(F(x))P(A)Q(B)
Let FC be a breadth-first forward-chaining algorithm that repeatedly adds all consequences of currently satisfied rules; let BC be a depth-first left-to-right backward-chaining algorithm that tries clauses in the order given in the KB. Which of the following are true?
1. FC will infer the literal Q(A).
2. FC will infer the literal P(B).
3. If FC has failed to infer a given literal, then it is not entailed by the KB.
4. BC will return true given the query P(B).
5. If BC does not return true given a query literal, then it is not entailed by the KB.

9.24 (2 + 3 + 4 = 9 pts)

Let L be the first-order language with a single predicate S(p,q), meaning “p shaves  q.” Assume a domain of people.
1. Consider the sentence “There exists a person P who shaves every one who does not shave themselves, and only people that do not shave themselves.” Express this in L.
2. Convert the sentence in (a) to clausal form.
3. Construct a resolution proof to show that the clauses in (b) are inherently inconsistent. (Note: you do not need any additional axioms.)

9.29 (2 + 2 + 2 + 2 + 2 + 3 + 3 = 16 pts)

Here are two sentences in the language of first-order logic:
- (A) ∀x∃y(x≥y) - (B) ∃y∀x(x≥y) 1. Assume that the variables range over all the natural numbers 0,1,2,…,∞ and that the “≥” predicate means “is greater than or equal to.” Under this interpretation, translate (A) and (B) into English.
2. Is (A) true under this interpretation?
3. Is (B) true under this interpretation?
4. Does (A) logically entail (B)?
5. Does (B) logically entail (A)?
6. Using resolution, try to prove that (A) follows from (B). Do this even if you think that (B) does not logically entail (A); continue until the proof breaks down and you cannot proceed (if it does break down). Show the unifying substitution for each resolution step. If the proof fails, explain exactly where, how, and why it breaks down.
7. Now try to prove that (B) follows from (A).
