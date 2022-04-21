8.11 (7 X 2 = 14 pts)

Consider a vocabulary with the following symbols:
- Occupation(p,o): Predicate. Person p has occupation o.
- Customer(p1,p2): Predicate. Person p1 is a customer of person p2.
- Boss(p1,p2): Predicate. Person p1 is a boss of person p2.
- Doctor, Surgeon, Lawyer, Actor: Constants denoting occupations.
- Emily, Joe: Constants denoting people. Use these symbols to write the following assertions in first-order logic:
1. Emily is either a surgeon or a lawyer.

Occupation(Emily, Surgeon) &or; Occupation(Emily, Lawyer)

2. Joe is an actor, but he also holds another job.

∃x Occupation(Joe, Actor) &and; Occupation(Joe, x) &and; x $\neq$ Actor

3. All surgeons are doctors.

∀x Occupation(x, Surgeon) ⟹ Occupation(x, Doctor)

4. Joe does not have a lawyer (i.e., is not a customer of any lawyer)

$\neg$ ∃x Customer(Joe, x) &and; Occupation(x, Lawyer)

5. Emily has a boss who is a lawyer.

∃x Boss(x, Emily) &and; Occupation(x, Lawyer)

6. There exists a lawyer all of whose customers are doctors.

∃x Occupation(x, Lawyer) &and; ∀y Customer(y, x) &and; Occupation(y, Doctor)

7. Every surgeon has a lawyer.

∀x Occupation(x, Surgeon) ⟹ ∃y Customer(x, y) &and; Occupation(y, Lawyer)

8.23 (5 X 2 = 10 pts)

Assuming predicates

- Parent( p,q )
- Female( p )

and constants Joan and Kevin, with the obvious meanings, express each of the following sentences in first-order logic. (You may use the abbreviation ∃1 to mean “there exists exactly one.”)

1. Joan has a daughter (possibly more than one, and possibly sons as well).

∃x Parent(Joan, x) &and; Female(x)

2. Joan has exactly one daughter (but may have sons as well).

∃1x Parent(Joan, x) &and; Female(x)

3. Joan has exactly one child, a daughter.

∃1y Parent(Joan, y) &and; Female(y) &and; $\neg$∃x Parent(Joan, x) &and; $\neg$ Female(x)

4. Joan and Kevin have exactly one child together.

∃1x Parent(Joan, x) &and; Parent(Kevin, x)

5. Joan has at least one child with Kevin, and no children with anyone else.

∃x Parent(Joan, x) &and; Parent(Kevin, x) &and; $\neg$∃y,c Parent(Joan, c) &and; Parent(y, c) &and; y $\neq$ Kevin

8.29 (3 X 3 = 9 pts)

For each of the following sentences in English, decide if the accompanying first-order logic sentence is a good translation. If not, explain why not and correct it.
1. Any apartment in London has lower rent than some apartments in Paris.
∀x[Apt(x)∧In(x,London)]⟹∃y([Apt(y)∧In(y,Paris)]⟹(Rent(x)\<Rent(y)))

Not true, the language "some apartments" implies that there are more than one apartment, but the formal argument makes it so that there can be only one apartment and it will be true

Fixed: ∀x[Apt(x)∧In(x,London)]⟹∃y([Apt(y)∧In(y,Paris)]⟹(Rent(x)\<Rent(y))) ∧ ∃z([Apt(z)∧In(z,Paris)]⟹(Rent(x)\<Rent(z))) ∧ (y $\neq$ z)

2. There is exactly one apartment in Paris with rent below $1000.
∃x[Apt(x)∧In(x,Paris)∧∀y[Apt(y)∧In(y,Paris)∧(Rent(y)\<Dollars(1000))]⟹(y=x)]

True

3. If an apartment is more expensive than all apartments in London, it must be in Moscow.
∀xApt(x)∧[∀yApt(y)∧In(y,London)∧(Rent(x)\>Rent(y))]⟹In(x,Moscow).

Not True, the statement above is saying for all apartment x, that has a corresponding cheaper apartment y in London, then x must be in Moscow

Fixed:∀xApt(x)∧[$\neg$∃yApt(y)∧In(y,London)∧(Rent(y)\>Rent(x))]⟹In(x,Moscow).

9.4  (4 X 3 = 12 pts)

For each pair of atomic sentences, give the most general unifier if it exists:
1. P(A,B,B), P(x,y,z).

Unify(P(A,B,B), P(x,y,z))

{x/A, y/B, z/B}

2. Q(y,G(A,B)), Q(G(x,x),y).

Unify(Q(y,G(A,B)), Q(G(x,x),y))

Unification does not exist

3. Older(Father(y),y), Older(Father(x),John).

Unify(Older(Father(y),y), Older(Father(x),John))

{x/John y/John}

4. Knows(Father(y),y), Knows(x,x).

Unify(Knows(Father(y),y), Knows(x,x).)

Unification does not exist

9.9  (5 X 2 = 10 pts)

