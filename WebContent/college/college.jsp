<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>学院主界面</title>
<link rel="stylesheet" href="css/base.css"> <!--初始化文件-->
<link rel="stylesheet" href="css/theme.css">
<link rel="stylesheet" href="css/menu.css"> <!--主样式-->
</head>
<%
Object ob = session.getAttribute("choice");
if( ob == null||!ob.toString().equals("college"))
	request.getRequestDispatcher("/login.jsp").forward(request, response);
%>
<body>
<script src="js/adapter.js"></script>
<script src="js/menu.js"></script> <!--控制js-->
<div id="head">
    <ul>
        <li></li>
        <li>学院办事处</li>
        <li class="welcome"><%=session.getAttribute("name") %><a href="/project/login.jsp"> &nbsp| 退出</a></li>
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
            学院
            <span><img class="obscure" src="img/obscure.png" alt=""></span>
        </div>
        <div class="navBox">
            <ul>
                <a href="college/info.jsp" target="menuFrame"><li><h2 class="obtain">发布信息</h2></li></a>
                <li>
                    <h2 class="obtain">审核选题<i></i></h2>
                    <div class="secondary">
                        <a href="college/checkTopic/teacherTopic.jsp" target="menuFrame"><h3>教师课题</h3></a>
                        <a href="college/checkTopic/studentTopic.jsp" target="menuFrame"><h3>学生选题</h3></a>
                        <h3 style="height: 25px"></h3>
                    </div>
                </li>
                <li>
                    <h2 class="obtain">审核报告<i></i></h2>
                    <div class="secondary">                        
                        <a href="college/checkReport/task.jsp" target="menuFrame"><h3>任务书</h3></a>
                        <a href="college/checkReport/openReport.jsp" target="menuFrame"><h3>开题报告</h3></a>
                        <a href="college/checkReport/metaphase.jsp" target="menuFrame"><h3>中期报告</h3></a>
                    </div>
                </li>
                <a href="college/defenceTeam.jsp" target="menuFrame"><li><h2 class="obtain">答辩小组</h2></li></a>
                <li>
                    <h2 class="obtain">审核成绩<i></i></h2>
                    <div class="secondary">
                        <a href="college/checkGrade/reviewGrade.jsp" target="menuFrame"><h3>评阅成绩</h3></a>
                        <a href="college/checkGrade/defenceGrade.jsp" target="menuFrame"><h3>答辩成绩</h3></a>
                        <h3 style="height: 25px"></h3>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</div>
<iframe id="menuFrame"name="menuFrame"src="college/info.jsp"frameborder="no">
</iframe>
</body>
</html>