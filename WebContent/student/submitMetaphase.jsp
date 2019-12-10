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
</head>
<body>
<% 
String id = (String)request.getSession().getAttribute("id") ;
String s="";
String state = "";
DataBase db = new DataBase();

String sql = "select * from tb_metaphase where student_id = '" + id + "'";
try {
	db.rs = db.stmt.executeQuery(sql);
	if(db.rs.next()) {
		state = db.rs.getString("review_state");
		if(state.equals("3")||state.equals("4")) {
			s="您提交的中期报告审核失败，请重新提交";
		}
		else if(state.equals("2"))
			s="您提交的中期报告已审核通过";
		else
			s="您的中期报告已经提交,正在等待审核";
	}
	else{
		s="您尚未提交中期报告";
	}
} catch (SQLException e) {
	e.printStackTrace();
}
%>
<h2>课题中期报告注意事项</h2>
<h4>规范、合格的课题阶段研究报告，需要回答三个问题：</h4>
<p>一是“为什么要选择这项课题进行研究”，即这项课题是在怎样的背景下提出来的，其理论意义和现实意义怎样；</p>
<p>二是“这项课题是怎样进行研究的”，着重讲清研究的理论依据、目标内容、方法步骤及主要过程，中途研究进行了哪些调整；</p>
<p>三是“课题研究取得哪些研究成果”。</p>
<form action="/project/stuMeta" method="post">
	<h4 style="color: red"><%=s %></h4>
	中期报告：<input type="file" name = "meta">
	<input type="submit" value="提&nbsp交" style="color: red" onClick="return func();"><br/>
	<p>请确认提交的报告准确无误</p>
</form>
<script type="text/javascript">
function func(){
	<%
	db.rs = db.stmt.executeQuery("select review_state from tb_open_report where student_id='"+id+"'");
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