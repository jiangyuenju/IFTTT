<%@page import="task.Task"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="t" scope="session" class="task.Task"></jsp:useBean>
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

<script>
function chooseTime(){
	document.getElementById("div_mail").style.visibility="hidden"
	document.getElementById("div_weibo0").style.visibility="hidden"
	document.getElementById("div_weibo1").style.visibility="hidden"
	document.getElementById("div_select").style.visibility="hidden"
	document.getElementById("div_time").style.visibility="visible"
}
function chooseMail(){
	document.getElementById("div_time").style.visibility="hidden"
	document.getElementById("div_weibo0").style.visibility="hidden"
	document.getElementById("div_weibo1").style.visibility="hidden"
	document.getElementById("div_select").style.visibility="hidden"
	document.getElementById("div_mail").style.visibility="visible"
}
function chooseWeibo(){
	document.getElementById("div_time").style.visibility="hidden"
	document.getElementById("div_mail").style.visibility="hidden"
	document.getElementById("div_weibo0").style.visibility="visible"
	document.getElementById("div_select").style.visibility="visible"
}

function thatchooseMail(){
	document.getElementById("div_sendmail").style.visibility="visible"
	document.getElementById("div_sendweibo").style.visibility="hidden"
}
function thatchooseWeibo(){
	document.getElementById("div_sendweibo").style.visibility="visible"
	document.getElementById("div_sendmail").style.visibility="hidden"
}
function selectchange(){
	if(document.getElementById("myselect").value== "1"){
		document.getElementById("div_weibo0").style.visibility="hidden"
		document.getElementById("div_weibo1").style.visibility="visible"
		document.getElementById("weiboflag").value="1"
	}
	else{
		document.getElementById("div_weibo0").style.visibility="visible"
		document.getElementById("div_weibo1").style.visibility="hidden"	
		document.getElementById("weiboflag").value="0"
	}
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
      .div-mail{
        position:absolute;
		left:0px;
		top:0px; 
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
            <li class="active"><a href="#">新建任务</a></li>
            <li><a href="TaskManage.jsp?username=<%=request.getParameter("username")%>">任务管理</a></li>
            <li><a href=UserProfile.jsp?username=<%=request.getParameter("username")%>>用户资料</a></li>
            <li><a href=Messages.jsp?username=<%=request.getParameter("username")%>>Messages<span class="navbar-unread"></span></a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>


    <div class="container">
    <h2>If this then that</h2>
    <div>
    <h4>choose trigger:</h4>
    <div class="row">
    <div class="col-xs-3">
    <a href="http://localhost:8080/Task3/newtask?this=1" target="hidden_frame">
	<img src="images/icons/svg/clocks.svg" onclick="chooseTime()">
	</a>
	<h5>&emsp;定时</h5>
	</div>
	<div class="col-xs-3">
	<a href="http://localhost:8080/Task3/newtask?this=2" target="hidden_frame">
	<img src="images/icons/svg/mail.svg" onclick="chooseMail()">
	</a>
	<h5>QQ邮箱</h5>
	</div>
	<div class="col-xs-3">
	<a href="http://localhost:8080/Task3/newtask?this=5" target="hidden_frame">
	<img src="images/icons/weibo.png" onclick="chooseWeibo()">
	</a>
	<h5>新浪微博</h5>
	</div>
	</div>
	<form action="http://localhost:8080/Task3/newtask" method="post">
	<input type="hidden" name="username" value=<%=request.getParameter("username")%>>
	<input type="hidden" name="weiboflag" id="weiboflag" value="0">
	
	<div class="div-relative">
	<div class="div-option" style="visibility:hidden;" id="div_time">
	<div>
	<label class="control-label">时间：</label>
	<input class="form-control" style="width:300px;" name="time">
	</div>
	</div>
	<div class="div-option" style="visibility:hidden;" id="div_mail">
	<label class="control-label">邮箱账号：</label>
	<input class="form-control" style="width:300px;" name="mailusern">
	<label class="control-label">邮箱密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="mailpassw">
	</div>
	
	<div class="div-option" style="visibility:hidden;" id="div_select">
	<div>
	<select id="myselect" data-toggle="select" class="form-control select select-inverse mrs mbm" onchange="selectchange()">
        <option value="0">  
                     发布指定内容微博
        </option>
        <option value="1">
                    在指定时间长度内未发布微博
        </option>
    </select>
    </div>
    <label class="control-label">微博昵称：</label>
	<input class="form-control" style="width:300px;" name="weibousern">
	<label class="control-label">微博密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="weibopassw">
    </div>
    
	<div class="div-option" style="visibility:hidden; margin-top:220px;" id="div_weibo0">
	<label class="control-label">指定内容：</label>
	<input class="form-control" style="width:300px;" name="weibocontent">
	</div>
	<div class="div-option" style="visibility:hidden; margin-top:220px;" id="div_weibo1">
	<label class="control-label">时间长度（毫秒为单位）：</label>
	<input class="form-control" style="width:300px;" name="weiboperiod">
	</div>
	
	</div>
	<div>
	<input type="button" style="font-size:20px; margin-top:30px;" class="btn btn-primary" value="确定">
	</div>
	<h4>choose action:</h4>
	<div class="row">
	<div class="col-xs-3">
	<a href="http://localhost:8080/Task3/newtask?that=3" target="hidden_frame">
	<img src="images/icons/svg/mail.svg" onclick="thatchooseMail()">
	</a>
	<h5>QQ邮箱</h5>
	</div>
	<div class="col-xs-3">
	<a href="http://localhost:8080/Task3/newtask?that=4" target="hidden_frame">
	<img src="images/icons/weibo.png" onclick="thatchooseWeibo()">
	</a>
	<h5>新浪微博</h5>
	</div>
	</div>
	<div class="div-relative">
	<div class="div-option" style="visibility:hidden;" id="div_sendmail">
	<label class="control-label">邮箱账号：</label>
	<input class="form-control" style="width:300px;" name="sendmailusern">
	<label class="control-label">邮箱密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="sendmailpassw">
	<label class="control-label">正文：</label>
	<input class="form-control" style="width:300px;" name="sendmailcontent">
	<label class="control-label">收件人：</label>
	<input class="form-control" style="width:300px;" name="sendmailto">
	</div>
	<div class="div-option" style="visibility:hidden;" id="div_sendweibo">
	<label class="control-label">微博昵称：</label>
	<input class="form-control" style="width:300px;" name="sendweibousern">
	<label class="control-label">微博密码：</label>
	<input type="password" class="form-control" style="width:300px;" name="sendweibopassw">
	<label class="control-label">微博内容：</label>
	<input class="form-control" style="width:300px;" name="sendweibocontent">
	</div>
	</div>
	<input type="submit" style="font-size:20px; margin-top:30px;" class="btn btn-primary" value="确定">
	</form>
	</div>
      <!-- TODO:new task -->
    <iframe name='hidden_frame' id="hidden_frame" style="display:none"></iframe>  

    </div> <!-- /container -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>

  </body>
</html>
