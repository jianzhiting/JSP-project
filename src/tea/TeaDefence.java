package tea;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/teaDefence")
public class TeaDefence extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public TeaDefence() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String student_id = request.getParameter("student_id");
		String capital_grade = request.getParameter("capital_grade");
		String mem_one_grade = request.getParameter("mem_one_grade");
		String mem_two_grade = request.getParameter("mem_two_grade");
		String sql = "";
		DataBase db = new DataBase();
		try {
			if(capital_grade!=""&&mem_one_grade!=""&&mem_two_grade!="") {				
				sql = "update tb_review set capital_grade="+capital_grade+",mem_one_grade="+mem_one_grade+",mem_two_grade="+mem_two_grade+" "+
					"where student_id='"+student_id+"'";
				db.stmt.executeUpdate(sql);
				int defence_grade = (Integer.parseInt(capital_grade)+Integer.parseInt(mem_one_grade)+Integer.parseInt(mem_two_grade))/3;
				sql = "select paper_grade from tb_paper where student_id='"+student_id+"'";
				db.rs = db.stmt.executeQuery(sql);
				db.rs.next();
				int paper_grade = Integer.parseInt(db.rs.getString(1));
				int final_grade = (int)(0.8*paper_grade + 0.2*defence_grade);
				sql = "update tb_paper set defence_grade="+defence_grade+",final_grade="+final_grade+" where student_id='"+student_id+"'";
				db.stmt.executeUpdate(sql);
				request.getRequestDispatcher("teacher/recordGrade.jsp").forward(request, response);
				db.stmt.close();
				db.conn.close();
			}
			else {
				request.getRequestDispatcher("teacher/recordGrade.jsp?s=1").forward(request, response);		
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
