package col;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/colTopic")
public class StudentTopic extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public StudentTopic() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");		
		int state=4;
		String student_id = request.getParameter("student_id");
		String pass = request.getParameter("pass");
		if(pass!=null)
		state=2;
		DataBase db = new DataBase();
		try {
			String sql = "update tb_student_topic set review_state='"+state+"' where student_id='"+student_id+"'";
			db.stmt.executeUpdate(sql);
			sql = "select topic_name,teacher_id from tb_student_topic where student_id='"+student_id+"'";
			db.rs = db.stmt.executeQuery(sql);
			db.rs.next();
			String topic_name = db.rs.getString(1).toString();
			String teacher_id = db.rs.getString(2).toString();
			db.rs = db.stmt.executeQuery("select * from tb_task where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'");
			if(!db.rs.next()&&state == 2)
				sql = "insert into tb_task(topic_name,teacher_id) values('"+topic_name+"','"+teacher_id+"')";
			else
				sql = "delete from tb_task where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'";
			db.stmt.executeUpdate(sql);
			db.Close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("college/checkTopic/studentTopic.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
