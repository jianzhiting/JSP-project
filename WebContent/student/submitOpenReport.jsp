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
String id = (String)request.getSession().getAttribute("id") ;
String s="";
String state = "";
String topic_name = "";
String content = "";
DataBase db = new DataBase();

String sql = "select * from tb_open_report where student_id = '" + id + "'";
try {
	db.rs = db.stmt.executeQuery(sql);
	if(db.rs.next()) {
		state = db.rs.getString("review_state");
		if(state.equals("3")||state.equals("4")) {
			s="您提交的开题报告审核失败，请重新提交";
		}
		else if(state.equals("2"))
			s="您提交的开题报告已审核通过";
		else
			s="您的开题报告已经提交,正在等待审核";
	}
	else{
		s="您尚未提交开题报告";
	}
	sql = "select tb_student_topic.topic_name,content "+
	"from tb_student_topic,tb_task "+
	"where student_id='"+id+"' and "+
	"tb_student_topic.topic_name=tb_task.topic_name and tb_student_topic.teacher_id=tb_task.teacher_id";
	db.rs = db.stmt.executeQuery(sql);
	if(db.rs.next()) {
		topic_name = db.rs.getString(1).toString();
		if(db.rs.getString(2)!=null)
			content = db.rs.getString(2).toString();
	}
} catch (SQLException e) {
	e.printStackTrace();
}
%>
<div id="left" class="topic" style="text-align: left">
<b style="font-size:23px">提交论文开题报告注意事项</b><br/><br/>
<b style="font-size:18px0">一、选题</b>
<p>论文题目的选择由学员本人提出，由党校培训部指定指导老师审定。选题时一般掌握以下原则：</p><br/>
<p>1、要具有较高的理论意义和实用价值。</p><br/>
<p>2、必须密切联系工作实际。</p><br/>
<p>3、要结合本人的基础和特长。</p><br/>
<b style="font-size:18px">二、开题报告的内容</b>
<p>1、选题的依据。主要说明所选题目的经过，对选择此题目的设想。</p><br/>
<p>2、对所确定的题目，在理论上和实际上的意义、价值及可能达到的水平，给予充分的阐述。</p><br/>
<p>3、阐述可能遇的困难和问题，以及解决的方法和措施。</p><br/>
<form action="/project/stuOpen" method="post">
	<h4 style="color: red"><%=s %></h4>
	开题报告：<input type="file" name = "meta">
	<input type="submit" value="提&nbsp交" style="color: red" class="d" onClick="return func();"><br/>
	<p>请确认提交准确无误</p><br/>
</form>
</div>
<div id="right" class="topic">
		<h1 style="font-size: 27px">任务书</h1>
		<div>
            <form id="f">
            	课题名：<input type="text" name="topic" class="topic_name" value="<%=topic_name%>"><br/>
            	<p>安 &nbsp&nbsp排：</p>
            	<textarea name="introduction" form="f" maxlength="50" style="height: 27rem"><%=content %></textarea><br/><br/>
            </form>
    	</div>
</div>
<script type="text/javascript">
function func(){
	<%
	db.rs = db.stmt.executeQuery("select review_state from tb_student_topic where student_id='"+id+"'");
	String review_state = "";
	if(db.rs.next())
		review_state = db.rs.getString(1).toString();
	if(!review_state.equals("2")||state.equals("0")||state.equals("1")||state.equals("2")){
	%>
		alert("当前状态下不能提交");
		return false;
	<%}%>
}
</script>
<%db.Close(); %>
</body>
</html>