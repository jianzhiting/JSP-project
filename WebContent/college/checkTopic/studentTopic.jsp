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
	String review_state = "";
	request.setCharacterEncoding("utf-8");
%>
	<div id="table">
		<table>
			<tr>
			  <th class="a">学生姓名</th>
			  <th class="b">课题名称</th>
			  <th class="c">教师姓名</th>
			  <th class="d">审核状态</th>
			  <th class="e">评审</th>
			</tr>
			<%
			try {
				String sql = "select tb_student_topic.student_id,student_name,topic_name,teacher_name,review_state "+
					"from tb_student_topic,tb_student,tb_teacher "+
					"where tb_student_topic.student_id=tb_student.student_id and tb_student_topic.teacher_id=tb_teacher.teacher_id "+
					"and tb_student.college_id='"+id+"' and review_state in ('1','3') order by review_state asc";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					review_state = db.rs.getString(5).toString();
					String s = "待审核";
					if(review_state.equals("3"))
						s = "审核未通过";
			%>
			<tr>
			  <td  class="a"><%=db.rs.getString(2)%></td>
			  <td  class="b"><%=db.rs.getString(3)%></td>
			  <td  class="c"><%=db.rs.getString(4)%></td>
			  <td  class="d"><%=s %></td>
			  <td  class="e">
				<form action="/project/colTopic?student_id=<%=db.rs.getString(1)%>" method="post">
			        <input type="submit" name="pass" class="down" value="通&nbsp过" onclick="return confirm('确认通过？');">
			        <input type="submit" name="notpass" class="down" value="不通过" onclick="return confirm('确认不通过？');">
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
<%
	db.Close();
%>
</body>
</html>