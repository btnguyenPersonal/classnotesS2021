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
      System.out.println("No solution exists for the following initial state:" + s0.toString());
    }

    // 2) Otherwise, solve the puzzle with the three heuristics.  The two solutions generated by
    //    the first two heuristics may be different but must have the same length for optimality. 

    Heuristic h[] = {Heuristic.TileMismatch, Heuristic.ManhattanDist, Heuristic.DoubleMoveHeuristic }; 
    String [] moves = new String[3]; 

    moves[0] = AStar(s0, Heuristic.TileMismatch);

    // for (int i = 0; i < 3; i++)
    // {
    //   moves[i] = AStar(s0, h[i]); 
    // }

    // 3) Combine the three solution strings into one that would print out in the 
    //    output format specified in Section 6 of the project description.

    return "Tile:\n" + moves[0] + "\nManhattan:\n" + moves[1] + "\nDoubleMove:\n" + moves[2]; 
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
      if (index < 10) {
        index++;
        OPEN.print();
        CLOSE.print();
      }
      CLOSE.addState(s);
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
      }
    }
    return null; 
  }

  public static ArrayList<State> generateSubsets(State s) {
    ArrayList<State> output = new ArrayList<State>();
    if (!s.isIllegalMove(Move.LEFT)) {
      output.add(s.successorState(Move.LEFT));
    } else if (!s.isIllegalMove(Move.RIGHT)) {
      output.add(s.successorState(Move.RIGHT));
    } else if (!s.isIllegalMove(Move.UP)) {
      output.add(s.successorState(Move.UP));
    } else if (!s.isIllegalMove(Move.DOWN)) {
      output.add(s.successorState(Move.DOWN));
    } else if (!s.isIllegalMove(Move.DBL_LEFT)) {
      output.add(s.successorState(Move.DBL_LEFT));
    } else if (!s.isIllegalMove(Move.DBL_RIGHT)) {
      output.add(s.successorState(Move.DBL_RIGHT));
    } else if (!s.isIllegalMove(Move.DBL_UP)) {
      output.add(s.successorState(Move.DBL_UP));
    } else if (!s.isIllegalMove(Move.DBL_DOWN)) {
      output.add(s.successorState(Move.DBL_DOWN));
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
    String output = goal.toString();
    State current = goal;
    while (current.predecessor != null) {
      output = current.toString() + "\n<insert move here>\n" + output;
    }
    return output;
  }
}
