package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.*;
import javax.servlet.http.*;

import database.ConnectDB;
import task.Task;

//修改任务信息
public class ModifyTaskServlet extends HttpServlet{
	@SuppressWarnings("resource")
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("UTF-8");
		String taskId=request.getParameter("taskid");
		Connection con=ConnectDB.getConnection();
		String sql="select * from task where id = ?;";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, taskId);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int This=rs.getInt("This");
			int That=rs.getInt("That");
			rs.close();
			ps.close(); 
			if(This==Task.ALARM){
				sql="update task set alarm = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("time"));
				ps.executeUpdate();
			}
			else if(This==Task.RECVM){
				sql="update task set thisId = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("mailusern"));
				ps.executeUpdate();
				sql="update task set thisPassw = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("mailpassw"));
				ps.executeUpdate();
			}
			else if(This==Task.RECVW){
				sql="update task set thisId = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("weibousern"));
				ps.executeUpdate();
				sql="update task set thisPassw = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("weibopassw"));
				ps.executeUpdate();
				sql="update task set thisContent = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("weibocontent"));
				ps.executeUpdate();
			}
			else{
				sql="update task set thisId = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("weibousern2"));
				ps.executeUpdate();
				sql="update task set thisPassw = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("weibopassw2"));
				ps.executeUpdate();
				sql="update task set period = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("weiboperiod"));
				ps.executeUpdate();
			}
			ps.close();
			if(That==Task.SENDM){
				sql="update task set thatId = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendmailusern"));
				ps.executeUpdate();
				sql="update task set thatPassw = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendmailpassw"));
				ps.executeUpdate();
				sql="update task set thatContent = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendmailcontent"));
				ps.executeUpdate();
				sql="update task set thatToAddrs = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendmailto"));
				ps.executeUpdate();
			}
			else if(That==Task.WEIBO){
				sql="update task set thatId = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendweibousern"));
				ps.executeUpdate();
				sql="update task set thatPassw = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendweibopassw"));
				ps.executeUpdate();
				sql="update task set thatContent = ? where id = "+taskId+";";
				ps=con.prepareStatement(sql);
				ps.setString(1, request.getParameter("sendweibocontent"));
				ps.executeUpdate();
				ps.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
		response.sendRedirect("http://localhost:8080/Task3/TaskManage.jsp?username="+request.getParameter("username"));
		return;
	}
}
