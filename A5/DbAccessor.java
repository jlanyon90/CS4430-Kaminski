/*************************************************
* Course: CS 4430 – Fall 2015
* Assignment 5
* Name: Justin Lanyon & James Dilts
* E-mail: justin.j.lanyon@wmich.edu , james.a.dilts@wmich.edu
* Submitted: 12/04/2015
*
*
* THIS CODE WAS BUILT UPON CODE PROVIDED BY ALEC CARPENTER AND CODY BEEBE
/*************************************************/


import java.sql.*;
import java.io.*;
import java.util.*;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.rowset.OracleCachedRowSetReader;

public class DbAccessor {

	//******************************************************************************
    // This method just dumps the data out without formatting, alignment or labels.
    // For nicer output, the program could use the data in the sqlStr
    //              (parse it to find the column names and table names)
    //      and use that data to query the DB catalog for data_types
    //      to use for formatting the output for the user.
    //      (SELECT column_name, data_type FROM user_tab_columns
    //              WHERE table_name = tableNameFromSqlStr).
    //------------------------------------------------------------------------------

    static FileWriter log;

    public DbAccessor(FileWriter logger) {
        log = logger;
    }

    public static void SelectData(String sqlString, Connection con) throws SQLException, IOException
    {
    	log.write(String.format(sqlString+"\n\n"));
    	try
    	{
	        Statement cmd = con.createStatement();

	        ResultSet rs = cmd.executeQuery(sqlString);
	        ResultSetMetaData rsmd = rs.getMetaData();

	        int columnsNumber = rsmd.getColumnCount();
	        boolean haveRows = false;

	        while (rs.next())
	        {
	        	if (!haveRows) //Print the column headers just once, and only if there are rows (haveRows changes later)
	        	{
	        		if (columnsNumber > 1)
	    	        {
	    	        	for (int i = 1; i <= columnsNumber; i++) //columns start with 1 sadly
	    	        	{
	    	        		if (i > 1)
	    	            	{
	    	            		log.write(String.format("\t")); // first	second	etc.
	    	            	}
	    	        		log.write(String.format("%21s", rsmd.getColumnName(i)));
	    	        	}
	    	        	log.write(String.format("\n"));
	    	        }
	        	}

	        	haveRows = true;

	            for (int i = 1; i <= columnsNumber; i++)
	            {
	                if (i > 1)
	            	{
	            		log.write(String.format("\t"));
	            	}

	                log.write(String.format("%21s", rs.getString(i)));
	            }
	            log.write(String.format("\n"));
	        }
	        log.write(String.format("\n"));
	        if (!haveRows)
	        {
	        	log.write("No rows selected\n\n");
	        }
    	}
    	catch (SQLException e)
    	{
    		log.write(String.format("SQL Exception occured: " + e.toString()));
    	}
    }//END SELECTDATA

    //******************************************************************************
    public static void ChangeData(String sqlString, Connection con) throws SQLException, IOException
	{
    	log.write(sqlString);
    	log.write("\n");

    	try
    	{
			Statement cmd = con.createStatement();
			String whichOp = sqlString.substring(0, 6);
			String req = null;

            switch (whichOp.charAt(0)) {
                case 'I':
                    req = "Added";
                    break;
                case 'U':
                    req = "Updated";
                    break;
                case 'D':
                    req = "Deleted";
                    break;
            }

			try
			{
				int numRowsChanged = cmd.executeUpdate(sqlString);
				if (numRowsChanged == 0)
					log.write("SORRY, no rows changed\n");
				else
					log.write(String.format(">> OK, product %s\n", req));
			}
			catch (Exception e)
			{
				log.write(String.format("ERROR - did not %s the data: %s\n", whichOp, e.toString()));
			}
			log.write("\n");
    	}
    	catch (SQLException e)
    	{
    		log.write(String.format("SQL Exception occured: " + e.toString()));
    	}
	}//END CHANGEDATA
}//END DbAccessor
