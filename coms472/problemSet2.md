# COMS 472 Problem Set 2

#### By Ben Nguyen

## 4.1

###### Give the name of the algorithm that results from each of the following special cases

1. Local beam search with $k = 1$

---

___Solution___:

Hill Climbing Search

---

2. Local beam search with one initial state and no limit on the number of states retained.

---

___Solution___:

Breadth First Search

---

3. Simlated annealing with $T = 0$ at all times (and omitting the termination test)

---

___Solution___:

First Choice Hill Climbing

---

4. Simulated annealing with $T = \infty$ at all times

---

___Solution___:

Depth First Search

---

5. Genetic algorithm with population size $N = 1$

---

Random Search

---

## 4.7

###### In Section  we introduced belief states to solve sensorless search problems. A sequence of actions solves a sensorless problem if it maps every physical state in the initial belief state b to a goal state. Suppose the agent knows h$\ast$(s), the true optimal cost of solving the physical state s in the fully observable problem, for every state s in b. Find an admissible heuristic h(b) for the sensorless problem in terms of these costs, and prove its admissibilty. Comment on the accuracy of this heuristic on the sensorless vacuum problem of Figure 4.14. How well does A$\ast$ perform?

---

___Solution___:

A $\ast$ will create all of its belief states based on $h\ast(s)$, so $h\ast(b)$ will be functionally identical to it. A $\ast$ will perform exactly the same as if it were in a fully observable problem

Does sensorless mean not being able to know the costs associated with moving between states?

---

## 4.8

###### This exercise explores subset–superset relations between belief states in sensorless or partially observable environments.

a. Prove that if an action sequence is a solution for a belief state b, it is also a solution for any subset of b. Can anything be said about supersets of b?

The reverse can also be said about the supersets of b, because if there is an actionable sequence of moves to solve the superset of b, then there must also be an actionable sequence of moves for b.

- $Assume$ $A$ $is$ $a$ $subset$ $of$ $B$

- $=>$ $if$ $B$ $has$ $an$ $actionable$ $sequence$ $that$ $is$ $a$ $solution$ $to$ $it$, $then$ $A$ $must$ $have$ $that$ $solution$ $as$ $well$.

- $Let$ $A$ $=$ $b,$ $B$ $=$ $q$

- $=>$ $b$ $is$ $a$ $subset$ $of$ $q$

- $=>$ $if$ $q$ $has$ $an$ $actionable$ $sequence$ $that$ $is$ $a$ $solution$ $to$ $it$, $then$ $b$ $must$ $have$ $that$ $solution$ $as$ $well$.

- $q$ $is$ $a$ $superset$ $of$ $b$

- $Therefore,$ $if$ $supersets$ $of$ $b$ $have$ $an$ $actionable$ $sequence$ $of$ $moves,$ $then$ $b$ $must$ $also$ $have$ $a$ $solution$

b. Explain in detail how to modify graph search for sensorless problems to take advantage of your answers in (a).

In sensorless problems, many times you can build a model for Reachable belief states, and find the solution for all of them if there is one, and then if you can make a sequence of moves to _guarantee_ that you are in one of the states that can be solved, then you have a solution to the problem, because you found a superset of b that can be solved

c. Explain in detail how to modify and–or search for partially observable problems, beyond the modifications you describe in (b).

For partially-observable problems, you do not need to find a way for you to guarantee that you are in a solvable state, with partially observable, you can see part of the state space, so often you can just find out what state you are in by making moves, and observing what happens, which will give you info, which can be used to piece together what state space you are in.

## 4.10

###### Consider the sensorless version of the erratic vacuum world. Draw the belief-state space reachable from the initial belief state {1,2,3,4,5,6,7,8}, and explain why the problem is unsolvable.

![](../pic/vacuum\ world.png)

  This problem is unsolvable because there is no way for you to know if you have cleaned up all of the dirt. You will get caught in a cycle where no matter what you do, if you have no sensors you can never tell if you are in the goal state. Every time you suck from any of the left states, you do not know which one of the left states you will end up in, and the same can be said for the right side. When you switch from one of the left states to the right state, it does not guarantee which room you are going to be in either. Therefore, you will get stuck in this loop of sucking or switching rooms, and since neither of those moves helps you at all with figuring out where you are, you can never figure out if you are at the goal state or not.
