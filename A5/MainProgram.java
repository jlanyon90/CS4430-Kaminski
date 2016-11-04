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

public class MainProgram {
    //******************************************************************************
	public static void main(String[] args) throws SQLException, ClassNotFoundException, IOException {
		Class.forName("oracle.jdbc.driver.OracleDriver");

		Connection con = DriverManager.getConnection(getConnectionString(), "jlan", "password");
		con.setAutoCommit(false);
		FileWriter log = new FileWriter(new File("Log.txt"));
		log.write("\t\t\t\t\t\t\t\t\t\t\t Justin Lanyon & James Dilts\n");
		log.write("Logging started.\n");
		log.write("Connection Opened.\n");

		RequestHandler handler = new RequestHandler(con, log);
		log.write("********Before View********\n");
		handler.beforeAfterView();
		log.write("********End Before View********\n");

		// The name of the file to open.
        String fileName = "C:\\Users\\Owner\\workspace\\sqlA5\\src\\A5UserRequests.txt";
		String line = null;
		FileReader reqFReader = new FileReader(fileName);
		BufferedReader reqBReader = new BufferedReader(reqFReader);

		//Loop through Request File
		while((line = reqBReader.readLine()) != null) {
			switch (line.charAt(0)) {
				case 'A':
					handler.add(line);
					break;
				case 'D':
					handler.delete(line);
					break;
				case 'L':
					handler.list();
					break;
				case 'U':
					handler.update(line);
					break;
				default:
					log.write("Unknown Operation!\n");
					break;
			}
		}
		log.write("********After View********\n");
		handler.beforeAfterView();
		log.write("********End After View********\n");
		con.close();
		log.write("\nConnection closed.\n");
		log.close();
	}//END MAIN
    //******************************************************************************
	private static String getConnectionString()
	{
		String prefix = "jdbc:oracle:thin:@";
		String computerName = "localhost"; //NAME OF YOUR COMPUTER, or "localhost" (maybe)
		String port = "1521";
		String databaseName = "orcl"; //NAME OF YOUR DATABASE (probably default "xe")
		return prefix + computerName + ":" + port + ":" + databaseName;
	}//END getConnectionString


}//END CLASS MAINPROGRAM
