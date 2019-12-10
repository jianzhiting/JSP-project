package col;

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

@WebServlet("/colinfo")
public class Colinfo extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Colinfo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String message_name = request.getParameter("message_name");
		String introduction = request.getParameter("introduction");
		String college_id = request.getSession().getAttribute("id").toString();
		DataBase db = new DataBase();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time=df.format(new Date());
		
		String sql = "select * from tb_message where message_name='"+message_name+"' and college_id='"+college_id+"'";
		try {
			db.rs = db.stmt.executeQuery(sql);
			if(db.rs.next()) {
				sql = "update tb_message set introduction='"+introduction+"',submit_time='"+time+"' where message_name='"+message_name+"' and college_id='"+college_id+"'";
			}
			else
				sql = "insert into tb_message values('"+message_name+"','"+college_id+"','"+time+"','"+introduction+"')";
			db.stmt.executeUpdate(sql);
			db.Close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("college/info.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
