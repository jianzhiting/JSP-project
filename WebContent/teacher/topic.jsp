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
	String introduction = "";
	String topic_name = request.getParameter("topic_name");
	String delete = request.getParameter("delete");
	request.setCharacterEncoding("utf-8");
	String sql = "";
	if(delete != null&&delete.equals("yes")){
		sql = "delete from tb_topic where topic_name='"+topic_name+"' and teacher_id='"+id+"'";
		db.stmt.executeUpdate(sql);
		topic_name = "";
	}
	else if(topic_name != null){
		sql = "select introduction from tb_topic where teacher_id='"+id+"' and topic_name='"+topic_name+"'";
		db.rs = db.stmt.executeQuery(sql);
		db.rs.next();
		introduction = db.rs.getString(1).toString();
	}
	else
		topic_name = "";
%>
	<div class="topic" id="left">
		<table>
			<tr>
			  <th class="a">课题名称</th>
			  <th class="b">审核状态</th>
			</tr>
			<%
			try {
				db.rs = db.stmt.executeQuery("select topic_name,review_state from tb_topic where teacher_id='"+ id +"'");
				while(db.rs.next()){
					int state = Integer.parseInt(db.rs.getString(2));
					String s = "审核未通过";
					if(state == 0)
						s = "待审核";
					else if(state == 1)
						s = "审核通过";
			%>
			<tr>
			  <td class="a"><a href="/project/teacher/topic.jsp?topic_name=<%=db.rs.getString(1)%>"><%=db.rs.getString(1)%></a></td>
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
		<h1 style="font-size: 27px">申报课题</h1>
		<div>
            <form action="/project/teaTopic" method="post" id="f">
            	课题名：<input type="text" name="topic" class="topic_name" value="<%=topic_name %>"><br/>
            	<p>简 &nbsp&nbsp介：</p>
            	<textarea name="introduction" form="f" maxlength="50"><%=introduction %></textarea><br/><br/>
                <input type="submit" class="down" value="提&nbsp交" onClick="return confirm('确认提交');">
                <a href="/project/teacher/topic.jsp?delete=yes&topic_name=<%=topic_name %>" onClick="return confirm('确认删除');"><input type="button" class="down" value="删&nbsp除"></a>
                <input type="reset" class="down" value="重&nbsp置">
            </form>
            <p class="bottom">点击课题名称进行修改，如若同时修改课题名称，则视为新申请课题</p>
    	</div>
	</div>
<%
	db.Close();
%>
</body>
</html>