<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"
		 import="database.*"
		 import="task.Task"%>
<%
Connection con=ConnectDB.getConnection();
String sql="select * from task where id = ?;";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, request.getParameter("taskid"));
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
<title>修改任务</title>
</head>

<style>
body {
  min-height: 2000px;
}

.navbar-static-top {
  margin-bottom: 19px;
}

.div-relative{
  position:relative;
  width:700px;
  height:300px;
}
.div-option{
  position:absolute;
  left:0px;
  top:0px;      
}
</style>
<body>
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
            <li class="active"><a href="TaskManage.jsp?username=<%=request.getParameter("username")%>">任务管理</a></li>
            <li><a href="UserProfile.jsp?username=<%=request.getParameter("username")%>">用户资料</a></li>
            <li><a href="Messages.jsp">Messages<span class="navbar-unread"></span></a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
</div>

<div class="container">
<h3>Task ID <%=request.getParameter("taskid")%></h3>
<a href=TaskManage.jsp?username=<%=request.getParameter("username")%>><span class="fui-triangle-left-large"></span>&ensp;Back to my Tasks</a>
<% 
		rs.next();
		String thisImgPath=null;
		String detail="";
		String thisTimeVisib="hidden";
		String thisMailVisib="hidden";
		String thisWeiboVisib="hidden";
		String thisWeiboVisib2="hidden";
		String thatMailVisib="hidden";
		String thatWeiboVisib="hidden";
		int This=rs.getInt("This");
		if(This == Task.ALARM){
			thisImgPath="images/icons/svg/clocks.svg";
			detail+="if the time is "+rs.getString("alarm")+", ";
			thisTimeVisib="visible";
		}
		else if(This==Task.RECVM){
			thisImgPath="images/icons/svg/mail.svg";
			detail+="if "+rs.getString("thisId")+" receive any email, ";
			thisMailVisib="visible";
		}
		else if(This==Task.RECVW){
			thisImgPath="images/icons/weibo.png";
			detail+="if "+rs.getString("thisId")+" publish a post:"+rs.getString("thisContent")+", ";
			thisWeiboVisib="visible";
		}
		else if(This==Task.PERIOD){
			thisImgPath="images/icons/weibo.png";
			detail+="if "+rs.getString("thisId")+" doesn't publish any post in "+rs.getInt("period")+" milliseconds, ";
			thisWeiboVisib2="visible";
		}
		int That=rs.getInt("That");
		String thatImgPath=null;
		if(That==Task.SENDM){
			thatImgPath="images/icons/svg/mail.svg";
			detail+="then send a mail to "+rs.getString("thatToAddrs")+" with content: "+rs.getString("thatContent")+".";
			thatMailVisib="visible";
		}
		else if(That == Task.WEIBO){
			thatImgPath="images/icons/weibo.png";
			detail+="then publish a post to "+rs.getString("thatId")+" with content: "+rs.getString("thatContent")+".";
			thatWeiboVisib="visible";
		}
%>
<div class="row" style="margin-top:50px;">
		<div style="display:inline; margin-left:20px;">
		<label style="font-size:50px;">if</label>
		</div>
		<div style="display:inline; margin-left:20px;">
		<img src=<%=thisImgPath%>>
		</div>
		<div style="display:inline; margin-left:20px;">
		<label style="font-size:50px;">then</label>
		</div>
		<div style="display:inline; margin-left:20px;">
		<img src=<%=thatImgPath%>>
		</div>
<p class="leading" style="margin-left:20px; margin-top:30px;"><%=detail%></p>		
</div>
<form action="http://localhost:8080/Task3/modifytask" method="post">
<input type="hidden" name="taskid" value=<%=request.getParameter("taskid")%>>
<input type="hidden" name="username" value=<%=request.getParameter("username")%>>
<h4>Trigger:</h4>

<div class="div-relative">
	<div class="div-option" style="visibility:<%=thisTimeVisib%>;">
	<div>
	<label class="control-label">时间：</label>
	<input class="form-control" style="width:300px;" name="time" value=<%=rs.getString("alarm")%>>
	</div>
	</div>
	<div class="div-option" style="visibility:<%=thisMailVisib%>;">
	<label class="control-label">邮箱账号：</label>
	<input class="form-control" style="width:300px;" name="mailusern" value=<%=rs.getString("thisId")%>>
	<label class="control-label">邮箱密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="mailpassw" value=<%=rs.getString("thisPassw")%>>
	</div>
	<div class="div-option" style="visibility:<%=thisWeiboVisib%>;">
	<label class="control-label">微博账号：</label>
	<input class="form-control" style="width:300px;" name="weibousern" value=<%=rs.getString("thisId")%>>
	<label class="control-label">微博密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="weibopassw" value=<%=rs.getString("thisPassw")%>>
	<label class="control-label">指定内容：</label>
	<input class="form-control" style="width:300px;" name="weibocontent" value=<%=rs.getString("thisContent")%>>
	</div>
	
	<div class="div-option" style="visibility:<%=thisWeiboVisib2%>;">
	<label class="control-label">微博账号：</label>
	<input class="form-control" style="width:300px;" name="weibousern2" value=<%=rs.getString("thisId")%>>
	<label class="control-label">微博密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="weibopassw2" value=<%=rs.getString("thisPassw")%>>
	<label class="control-label">时间长度：</label>
	<input class="form-control" style="width:300px;" name="weiboperiod" value=<%=rs.getInt("period")+""%>>
	</div>
	
</div>
<h4>Action:</h4>
<div class="div-relative">
	<div class="div-option" style="visibility:<%=thatMailVisib%>;">
	<label class="control-label">邮箱账号：</label>
	<input class="form-control" style="width:300px;" name="sendmailusern" value=<%=rs.getString("thatId")%>>
	<label class="control-label">邮箱密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="sendmailpassw" value=<%=rs.getString("thatPassw")%>>
	<label class="control-label">正文：</label>
	<input class="form-control" style="width:300px;" name="sendmailcontent" value=<%=rs.getString("thatContent")%>>
	<label class="control-label">收件人：</label>
	<input class="form-control" style="width:300px;" name="sendmailto" value=<%=rs.getString("thatToAddrs")%>>
	</div>
	<div class="div-option" style="visibility:<%=thatWeiboVisib%>;">
	<label class="control-label">微博账号：</label>
	<input class="form-control" style="width:300px;" name="sendweibousern" value=<%=rs.getString("thatId")%>>
	<label class="control-label">微博密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="sendweibopassw" value=<%=rs.getString("thatPassw")%>>
	<label class="control-label">微博内容：</label>
	<input class="form-control" style="width:300px;" name="sendweibocontent" value=<%=rs.getString("thatContent")%>>
	</div>
</div>
<input type="submit" style="font-size:20px; margin-top:50px;" class="btn btn-primary" value="Update">
</form>
</div>
</body>
</html>