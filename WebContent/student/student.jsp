<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>学生主界面</title>
<link rel="stylesheet" href="css/base.css"> <!--初始化文件-->
<link rel="stylesheet" href="css/theme.css">
<link rel="stylesheet" href="css/menu.css"> <!--主样式-->
</head>
<%
Object ob = session.getAttribute("choice");
if( ob == null||!ob.toString().equals("student"))
	request.getRequestDispatcher("/login.jsp").forward(request, response);
%>
<body>
<script src="js/adapter.js"></script>
<script src="js/menu.js"></script>
<div id="head">
    <ul>
        <li></li>
        <li>学生主界面</li>
        <li class="welcome">欢迎：<%=session.getAttribute("name") %><a href="/project/login.jsp" class='quit'>| 退出</a></li>
    </ul>
</div>
<div id="menu">
    <!--隐藏菜单-->
    <div id="ensconce">
        <h2>
            <img src="img/show.png" alt="">
        </h2>
    </div>

    <!--显示菜单-->
    <div id="open">
        <div class="navH">
            学生
            <span><img class="obscure" src="img/obscure.png" alt=""></span>
        </div>
        <div class="navBox">
            <ul>
                <a href="student/info.jsp" target="menuFrame"><li><h2 class="obtain">通知公告</h2></li></a>
                <a href="student/chooseTopic.jsp" target="menuFrame"><li><h2 class="obtain">选择课题</h2></li></a>
                <a href="student/submitOpenReport.jsp" target="menuFrame"><li><h2 class="obtain">开题报告</h2></li></a>
                <a href="student/submitMetaphase.jsp" target="menuFrame"><li><h2 class="obtain">中期检查</h2></li></a>
                <a href="student/submitPaper.jsp" target="menuFrame"><li><h2 class="obtain">论文定稿</h2></li></a>
            </ul>
        </div>
    </div>
</div>
<iframe id="menuFrame"name="menuFrame"src="student/info.jsp"frameborder="no"></iframe>
</body>
</html>