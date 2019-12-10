<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>指导老师界面</title>
<link rel="stylesheet" href="/project/css/base.css"> <!--初始化文件-->
<link rel="stylesheet" href="/project/css/theme.css"> 
<link rel="stylesheet" href="/project/css/menu.css"> <!--主样式-->
</head>
<%
Object ob = session.getAttribute("choice");
if( ob == null||!ob.toString().equals("teacher"))
	request.getRequestDispatcher("/login.jsp").forward(request, response);
%>

<body>
<script src="/project/js/adapter.js"></script> <!--rem适配js-->
<script src="/project/js/menu.js"></script> <!--控制js-->
<div id="head">
    <ul>
        <li></li>
        <li class="lock">指导老师</li>
        <li><a  href="/project/teacher/review.jsp">评阅老师</a></li>
        <li><a  href="/project/teacher/defence.jsp">答辩组长</a></li>
        <li class="welcome">欢迎：<%=session.getAttribute("name") %> <a href="/project/login.jsp" class='quit'>| 退出</a></li>
    </ul>
</div>
<div id="menu">
    <!--隐藏菜单-->
    <div id="ensconce">
        <h2>
            <img src="/project/img/show.png" alt="">
        </h2>
    </div>

    <!--显示菜单-->
    <div id="open">
        <div class="navH">
            教师
            <span><img class="obscure" src="/project/img/obscure.png" alt=""></span>
        </div>
        <div class="navBox">
            <ul>
                <a href="/project/teacher/info.jsp" target="menuFrame"><li><h2 class="obtain">通知公告</h2></li></a>
                <a href="/project/teacher/topic.jsp" target="menuFrame"><li><h2 class="obtain">申报课题</h2></li></a>
                <li>
                    <h2 class="obtain">审核<i></i></h2>
                    <div class="secondary">
                        <a href="/project/teacher/check/studentTopic.jsp" target="menuFrame"><h3>学生选题</h3></a>
                        <a href="/project/teacher/check/openReport.jsp" target="menuFrame"><h3>开题报告</h3></a>
                        <a href="/project/teacher/check/metaphase.jsp" target="menuFrame"><h3>中期检查</h3></a>
                    </div>
                </li>
                <a href="/project/teacher/task.jsp" target="menuFrame"><li><h2 class="obtain">下达任务书</h2></li></a>
                <a href="/project/teacher/directorReviewPaper.jsp" target="menuFrame"><li><h2 class="obtain">评阅论文</h2></li></a>
            </ul>
        </div>
    </div>
</div>
<iframe id="menuFrame"name="menuFrame"src="/project/teacher/info.jsp"frameborder="no"></iframe>
</body>
</html>