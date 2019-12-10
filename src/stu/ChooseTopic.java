package stu;

import java.io.IOException;
import java.sql.SQLException;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/stuChooseTopic")
public class ChooseTopic extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ChooseTopic() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String c = request.getParameter("choose");
		if(c !=null) {
		StringTokenizer choose = new StringTokenizer(c);
			String topic_name = choose.nextToken();
			String teacher_id = choose.nextToken();
			String student_id = request.getSession().getAttribute("id").toString();
			DataBase db = new DataBase();
			try {
				db.rs = db.stmt.executeQuery("select * from tb_student_topic where student_id='"+student_id+"'");
				if(db.rs.next())
					db.stmt.executeUpdate("delete from tb_student_topic where student_id='"+student_id+"'");
				db.stmt.executeUpdate("insert into tb_student_topic values('"+student_id+"','"+topic_name+"','"+teacher_id+"','0')");
			} catch (SQLException e) {
				e.printStackTrace();
			}
			db.Close();	
		}
		request.getRequestDispatcher("student/chooseTopic.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
