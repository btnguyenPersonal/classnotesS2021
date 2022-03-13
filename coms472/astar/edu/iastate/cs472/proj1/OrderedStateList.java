/**
 * @author btnguyen
 *
 */

package edu.iastate.cs472.proj1;

import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 *
 * @author
 *
 */

/**
 * This class describes a circular doubly-linked list of states to represent both the OPEN and CLOSED lists
 * used by the A* algorithm.  The states on the list are sorted in the
 *
 *     a) order of non-decreasing cost estimate for the state if the list is OPEN, or
 *     b) lexicographic order of the state if the list is CLOSED.
 *
 */
public class OrderedStateList
{

  /**
   * Implementation of a circular doubly-linked list with a dummy head node.
   */
  private State head;           // dummy node as the head of the sorted linked list
  private int size = 0;

  private boolean isOPEN;       // true if this OrderedStateList object is the list OPEN and false
                                // if the list CLOSED.

  /**
   *  Default constructor constructs an empty list. Initialize heuristic. Set the fields next and
   *  previous of head to the node itself. Initialize instance variables size and heuristic.
   *
   * @param h
   * @param isOpen
   */
  public OrderedStateList(Heuristic h, boolean isOpen)
  {
    int[][] emptyBoard = new int[3][3];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        emptyBoard[i][j] = -1;
      }
    }
    head = new State(emptyBoard);
    head.next = head;
    head.previous = head;
    State.heu = h;   // initialize heuristic used for evaluating all State objects.
  }


  public int size()
  {
    return size;
  }


  /**
   * A new state is added to the sorted list.  Traverse the list starting at head.  Stop
   * right before the first state t such that compareStates(s, t) <= 0, and add s before t.
   * If no such state exists, simply add s to the end of the list.
   *
   * Precondition: s does not appear on the sorted list.
   *
   * @param s
   */
  public void addState(State s)
  {
    size++;
    State current = head.next;
    boolean isSet = false;
    while (compareStates(current, head) != 0) {
      if (compareStates(s, current) <= 0) {
        s.next = current;
        s.previous = current.previous;
        (current.previous).next = s;
        current.previous = s;
        isSet = true;
        break;
      }
      current = current.next;
    }
    if (!isSet) {
      s.next = head;
      s.previous = head.previous;
      (head.previous).next = s;
      head.previous = s;
    }
  }


  /**
   * Conduct a sequential search on the list for a state that has the same board configuration
   * as the argument state s.
   *
   * Calls equals() from the State class.
   *
   * @param s
   * @return the state on the list if found
   *         null if not found
   */
  public State findState(State s)
  {
    State current = head.next;
    for (int i = 0; i < size; i++) {
      if (s.equals(current)) {
        return current;
      }
      current = current.next;
    }
    return null;
  }


  /**
   * Remove the argument state s from the list.  It is used by the A* algorithm in maintaining
   * both the OPEN and CLOSED lists.
   *
   * @param s
   * @throws IllegalStateException if s is not on the list
   */
  public void removeState(State s) throws IllegalStateException
  {
    State current = head.next;
    for (int i = 0; i < size; i++) {
      if (compareStates(current, s) == 0) {
        current.next = (current.next).next;
        (current.next).previous = current;
        size--;
        break;
      }
      current = current.next;
    }
    throw new IllegalStateException("State not found");
  }

  public void print() {
    State current = head.next;
    int i = 1;
    for (int j = 0; j < size; j++) {
      System.out.println("    i: " + i + "\n" + current);
      i++;
      current = current.next;
    }
  }


  /**
   * Remove the first state on the list and return it.  This is used by the A* algorithm in maintaining
   * the OPEN list.
   *
   * @return
   */
  public State remove()
  {
    State first = head.next;
    head.next = (head.next).next;
    (head.next).previous = head;
    size--;
    return first;
  }


  /**
   * Compare two states depending on whether this OrderedStateList object is the list OPEN
   * or the list CLOSE used by the A* algorithm.  More specifically,
   *
   *     a) call the method compareTo() of the State if isOPEN == true, or
   *     b) create a StateComparator object to call its compare() method if isOPEN == false.
   *
   * @param s1
   * @param s2
   * @return -1 if s1 is less than s2 as determined by the corresponding comparison method
   *         0  if they are equal
   *         1  if s1 is greater than s2
   */
  private int compareStates(State s1, State s2)
  {
    return s1.compareTo(s2);
  }
}
