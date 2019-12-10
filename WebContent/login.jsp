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
<title>登录界面</title>
<link rel="stylesheet" href="/project/css/base.css"> 
<link rel="stylesheet" href="/project/css/login.css"> 
</head>

<body>
<div id="first">
    <h1><b>西南财经大学毕业论文管理系统</b></h1>
    <div id="login">
            <form action="/project/check" method="post">
		                用户名：<input type="text" name="id" class="set" value="">
		                密码：<input type="password" name="password" class="set" value="">
              <input type="submit" value="登&nbsp录" id="sure"><br/><br/>
              <input type="radio" checked="checked" name="choice" value="student" class="r" />学生&nbsp&nbsp
              <input type="radio" name="choice" value="teacher" class="r"/>老师&nbsp&nbsp
              <input type="radio" name="choice" value="college" class="r"/>学院 
            </form>
    </div>
</div>
<div id="second">
    <div class="left"></div>
    <div class="right">
        <h2><b>通知公告</b></h2>
        <%
        DataBase db1 = new DataBase();
        String sql = "select distinct tb_message.college_id,college_name "+
        "from tb_message left join tb_college on(tb_message.college_id=tb_college.college_id) "+
        "order by tb_message.college_id asc";
        db1.rs = db1.stmt.executeQuery(sql);
        while(db1.rs.next()){
        	out.write("<h4>"+db1.rs.getString(2)+"</h4>");
        	DataBase db2 = new DataBase();
        	sql = "select message_name from tb_message where college_id='"+db1.rs.getString(1)+"' order by submit_time desc";
        	db2.rs = db2.stmt.executeQuery(sql);
        	while(db2.rs.next()){
       		%>
       		<img src="/project/img/arrow.png"/><a href="#"><%=db2.rs.getString(1) %></a><br/>
       		<%
        	}
        	db2.Close();
        }
        %>
    </div>
</div>
<div id="thrid">
</div>
<%
db1.Close();
%>
</body>
</html>