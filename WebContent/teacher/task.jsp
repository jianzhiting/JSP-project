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
	String content = "";
	String topic_name = request.getParameter("topic_name");
	request.setCharacterEncoding("utf-8");
	String sql = "";
	if(topic_name != null){
		sql = "select content from tb_task where teacher_id='"+id+"' and topic_name='"+topic_name+"'";
		db.rs = db.stmt.executeQuery(sql);
		db.rs.next();
		if(db.rs.getString(1) != null)
			content = db.rs.getString(1).toString();
	}
	else
		topic_name = "";
%>
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">课题名称</th>
			  <th class="b">状态</th>
			</tr>
			<%
			try {
				db.rs = db.stmt.executeQuery("select topic_name,review_state from tb_task where teacher_id='"+ id +"'");
				while(db.rs.next()){
					String s;
					if(db.rs.getString(2) == null)
						s = "未发布任务";
					else{
						int state = Integer.parseInt(db.rs.getString(2));
						s = "审核未通过";
						if(state == 0)
							s = "待审核";
						else if(state == 1)
							s = "审核通过";	
					}
			%>
			<tr>
			  <td class="a"><a href="/project/teacher/task.jsp?topic_name=<%=db.rs.getString(1)%>"><%=db.rs.getString(1)%></a></td>
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
		<h1 style="font-size: 27px">任务书</h1>
		<div>
            <form action="/project/teaTask" method="post" id="f">
            	课题名：<input type="text" name="topic" class="topic_name" readonly="readonly" value="<%=topic_name %>"><br/>
            	<p>安 &nbsp&nbsp排：</p>
            	<textarea name="content" form="f" maxlength="50"><%=content %></textarea><br/><br/>
                <input type="submit" class="down" value="提&nbsp交" onClick="return confirm('确认提交');">
                <input type="reset" class="down" value="重&nbsp置">
            </form>
            <p class="bottom">点击课题名称进行添加或修改任务进度安排</p>
    	</div>
	</div>
<%
	db.Close();
%>
</body>
</html>