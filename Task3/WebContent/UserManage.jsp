<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.*"
		import="database.*" %>
<%
Connection con=ConnectDB.getConnection();
String sql="select * from ifttt_user;";
PreparedStatement ps=con.prepareStatement(sql);
ResultSet rs=ps.executeQuery();
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
<title>用户管理</title>
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
            <li class="active"><a href="UserManage.jsp">用户管理</a></li>
            <li><a href="SendNotice.jsp">发公告</a></li>
            <li><a href="MessageManage.jsp">消息管理</a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>
    
    <div class="container">
	<%
	while(rs.next()){
		%>
		<div class="row">
		<div>
		<textarea style="width:1000px; margin-bottom:10px;" rows="1" readonly="readonly"><%=rs.getString("username")%></textarea>
		</div>
		<div>
		<a href="UserDetail.jsp?username=<%=rs.getString("username")%>"><input class="btn btn-primary" type="button" value="会员详情" style="margin-bottom:20px; width:100px; font-size:18px;"/></input></a>
		<a href="SendPrivate.jsp?username=<%=rs.getString("username")%>"><input class="btn btn-primary" type="button" value="发送私信" style="margin-bottom:20px; width:100px; font-size:18px;"/></input></a>
		</div>
		</div>
		<%}
		rs.close();  
		ps.close();
		con.close();
		%>      
	</form>
    </div> <!-- /container -->
    
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>

</body>
</html>