This question considers Horn KBs, such as the following:

- P(F(x))⇒P(x)
- Q(x)⇒P(F(x))
- P(A)
- Q(B)

Let FC be a breadth-first forward-chaining algorithm that repeatedly adds all consequences of currently satisfied rules; let BC be a depth-first left-to-right backward-chaining algorithm that tries clauses in the order given in the KB. Which of the following are true?
1. FC will infer the literal Q(A).

False

2. FC will infer the literal P(B).

True

3. If FC has failed to infer a given literal, then it is not entailed by the KB.

True

4. BC will return true given the query P(B).

True

5. If BC does not return true given a query literal, then it is not entailed by the KB.

True

9.24 (2 + 3 + 4 = 9 pts)

Let L be the first-order language with a single predicate S(p,q), meaning “p shaves  q.” Assume a domain of people.
1. Consider the sentence “There exists a person P who shaves every one who does not shave themselves, and only people that do not shave themselves.” Express this in L.

∀q ∃p $\neg$S(q, q) ⟹ S(p,q) &and; $\neg$∃r S(r,r) &and; S(p,r)

2. Convert the sentence in (a) to clausal form.

∀q ∃p $\neg$S(q, q) ⟹ S(p,q) &and; $\neg$∃r S(r,r) &and; S(p,r)

∀q ∃p $\neg$S(q, q) ⟹ S(p,q) &and; ∀r $\neg$(S(r,r) &and; $\neg$S(p,r))

∀q ∃p $\neg$S(q, q) ⟹ S(p,q) &and; ∀r $\neg$S(r,r) &or; $\neg$S(p,r)

∀q ∃p ∀r $\neg$S(q, q) ⟹ S(p,q) &and; $\neg$S(r,r) &or; $\neg$S(p,r)

∀q ∃p ∀r S(q, q) &or; S(p,q) &and; $\neg$S(r,r) &or; $\neg$S(p,r)

[ S(q, q) &or; S(Person,q) ] &and; [ $\neg$S(r,r) &or; $\neg$S(Person,r) ]

3. Construct a resolution proof to show that the clauses in (b) are inherently inconsistent. (Note: you do not need any additional axioms.)

Fact 1: [ S(q, q) &or; S(Person,q) ] 

Fact 2: [ $\neg$S(r,r) &or; $\neg$S(Person,r) ]

[ $\neg$S(r,r) &or; $\neg$S(Person,r) ] resolved with [ S(q, q) &or; S(Person,q) ] where q = r

[ $\neg$S(r,r) &or; $\neg$S(Person,r) ] resolved with [ S(r, r) &or; S(Person,r) ]

[ $\neg$S(Person,r) ] &or; [ S(Person,r) ]

True

9.29 (2 + 2 + 2 + 2 + 2 + 3 + 3 = 16 pts)

Here are two sentences in the language of first-order logic:

- (A) ∀x∃y(x≥y)

- (B) ∃y∀x(x≥y) 

1. Assume that the variables range over all the natural numbers 0,1,2,…,∞ and that the “≥” predicate means “is greater than or equal to.” Under this interpretation, translate (A) and (B) into English.

A) For all x, there exists a y such that x is greater than or equal to y

B) There exists a y, for all x such that x is greater than or equal to y

2. Is (A) true under this interpretation?

True, set y = 0

3. Is (B) true under this interpretation?

True, set y = 0

4. Does (A) logically entail (B)?

false, A does not logically entail B

5. Does (B) logically entail (A)?

true, B does logically entail A

6. Using resolution, try to prove that (A) follows from (B). Do this even if you think that (B) does not logically entail (A); continue until the proof breaks down and you cannot proceed (if it does break down). Show the unifying substitution for each resolution step. If the proof fails, explain exactly where, how, and why it breaks down.

Assume A is true, and for contradiction, $\neg$B is true

B: $\neg$∃y∀x(x≥y) 

B: ∀y$\neg$∀x(x≥y) 

B: ∀y∃x$\neg$(x≥y) 

B: ∃x$\neg$(x≥y) 

B: ∃x(x\<y) 

B: (X\<y) 

A: ∀x∃y(x≥y)

A: ∃y(x≥y)

A: (x≥Y)

Unify(A, B)

Unify((x≥Y), (X\<y))

Unification fails &rarr; Contradiction!

Therefore, by contradiction A must entail B

7. Now try to prove that (B) follows from (A).

Assume B is true, and for contradiction, $\neg$A is true

A: $\neg$∀x∃y(x≥y)

A: ∃x$\neg$∃y(x≥y)

A: ∃x∀y$\neg$(x≥y)

A: ∃x∀y(x\<y)

A: ∃x(x\<y)

A: (X\<y)

B: ∃y∀x(x≥y) 

B: ∃y(x≥y) 

B: (x≥Y) 

Unify((x≥Y), (X\<y))

Unification fails &rarr; Contradiction!

Therefore, by contradiction B must entail A
