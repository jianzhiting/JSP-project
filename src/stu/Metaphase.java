package stu;

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

@WebServlet("/stuMeta")
public class Metaphase extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Metaphase() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = (String)request.getSession().getAttribute("id") ;
		DataBase db = new DataBase();
		
		String sql = "select * from tb_metaphase where student_id = '" + id + "'";
		try {
			db.rs = db.stmt.executeQuery(sql);
			if(db.rs.next()) {
				String state=db.rs.getString(3);
				if(state.equals("3")||state.equals("4")) {
					SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String time=df.format(new Date());
					String s = "update  tb_metaphase set submit_time ='"+time+"',review_state='0' where student_id='"+id+"'";
					db.stmt.executeUpdate(s);
				}
			}
			else{
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String time=df.format(new Date());
				String s = "insert into  tb_metaphase values('"+id+"','"+time+"','0')";
				db.rs = db.stmt.executeQuery(s);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		db.Close();
		request.getRequestDispatcher("student/submitMetaphase.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
