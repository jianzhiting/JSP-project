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
<link rel="stylesheet" href="/project/css/topic.css">
<link rel="stylesheet" href="/project/css/base.css">
</head>

<body>
<%
DataBase db = new DataBase();
String id = session.getAttribute("id").toString();
String director = "";
String introduction = "";
String topic_name = "";
String teacher_id = request.getParameter("teacher_id");
request.setCharacterEncoding("utf-8");
if(teacher_id != null){
	topic_name = request.getParameter("topic_name");
	db.rs = db.stmt.executeQuery("select teacher_name from tb_teacher where teacher_id='"+teacher_id+"'");
	db.rs.next();
	director = db.rs.getString(1).toString();
	String sql = "select introduction from tb_topic where teacher_id='"+teacher_id+"' and topic_name='"+topic_name+"'";
	db.rs = db.stmt.executeQuery(sql);
	db.rs.next();
	introduction = db.rs.getString(1).toString();
}
String content = "只能进行一次提交";
String review_state = "";
db.rs = db.stmt.executeQuery("select review_state from tb_student_topic where student_id='"+id+"'");
if(db.rs.next()){
	content = "已经提交过啦";
	review_state = db.rs.getString(1).toString();
	if(review_state.equals("3")||review_state.equals("4"))
		content = "审核未通过，请重新提交";
	else if(review_state.equals("2"))
		content = "已经通过了哦";
}
%>
<form action="/project/stuChooseTopic" method="post">
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">课题名称</th>
			  <th class="b">选择课题</th>
			</tr>
			<%
			try {
				String sql = "select topic_name,tb_topic.teacher_id "+
					"from tb_topic left join tb_teacher on(tb_topic.teacher_id=tb_teacher.teacher_id) "+
					"where review_state='1' and college_id=("+
						"select college_id from tb_student "+
						"where student_id='"+id+"'"+
					")";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
			%>
			<tr>
			  <td class="a"><a href="/project/student/chooseTopic.jsp?topic_name=<%=db.rs.getString(1)%>&teacher_id=<%=db.rs.getString(2)%>"><%=db.rs.getString(1)%></a></td>
			  <td class="b"><input type="radio" name="choose" value="<%=db.rs.getString(1)%> <%=db.rs.getString(2)%>"/></td>
			</tr>
			<%
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
			<tr>
			  <td style="color: red"><%=content %></td>
			  <td><input type="submit" value="确认" onclick="return func();"class="choose"/></td>
			</tr>
		</table>
	</div>
</form>
	<div class="topic" id="right">
		<h1 style="font-size: 27px">详细内容</h1>
		<div>
            <form id="f">
            	导师名：<input type="text" name="topic" class="topic_name" value="<%=director %>"><br/>
            	<p>简 &nbsp&nbsp介：</p>
            	<textarea name="introduction" form="f" maxlength="50" style="height: 27rem"><%=introduction %></textarea><br/><br/>
            </form>
    	</div>
	</div>
	<script>
	function func(){
		<%
		if(review_state.equals("0")||review_state.equals("2")){
		%>
			alert("当前状态下不能提交");
			return false;
		<%
		}
		%>
	}
	</script>
<%
	db.Close();
%>
</body>
</html>