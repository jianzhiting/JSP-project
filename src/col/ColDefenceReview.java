package col;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/colDefenceReview")
public class ColDefenceReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ColDefenceReview() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		
		int state=2;
		String student_id = request.getParameter("student_id");
		String pass = request.getParameter("pass");
		if(pass!=null)
		state=1;
		String sql = "";
		DataBase db = new DataBase();
		try {
			sql = "update tb_paper set review_state='"+state+"' where student_id='"+student_id+"'";
			db.stmt.executeUpdate(sql);
			db.stmt.close();
			db.conn.close();
			request.getRequestDispatcher("college/checkGrade/defenceGrade.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
