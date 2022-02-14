# COMS 472 Problem Set 2

#### By Ben Nguyen

## 4.1

###### Give the name of the algorithm that results from each of the following special cases

1. Local beam search with $k = 1$

2. Local beam search with one initial state and no limit on the number of states retained.

3. Simlated annealing with $T = 0$ at all times (and omitting the termination test)

4. Simulated annealing with $T = \infty$ at all times

5. Genetic algorithm with population size $N = 1$

## 4.7

###### In Section  we introduced belief states to solve sensorless search problems. A sequence of actions solves a sensorless problem if it maps every physical state in the initial belief state b to a goal state. Suppose the agent knows h$\ast$(s), the true optimal cost of solving the physical state s in the fully observable problem, for every state s in b. Find an admissible heuristic h(b) for the sensorless problem in terms of these costs, and prove its admissibilty. Comment on the accuracy of this heuristic on the sensorless vacuum problem of Figure 4.14. How well does A$\ast$ perform?

## 4.8

###### This exercise explores subset–superset relations between belief states in sensorless or partially observable environments.

1. Prove that if an action sequence is a solution for a belief state b, it is also a solution for any subset of b. Can anything be said about supersets of b?

2. Explain in detail how to modify graph search for sensorless problems to take advantage of your answers in (a).

3. Explain in detail how to modify and–or search for partially observable problems, beyond the modifications you describe in (b).

## 4.10

###### Consider the sensorless version of the erratic vacuum world. Draw the belief-state space reachable from the initial belief state {1,2,3,4,5,6,7,8}, and explain why the problem is unsolvable.
