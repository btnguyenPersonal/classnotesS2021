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

Hill Climbing Search

---

4. Simulated annealing with $T = \infty$ at all times

---

___Solution___:

Depth First Search

---

5. Genetic algorithm with population size $N = 1$

---

Depth First Search where you start at the parent node, and then each search has a random chance to choose a random node

---

## 4.7

###### In Section  we introduced belief states to solve sensorless search problems. A sequence of actions solves a sensorless problem if it maps every physical state in the initial belief state b to a goal state. Suppose the agent knows h$\ast$(s), the true optimal cost of solving the physical state s in the fully observable problem, for every state s in b. Find an admissible heuristic h(b) for the sensorless problem in terms of these costs, and prove its admissibilty. Comment on the accuracy of this heuristic on the sensorless vacuum problem of Figure 4.14. How well does A$\ast$ perform?

---

___Solution___:

An admissible heuristic h(b) for a sensorless problem is to take the lowest cost that h(s) can ever give, and use that for all outputs of h(b)

This works because in sensorless problems, we have no idea where we are, so the only thing it is safe to assume is that the heuristic must return equal to or less than the lowest cost in h(s), because anything that goes over will make the heuristic inadmissible

Most of the time, this will just mean that h(b) = 0

This heuristic will just give the same performance as Uniform Cost search

---

## 4.8

###### This exercise explores subset–superset relations between belief states in sensorless or partially observable environments.

a. Prove that if an action sequence is a solution for a belief state b, it is also a solution for any subset of b. Can anything be said about supersets of b?


Proof by Contradiction:

- Assume that $b$ is a subset of $b_s$, and $b_s$ has an actionable solution

Contradiction statement: if there is a solution for $b_s$, there could be a subset of $b$ that does not have the solution

- Therefore, the start node of $b_s$ must be able to reach the start node of $b$ by the definition of subset

- There also must be a path from the start of $b_s$ to the goal state, by the given prompt

- Therefore, there is a path from the start of $b$ to the goal state

- Contradiction

<!-- - $Assume$ $A$ $is$ $a$ $subset$ $of$ $B$ -->

<!-- - $=>$ $if$ $B$ $has$ $an$ $actionable$ $sequence$ $that$ $is$ $a$ $solution$ $to$ $it$, $then$ $A$ $must$ $have$ $that$ $solution$ $as$ $well$. -->

<!-- - $Let$ $A$ $=$ $b,$ $B$ $=$ $q$ -->

<!-- - $=>$ $b$ $is$ $a$ $subset$ $of$ $q$ -->

<!-- - $=>$ $if$ $q$ $has$ $an$ $actionable$ $sequence$ $that$ $is$ $a$ $solution$ $to$ $it$, $then$ $b$ $must$ $have$ $that$ $solution$ $as$ $well$. -->

<!-- - $q$ $is$ $a$ $superset$ $of$ $b$ -->

<!-- - $Therefore,$ $if$ $supersets$ $of$ $b$ $have$ $an$ $actionable$ $sequence$ $of$ $moves,$ $then$ $b$ $must$ $also$ $have$ $a$ $solution$ -->

b. Explain in detail how to modify graph search for sensorless problems to take advantage of your answers in (a).

In a sensorless problem, to solve the problem with no prior knowledge what state you are currently in, you would assume that you are in every state at once.

Your start state would have n many trees, each with n different unique starting positions on the state space, where n is the total number of states in the state space.

Then, each time you move around in the tree, you would apply the action you would for one node, to every single node in every tree in the state.

Then, to find the solution to the sensorless problem, the goal state is that every tree in your state has the current node on the goal node.

## 4.10

###### Consider the sensorless version of the erratic vacuum world. Draw the belief-state space reachable from the initial belief state {1,2,3,4,5,6,7,8}, and explain why the problem is unsolvable.

![](../pic/vacuum\ world.png)

  This problem is unsolvable because there is no way for you to know if you have cleaned up all of the dirt. You will get caught in a cycle where no matter what you do, if you have no sensors you can never tell if you are in the goal state. Every time you suck from any of the left states, you do not know which one of the left states you will end up in, and the same can be said for the right side. When you switch from one of the left states to the right state, it does not guarantee which room you are going to be in either. Therefore, you will get stuck in this loop of sucking or switching rooms, and since neither of those moves helps you at all with figuring out where you are, you can never figure out if you are at the goal state or not.
