<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.*"
		import="database.*" %>
<%
Connection con=ConnectDB.getConnection();
String sql="select * from ifttt_user where username = ?;";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, request.getParameter("username"));
ResultSet rs=ps.executeQuery();

String sql2="select * from consumption where username = ?;";
PreparedStatement ps2=con.prepareStatement(sql2);
ps2.setString(1, request.getParameter("username"));
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
<title>登陆成功</title>

<script type="text/javascript">
function modify(){
	document.getElementById("username").readOnly=false
	document.getElementById("email").readOnly=false
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
            <li><a href="LoginSuccess.jsp?username=<%=request.getParameter("username")%>">新建任务</a></li>
            <li><a href="TaskManage.jsp?username=<%=request.getParameter("username")%>">任务管理</a></li>
            <li  class="active"><a href="UserProfile.jsp?username=<%=request.getParameter("username")%>">用户资料</a></li>
            <li><a href=Messages.jsp?username=<%=request.getParameter("username")%>>Messages<span class="navbar-unread"></span></a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>


    <div class="container">
	<h5>个人资料</h5>
	<form id="myform" action="http://localhost:8080/Task3/changeprofile?oldusername=<%=request.getParameter("username")%>" method="post">
	<div>
	<label class="control-label">当前账户:</label>
	<input class="form-control" style="color:#2f4f4f;" type="text" id="username" name="username" value=<%=request.getParameter("username")%> readonly="readonly">
	</div>
	<%rs.next();%>
	<div>
	<label class="control-label">注册邮箱：</label>
	<input class="form-control" style="color:#2f4f4f;" type="text" id="email" name="email" value=<%=rs.getString("email")%> readonly="readonly">
	</div>
	<div>
	<label class="control-label">用户等级：</label>
	<input class="form-control" style="color:#2f4f4f;" type="text" name="level" value=<%=rs.getString("level")%> readonly="readonly">
	</div>
	<div>
	<label class="control-label">账户余额：</label>
	<input class="form-control" style="color:#2f4f4f;" type="text" name="account" value=<%=rs.getString("account")%> readonly="readonly">
	</div>
	<input type="button" class="btn btn-primary" style="margin-top:30px; font-size:20px;" value="编辑" onclick="modify()">
	<input type="submit" class="btn btn-primary" name="commit" style="margin-top:30px; font-size:20px; margin-left:20px; visibility:hidden;" id="commit" value="保存">
	
	<h5>账户充值</h5>
    <label class="control-label" style="width:100px;">充值金额：</label>
    <div class="input-group">  
    <input class="form-control"  type="text" name="money">
    <span class="input-group-addon">$</span>
    </div>
    <input type="submit" class="btn btn-primary" name="deposit" style="margin-top:30px; font-size:20px;">
	<%
	rs.close();
	ps.close();
	%>
	
	<h5>消费记录</h5>
	<div class="container">
	<%
	while(rs2.next()){
		String content="于："+rs2.getString("alarm")+" 有一笔收支："+rs2.getString("cost")+" ，余额为："+rs2.getString("account")+" \n"+rs2.getString("taskdetail");
		%>
		<!-- <div>
		<textarea style="width:1000px; margin-bottom:10px;" rows="3" readonly="readonly"></textarea>
		</div>-->
		<ul class="list-group">
    	<li class="list-group-item"><%=content%></li>
		<%}
		rs2.close();  
		ps2.close();
		con.close();
		%>
		</ul>
    </div> <!-- /container -->
	
	
	</form>
	
    </div> <!-- /container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>

  </body>
</html>
