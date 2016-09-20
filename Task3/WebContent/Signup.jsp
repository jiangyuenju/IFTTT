<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>Flat UI - Free Bootstrap Framework and Theme</title>
    <meta name="description" content="Flat UI Kit Free is a Twitter Bootstrap Framework design and Theme, this responsive framework includes a PSD and HTML version."/>

    <meta name="viewport" content="width=1000, initial-scale=1.0, maximum-scale=1.0">

    <!-- Loading Bootstrap -->
    <link href="dist/css/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Loading Flat UI -->
    <link href="dist/css/flat-ui.css" rel="stylesheet">
    <link href="docs/assets/css/demo.css" rel="stylesheet">

    <link rel="shortcut icon" href="img/favicon.ico">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements. All other JS at the end of file. -->
    <!--[if lt IE 9]>
      <script src="dist/js/vendor/html5shiv.js"></script>
      <script src="dist/js/vendor/respond.min.js"></script>
    <![endif]-->

<script type="text/javascript">
function check(form)
{
if(form.username.value == ""){
	alert("用户名不能为空！");
	return false;
}
if(form.password.value==""){
	alert("密码不能为空！");
	return false;
}
if(form.email.value==""){
	alert("邮箱不能为空！");
	return false;
}
return true;
}

</script>

<style>
body
{
position:fixed;
background:url(images/1.jpg);
height:100%;
width:100%;
background-repeat:no-repeat;
}
</style>

</head>
<body>
<div class="container">
<h3>用户注册</h3>

<form class="form-horizontal" style="background-color:#edeff1; padding: 24px 23px 20px; position: relative; border-radius: 6px; filter:alpha(opacity=90);
  opacity:0.9;" action="http://localhost:8080/Task3/signup" method="post" onSubmit="return check(this);">

<div class="form-group">
<span class="col-xs-2 demo-text-note">用户名：</span>
<div class="col-xs-10" style="text-align:left">
<input type="text" name="username" class="form-control"/>
</div>
</div>

<div class="form-group">
<span class="col-xs-2 demo-text-note">密码：&emsp;</span>
<div class="col-xs-10" style="text-align:left">
<input type="password" name="password" class="form-control login-field" id="login-pass"/>
</div>
</div>


<div class="form-group">
<span class="col-xs-2 demo-text-note">性别：</span>
<div class="col-xs-3">
<label class="radio icon-checked">
<input type="radio" name="sex" value="M" data-toggle="radio">
Male
</label>
<label class="radio">
<input type="radio" name="sex" value="F" data-toggle="radio" checked>
Female
</label>
</div>
</div>

<div class="form-group">
<span class="col-xs-2 demo-text-note">电子邮箱：</span>
<div class="col-xs-10">
<input type="text" name="email" class="form-control"/>
</div>
</div>

<div style="text-align:center">
<input class="btn btn-primary btn-lg" type="submit" value="注册"/>
</div>
</form>
</div>

<script src="dist/js/vendor/jquery.min.js"></script>
    <script src="dist/js/vendor/video.js"></script>
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/prettify.js"></script>
    <script src="docs/assets/js/application.js"></script>

    <script>
      videojs.options.flash.swf = "dist/js/vendors/video-js.swf"
    </script>
</body>
</html>