package edu.iastate.cs472.proj1;

import java.io.FileNotFoundException;
import java.io.File;
import java.util.Scanner;

/**
 *
 * @author
 *
 */

/**
 * This class represents a board configuration in the 8-puzzle. Only the initial
 * configuration is
 * generated by a constructor, while intermediate configurations will be
 * generated via calling
 * the method successorState(). State objects will form two circular
 * doubly-linked lists OPEN and
 * CLOSED, which will be used by the A* algorithm to search for a path from a
 * given initial board
 * configuration to the final board configuration below:
 *
 * 1 2 3
 * 8 4
 * 7 6 5
 *
 * The final configuration (i.e., the goal state) above is not explicitly
 * represented as an object
 * of the State class.
 */

public class State implements Cloneable, Comparable<State> {
  public int[][] board; // configuration of tiles

  public State previous; // previous node on the OPEN/CLOSED list
  public State next; // next node on the OPEN/CLOSED list
  public State predecessor; // predecessor node on the path from the initial state

  public Move move; // the move that generated this state from its predecessor
  public int numMoves; // number of moves from the initial state to this state

  public static Heuristic heu; // heuristic used. shared by all the states.

  private int numMismatchedTiles = -1; // number of mismatched tiles between this state
                                       // and the goal state; negative if not computed yet.
  private int ManhattanDistance = -1; // Manhattan distance between this state and the
                                      // goal state; negative if not computed yet.
  private int numSingleDoubleMoves = -1; // number of single and double moves with each double
                                         // move counted as one; negative if not computed yet.

  /**
   * Constructor (for the initial state).
   *
   * It takes a 2-dimensional array representing an initial board configuration.
   * The empty
   * square is represented by the number 0.
   *
   * a) Initialize all three links previous, next, and predecessor to null.
   * b) Set move to null and numMoves to zero.
   *
   * @param board
   * @throws IllegalArgumentException if board is not a 3X3 array or its nine
   *                                  entries are
   *                                  not respectively the digits 0, 1, ..., 8.
   */
  public State(int[][] board) throws IllegalArgumentException {
    this.move = null;
    this.numMoves = 0;
    this.previous = null;
    this.next = null;
    this.predecessor = null;
    this.board = board;
  }

  public State() throws IllegalArgumentException {
    this.move = null;
    this.numMoves = 0;
    this.previous = null;
    this.next = null;
    this.predecessor = null;
  }

