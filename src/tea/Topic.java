package tea;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/teaTopic")
public class Topic extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public Topic() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String topic_name = request.getParameter("topic");
		String introduction = request.getParameter("introduction");
		String teacher_id = request.getSession().getAttribute("id").toString();
		DataBase db = new DataBase();
		
		String sql = "select * from tb_topic where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'";
		try {
			db.rs = db.stmt.executeQuery(sql);
			if(db.rs.next()) {
				sql = "update tb_topic set introduction='"+introduction+"',review_state='0' where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'";
			}
			else
				sql = "insert into tb_topic values('"+topic_name+"','"+teacher_id+"','"+introduction+"','0')";
			db.stmt.executeUpdate(sql);
			db.Close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("teacher/topic.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
