<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"
		 import="database.*"
		 import="task.Task"
		 import="task.TaskMap" %>
<% 
Connection con=ConnectDB.getConnection();
String sql="select * from task where username=? order by id desc;";
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1, request.getParameter("username"));
ResultSet rs=ps.executeQuery();
TaskMap.prepareStateMap();
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
<title>站内信</title>
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
            <li class="active"><a href="TaskManage.jsp?username=<%=request.getParameter("username")%>">任务管理</a></li>
            <li><a href="UserProfile.jsp?username=<%=request.getParameter("username")%>">用户资料</a></li>
            <li><a href="Messages.jsp">Messages<span class="navbar-unread"></span></a></li>
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </div>


    <div class="container">
    <h3>Your Tasks</h3>
    <%
	while(rs.next()){
		String thisImgPath=null;
		String detail="";
		int This=rs.getInt("This");
		if(This == Task.ALARM){
			thisImgPath="images/icons/svg/clocks.svg";
			detail+="if the time is "+rs.getString("alarm")+", ";
		}
		else if(This==Task.RECVM){
			thisImgPath="images/icons/svg/mail.svg";
			detail+="if "+rs.getString("thisId")+" receive any email, ";
		}
		else if(This==Task.RECVW){
			thisImgPath="images/icons/weibo.png";
			detail+="if "+rs.getString("thisId")+" publish a post:"+rs.getString("thisContent")+", ";
		}
		else if(This==Task.PERIOD){
			thisImgPath="images/icons/weibo.png";
			detail+="if "+rs.getString("thisId")+" doesn't publish any post in "+rs.getInt("period")+" milliseconds, ";
		}
		int That=rs.getInt("That");
		String thatImgPath=null;
		if(That==Task.SENDM){
			thatImgPath="images/icons/svg/mail.svg";
			detail+="then send a mail to "+rs.getString("thatToAddrs")+" with content: "+rs.getString("thatContent")+".";
		}
		else if(That == Task.WEIBO){
			thatImgPath="images/icons/weibo.png";
			detail+="then publish a post to "+rs.getString("thatId")+" with content: "+rs.getString("thatContent")+".";
		}
		int taskId=rs.getInt("id");
		int state=TaskMap.getState(taskId);
		String link=null;
		String tooltip=null;
		if(state==1){
			link="http://localhost:8080/Task3/starttask";
			tooltip="开始任务";
		}
		else if(state==2){
			link="http://localhost:8080/Task3/stoptask";
			tooltip="停止任务";
		}
		%>
		<Label style="font-size:25px; margin-left:10px;">Task ID:<%=taskId%></Label>
		<div class="row" style="margin-bottom:100px;">
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
		<div style="display:inline; margin-left:100px;">
		<button title=<%=tooltip%> onclick="{location.href='<%=link%>?taskid=<%=rs.getString("id")%>&username=<%=request.getParameter("username")%>'}" style="background-color:#ecf0f1; padding:0 18px; border-style: none; border-radius:8px;">
		<span class="fui-power" style="font-size:50px;"></span>
		</button>
		</div>
		<div style="display:inline;">
		<button title="修改任务" onclick="{location.href='ModifyTask.jsp?taskid=<%=rs.getString("id")%>&username=<%=request.getParameter("username")%>'}" style="background-color:#ecf0f1; padding:0 18px; border-style: none; border-radius:8px;">
		<span class="fui-new" style="font-size:50px;"></span>
		</button>
		</div>
		<div style="display:inline;">
		<button title="删除任务" onclick="{location.href='http://localhost:8080/Task3/deletetask?taskid=<%=rs.getString("id")%>&username=<%=request.getParameter("username")%>'}" style="background-color:#ecf0f1; padding:0 18px; border-style: none; border-radius:8px;">
		<span class="fui-trash" style="font-size:50px;"></span>
		</button>
		</div>
		<div>
		<p class="leading" style="margin-left:20px; margin-top:30px;"><%=detail%></p>
		</div>
		</div>
	<%}
	rs.close();  
	ps.close();
	con.close();
	%>      
    </div>
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="dist/js/vendor/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="dist/js/flat-ui.min.js"></script>

    <script src="docs/assets/js/application.js"></script>

	<script>
   
    </script>
  </body>
</html>