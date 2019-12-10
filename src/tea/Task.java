package tea;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/teaTask")
public class Task extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Task() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String topic_name = request.getParameter("topic");
		String content = request.getParameter("content");
		String teacher_id = request.getSession().getAttribute("id").toString();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time=df.format(new Date());
		DataBase db = new DataBase();
		
		String sql = "update tb_task set content='"+content+"',review_state='0',submit_time='"+time+"' where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'";
		try {
			db.stmt.executeUpdate(sql);
			db.stmt.close();
			db.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("teacher/task.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
