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

<body>
<%
	DataBase db = new DataBase();
	String id = session.getAttribute("id").toString();
	String director = "";
	String introduction = "";
	String topic_name = request.getParameter("topic_name");
	String teacher_id = request.getParameter("teacher_id");
	String review = request.getParameter("review");
	request.setCharacterEncoding("utf-8");
	if(review != null && teacher_id != null){		
		if(review.equals("yes"))
			db.stmt.executeUpdate("update tb_topic set review_state='1' where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'");
		else if(review.equals("no"))
			db.stmt.executeUpdate("update tb_topic set review_state='2' where topic_name='"+topic_name+"' and teacher_id='"+teacher_id+"'");		
	}
	else if(teacher_id != null){
		db.rs = db.stmt.executeQuery("select teacher_name from tb_teacher where teacher_id='"+teacher_id+"'");
		db.rs.next();
		director = db.rs.getString(1).toString();
		String sql = "select introduction from tb_topic where teacher_id='"+teacher_id+"' and topic_name='"+topic_name+"'";
		db.rs = db.stmt.executeQuery(sql);
		db.rs.next();
		introduction = db.rs.getString(1).toString();
	}
%>
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">课题名称</th>
			  <th class="b">审核状态</th>
			</tr>
			<%
			try {
				String sql = "select topic_name,tb_topic.teacher_id,review_state "+
					"from tb_topic left join tb_teacher on(tb_topic.teacher_id=tb_teacher.teacher_id) "+
					"where review_state='0' and college_id='"+id+"'";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					int state = Integer.parseInt(db.rs.getString(3));
					String s = "审核未通过";
					if(state == 0)
						s = "待审核";
					else if(state == 1)
						s = "审核通过";
			%>
			<tr>
			  <td class="a"><a href="teacherTopic.jsp?teacher_id=<%=db.rs.getString(2) %>&topic_name=<%=db.rs.getString(1)%>"><%=db.rs.getString(1)%></a></td>
			  <td class="b"><%=s %></td>
			</tr>
			<%
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
		</table>
	</div>
	<div class="topic" id="right">
		<h1 style="font-size: 27px">详细内容</h1>
		<div>
            <form id="f">
            	导师名：<input type="text" name="topic" readonly="readonly"class="topic_name" value="<%=director %>"><br/>
            	<p>简 &nbsp&nbsp介：</p>
            	<textarea name="introduction" form="f" maxlength="50"readonly="readonly"><%=introduction %></textarea><br/><br/>
                <a href="teacherTopic.jsp?review=yes&topic_name=<%=topic_name %>&teacher_id=<%=teacher_id %>" onClick="return confirm('确认通过？');"><input type="button" class="down" value="通过"></a>
                <a href="teacherTopic.jsp?review=no&topic_name=<%=topic_name %>&teacher_id=<%=teacher_id %>" onClick="return confirm('确认不通过？');"><input type="button" class="down" value="不通过"></a>
            </form>
            <p class="bottom">点击课题名称进行评审</p>
    	</div>
	</div>
<%
	db.Close();
%>
</body>
</html>