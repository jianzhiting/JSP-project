package tea;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/teaMeta")
public class TeaMetaphase extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TeaMetaphase() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		
		int state=3;
		String student_id = request.getParameter("student_id");
		String pass = request.getParameter("pass");
		if(pass!=null)
		state=1;
		DataBase db = new DataBase();
		try {
			String sql = "update tb_metaphase set review_state='"+state+"' where student_id='"+student_id+"'";
			db.stmt.executeUpdate(sql);
			db.stmt.close();
			db.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("teacher/check/metaphase.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
