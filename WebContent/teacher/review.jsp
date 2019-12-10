<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>评阅老师界面</title>
<link rel="stylesheet" href="../css/base.css"> <!--初始化文件-->
<link rel="stylesheet" href="../css/theme.css">
<link rel="stylesheet" href="../css/menu.css"> <!--主样式-->
</head>
<%
Object ob = session.getAttribute("choice");
if( ob == null||!ob.toString().equals("teacher"))
	request.getRequestDispatcher("/login.jsp").forward(request, response);
%>
<body>
<body>
<script src="../js/adapter.js"></script> <!--rem适配js-->
<script src="../js/menu.js"></script> <!--控制js-->
<div id="head">
    <ul>
        <li></li>
        <li><a href="teacher.jsp">指导老师</a></li>
        <li class="lock">评阅老师</li>
        <li><a href="defence.jsp">答辩组长</a></li>
        <li class="welcome">欢迎：<%=session.getAttribute("name") %><a href="/project/login.jsp" class='quit'>| 退出</a></li>
    </ul>
</div>
<div id="menu">
    <!--隐藏菜单-->
    <div id="ensconce">
        <h2>
            <img src="../img/show.png" alt="">
        </h2>
    </div>

    <!--显示菜单-->
    <div id="open">
        <div class="navH">
            教师
            <span><img class="obscure" src="../img/obscure.png" alt=""></span>
        </div>
        <div class="navBox">
            <ul>
                <a href="/project/teacher/info.jsp" target="menuFrame"><li><h2 class="obtain">通知公告</h2></li></a>
                <a href="reviewPaper.jsp" target="menuFrame"><li><h2 class="obtain">评阅论文</h2></li></a>
            </ul>
        </div>
    </div>
</div>
<iframe id="menuFrame"name="menuFrame"src="info.jsp"frameborder="no">
</iframe>
</body>
</html>