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
<link rel="stylesheet" href="/project/css/stutopic.css">
</head>

<body>
<%
	DataBase db = new DataBase();
	String id = session.getAttribute("id").toString();
	String student_name = "";
	String grade = "";
	String department = "";
	String review_state = request.getParameter("review_state");
	String student_id = request.getParameter("student_id");
	if(student_id != null){		
		String sql = "select * from tb_student where student_id='"+student_id+"'";
		db.rs = db.stmt.executeQuery(sql);
		db.rs.next();
		student_name = db.rs.getString("student_name").toString();
		grade = db.rs.getString("grade").toString();
		department = db.rs.getString("department").toString();
	}
	else
		student_id = "";
	if(review_state != null){
		db.stmt.executeUpdate("update tb_student_topic set review_state='"+review_state+"' where student_id='"+student_id+"'");
	}
%>
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">课题名称</th>
			  <th class="b">学生姓名</th>
			  <th class="b">审核状态</th>
			</tr>
			<%
			try {
				String sql = "select topic_name,tb_student_topic.student_id,student_name,review_state "+
					"from tb_student_topic left join tb_student on(tb_student_topic.student_id=tb_student.student_id) "+
					"where teacher_id='"+ id +"' and review_state!='4' order by review_state asc";
				db.rs = db.stmt.executeQuery(sql);				
				while(db.rs.next()){
					int state = Integer.parseInt(db.rs.getString(4));
					String s = "待审核";
					if(state == 1)
						s = "审核通过";
					else if(state == 2)
						s = "学院审核通过";
					else if(state == 3)
						s = "审核未通过";
			%>
			<tr>
			  <td class="a"><a href="/project/teacher/check/studentTopic.jsp?student_id=<%=db.rs.getString(2)%>"><%=db.rs.getString(1)%></a></td>
			  <td class="b"><%=db.rs.getString(3)%></td>
			  <td class="b"><%=s %></td>
			</tr>
			<%
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
		</table>
	</div>
	<div class="topic" id="right">
		<h1 style="font-size: 27px">学生信息</h1>
		<div>
            <form action="">
            	学号：<input type="text" class="topic_name" value="<%=student_id%>"><br/>
            	姓名：<input type="text" class="topic_name" value="<%=student_name%>"><br/>
            	年级：<input type="text" class="topic_name" value="<%=grade%>"><br/>
            	专业：<input type="text" class="topic_name" value="<%=department%>"><br/>
                <a href="studentTopic.jsp?review_state=1&student_id=<%=student_id %>" onClick="return func();">
                <input type="button" class="down" value="通&nbsp过"></a>
                <a href="studentTopic.jsp?review_state=3&student_id=<%=student_id %>" onClick="return func();">
                <input type="button" class="down" value="不通过"></a>
            </form>
            <p class="bottom">点击课题名称进行审核</p>
    	</div>
	</div>
	<script>
	function func(){
		<%
		db.rs = db.stmt.executeQuery("select review_state from tb_student_topic where student_id='"+student_id+"'");
		review_state = "";
		if(db.rs.next())
			review_state = db.rs.getString(1).toString();
		if(review_state.equals("")){
		%>
			alert("当前状态下不能评审");
			return false;
		<%
		}
		else if(review_state.equals("2")){
		%>
			alert("学院已通过该条记录");
			return false;
		<%
		}
		else
		%>
		return confirm("确认操作？");
	}
	</script>
<%
	db.Close();
%>
</body>
</html>