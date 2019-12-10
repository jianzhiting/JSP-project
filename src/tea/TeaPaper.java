package tea;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/teaPaper")
public class TeaPaper extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TeaPaper() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String student_id = request.getParameter("student_id");
		if(request.getParameter("guide_grade") != "") {
			int guide_grade = Integer.parseInt(request.getParameter("guide_grade"));			
			DataBase db = new DataBase();
			try {
				String sql = "update tb_review set guide_grade="+guide_grade+" where student_id='"+student_id+"'";
				db.stmt.executeUpdate(sql);
				sql = "select review_grade from tb_review where student_id='"+student_id+"'";
				db.rs = db.stmt.executeQuery(sql);
				db.rs.next();
				if(db.rs.getString(1) != null) {
					int review_grade = Integer.parseInt(db.rs.getString(1));
					int paper_grade = (guide_grade + review_grade)/2;
					if(paper_grade < 60) {
						sql = "update tb_paper set review_state='2' where student_id='"+student_id+"'";
						db.stmt.executeUpdate(sql);
						sql = "update tb_review set guide_grade=null,review_grade=null where student_id='"+student_id+"'";
					}
					else {
						sql = "update tb_paper set paper_grade='"+paper_grade+"' where student_id='"+student_id+"'";
					}
					db.stmt.executeUpdate(sql);
				}
				db.Close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		request.getRequestDispatcher("teacher/directorReviewPaper.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
