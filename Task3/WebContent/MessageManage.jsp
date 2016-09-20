<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"
		 import="database.*" %>
<% 
Connection con=ConnectDB.getConnection();
String sql1="select * from message where public = true group by noticetext;";
PreparedStatement ps1=con.prepareStatement(sql1);
ResultSet rs1=ps1.executeQuery();

String sql2="select * from message where public = false;";
PreparedStatement ps2=con.prepareStatement(sql2);
ResultSet rs2=ps2.executeQuery();
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
    
<title>消息管理</title>


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
    
    <div class="container">
	<div class="form-group">
	<span class="demo-text-note">公告：</span>
	</div>
	<%
	while(rs1.next()){
		%>
		<div>
		<textarea name=notice id=notice style="width:1000px; margin-bottom:10px;" rows="2" readonly="readonly"><%=rs1.getString("noticetext")%></textarea>
		</div>
		<a href="MessageDetail.jsp?id=<%=rs1.getString("id")%>"><input type="button" name="delnot" class="btn btn-primary" style="margin-bottom:20px; font-size:20px;" value="详情"></a>
		<%}
		rs1.close();  
		ps1.close();
	%> 
	<div class="form-group">
	<span class="demo-text-note">私信：</span>
	</div>  
	<%
	while(rs2.next()){
		String content = "收件人:"+rs2.getString("recvname")+"\n内容："+rs2.getString("noticetext");
		%>	
		<div class="form-group">
		<span class="col-xs-1 demo-text-note" >发往:</span>
		<div class="col-xs-11" style="text-align:left">
		<input class="form-control" style="color:#2f4f4f;" type="text" id="username" name="username" value=<%=rs2.getString("recvname")%> readonly="readonly">
		</div>
		<span class="col-xs-1 demo-text-note" style="margin-bottom:20px;">内容:</span>
		<div class="col-xs-11" style="text-align:left">
		<input class="form-control" style="color:#2f4f4f;margin-bottom:20px;" type="text" id=private name=private value=<%=rs2.getString("noticetext")%> readonly="readonly">
		</div>	
		
		<a href="MessageDetail.jsp?id=<%=rs2.getString("id")%>"><input type="button" name="delpri" class="btn btn-primary" style="margin-bottom:20px; font-size:20px;" value="详情"></a>
		
		</div>
	<%}
	rs2.close();  
	ps2.close();
	con.close();
	%>  

    </div> <!-- /container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>

</body>
</html>