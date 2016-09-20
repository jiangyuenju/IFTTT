<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"
		 import="database.*" %>
<% 
Connection con=ConnectDB.getConnection();
String sql1="select * from message where id = ?;";
PreparedStatement ps1=con.prepareStatement(sql1);
ps1.setString(1, request.getParameter("id"));
ResultSet rs1=ps1.executeQuery();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Set the viewport so this responsive site displays correctly on mobile devices -->
    <meta name="viewport" content="width=1000, initial-scale=1.0, maximum-scale=1.0">
    <link href="dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="dist/css/flat-ui.css" rel="stylesheet">
    <link href="docs/assets/css/demo.css" rel="stylesheet">

    <link rel="shortcut icon" href="img/favicon.ico">
<title>详情</title>

<script type="text/javascript">
function modify(){
	document.getElementById("content").readOnly=false
	document.getElementById("commit").style.visibility="visible"
}
</script>

</head>
<body>
<style>
      body {
        min-height: 2000px;
      }

      .navbar-static-top {
        margin-bottom: 19px;
      }
</style>

   <!-- Static navbar -->
    <div class="navbar navbar-default navbar-static-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
          </button>
          <a class="navbar-brand" href="#">IFTTT</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="UserManage.jsp">用户管理</a></li>
            <li><a href="SendNotice.jsp">发公告</a></li>
            <li class="active"><a href="MessageManage.jsp">消息管理</a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>
    <%rs1.next();%>
    <div class="container">
    <form action="http://localhost:8080/Task3/messagemanage?id=<%=request.getParameter("id") %>" method="post">
	<div class="form-group">
	
	<%
	if(rs1.getBoolean("public")){
	%><span class="demo-text-note">公告：</span>
	<%}else{
	%><div><span class="demo-text-note">私信：</span></div>
		<span class="col-xs-1 demo-text-note" >发往:</span>
		<div class="col-xs-11" style="text-align:left">
		<input class="form-control" style="color:#2f4f4f;" type="text" id="username" name="username" value=<%=rs1.getString("recvname")%> readonly="readonly">
		</div>
	<%} %>
	</div>
	
	<span class="col-xs-1 demo-text-note" style="margin-bottom:20px;">内容:</span>
	<div class="col-xs-11" style="text-align:left">
	<input class="form-control" style="color:#2f4f4f;margin-bottom:20px;" type="text" id=content name=content value=<%=rs1.getString("noticetext")%> readonly="readonly">
	</div>
	<input type="submit" name="delnot" class="btn btn-primary" style="margin-bottom:20px; font-size:20px;" value="删除" >
	<input type="button" class="btn btn-primary" style="margin-bottom:20px; font-size:20px;" value="编辑" onclick="modify()">
	<input type="submit" class="btn btn-primary" name=commit style="margin-bottom:20px; font-size:20px; visibility:hidden;" id=commit value="保存">
		
	</form>
	</div>
</body>
</html>