  /**
   * Constructor (for the initial state)
   *
   * It takes a state from an input file that has three rows, each containing
   * three digits
   * separated by exactly one blank. Every row starts with a digit. The nine
   * digits are
   * from 0 to 8 with no duplicates.
   *
   * Do the same initializations as for the first constructor.
   *
   * @param inputFileName
   * @throws FileNotFoundException
   * @throws IllegahilArgumentException if the file content does not meet the
   *                                    above requirements.
   */
  public State(String inputFileName) throws FileNotFoundException, IllegalArgumentException {
    this.move = null;
    this.numMoves = 0;
    this.previous = null;
    this.next = null;
    this.predecessor = null;
    try {
      File f = new File(inputFileName);
      Scanner s = new Scanner(f);
      this.board = new int[3][3];
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          this.board[i][j] = Integer.parseInt(s.next());
        }
      }
      s.close();
    } catch (FileNotFoundException e) {
      System.out.println("File not found: " + inputFileName);
      e.printStackTrace();
    }
  }

  /**
   * Generate the successor state resulting from a given move. Throw an exception
   * if the move
   * cannot be executed. Besides setting the array board[][] properly, you also
   * need to do the
   * following:
   *
   * a) set the predecessor of the successor state to this state;
   * b) set the private instance variable move of the successor state to the
   * parameter m;
   * c) Set the links next and previous to null;
   * d) Set the variable numMoves for the successor state to this.numMoves + 1.
   *
   * @param m one of the moves LEFT, RIGHT, UP, DOWN, DBL_LEFT, DBL_RIGHT, DBL_UP,
   *          and DBL_DOWN
   * @return null if the successor state is this.predecessor
   *         successor state otherwise
   * @throws IllegalArgumentException if LEFT when the empty square is in the
   *                                  right column, or
   *                                  if RIGHT when the empty square is in the
   *                                  left column, or
   *                                  if UP when the empty square is in the bottom
   *                                  row, or
   *                                  if DOWN when the empty square is in the top
   *                                  row, or
   *                                  if DBL_LEFT when the empty square is not in
   *                                  the left column, or
   *                                  if DBL_RIGHT when the empty square is not in
   *                                  the right column, or
   *                                  if DBL_UP when the empty square is not in
   *                                  the top row, or
   *                                  if DBL_DOWN when the empty square is not in
   *                                  the bottom row.
   */
  public State successorState(Move m) throws IllegalArgumentException {
    if (isIllegalMove(m)) {
      throw new IllegalArgumentException("Illegal Move");
    }
    State output = (State) this.clone();
    output.predecessor = this;
    output.move = m;
    output.next = null;
    output.previous = null;
    output.numMoves = this.numMoves + 1;
    int[] zero = getZero();
    int i = zero[0];
    int j = zero[1];
    if (m == Move.LEFT) {
      output.board[i][j] = output.board[i][j + 1];
      output.board[i][j + 1] = 0;
    }
    else if (m == Move.RIGHT) {
      output.board[i][j] = output.board[i][j - 1];
      output.board[i][j - 1] = 0;
    }
    else if (m == Move.UP) {
      output.board[i][j] = output.board[i + 1][j];
      output.board[i + 1][j] = 0;
    }
    else if (m == Move.DOWN) {
      output.board[i][j] = output.board[i - 1][j];
      output.board[i - 1][j] = 0;
    }
    else if (m == Move.DBL_LEFT) {
      output.board[i][j] = output.board[i][j + 1];
      output.board[i][j + 1] = output.board[i][j + 2];
      output.board[i][j + 2] = 0;
    }
    else if (m == Move.DBL_RIGHT) {
      output.board[i][j] = output.board[i][j - 1];
      output.board[i][j - 1] = output.board[i][j - 2];
      output.board[i][j - 2] = 0;
    }
    else if (m == Move.DBL_UP) {
      output.board[i][j] = output.board[i + 1][j];
      output.board[i + 1][j] = output.board[i + 2][j];
      output.board[i + 2][j] = 0;
    }
    else if (m == Move.DBL_DOWN) {
      output.board[i][j] = output.board[i - 1][j];
      output.board[i - 1][j] = output.board[i - 2][j];
      output.board[i - 2][j] = 0;
    } else {
      throw new IllegalArgumentException("Illegal Move: " + m);
    }
    return output;
  }

  public int[] getZero() {
    int[] output = new int[2];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.board[i][j] == 0) {
          output[0] = i;
          output[1] = j;
          return output;
        }
      }
    }
    return output;
  }

  public boolean isIllegalMove(Move move) {
    int[] zero = getZero();
    if (move == Move.LEFT) {
      if (zero[1] == 2) {
        return true;
      }
    }
    else if (move == Move.RIGHT) {
      if (zero[1] == 0) {
        return true;
      }
    }
    else if (move == Move.UP) {
      if (zero[0] == 2) {
        return true;
      }
    }
    else if (move == Move.DOWN) {
      if (zero[0] == 0) {
        return true;
      }
    }
    else if (move == Move.DBL_LEFT) {
      if (zero[1] == 2 || zero[1] == 1) {
        return true;
      }
    }
    else if (move == Move.DBL_RIGHT) {
      if (zero[1] == 0 || zero[1] == 1) {
        return true;
      }
    }
    else if (move == Move.DBL_UP) {
      if (zero[0] == 2 || zero[0] == 1) {
        return true;
      }
    }
    else if (move == Move.DBL_DOWN) {
      if (zero[0] == 0 || zero[0] == 1) {
        return true;
      }
    }
    return false;
  }

  /**
   * Determines if the board configuration in this state can be rearranged into
   * the goal configuration.
   * According to the PowerPoint notes that introduce the 8-puzzle, we check if
   * this state has an odd number
   * of inversions.
   */
  /**
   *
   * @return true if the puzzle starting in this state can be rearranged into the
   *         goal state.
   */
  public boolean solvable() {
    return get_inversions() % 2 == 1;
  }

  private int get_inversions() {
    int inversions = 0;
    String boardString = getBoardString();
    for (int i = 0; i < boardString.length(); i++) {
      for (int j = i; j < boardString.length(); j++) {
        if (Integer.parseInt(boardString.substring(j, j + 1)) > Integer.parseInt(boardString.substring(i, i + 1))) {
          inversions++;
          break;
        }
      }
    }
    return inversions;
  }

  private String getBoardString() {
    String boardString = "";
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        boardString += this.board[i][j];
      }
    }
    return boardString;
  }

  /**
   * Check if this state is the goal state, namely, if the array board[][] stores
   * the following contents:
   *
   * 1 2 3
   * 8 0 4
   * 7 6 5
   *
   * @return
   */
  public boolean isGoalState() {
    int[][] goalBoard = {
      { 1, 2, 3 },
      { 8, 0, 4 },
      { 7, 6, 5 }
    };
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.board[i][j] != goalBoard[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  /**
   * Write the board configuration according to the following format:
   *
   * a) Output row by row in three lines with no indentations.
   * b) Two adjacent tiles in each row have exactly one blank in between.
   * c) The empty square is represented by a blank.
   *
   * For example,
   *
   * 2 3
   * 1 8 4
   * 7 6 5
   *
   */
  @Override
  public String toString() {
    String output = "";
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        output += this.board[i][j] + " ";
      }
      output += "\n";
    }
    return output;
  }

  /**
   * Create a clone of this State object by copying over the board[][]. Set the
   * links previous,
   * next, and predecessor to null.
   *
   * The method is called by SuccessorState();
   */
  @Override
  public Object clone() {
    State output = new State();
    output.board = new int[3][3];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        output.board[i][j] = this.board[i][j];
      }
    }
    return output;
  }

  /**
   * Compare this state with the argument state. Two states are equal if their
   * arrays board[][]
   * have the same content.
   */
  @Override
  public boolean equals(Object o) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (((State) o).board[i][j] != this.board[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  /**
   * Evaluate the cost of this state as the sum of the number of moves from the
   * initial state and
   * the estimated number of moves to the goal state using the heuristic stored in
   * the instance
   * variable heu.
   *
   * If heu == TileMismatch, add up numMoves and the return values from
   * computeNumMismatchedTiles().
   * If heu == MahattanDist, add up numMoves and the return values of
   * computeMahattanDistance().
   * If heu == DoubleMoveHeuristic, add up numMoves and the return value of
   * computeNumSingleDoubleMoves().
   *
   * @return estimated number of moves from the initial state to the goal state
   *         via this state.
   * @throws IllegalArgumentException if heuristic is neither 0 nor 1.
   */
  public int cost() throws IllegalArgumentException {
    switch (heu) {
      case TileMismatch:
        return numMoves + computeNumMismatchedTiles();
      case ManhattanDist:
        return numMoves + computeManhattanDistance();
      case DoubleMoveHeuristic:
        return numMoves + computeNumSingleDoubleMoves();
      default:
        throw new IllegalAccessError();
    }
  }

  /**
   * Compare two states by the cost. Let c1 and c2 be the costs of this state and
   * the argument state s.
   *
   * @return -1 if c1 < c2
   *         0 if c1 = c2
   *         1 if c1 > c2
   *
   *         Call the method cost(). This comparison will be used in maintaining
   *         the OPEN list by the A* algorithm.
   */
  @Override
  public int compareTo(State s) {
    if (this.cost() < s.cost()) {
      return -1;
    } else if (this.cost() == s.cost()) {
      return 0;
    } else {
      return 1;
    }
  }

  /**
   * Return the value of the private variable numMismatchedTiles if it is
   * non-negative, and compute its
   * value otherwise.
   *
   * @return the number of mismatched tiles between this state and the goal state.
   */
  private int computeNumMismatchedTiles() {
    int[][] goalBoard = {
      { 1, 2, 3 },
      { 8, 0, 4 },
      { 7, 6, 5 }
    };
    int numMismatched = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (this.board[i][j] != goalBoard[i][j]) {
          numMismatched++;
        }
      }
    }
    return numMismatched;
  }

  /**
   * Return the value of the private variable ManhattanDistance if it is
   * non-negative, and compute its value
   * otherwise.
   *
   * @return the Manhattan distance between this state and the goal state.
   */
  private int computeManhattanDistance() {
    int dist = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        dist += getManhattanSingle(i, j);
      }
    }
    return dist;
  }

  private int getManhattanSingle(int in_i, int in_j) {
    int goal_i = -1;
    int goal_j = -1;
    int[][] goalBoard = {
      { 1, 2, 3 },
      { 8, 0, 4 },
      { 7, 6, 5 }
    };
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (goalBoard[i][j] == board[in_i][in_j]) {
          goal_i = i;
          goal_j = j;
        }
      }
    }
    return Math.abs(goal_i - in_i) + Math.abs(goal_j - in_j);
  }

  /**
   * Return the value of the private variable numSingleDoubleMoves if it is
   * non-negative, and compute its value
   * otherwise.
   *
   * @return the value of the private variable numSingleDoubleMoves that bounds
   *         from below the number of moves,
   *         single or double, which will take this state to the goal state.
   */
  private int computeNumSingleDoubleMoves() {
    int dist = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        dist += getDoubleManhattanSingle(i, j);
      }
    }
    return dist;
  }

  private int getDoubleManhattanSingle(int in_i, int in_j) {
    int goal_i = -1;
    int goal_j = -1;
    int[][] goalBoard = {
      { 1, 2, 3 },
      { 8, 0, 4 },
      { 7, 6, 5 }
    };
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (goalBoard[i][j] == board[in_i][in_j]) {
          goal_i = i;
          goal_j = j;
        }
      }
    }
    int i = Math.abs(goal_i - in_i);
    int j = Math.abs(goal_j - in_j);
    if (i == 2) {
      i = 1;
    }
    if (j == 2) {
      j = 2;
    }
    return i + j;
  }
}
