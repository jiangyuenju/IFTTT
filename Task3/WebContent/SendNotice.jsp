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
<title>Administrator</title>
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
            <li class="active"><a href="SendNotice.jsp">发公告</a></li>
            <li><a href="MessageManage.jsp">消息管理</a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>
    
    <div class="container">
    <form action="http://localhost:8080/Task3/sendnotice" method="post">
    <div>
    <textarea class="form-control" rows="4" style="margin-top:100px;" placeholder="请输入公告内容" name="text"></textarea>
    </div>
    <div>
    <input class="btn btn-primary" style="margin-top:40px;" type="submit" value="发送"/>
    </div>
    </form>
    </div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>
</body>
</html>