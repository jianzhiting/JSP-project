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
	String review_state = "";
	int cnt = 1;
	request.setCharacterEncoding("utf-8");
%>
	<div id="table">
		<table>
			<tr>
			  <th class="i">小组</th>
			  <th class="h">答辩组长</th>
			  <th class="h">成员一</th>
			  <th class="h">成员二</th>
			  <th class="c">答辩开始时间</th>
			  <th class="c">答辩结束时间</th>
			  <th class="j">答辩地址</th>
			  <th class="j">答辩秘书</th>
			</tr>
			<%
			try {
				String sql = "select team_id,capital_id,member_one,member_two,defence_time,defence_address,secretary_id "+
					"from tb_defence_team "+
					"where college_id='"+id+"'";
				db.rs = db.stmt.executeQuery(sql);
				while(db.rs.next()){
					DataBase db2 = new DataBase();
					db2.rs = db2.stmt.executeQuery("select teacher_name from tb_teacher where teacher_id='"+db.rs.getString(2)+"'");
					db2.rs.next();
					String capital_name = db2.rs.getString(1).toString();
					db2.rs = db2.stmt.executeQuery("select teacher_name from tb_teacher where teacher_id='"+db.rs.getString(3)+"'");
					db2.rs.next();
					String member_one_name = db2.rs.getString(1).toString();
					db2.rs = db2.stmt.executeQuery("select teacher_name from tb_teacher where teacher_id='"+db.rs.getString(4)+"'");
					db2.rs.next();
					String menber_two_name = db2.rs.getString(1).toString();
					db2.rs = db2.stmt.executeQuery("select student_name from tb_student where student_id='"+db.rs.getString(7)+"'");
					db2.rs.next();
					String secretary_name = db2.rs.getString(1).toString();
					db2.Close();
					String defence_time[] = db.rs.getString(5).toString().split(",");
					cnt++;
			%>
			<tr>
			  <td  class="i"><%=db.rs.getString(1) %></td>
			  <td  class="h"><%=capital_name%></td>
			  <td  class="h"><%=member_one_name%></td>
			  <td  class="h"><%=menber_two_name %></td>
			  <td  class="c"><%=defence_time[0] %></td>
			  <td  class="c"><%=defence_time[1] %></td>
			  <td  class="j"><%=db.rs.getString(6) %></td>
			  <td  class="j"><%=secretary_name %></td>
			</tr>
			<% 	
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			%>
			<tr>
			  <td  class="i"><%=cnt %></td>
			  <%for(int i=0;i<3;i++){%>
			  <td  class="h">
			  	<select form="f" name="<%=i%>">
			  	<%
			  	try {		  
					DataBase db2 = new DataBase();
					String sql = "select teacher_id,teacher_name from tb_teacher "+
						"where college_id='"+id+"' and teacher_id not in("+
						"select capital_id from tb_defence_team union "+
						"select member_one from tb_defence_team union "+
						"select member_two from tb_defence_team)";
					db2.rs = db2.stmt.executeQuery(sql);
					while(db2.rs.next()){
				%>
				<option value="<%=db2.rs.getString(1) %>"><%=db2.rs.getString(2) %></option>
				<%
					}
					db2.Close();
				}
			    catch (SQLException e1) {
			    	System.out.println(e1);
			    }
			  	%>				  
				</select>
			  </td>
			  <%} %>
			  <td  class="c"><input type="datetime-local" value="2015-09-24T13:59:59" class="defence" form="f" name="start"/></td>
			  <td  class="c"><input type="datetime-local" value="2015-09-24T13:59:59" class="defence" form="f" name="end"/></td>
			  <td  class="j"><input type="text" placeholder="地址" class="defence" id="defence_address" form="f" name="address"/></td>
			  <td  class="j">
				<form action="/project/colDefence" method="post" id="f">
					<input name="item" type="hidden"value="<%=cnt %>">
			        <input type="submit" class="paper" value="提交" onclick="return confirm('提交？');">
			    </form>
			  </td>
			</tr>
		</table>
	</div>
	<script type="text/javascript">
	<%if(request.getParameter("s")!=null){
		out.write("alert('填写存在问题');");
	}
	%>
	</script>
<%
	db.Close();
%>
</body>
</html>