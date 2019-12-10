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
<link rel="stylesheet" href="/project/css/topic.css">
</head>
<body>
<%
DataBase db = new DataBase();
String id = session.getAttribute("id").toString();
String introduction = "";
String message_name = request.getParameter("message_name");
String delete = request.getParameter("delete");
request.setCharacterEncoding("utf-8");
String sql = "";
if(delete != null&&delete.equals("yes")){
	sql = "delete from tb_message where message_name='"+message_name+"' and college_id='"+id+"'";
	db.stmt.executeUpdate(sql);
	message_name = "";
}
else if(message_name != null){
	sql = "select introduction from tb_message where college_id='"+id+"' and message_name='"+message_name+"'";
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
			  <th class="b">删除公告</th>
			</tr>
			<%
			try {
				db.rs = db.stmt.executeQuery("select message_name from tb_message where college_id='"+id+"' order by submit_time desc");
				while(db.rs.next()){
			%>
			<tr>
			  <td  class="a"><a href="/project/college/info.jsp?message_name=<%=db.rs.getString(1) %>"><%=db.rs.getString(1)%></a></td>
			  <td class="b"><a href="/project/college/info.jsp?message_name=<%=db.rs.getString(1) %>&delete=yes">删除</a></td>
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
            <form action="/project/colinfo" method="post" id="f">
            	公告题目：<input type="text" name="message_name" class="topic_name" value="<%=message_name %>"><br/>
            	<p>详细内容：</p>
            	<textarea name="introduction" form="f" maxlength="50"><%=introduction%></textarea><br/><br/>
                <input type="submit" name="pub" class="down" value="发&nbsp布">
                <input type="reset" class="down" value="重&nbsp置">
            </form>
            <p class="bottom">点击公告题目查看，如若同时修改公告题目，则视为新发布公告</p>
    	</div>
	</div>
</body>
<style>
</style>
</html>