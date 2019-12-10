package col;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DataBase;

@WebServlet("/colDefence")
public class ColDefence extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ColDefence() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String item_id = request.getParameter("item");
		String college_id = (String)request.getSession().getAttribute("id") ;
		String capital_id = request.getParameter("0");
		String member_one = request.getParameter("1");
		String member_two = request.getParameter("2");
		String secretary_id = "";
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String time = "";
		String address = request.getParameter("address");
		if(start==null||end==null||address==null||capital_id.equals(member_one)||capital_id.equals(member_two)||member_one.equals(member_two))
			request.getRequestDispatcher("college/defenceTeam.jsp?s=1").forward(request, response);
		else {			
			DataBase db = new DataBase();
			try {
				String sql = "select student_id from tb_student where student_id not in("+
						"select secretary_id from tb_defence_team)";
				db.rs = db.stmt.executeQuery(sql);
				if(db.rs.next())
					secretary_id = db.rs.getString(1).toString();
				time = start + "," + end;
				sql = "insert into tb_defence_team "+
					"values('"+item_id+"','"+college_id+"','"+capital_id+"','"+member_one+"','"+member_two+"','"+secretary_id+"','"+time+"','"+address+"')";
				db.stmt.executeUpdate(sql);
				db.Close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("college/defenceTeam.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
