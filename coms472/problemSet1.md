# Problem Set 1
#### By Ben Nguyen
## 3.2
###### Give a complete problem formulation for each of the following problems. Choose a formulation that is precise enough to be implemented.
###### 1. There are six glass boxes in a row, each with a lock. Each of the first five boxes holds a key unlocking the next box in line; the last box holds a banana. You have the key to the first box, and you want the banana.
---
__Solution__:
  1. Take the first key and open the first box
  2. Take the last key you have found and open the next box that has not been opened yet
  3. Repeat the last step until you have found the banana
---
###### 2. You start with the sequence ABABAECCEC, or in general any sequence made from A, B, C, and E. You can transform this sequence using the following equalities: AC = E, AB = BC, BB = E, and Ex = x for any x. For example, ABBC can be transformed into AEC, and then AC, and then E. Your goal is to produce the sequence E. 
---
__Solution__:
  1. First parse through the entire string, and store all of the permutations that the can result from one translation in the string through the given equalities, and check if any of those are equal to the sequence `E`
  2. If one is equal to the sequence `E`, then the algorithm is done, and the algorithm can go back through the tree to find out what equalities where used to result in the answer
  3. Otherwise, if none of the resulting strings are not equal, then all of the new strings become the frontier and the algorithm starts back at step 1
---
###### 3. There is an n×n grid of squares, each square initially being either unpainted floor or a bottomless pit. You start standing on an unpainted floor square, and can either paint the square under you or move onto an adjacent unpainted floor square. You want the whole floor painted.
---
__Solution__:
  1. Move to the closest square with the least amount of unpainted floor squares adjacent to it by using a Depth-first search until you are standing on the desired square
  2. Paint the square under you and go back to step 1 if there are any unpainted floor squares left
---
###### 4. A container ship is in port, loaded high with containers. There 13 rows of containers, each 13 containers wide and 5 containers tall. You control a crane that can move to any location above the ship, pick up the container under it, and move it onto the dock. You want the ship unloaded.
---
__Solution__:
  1. Take the highest top-left-most container and unload it, then unload the 4 containers under it
  2. Move your crane one container to the right and repeat step 1 if possible
  3. If there are no more containers to the moved to the right, go one row down and start again at the left-most container
---
## 3.7
###### Consider the n-queens problem using the “efficient” incremental formulation given on page . Explain why the state space has at least $\sqrt[3]{n!}$ states and estimate the largest n for which exhaustive exploration is feasible. (Hint: Derive a lower bound on the branching factor by considering the maximum number of squares that a queen can attack in any column.)
---
__Solution__:
  1. The branching factor for this equation is n, because when placing the first queen there are 8 squares on the first row that a queen can be placed
  2. Therefore, there are $n^n$ possible queen configurations that need to be checked for a valid state
---
## 3.17
Which of the following are true and which are false? Explain your answers.
###### 1. Depth-first search always expands at least as many nodes as A search with an admissible heuristic.
  > ???

  what is an "admissible heuristic"
###### 2. h(n)=0 is an admissible heuristic for the 8-puzzle.
  > ???

  what is an "admissible heuristic"
###### 3. A is of no use in robotics because percepts, states, and actions are continuous.
  > false

  A* still is of good use in robotics because A* is good at creating a pathfinding solution when there is already prior knowledge given to the bot
###### 4. Breadth-first search is complete even if zero step costs are allowed.
  > true

  Breadth first search will always find the solution eventually because even when there are zero-step costs, because it will iteratively find every possible path that the search can take. This will result in the Breadth first search taking n iterations, in which n is the number of steps that is in the optimal solution from the start to end node
###### 5. Assume that a rook can move on a chessboard any number of squares in a straight line, vertically or horizontally, but cannot jump over other pieces. Manhattan distance is an admissible heuristic for the problem of moving the rook from square A to square B in the smallest number of moves.
  > true

  This is true because the Manhattan distance is by definition unable to move diagonal, so the shortest Manhattan distance will be the shortest rook movement
## 3.22
###### Describe a state space in which iterative deepening search performs much worse than depth-first search (for example, O(n2) vs. O(n)).
If the Depth first search is starting in the middle of an n by n grid, and it always expands the leftmost node first, Iterative deepening search would perform much worse on a large grid where the end goal is directly on the left side of the grid compared to regular depth first search
The regular depth-first search would keep expanding the left-most nodes until it found the end goal, whereas the Iterative Deepening search would search all of the paths of length 1 around the start node, and then 2 around the start node, until it finally searches at the path length that is equal to the shortest path, so it will take $O(n^2)$, and regular DFS would take $O(n)$ time
## 3.27
###### Trace the operation of A search applied to the problem of getting to Bucharest from Lugoj using the straight-line distance heuristic. That is, show the sequence of nodes that the algorithm will consider and the f, g, and h score for each node.
## 3.31
###### The heuristic path algorithm Pohl:1977 is a best-first search in which the evaluation function is f(n)=(2−w)g(n)+wh(n). For what values of w is this complete? For what values is it optimal, assuming that h is admissible? What kind of search does this perform for w=0, w=1, and w=2?
