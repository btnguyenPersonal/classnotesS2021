package edu.iastate.cs472.proj1;

import java.io.FileNotFoundException;
import java.util.ArrayList;

/**
 *
 * @author
 *
 */

public class EightPuzzle
{
  /**
   * This static method solves an 8-puzzle with a given initial state using three heuristics. The
   * first two, allowing single moves only, compare the board configuration with the goal configuration
   * by the number of mismatched tiles, and by the Manhattan distance, respectively.  The third
   * heuristic, designed by yourself, allows double moves and must be also admissible.  The goal
   * configuration set for all puzzles is
   *
   * 			1 2 3
   * 			8   4
   * 			7 6 5
   *
   * @param s0
   * @return a string specified in the javadoc below
   */
  public static String solve8Puzzle(State s0)
  {
    // 1) Return a message that starts with "No solution exists for the following initial
    //    state:" and follows with a blank line and then what would be the output from a
    //    call s0.toString(). See the end of Section 6 in the project description for an
    //    example.
    if (!s0.solvable()) {
      System.out.println("No solution exists for the following initial state:\n" + s0.toString());
      return null;
    }

    // 2) Otherwise, solve the puzzle with the three heuristics.  The two solutions generated by
    //    the first two heuristics may be different but must have the same length for optimality.

    Heuristic h[] = {Heuristic.TileMismatch, Heuristic.ManhattanDist, Heuristic.DoubleMoveHeuristic };
    String [] moves = new String[3];

    for (int i = 0; i < 3; i++)
    {
      moves[i] = AStar(s0, h[i]);
    }

    // 3) Combine the three solution strings into one that would print out in the
    //    output format specified in Section 6 of the project description.

    return moves[0] + moves[1] + moves[2];
  }


  /**
   * This method implements the A* algorithm to solve the 8-puzzle with an input initial state s0.
   * The algorithm implementation is described in Section 3 of the project description.
   *
   * Precondition: the puzzle is solvable with the initial state s0.
   *
   * @param s0  initial state
   * @param h   heuristic
   * @return    solution string
   */
  public static String AStar(State s0, Heuristic h)
  {
    // Initialize the two lists used by the algorithm.
    OrderedStateList OPEN = new OrderedStateList(h, true);
    OrderedStateList CLOSE = new OrderedStateList(h, false);
    OPEN.addState(s0);
    int index = 0;
    while (OPEN.size() > 0) {
      State s = OPEN.remove();
      if (s.isGoalState()) {
        return solutionPath(s);
      } else {
        ArrayList<State> successors = generateSubsets(s);
        for (int i = 0; i < successors.size(); i++) {
          State current = successors.get(i);
          if (OPEN.findState(current) == null && CLOSE.findState(current) == null) {
            OPEN.addState(current);
          }
        }
        CLOSE.addState(s);
      }
    }
    return null;
  }

  public static ArrayList<State> generateSubsets(State s) {
    ArrayList<State> output = new ArrayList<State>();
    if (!(s.isIllegalMove(Move.LEFT))) {
      output.add(s.successorState(Move.LEFT));
    }
    if (!(s.isIllegalMove(Move.RIGHT))) {
      output.add(s.successorState(Move.RIGHT));
    }
    if (!(s.isIllegalMove(Move.UP))) {
      output.add(s.successorState(Move.UP));
    }
    if (!(s.isIllegalMove(Move.DOWN))) {
      output.add(s.successorState(Move.DOWN));
    }
    if (s.heu == Heuristic.DoubleMoveHeuristic) {
      if (!(s.isIllegalMove(Move.DBL_LEFT))) {
        output.add(s.successorState(Move.DBL_LEFT));
      }
      if (!(s.isIllegalMove(Move.DBL_RIGHT))) {
        output.add(s.successorState(Move.DBL_RIGHT));
      }
      if (!(s.isIllegalMove(Move.DBL_UP))) {
        output.add(s.successorState(Move.DBL_UP));
      }
      if (!(s.isIllegalMove(Move.DBL_DOWN))) {
        output.add(s.successorState(Move.DBL_DOWN));
      }
    }
    return output;
  }

  /**
   * From a goal state, follow the predecessor link to trace all the way back to the initial state.
   * Meanwhile, generate a string to represent board configurations in the reverse order, with
   * the initial configuration appearing first. Between every two consecutive configurations
   * is the move that causes their transition. A blank line separates a move and a configuration.
   * In the string, the sequence is preceded by the total number of moves and a blank line.
   *
   * See Section 6 in the projection description for an example.
   *
   * Call the toString() method of the State class.
   *
   * @param goal
   * @return
   */
  private static String solutionPath(State goal)
  {
    String output = "\n" + goal.toString() + "\n\n";
    State current = goal;
    int moves = 0;
    while (current.predecessor != null) {
      Move m = current.move;
      current = current.predecessor;
      output = "\n" + current.toString() + "\n" + m + "\n" + output;
      moves++;
    }
    if (goal.heu == Heuristic.TileMismatch) {
      output = moves + " moves in total (heuristic: number of mismatched tiles)\n" + output;
    } else if (goal.heu == Heuristic.ManhattanDist) {
      output = moves + " moves in total (heuristic: the Manhattan distance)\n" + output;
    } else {
      output = moves + " moves in total (heuristic: double moves allowed)\n" + output;
    }
    return output;
  }
}
