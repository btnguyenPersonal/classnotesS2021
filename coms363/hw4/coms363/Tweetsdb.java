package coms363;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.sql.*;

import javax.swing.*;
import javax.swing.border.LineBorder;
/*
 * Author: ComS 363 Teaching Staff
 * Examples of static queries, parameterized queries, and 
 * transactions
 * You can use this example to build your queries upon
 *
 * @author Benjamin Trung Nguyen: btnguyen
 *
 */
public class Tweetsdb {
    public static String[] loginDialog() {
        // asking for a username and password to access the database.

        String result[] = new String[2];
        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints cs = new GridBagConstraints();

        cs.fill = GridBagConstraints.HORIZONTAL;

        JLabel lbUsername = new JLabel("Username: ");
        cs.gridx = 0;
        cs.gridy = 0;
        cs.gridwidth = 1;
        panel.add(lbUsername, cs);

        JTextField tfUsername = new JTextField(20);
        cs.gridx = 1;
        cs.gridy = 0;
        cs.gridwidth = 2;
        panel.add(tfUsername, cs);

        JLabel lbPassword = new JLabel("Password: ");
        cs.gridx = 0;
        cs.gridy = 1;
        cs.gridwidth = 1;
        panel.add(lbPassword, cs);

        JPasswordField pfPassword = new JPasswordField(20);
        cs.gridx = 1;
        cs.gridy = 1;
        cs.gridwidth = 2;
        panel.add(pfPassword, cs);
        panel.setBorder(new LineBorder(Color.GRAY));

        String[] options = new String[] { "OK", "Cancel" };
        int ioption = JOptionPane.showOptionDialog(null, panel, "Login", JOptionPane.OK_OPTION,
                JOptionPane.PLAIN_MESSAGE, null, options, options[0]);

        // store the username in the first slot.
        // store the password in the second slot.

        if (ioption == 0) // pressing OK button
        {
            result[0] = tfUsername.getText();
            result[1] = new String(pfPassword.getPassword());
        }
        return result;
    }

    /**
     * @param stmt
     * @param sqlQuery
     * @throws SQLException
     */
    // run a static SQL query
    private static void runQuery(Statement stmt, String sqlQuery) throws SQLException {
        // ResultSet is used to store the data returned by DBMS when issuing a static query
        ResultSet rs;

        // ResultSetMetaData is used to find meta data about the data returned
        ResultSetMetaData rsMetaData;
        String toShow;

        // Send the SQL query to the DBMS
        rs = stmt.executeQuery(sqlQuery);

        // get information about the returned result.
        rsMetaData = rs.getMetaData();
        System.out.println(sqlQuery);
        toShow = "";

        // iterate through each item in the returned result
        while (rs.next()) {
            // concatenate the columns in each row
            for (int i = 0; i < rsMetaData.getColumnCount(); i++) {

                toShow += rs.getString(i + 1) + ", ";
            }
            toShow += "\n";
        }
        // show the dialog box with the returned result by DBMS
        JOptionPane.showMessageDialog(null, toShow);
        rs.close();
    }

