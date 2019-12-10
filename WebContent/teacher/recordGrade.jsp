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
%>
	<div id="table">
		<table>
			<tr>
			  <th class="a">学生姓名</th>
			  <th class="b">论文题目</th>
			  <th class="a">组长评分</th>
			  <th class="a">成员一评分</th>
			  <th class="a">成员二评分</th>
			  <th class="j">提交成绩</th>
			</tr>
			<%
			try {
				String sql = "select tb_paper.student_id,student_name,paper_item,capital_grade,mem_one_grade,mem_two_grade "+
					"from tb_paper,tb_student,tb_review left join tb_defence_team on(tb_review.team_id=tb_defence_team.team_id and tb_review.college_id=tb_defence_team.college_id) "+
					"where tb_paper.student_id=tb_student.student_id and tb_paper.student_id=tb_review.student_id "+
					"and capital_id='"+id+"' and review_state!='2'";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					String capital_grade = "";
					String mem_one_grade = "";
					String mem_two_grade = "";
					if(db.rs.getString(4) != null){
						capital_grade = db.rs.getString(4).toString();
						mem_one_grade = db.rs.getString(5).toString();
						mem_two_grade = db.rs.getString(6).toString();						
					}
			%>
			<tr>
			  <td  class="a"><%=db.rs.getString(2)%></td>
			  <td  class="b"><%=db.rs.getString(3)%></td>
			  <td  class="a"><input type="text" name="capital_grade" class="paper" form="f" placeholder="输入评分" value="<%=capital_grade %>"></td>
			  <td  class="a"><input type="text" name="mem_one_grade" class="paper" form="f" placeholder="输入评分" value="<%=mem_one_grade %>"></td>
			  <td  class="a"><input type="text" name="mem_two_grade" class="paper" form="f" placeholder="输入评分" value="<%=mem_two_grade %>"></td>
			  <td  class="j">
			  	<form action="/project/teaDefence?student_id=<%=db.rs.getString(1)%>" method="post" id="f">
			        <input type="submit" class="paper" value="提交" onclick="return confirm('确认提交？');">
			  	</form>
			  </td>
			</tr>		    
			<% 
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
		</table>
	</div>
<script type="text/javascript">
	<%
	if(request.getParameter("s")!=null)
		out.write("alert('请填完三组数据一并提交');");
	%>
</script>
<%
	db.Close();
%>
</body>
</html>