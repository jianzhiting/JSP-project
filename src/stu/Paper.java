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

@WebServlet("/paper")
public class Paper extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Paper() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		String id = (String)request.getSession().getAttribute("id") ;
		String paper_item = request.getParameter("paper_item");
		String paper_type = request.getParameter("paper_type");
		
		if(paper_item != null&&paper_type != null) {			
			DataBase db = new DataBase();
			String sql = "select teacher_id from tb_student_topic where student_id='"+id+"'";
			
			try {
				db.rs = db.stmt.executeQuery(sql);
				db.rs.next();
				String teacher_id = db.rs.getString(1).toString();
				sql = "select * from tb_paper where student_id = '" + id + "'";
				db.rs = db.stmt.executeQuery(sql);
				sql = "";
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String time=df.format(new Date());
				if(db.rs.next()) {
					String state=db.rs.getString("review_state");
					if(state.equals("2")){
						sql = "update  tb_paper set submit_time ='"+time+"',paper_type='"+paper_type+"',paper_item='"+paper_item+"',review_state='0' where student_id='"+id+"'";
					}
				}
				else{
					sql = "insert into  tb_paper(student_id,paper_item,teacher_id,paper_type,submit_time,review_state) values('"+id+"','"+paper_item+"','"+teacher_id+"','"+paper_type+"','"+time+"','0')";
				}
				db.stmt.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}		
			db.Close();
		}
		request.getRequestDispatcher("student/submitPaper.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
