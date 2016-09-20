<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册成功</title>

<script language="javascript" type="text/javascript">
function Skip()
{
	window.setTimeout("window.location='index.jsp'",3000);
}
</script>
<style type="text/css"> 
html,body,div{ 
margin:0; 
padding:0; 
height:100%; 
position:relative; 
} 
.wrap{ 
width:1500px; 
height:600px; 
margin:10px; 
}
.all-middle1{ 
width:400px; 
height:150px;
top:50%; 
margin:-100px auto 0; 
}
</style>
</head>
<body onload="Skip();">
<div class="wrap"> 
	<div class="all-middle1">
		<div class="login-icon">
            &emsp;<img src="images/icons/svg/retina.svg" alt="Infinity-Loop">
			<h1 class="demo-logo">&ensp;注册成功！</h1>
			<h3>3秒钟后返回登陆界面</h3>
        </div>
    </div> 
</div> 
</body>
</html>