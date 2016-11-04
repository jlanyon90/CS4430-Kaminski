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

public class RequestHandler {

	private static String sqlString;
	static DbAccessor DBAccess;
	static Connection connector;
	static FileWriter log;

	//******************************************************************************
	public RequestHandler(Connection con, FileWriter logger){
		connector = con;
		log = logger;
		DBAccess = new DbAccessor(log);
	}//END CONSTRUCTOR

	//******************************************************************************

    public static void list() throws SQLException, IOException
    {

        sqlString = "SELECT * FROM Product ORDER BY ProductName";    // List all products by name
        DBAccess.SelectData(sqlString, connector);
        log.write("\n\n");

    }//END LIST

  //******************************************************************************

    public static void add(String input) throws SQLException, IOException
    {				String [] params= input.split(" ");
					sqlString = "SELECT * FROM Product WHERE ProductID = "+ params[1];
					Statement cmd = connector.createStatement();
					int numRowsChanged = cmd.executeUpdate(sqlString);
					sqlString = "INSERT INTO Product VALUES (" +params[1].trim()+",'"+params[2].trim()+
							"',20,5,"+params[3].trim()+",'"+params[4].trim()+"',20)";
					if (numRowsChanged == 0){
						DBAccess.ChangeData(sqlString, connector);
	        			connector.commit();
					}else{
						log.write(String.format(sqlString+"\n"));
						log.write(String.format(">> ERROR: existing ProductID\n\n"));
					}

    }//END ADD
    //******************************************************************************
    public static void update(String input) throws SQLException, IOException
    {
		String[] params = input.split(" ");
        sqlString = "UPDATE Product SET QuanInStock = QuanInStock +  " +
					params[2] +     // OK                     // OK
                    " WHERE ProductID = " +
					params[1];
        DBAccess.ChangeData(sqlString, connector);
        connector.commit();

    }//END UPDATE
    //******************************************************************************
    public static void delete(String input) throws SQLException, IOException
    {
    	String[] params = input.split(" ");
        sqlString = "Select OrderId, Quantity from OrderDetails WHERE ProductID = "+params[1];
        DBAccess.SelectData(sqlString, connector);
        //log.write("\n");

        sqlString = "DELETE FROM OrderDetails WHERE ProductID = "+params[1];
        DBAccess.ChangeData(sqlString, connector);//DELETES OrderDetails tuples
        //log.write("\n");
    	sqlString = "DELETE FROM Product WHERE ProductID = "+params[1];
        DBAccess.ChangeData(sqlString, connector);
        connector.commit();
    }//END DELETE

	public static void beforeAfterView() throws SQLException, IOException{
		sqlString = "SELECT * FROM Product ORDER BY ProductID";
		DBAccess.SelectData(sqlString, connector);

		sqlString = "SELECT PONo, ProductID FROM PurchaseOrder ORDER BY PONo";
		DBAccess.SelectData(sqlString, connector);
		sqlString = "SELECT * FROM OrderDetails ORDER BY OrderID, ProductID";
		DBAccess.SelectData(sqlString, connector);
		sqlString = "SELECT SupplierID, Name FROM Supplier ORDER BY SupplierID";
		DBAccess.SelectData(sqlString, connector);
	}//end beforeAfterView
}//END CLASS RequestHandler
