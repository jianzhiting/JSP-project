package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.JOptionPane;

public class DataBase {
	public Connection conn;
	public Statement stmt;
	public ResultSet rs;
	
	public DataBase(){
		try {		  
			Class.forName("oracle.jdbc.driver.OracleDriver");  
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/halo","system","Jz1997zt");
			stmt = conn.createStatement();
			rs = null;
		}
		catch(ClassNotFoundException e){
			JOptionPane.showMessageDialog(null,e.toString());
		}
	    catch (SQLException e1) {
	    	JOptionPane.showMessageDialog(null,e1.toString(),"check", JOptionPane.ERROR_MESSAGE);
	    }
	}
	
	public void Close() {
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
