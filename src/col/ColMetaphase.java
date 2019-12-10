package col;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/colMeta")
public class ColMetaphase extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ColMetaphase() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");		
		int state=4;
		String student_id = request.getParameter("student_id");
		String review_teacher = request.getParameter("review_teacher");
		String college_id = (String)request.getSession().getAttribute("id") ;
		String pass = request.getParameter("pass");
		if(pass!=null)
		state=2;
		DataBase db = new DataBase();
		try {
			String sql = "update tb_metaphase set review_state='"+state+"' where student_id='"+student_id+"'";
			db.stmt.executeUpdate(sql);
			if(state==4)
				sql = "delete from tb_review where student_id='"+student_id+"'";
			else {				
				sql = "select teacher_id from tb_student_topic where student_id='"+student_id+"'";
				db.rs = db.stmt.executeQuery(sql);
				db.rs.next();
				String teacher_id = db.rs.getString(1).toString();
				sql = "select * from tb_review where student_id='"+student_id+"'";
				db.rs = db.stmt.executeQuery(sql);
				if(!db.rs.next())
					sql = "insert into tb_review(student_id,guide_teacher,review_teacher,college_id) values('"+student_id+"','"+teacher_id+"','"+review_teacher+"','"+college_id+"')";
				else
					sql = "update tb_review set guide_teacher='"+teacher_id+"',review_teacher='"+review_teacher+"'";
				db.rs.close();
			}
			db.stmt.executeUpdate(sql);
			db.stmt.close();
			db.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("college/checkReport/metaphase.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
