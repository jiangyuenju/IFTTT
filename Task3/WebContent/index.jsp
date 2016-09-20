<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>IFTTT</title>
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
<div class="row demo-row">
<div class="col-xs-3">
<h1 class="demo-logo">IFTTT</h1>
</div>
</div>

<form class="login-form"  action="http://localhost:8080/Task3/login" method = "post">
<div class="form-group">

<input type="text" name="username" width="200px" class="form-control login-field" value="" placeholder="Enter your name" id="login-name" />
<label class="login-field-icon fui-user" for="login-name"></label>
</div>

<div class="form-group">
<input type="password" name="password" class="form-control login-field" value="" placeholder="Password" id="login-pass" />
<label class="login-field-icon fui-lock" for="login-pass"></label>
</div>

<div class="row">
<div style="text-align:center; margin-left:380px; display:inline;">
<input class="btn btn-primary btn-lg" type="submit" value="登录" name="login"/>
</div>
<div style="text-align:center; margin-left:300px; display:inline;">
<input class="btn btn-default btn-lg" type="submit" value="注册" name="signup"/>
</div>
</div>

</form>

</div>

</body>
</html>