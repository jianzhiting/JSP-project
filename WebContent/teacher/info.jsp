<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@page import ="com.sun.rowset.*" %>
<%@ page import="com.DataBase" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title></title>
<link rel="stylesheet" href="/project/css/base.css"> 
<link rel="stylesheet" href="/project/css/topic.css">
</head>
<body>
<%
	DataBase db = new DataBase();
	String id = session.getAttribute("id").toString();//id=01
    request.setCharacterEncoding("utf-8");
	String introduction = "";
	String message_name = request.getParameter("message_name");
	if(message_name != null){
		String sql = "select introduction from tb_message "+
		"where  message_name='"+message_name+"' and college_id=("+
		"select college_id from tb_teacher where teacher_id='"+id+"')";
		db.rs = db.stmt.executeQuery(sql);
		db.rs.next();
		introduction = db.rs.getString(1).toString();
	}
	else
		message_name = "";
%>
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">公告标题</th>
			</tr>
			<%
			try {
				String sql = "select message_name "+
				"from tb_message "+
				"where college_id=("+
				"select college_id from tb_teacher where teacher_id='"+id+"') "+
				"order by submit_time desc";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
			%>
			<tr>
			  <td  class="a"><a href="info.jsp?message_name=<%=db.rs.getString(1)%>"><%=db.rs.getString(1)%></a></td>
			</tr>
			<%
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
	db.Close();
%>
		</table>
	</div>
	<div class="topic" id="right">
		<h1 style="font-size: 27px">详细内容</h1>
		<div id="login">
            <form action="" id="f">
            	公告题目：<input type="text" name="message_name" class="topic_name" value="<%=message_name %>"><br/>
            	<p>详细内容：</p>
            	<textarea name="introduction" form="f" maxlength="50" style="height: 27rem"><%=introduction%></textarea><br/><br/>
            </form>
    </div>
	</div>
</body>
<style>
</style>
</html>