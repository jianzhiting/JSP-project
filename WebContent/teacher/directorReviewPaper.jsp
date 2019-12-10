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
<link rel="stylesheet" href="/project/css/coltopic.css">
</head>
<body>
<%
	DataBase db = new DataBase();
	String id = session.getAttribute("id").toString();
	request.setCharacterEncoding("utf-8");
%>
	<div id="table">
		<table>
			<tr>
			  <th class="a">学生姓名</th>
			  <th class="b">论文题目</th>
			  <th class="d">论文类型</th>
			  <th class="c">下载论文终稿</th>
			  <th class="e">评阅</th>
			</tr>
			<%
			try {
				String sql = "select tb_paper.student_id,student_name,paper_item,paper_type,guide_grade "+
					"from tb_paper,tb_student,tb_review "+
					"where tb_paper.student_id=tb_student.student_id and tb_paper.student_id=tb_review.student_id "+
					"and teacher_id='"+id+"' and review_state!='2'";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					String guide_grade = "";
					if(db.rs.getString(5) != null)
						guide_grade = db.rs.getString(5).toString();
					String paper_type = db.rs.getString(4).toString();
					String s = "理论研究";
					if(paper_type.equals("b"))
						s = "应用研究";
					else if(paper_type.equals("c"))
						s = "软件设计";
			%>
			<tr>
			  <td  class="a"><%=db.rs.getString(2)%></td>
			  <td  class="b"><%=db.rs.getString(3)%></td>
			  <td  class="d"><%=s %></td>
			  <td  class="c"><a href="#">点击下载</a></td>
			  <td  class="e">
				<form action="/project/teaPaper?student_id=<%=db.rs.getString(1)%>" method="post">
			        <input type="text" name="guide_grade" class="paper" placeholder="输入评分" value="<%=guide_grade%>">
			        <input type="submit" class="paper" value="提交" onclick="return confirm('确认提交？');">
			    </form>
			  </td>
			</tr>
			<% 
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
		</table>
	</div>
<%
	db.Close();
%>
</body>
</html>