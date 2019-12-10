package com;

import com.DataBase;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/check")
public class CheckLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public CheckLogin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String choice = request.getParameter("choice");
		DataBase db = new DataBase();
		request.getSession().setAttribute("id", id);
		request.getSession().setAttribute("choice", choice);
		
		String sql = "select * from tb_" + choice + " where " + choice + "_id = '" + id + "'";
		try {
			db.rs = db.stmt.executeQuery(sql);
			if(db.rs.next() && db.rs.getString(2).equals(password)) {
				request.getSession().setAttribute("name", db.rs.getString(3));
				request.getRequestDispatcher(choice + "/"+ choice +".jsp").forward(request, response);
			}
			else
				request.getRequestDispatcher("login.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		db.Close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
