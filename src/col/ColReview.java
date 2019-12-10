package col;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/colReview")
public class ColReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ColReview() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		
		int state=2;
		String student_id = request.getParameter("student_id");
		String college_id = (String)request.getSession().getAttribute("id");
		String pass = request.getParameter("pass");
		if(pass!=null)
		state=1;
		String sql = "";
		DataBase db = new DataBase();
		try {
			sql = "select count(*) from tb_defence_team where college_id='"+college_id+"'";
			db.rs = db.stmt.executeQuery(sql);
			db.rs.next();
			int cnt = Integer.parseInt(db.rs.getString(1));
			if(cnt != 0) {				
				sql = "update tb_paper set review_state='"+state+"' where student_id='"+student_id+"'";
				db.stmt.executeUpdate(sql);
				if(state == 1) {
					int team_id = (int)(Math.random()*cnt) + 1;
					sql = "update tb_review set team_id='"+team_id+"' where student_id='"+student_id+"'";
				}
				else {
					sql = "update tb_review set team_id=null where student_id='"+student_id+"'";
				}
				db.stmt.executeUpdate(sql);
				db.Close();
				request.getRequestDispatcher("college/checkGrade/reviewGrade.jsp").forward(request, response);
			}
			else {
				db.Close();
				request.getRequestDispatcher("college/checkGrade/reviewGrade.jsp?s=1").forward(request, response);		
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
