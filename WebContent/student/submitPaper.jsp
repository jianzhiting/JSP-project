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
<% 
String id = (String)request.getSession().getAttribute("id") ;
String s="";
String state = "";
DataBase db = new DataBase();

String sql = "select * from tb_paper where student_id = '" + id + "'";
try {
	db.rs = db.stmt.executeQuery(sql);
	if(db.rs.next()) {
		state = db.rs.getString("review_state");
		if(state.equals("2")) {
			s="您提交的论文终稿审核失败，请重新提交";
		}
		else if(state.equals("1"))
			s="您提交的论文终稿已审核结束";
		else
			s="您的论文终稿已经提交,正在等待审核";
	}
	else{
		s="您尚未提交论文终稿";
	}
} catch (SQLException e) {
	e.printStackTrace();
}
%>
<body>
<div id="left" class="topic" style="text-align: left">
<b style="font-size:23px">论文文档提交注意事项</b><br/><br/>
<p>1．学号填写：严格按照研究生院提供给每位同学的标准学号填写，不能擅自随意自编学号；</p><br/>
<p>2．重复提交：如果学生认为已提交的论文有问题，可以申请修改，但不能用不同学号重复提交；</p><br/>
<p>3．信息提交不完整：有些学生只提交基本信息而不提交电子版文档；</p><br/>
<p>4．基本信息与电子版信息不符：基本信息各项的填写，应与提交的电子版相关信息完全相符，如：题名、姓名、指导导师及导师单位、学位、培养单位、答辩时间等等；</p><br/>
<p>5．提交电子版论文应为最终稿件，不能有涂抹、修改痕迹，字体颜色应为黑色；</p><br/>
<p>6．基本信息处学生姓名的填写：姓与名之间不空格；</p><br/>
<p>7．邮箱：学生所留信箱一定要留常用的正确地址，否则审核信息无法正常发出；</p><br/>
<p><b>论文类型：</b>A---理论研究；B---应用研究；C---软件设计等；</p>

</div>
<div id="right" class="topic">
	<form action="/project/paper" method="post">
                    <h2 style="text-align: center;font-size: 23px">提交论文定稿</h2>
       
                论文题目：<input type="text" name = "paper_item" class="topic_name"/><br><br>
                论文类型：<span></span><input type="radio" name = "paper_type" value="a"/>类型A<span></span>
              <input type="radio" name = "paper_type" value="b"/>类型B<span></span>
              <input type="radio" name = "paper_type" value="c"/>类型C<span style="margin-right: 19%"></span><br><br>
                论文终稿：<input type="file" name="paper" class="topic_name"><br>
                论文附件：<input type="file" name="paper_a" class="topic_name"><br/><br/>
           <input type="submit" name="submit" value="提交" class="down"onClick="return func();">
    </form>
    <p class="bottom" style="color: red"><%=s %></p>
</div>
<script type="text/javascript">
function func(){
	<%
	db.rs = db.stmt.executeQuery("select review_state from tb_metaphase where student_id='"+id+"'");
	String review_state = "";
	if(db.rs.next())
		review_state = db.rs.getString(1).toString();
	if(!review_state.equals("2")||state.equals("0")||state.equals("1")){
	%>
		alert("当前状态下不能提交");
		return false;
	<%
	}
	db.Close();
	%>
}
</script>
</body>
</html>