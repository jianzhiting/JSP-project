<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.DataBase" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title></title>
<link rel="stylesheet" href="/project/css/base.css">
<link rel="stylesheet" href="/project/css/coltopic.css">
</head>
<body>
<%
	DataBase db = new DataBase();
	String id = session.getAttribute("id").toString();
	request.setCharacterEncoding("utf-8");
	String state = "";
%>
	<div id="table">
		<table>
			<tr>
			  <th class="a">学生姓名</th>
			  <th class="b">论文题目</th>
			  <th class="c">答辩评分</th>
			  <th class="d">审核状态</th>
			  <th class="e">评审</th>
			</tr>
			<%
			try {
				String sql = "select tb_paper.student_id,student_name,paper_item,defence_grade,review_state "+
					"from tb_paper left join tb_student on(tb_paper.student_id=tb_student.student_id) "+
					"where college_id='"+id+"' order by review_state asc";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					DataBase db2 = new DataBase();
					String defence_grade = "";
					sql = "select team_id from tb_review where student_id='"+db.rs.getString(1)+"'";
					if(db.rs.getString(4) == null){
						state = "不能评审";
					}
					else{
						state = "待评审";
						defence_grade = db.rs.getString(4).toString();
						String review_state = db.rs.getString(5).toString();
						if(review_state.equals("1"))
							state = "评审通过 ";
						else if(review_state.equals("2"))
							state = "评审不通过 ";
					}
			%>
			<tr>
			  <td  class="a"><%=db.rs.getString(2)%></td>
			  <td  class="b"><%=db.rs.getString(3)%></td>
			  <td  class="c"><%=defence_grade%></td>
			  <td  class="d"><%=state %></td>
			  <td  class="e">
			  	<%if(state.equals("不能评审")){%>
			  	<form action="">
			        <input type="submit" class="down" value="通&nbsp过" onclick="false">
			        <input type="submit" class="down" value="不通过" onclick="false">
			    </form>
			  	<%}else{%>
				<form action="/project/colDefenceReview?student_id=<%=db.rs.getString(1)%>" method="post">
			        <input type="submit" name="pass" class="down" value="通&nbsp过" onclick="return confirm('确认通过？');">
			        <input type="submit" name="notpass" class="down" value="不通过" onclick="return confirm('确认不通过？');">
			    </form>
			  </td>
			</tr>
			<% 		}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
		</table>
	</div>
<%
	db.Close();
%>
</body>
</html>