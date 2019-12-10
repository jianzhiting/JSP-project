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
			  <th class="g">学生姓名</th>
			  <th class="f">课题名称</th>
			  <th class="g">导师姓名</th>
			  <th class="h">指定评阅老师</th>
			  <th class="a">审核状态</th>
			  <th class="e">评审</th>
			</tr>
			<%
			try {
				String sql = "select tb_metaphase.student_id,student_name,topic_name,tb_student_topic.teacher_id,teacher_name,tb_metaphase.review_state "+
					"from tb_metaphase,tb_student,tb_student_topic,tb_teacher "+
					"where tb_metaphase.student_id=tb_student.student_id and tb_metaphase.student_id=tb_student_topic.student_id and tb_student_topic.teacher_id=tb_teacher.teacher_id "+
					"and tb_teacher.college_id='"+id+"' and tb_metaphase.review_state in('1','2','4') order by tb_metaphase.review_state asc";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					review_state = db.rs.getString(6).toString();
					String s = "审核通过";
					if(review_state.equals("1"))
						s = "待审核";
					else if(review_state.equals("4"))
						s = "审核未通过";
			%>
			<tr>
			  <td  class="g"><%=db.rs.getString(2)%></td>
			  <td  class="f"><%=db.rs.getString(3)%></td>
			  <td  class="g"><%=db.rs.getString(5)%></td>
			  <td  class="h">
			  	<select form="<%=db.rs.getString(1)%>" name="review_teacher">
			  	<%
			  	try {		  
					DataBase db2 = new DataBase();
					sql = "select t1.teacher_id,t1.teacher_name from "+
						"tb_teacher t1,tb_teacher t2 "+
						"where t1.teacher_id!='"+db.rs.getString(4)+"' and t2.teacher_id='"+db.rs.getString(4)+"' "+
						"and t1.college_id=t2.college_id";
					db2.rs = db2.stmt.executeQuery(sql);
					while(db2.rs.next()){
				%>
				<option value="<%=db2.rs.getString(1) %>"><%=db2.rs.getString(2) %></option>
				<%
					}
					db2.Close();
				}
			    catch (SQLException e1) {
			    	System.out.println(e1);
			    }
			  	%>				  
				</select>
			  </td>
			  <td  class="a"><%=s %></td>
			  <td  class="e">
				<form action="/project/colMeta?student_id=<%=db.rs.getString(1)%>" method="post" id="<%=db.rs.getString(1)%>">
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