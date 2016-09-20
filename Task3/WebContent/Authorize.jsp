<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="weibo4j.Oauth"
		 import="weibo4j.Users"
		 import="weibo4j.http.AccessToken"
		 import="weibo4j.Account"
		 import="weibo4j.model.User"
		 import="java.sql.*"
		 import="database.*" %>   

<%
String code=request.getParameter("code");
Oauth oauth = new Oauth();
AccessToken token=(oauth.getAccessTokenByCode(code));
String mytoken=token.getAccessToken();
Account am = new Account(mytoken);
String userId=am.getUid().getString("uid");
Users um = new Users(mytoken);
User user = um.showUserById(userId);
String nname = user.getScreenName();

Connection con=ConnectDB.getConnection();
String sql="select * from task where (thisId =?and (This=5 or this=6)) or (thatId =? and That=4) order by id desc;";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, nname);
ps.setString(2, nname);
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
<title>授权成功</title>

<script type="text/javascript">
function formsubmit(){
	document.getElementById("myform").submit();    
}
</script>
</head>

<style>

.navbar-static-top {
  margin-bottom: 19px;
}
</style>

<body>
<form id="myform" action="http://localhost:8080/Task3/authorize" method="post">
<input type="hidden" name="token" value=<%=mytoken%>>

<div class="navbar navbar-default navbar-static-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
          </button>
          <a class="navbar-brand" href="#">IFTTT</a>
        </div>
        <div class="navbar-collapse collapse">         
        </div><!--/.nav-collapse -->
      </div>
</div>
<div class="container">
<h4>请选择你要授权执行的任务ID</h4>
<div class="col-xs-3">
<%while(rs.next()){
	String id=rs.getString("id");
%>
	<label class="radio icon-checked">
	<input type="radio" name="taskid" value=<%=id%> data-toggle="radio">
	<%=id%>
	</label>
<%}
%>
</div>
<input class="btn btn-primary btn-lg" type="submit" value="确定"/>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>
</form>
</body>
</html>