package col;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/colTask")
public class ColTask extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ColTask() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int state=2;
		String teacher_id = request.getParameter("teacher_id");
		String topic_name = request.getParameter("topic_name");
		String pass = request.getParameter("pass");
		if(pass!=null)
		state=1;
		DataBase db = new DataBase();
		String sql = "update tb_task set review_state="+state+" where teacher_id='"+teacher_id+"' and topic_name='"+topic_name+"'";
		try {
			db.stmt.executeUpdate(sql);
			db.stmt.close();
			db.conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("college/checkReport/task.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