    private static void deleteUser(Connection conn, String user_screen_name){

        if (conn==null 
                || post_day==null
                || post_month==null
                || post_year==null
                || texts==null
                || retweetCt==null
                || user_screen_name==null
                ) throw new NullPointerException();
        try {
            /* we want to make sure that all SQL statements for insertion 
               of a new food are considered as one unit.
               That is all SQL statements between the commit and previous commit 
               get stored permanently in the DBMS or  all the SQL statements 
               in the same transaction are rolled back.

               By default, the isolation level is TRANSACTION_REPEATABLE_READ
               By default, each SQL statement is one transaction

               conn.setAutoCommit(false) is to 
               specify what SQL statements are in the same transaction 
               by a developer.
               Several SQL statements can be put in one transaction.
               */ 

            conn.setAutoCommit(false);
            // full protection against interference from other transaction
            // prevent dirty read
            // prevent unrepeatable reads
            // prevent phantom reads
            conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE );

            PreparedStatement inststmt = conn.prepareStatement(" delete from Mentions where screen_name=? ");
            inststmt.setString(1, user_screen_name);
            int rowcount = inststmt.executeUpdate();
            System.out.println("Number of mention rows updated:" + rowcount);
            inststmt.close();

            PreparedStatement inststmt = conn.prepareStatement(" delete from Mentions join Tweets join Users where Users.screen_name=? and Tweets.user_screen_name = Users.screen_name and Tweets.tid = Mentions.tid");
            inststmt.setString(1, user_screen_name);
            int rowcount = inststmt.executeUpdate();
            System.out.println("Number of mention rows updated:" + rowcount);
            inststmt.close();

            PreparedStatement inststmt = conn.prepareStatement(" delete from HashTags join Tweets join Users where Users.screen_name=? and Tweets.user_screen_name = Users.screen_name and Tweets.tid = HashTags.tid");
            inststmt.setString(1, user_screen_name);
            int rowcount = inststmt.executeUpdate();
            System.out.println("Number of hashtags rows updated:" + rowcount);
            inststmt.close();

            PreparedStatement inststmt = conn.prepareStatement(" delete from URLs join Tweets join Users where Users.screen_name=? and Tweets.user_screen_name = Users.screen_name and Tweets.tid = URLs.tid");
            inststmt.setString(1, user_screen_name);
            int rowcount = inststmt.executeUpdate();
            System.out.println("Number of url rows updated:" + rowcount);
            inststmt.close();

            PreparedStatement inststmt = conn.prepareStatement(" delete from Tweets where user_screen_name=? ");
            inststmt.setString(1, user_screen_name);
            int rowcount = inststmt.executeUpdate();
            System.out.println("Number of tweet rows updated:" + rowcount);
            inststmt.close();

            PreparedStatement inststmt = conn.prepareStatement(" delete from Users where screen_name=? ");
            inststmt.setString(1, user_screen_name);
            int rowcount = inststmt.executeUpdate();
            System.out.println("Number of user rows updated:" + rowcount);
            inststmt.close();

            // Tell DBMS to make sure all the changes you made from 
            // the prior commit is saved to the database
            conn.commit();

            // Reset the autocommit to commit per SQL statement
            conn.setAutoCommit(true);

        } catch (SQLException e) {}

    }

    /**
     * Show an example of a transaction
     * @param conn Valid database connection
     * 		  fname: Name of a food to check
     */
    private static void insertTweet(Connection conn, String tid, String post_day, String post_month, String post_year, String texts, String retweetCt, String user_screen_name){

        if (conn==null 
                || post_day==null
                || post_month==null
                || post_year==null
                || texts==null
                || retweetCt==null
                || user_screen_name==null
                ) throw new NullPointerException();
        try {
            /* we want to make sure that all SQL statements for insertion 
               of a new food are considered as one unit.
               That is all SQL statements between the commit and previous commit 
               get stored permanently in the DBMS or  all the SQL statements 
               in the same transaction are rolled back.

               By default, the isolation level is TRANSACTION_REPEATABLE_READ
               By default, each SQL statement is one transaction

               conn.setAutoCommit(false) is to 
               specify what SQL statements are in the same transaction 
               by a developer.
               Several SQL statements can be put in one transaction.
               */ 

            conn.setAutoCommit(false);
            // full protection against interference from other transaction
            // prevent dirty read
            // prevent unrepeatable reads
            // prevent phantom reads
            conn.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE );

            Statement stmt = conn.createStatement();
            ResultSet rs;
            int id=0;

            // get the maximum id from the food table
            rs = stmt.executeQuery("select max(tid) from Tweets");
            while (rs.next()) {
                // 1 indicates the position of the returned result we want to get
                id = rs.getInt(1);
            }
            rs.close();
            stmt.close();
            // once done, close the DBMS resources

            /* Example of a parameterized query, which is
               that have ? in them where ? is 
               replaced by a value obtained from a user
               */
            PreparedStatement inststmt = conn.prepareStatement(
                    " insert into Tweets (tid,post_day,post_month,post_year,texts,retweetCt,user_screen_name) values(?,?,?,?,?,?) ");

            inststmt.setInt(1, id+1);
            inststmt.setInt(2, Integer.parseInt(post_day));
            inststmt.setInt(3, Integer.parseInt(post_month));
            inststmt.setInt(4, Integer.parseInt(post_year));
            inststmt.setString(5, texts);
            inststmt.setInt(6, Integer.parseInt(retweetCt));
            inststmt.setString(7, user_screen_name);

            // tell DBMS to insert the Tweets into the table
            int rowcount = inststmt.executeUpdate();

            // show how many rows are impacted, should be one row if 
            // successful
            // if not successful, SQLException occurs.
            System.out.println("Number of rows updated:" + rowcount);
            inststmt.close();

            // Tell DBMS to make sure all the changes you made from 
            // the prior commit is saved to the database
            conn.commit();

            // Reset the autocommit to commit per SQL statement
            conn.setAutoCommit(true);

        } catch (SQLException e) {}

    }

    /* this example shows how to use a parameterized SQL query
       @param conn: Valid connection to a dbms
       iname: the name of the ingredient to check
       */

    private static void getTopHashTagUsers(Connection conn, String hashtag, String post_month, String post_year, String state) {

        if (conn==null 
                || hashtag==null
                || post_month==null
                || post_year==null
                || state==null
                ) throw new NullPointerException();
        try {

            ResultSet rs =null;
            String toShow ="";

            /* Another example of a parameterized query
               Notice the use of PreparedStatement instead of Statement 
               used in a static query.
             * 
             */
            PreparedStatement lstmt = conn.prepareStatement(
                    "select count(Tweets.tid) as tweet_count,Users.screen_name, Users.category, from Tweets, Users, HashTags where hashtag=? and post_month=? and post_year=? and state=? group by Users.screen_name order by count(Tweets.tid) desc limit 5");

            // clear previous parameter values
            lstmt.clearParameters();

            lstmt.setString(1, hashtag);
            lstmt.setInt(2, Integer.parseInt(post_month));
            lstmt.setInt(3, Integer.parseInt(post_year));
            lstmt.setString(4, state);

            // execute the query
            rs=lstmt.executeQuery();

            // advance the cursor to the first record
            rs.next();
            int count = rs.getInt(1);

            JOptionPane.showMessageDialog(null, toShow);
            lstmt.close();
            rs.close();

        } catch (SQLException e) {}

    }

    public static void main(String[] args) {
        // useSSL=false means plain text allowed
        //String dbServer = "jdbc:mysql://localhost:3306/fooddb?useSSL=false";
        // useSSL=true; data are encrypted when sending between DBMS and 
        // this program

        String dbServer = "jdbc:mysql://localhost:3306/project?useSSL=true";
        String userName = "";
        String password = "";

        String result[] = loginDialog();
        userName = result[0];
        password = result[1];

        Connection conn=null;
        Statement stmt=null;
        if (result[0]==null || result[1]==null) {
            System.out.println("Terminating: No username nor password is given");
            return;
        }
        try {
            // load JDBC driver
            // must be in the try-catch-block
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbServer, userName, password);

            stmt = conn.createStatement();
            String sqlQuery = "";

            String option = "";
            // TODO change to a-c and e instead of 1-4
            String instruction = "Enter 1: Insert a new Tweet into the tweets relation" + "\n"
                + "Enter 2: Delete a user from the users relation given the user's screen name" + "\n" 
                + "Enter 3: Report top 5 twitter users who used a given hashtag the most in their tweets posted in a given month of given year" + "\n"
                + "Enter 4: Quit Program";

            while (true) {
                option = JOptionPane.showInputDialog(instruction);
                if (option.equals("1")) {
                    String post_day=JOptionPane.showInputDialog("Enter the day it was posted:");
                    String post_month=JOptionPane.showInputDialog("Enter the month the tweet was posted:");
                    String post_year=JOptionPane.showInputDialog("Enter the year the tweet was posted:");
                    String texts=JOptionPane.showInputDialog("Enter the texts of the tweet:");
                    String retweetCt=JOptionPane.showInputDialog("Enter how many retweets the tweet got:");
                    String user_screen_name=JOptionPane.showInputDialog("Enter the screen name of the user that posted:");
                    insertTweet(conn, post_day, post_month, post_year, texts, retweetCt, user_screen_name);
                } else if (option.equals("2")) {
                    String user_screen_name=JOptionPane.showInputDialog("Enter the screen name of the user you would like to delete:");
                    String confirmation=JOptionPane.showInputDialog("Warning: all the tweets posted by this user will be deleted, do you still want to delete user (y/n):");
                    if (confirmation == "y") {
                        deleteUser(conn, user_screen_name);
                    }
                } else if (option.equals("3")) {
                    String hashtag=JOptionPane.showInputDialog("Enter the hashtag:");
                    String post_month=JOptionPane.showInputDialog("Enter the month the tweet was posted:");
                    String post_year=JOptionPane.showInputDialog("Enter the year the tweet was posted:");
                    String state=JOptionPane.showInputDialog("Enter the year the state users need to be from:");
                    getTopHashTagUsers(conn, hashtag, post_month, post_year, state);
                } else {
                    break;
                }
            }
            // close the statement
            if (stmt != null) stmt.close();
            // close the connection
            if (conn != null) conn.close();
        } catch (Exception e) {

            System.out.println("Program terminates due to errors or user cancelation");
            e.printStackTrace(); // for debugging; 
        }
    }

}