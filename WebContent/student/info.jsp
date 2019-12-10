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
		"select college_id from tb_student where student_id='"+id+"')";
		db.rs = db.stmt.executeQuery(sql);
		db.rs.next();
		introduction = db.rs.getString(1).toString();
	}
	else
		message_name = "";
%>
	<div class="topic" id="stuleft">
		<table>
			<tr>
			  <th class="a">公告标题</th>
			</tr>
			<%
			try {
				String sql = "select message_name "+
				"from tb_message "+
				"where college_id=("+
				"select college_id from tb_student where student_id='"+id+"') "+
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
%>
		</table>
	</div>
	<div class="topic" id="sturight">
		<h1 style="font-size: 27px">详细内容</h1>
		<div id="login">
            <form action="" id="f">
            	公告题目：<input type="text" name="message_name" class="topic_name" value="<%=message_name %>"><br/>
            	<p>详细内容：</p>
            	<textarea name="introduction" form="f" maxlength="50" style="height: 17rem"><%=introduction%></textarea><br/><br/>
            </form>
    	</div>
	</div>
	<div class="stu">
	<table>
			<tr>
			  <th class="stuwa">评阅成绩一</th>
			  <th class="stuwa">评阅成绩二</th>
			  <th class="stuwa">总评阅成绩</th>
			  <th class="stuwa">答辩成绩一</th>
			  <th class="stuwa">答辩成绩二</th>
			  <th class="stuwa">答辩成绩三</th>
			  <th class="stuwa">总答辩成绩</th>
			  <th class="stuwa">总成绩</th>
			</tr>
			<%
			try {
				String sql = "select guide_grade,review_grade,paper_grade,capital_grade,mem_one_grade,mem_two_grade,defence_grade,final_grade "+
				"from tb_review left join tb_paper on(tb_review.student_id=tb_paper.student_id) "+
				"where tb_review.student_id='"+ id +"'";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					String guide_grade = "";
					String review_grade = "";
					String paper_grade = "";
					String capital_grade = "";
					String mem_one_grade = "";
					String mem_two_grade = "";
					String defence_grade = "";
					String final_grade = "";
					if(db.rs.getString(1) != null)
						guide_grade = db.rs.getString(1).toString();
					if(db.rs.getString(2) != null)
						review_grade = db.rs.getString(2).toString();
					if(db.rs.getString(3) != null)
						paper_grade = db.rs.getString(3).toString();
					if(db.rs.getString(4) != null)
						capital_grade = db.rs.getString(4).toString();
					if(db.rs.getString(5) != null)
						mem_one_grade = db.rs.getString(5).toString();
					if(db.rs.getString(6) != null)
						mem_two_grade = db.rs.getString(6).toString();
					if(db.rs.getString(7) != null)
						defence_grade = db.rs.getString(7).toString();
					if(db.rs.getString(8) != null)
						final_grade = db.rs.getString(8).toString();
					
			%>
			<tr>
			  <td class="stuwa"><%=guide_grade%></td>
			  <td class="stuwa"><%=review_grade%></td>
			  <td class="stuwa"><%=paper_grade%></td>
			  <td class="stuwa"><%=capital_grade%></td>
			  <td class="stuwa"><%=mem_one_grade%></td>
			  <td class="stuwa"><%=mem_two_grade%></td>
			  <td class="stuwa"><%=defence_grade%></td>
			  <td class="stuwa"><%=final_grade%></td>
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
</body>
<style>
</style>
</html>