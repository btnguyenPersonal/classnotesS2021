package edu.iastate.cs472.proj2;

import proj2Solution.CheckersData;

/**
 * 
 * @author 
 *
 */


/**
 * This class implements the Alpha-Beta pruning algorithm to find the best 
 * move at current state.
*/
public class AlphaBetaSearch extends AdversarialSearch {

    /**
     * The input parameter legalMoves contains all the possible moves.
     * It contains four integers:  fromRow, fromCol, toRow, toCol
     * which represents a move from (fromRow, fromCol) to (toRow, toCol).
     * It also provides a utility method `isJump` to see whether this
     * move is a jump or a simple move.
     *
     * @param legalMoves All the legal moves for the agent at current step.
     */
    public CheckersMove makeMove(CheckersMove[] legalMoves) {
        // The checker board state can be obtained from this.board,
        // which is a int 2D array. The numbers in the `board` are
        // defined as
        // 0 - empty square,
        // 1 - red man
        // 2 - red king
        // 3 - black man
        // 4 - black king
        System.out.println(board);
        System.out.println();

        // TODO 
        
        // Return the move for the current state.
        // Here, we simply return the first legal move for demonstration.
        return legalMoves[0];
    }
    
    // TODO
    // Implement your helper methods here.  Only two are offered with templates.
    
    /**
     * You can change the type of the third parameter player from int to enum for 
     * readability if you like. 
     * 
     * @param state
     * @param depth
     * @param player
     * @return  utility score if a terminal state
     *          value according to some heuristic if a non-terminal state
     */
    private double evalValue(CheckersData state, int depth, int player)
    {
    	// TODO 
    	return 0; 
    }
    
    // Calculate the score on a non-terminal state
    private double heuristic(CheckersData state)
    {
    	// TODO 
    	return 0; 
    }
    
    // other methods
    // ... 

}
