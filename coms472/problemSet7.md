# Problem Set 7

By Ben Nguyen

## 13.3 (3 + 3 + 3 = 9 pts)

Prove true or give counter example

a. If $P(a | b, c) = P(b | a, c)$, then $P(a | c) = P (b | c)$.

$P(a | b, c)$ = $P(a, b, c)$ / $P(b, c)$

$P(b | a, c)$ = $P(b, a, c)$ / $P(a, c)$

$P(b | a, c)$ = $P(a, b, c)$ / $P(a, c)$

$P(b, c)$ = $P(a, c)$

$P(b | c)$ = $P(a | c)$

b. If $P(a | b, c) = P(a)$, then $P(b | c) = P(b)$.

Counter Example:

Proof by Counter Example:

Let's say that the chance that there is going to be rain today given that there was snow yesterday and the day before is 70%.

Also, the chance that there is going to be rain today given no variables is also 70%.

Then, the relation above tells us that the chance of snow yesterday given that there is snow the day before is the same probability
of having snow yesterday.

This sentence does not make sense, so the prompt must be wrong.

c. If $P(a | b) = P(a)$, then $P(a | b, c) = P(a | c)$.

$P(a | b, c)$

$P(a, b, c) / P(b, c)$

$((P(a) P(c)) P(b)) / ((P(c)) P(b))$ given $P(a | b) = P(a)$

$(P(a) P(c)) / P(c)$

$P(a | c)$

True

## 13.8 (2 + 3 + 2 + 4 = 11 pts)

Given the full joint distribution shown in Figure 13.3, calculate the following:

![](../pic/toothachecavity.png)

1. P(Toothache).

.108 + .012 + .016 + .064 = 0.2

P(Toothache) = 0.2

2. P(cavity).

.108 + 0.012 + .072 + .008 = 0.2

P(cavity) = <0.2, 0.8>

3. P(Toothache | cavity).

(.108 + 0.012) / 0.2 = 0.6

P(Toothache | cavity) = <0.6, 0.4>

4. P(Cavity | Toothache ∨ Catch).

(.108 + 0.012 + 0.072) / 0.416 = 0.4615

P(Cavity | Toothache ∨ Catch) = <0.4615, 0.5385>

## 13.18 (12 pts)

After your yearly checkup, the doctor has bad news and good news. The bad news is that you tested positive for a serious disease and that the test is 99% accurate (i.e., the probability of testing positive when you do have the disease is 0.99, as is the probability of testing negative when you don’t have the disease). The good news is that this is a rare disease, striking only 1 in 10,000 people of your age. Why is it good news that the disease is rare? What are the chances that you actually have the disease?

P(TestPositive | HaveDisease) = 0.99

P($\neg$ TestPositive | $\neg$ HaveDisease) = 0.99

P(HaveDisease) = 0.0001

P(HaveDisease | TestPositive) = $\frac{P(TestPositive | HaveDisease) * P(HaveDisease)}{P(TestPositive)}$

P(HaveDisease | TestPositive) = $\frac{P(TestPositive | HaveDisease) * P(HaveDisease)}{P(TestPositive | HaveDisease) * P(HaveDisease) + P(TestPositive | \neg HaveDisease) * P(\neg HaveDisease)}$

P(HaveDisease | TestPositive) = (0.99 * 0.0001) / (0.99 * 0.0001 + 0.01 * 0.9999)

P(HaveDisease | TestPositive) = (0.000099) / (0.010098)

P(HaveDisease | TestPositive) = 0.00980392156863

P(HaveDisease | TestPositive) = Approximately 0.98% chance

## 13.26 (10 pts)

(Adapted from Pearl [Pearl:1988].) Suppose you are a witness to a nighttime hit-and-run accident involving a taxi in Athens. All taxis in Athens are blue or green. You swear, under oath, that the taxi was blue. Extensive testing shows that, under the dim lighting conditions, discrimination between blue and green is 75% reliable.

1. Is it possible to calculate the most likely color for the taxi? (*Hint:* distinguish carefully between the proposition that the taxi *is* blue and the proposition that it *appears* blue.)

P(TaxiColor = Blue | SawTaxiColor = Blue) = 0.75

P(TaxiColor = Green | SawTaxiColor = Blue) = 0.25

P(TaxiColor = Blue | SawTaxiColor = Green) = 0.25

P(TaxiColor = Green | SawTaxiColor = Green) = 0.75

Yes, P(TaxiColor = Blue | SawTaxiColor = Blue) \> P(TaxiColor = Green | SawTaxiColor = Blue)

Therefore, it is more likely for the actual taxi color to be Blue than for the actual taxi color to be Green

2. What if you know that 9 out of 10 Athenian taxis are green?

P(TaxiColor = Blue) = 0.1

P(TaxiColor = Green) = 0.9

$\frac{0.75 * 0.1}{0.25 * 0.9 + 0.75 * 0.1}$ = 0.25

There is a now a 25% chance that the witness is right

## 14.5 (3 + 9 = 13 pts)

Consider the Bayesian network in Figure burglary-figure.

![](../pic/Bgraph.png)

1. If no evidence is observed, are Burglary and Earthquake independent? Prove this from the numerical semantics and from the topological semantics.

P(Burglary) * P(Earthquake) = 0.000002, and since that is so close to 0, they are almost certainly independent

2. If we observe Alarm true, are Burglary and Earthquake independent? Justify your answer by calculating whether the probabilities involved satisfy the definition of conditional independence.

P(Burglary | Alarm = true) * P(Earthquake | Alarm = true)

(P(Burglary = true, Earthquake = true | Alarm = true) + P(Burglary = true, Earthquake = false | Alarm = true)
/
P(Burglary = true, Earthquake = false | Alarm = true) + P(Burglary = true, Earthquake = false | Alarm = true) + P(Burglary = false, Earthquake = false | Alarm = true) + P(Burglary = false, Earthquake = false | Alarm = true))
*
(P(Burglary = true, Earthquake = true | Alarm = true) + P(Burglary = false, Earthquake = true | Alarm = true))
/
(P(Burglary = true, Earthquake = false | Alarm = true) + P(Burglary = true, Earthquake = false | Alarm = true) + P(Burglary = false, Earthquake = false | Alarm = true) + P(Burglary = false, Earthquake = false | Alarm = true))

(0.95 + 0.94)
/
(0.95 + 0.94 + 0.29 + 0.001)
*
(0.95 + 0.29)
/
(0.95 + 0.94 + 0.29 + 0.001)

(1.89 / 2.181) * (1.24 / 2.181)

0.492688

Therefore, the Burglary and Earthquake are not independent because the product of the probabilities is not equal to 0
