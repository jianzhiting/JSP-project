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
	DataBase db = new DataBase();
	String id = session.getAttribute("id").toString();
   
	String topic_name ="";
	String teacher_id = "";
	String teacher_name = "";
	String content = "";
	
	Object ob = request.getParameter("teacher_id");//获取教师id
	if(ob != null){
		teacher_id= request.getParameter("teacher_id");//获取教师id
		topic_name= request.getParameter("topic_name");	
		db.rs = db.stmt.executeQuery("select teacher_name from tb_teacher where teacher_id='"+teacher_id+"'");
		db.rs.next();
		teacher_name = db.rs.getString(1).toString();
		db.rs = db.stmt.executeQuery("select content from tb_task where teacher_id='"+teacher_id+"' and topic_name='"+topic_name+"'");
		if(db.rs.next()){
			content = db.rs.getString(1).toString();
		}
	}
%>
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">课题名</th>
			 
			  <th class="b">审核状态</th>
			</tr>
			<%
			try {
				String sql = "select tb_task.teacher_id,topic_name,review_state "+
					"from tb_task left join tb_teacher on(tb_task.teacher_id=tb_teacher.teacher_id) "+
					"where college_id='"+id+"' "+
					"order by review_state asc,submit_time asc";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					String str=db.rs.getString(3).toString();
					if(str.equals("0"))//未审核
					str="未审核";
					if(str.equals("1"))//未审核
					str="审核通过";
					if(str.equals("2"))//未审核
					str="审核未通过";
			%>
			<tr>
			  <td  class="a"><a href="/project/college/checkReport/task.jsp?teacher_id=<%=db.rs.getString(1) %>&topic_name=<%=db.rs.getString(2)%>"><%=db.rs.getString(2)%></a></td>
			  <td class="b"><%=str %></td>
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
	<div class="topic"id="right">
		<h1 style="font-size: 27px">详细内容</h1>
		<div>
            <form action="/project/colTask?teacher_id=<%=teacher_id %>&topic_name=<%=topic_name %>" method="post" id="f">
            	导师名：<input type="text" name="topic_name" class="topic_name" value="<%=teacher_name %>" readonly="readonly"><br/>
            	<p>任 &nbsp&nbsp务：</p>
            	<textarea name="introduction" form="f" maxlength="50"  readonly="readonly"><%=content%></textarea><br/><br/>
                <input type="submit" name="pass" class="down" value="通&nbsp过">
                <input type="submit" name="notpass" class="down" value="不通过">
            </form>
            <p class="bottom">点击课题名称进行评审</p>
    	</div>
	</div>
</body>
</html>