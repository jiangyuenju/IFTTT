package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import database.*;
import task.*;
import user.User;
import weibo4j.Oauth;
import weibo4j.model.WeiboException;
import weibo4j.util.BareBonesBrowserLaunch;

//开始任务
public class StartTaskServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		Connection con=ConnectDB.getConnection();
		int taskId = Integer.parseInt(request.getParameter("taskid"));
		Timer timer=new Timer();
		TimerTask tt=null;
		Task task=DBFunction.getTaskById(taskId);
		
		User user = DBFunction.getUserByName(request.getParameter("username"));
		int cost = 60 - 10 * user.getLevel();
		if(user.getAccount() >= cost){
			user.setAccount(user.getAccount()-cost);
			String sql="update ifttt_user set account=?,level=? where username=?;";
			String username=request.getParameter("username");
			try{
				int conLev = DBFunction.numOfConsum(username)/10+1;
				if(conLev > user.getLevel()) conLev = user.getLevel();
				PreparedStatement ps=con.prepareStatement(sql);
				ps.setString(1,""+user.getAccount());
				ps.setString(2, ""+conLev);
				ps.setString(3, username);
				ps.executeUpdate();
				ps.close();
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				ConnectDB.closeConnection(con);
			}
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String t = df.format(new Date());
			DBFunction.insertConsum(user, taskId, "-"+cost, t);
		}
		else{
			JOptionPane.showMessageDialog(null, "抱歉，您的余额不足！", "Error", JOptionPane.ERROR_MESSAGE); 
			response.sendRedirect("TaskManage.jsp?username="+request.getParameter("username"));
			return;
		}
		if(task.getThis()==Task.ALARM){
			SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm");
			ParsePosition pos=new ParsePosition(0);
			Date dateTime=formatter.parse(task.getTime(), pos);
			if(task.getThat()==Task.SENDM){
				tt=new SendMail(task);
				timer.schedule(tt, dateTime);
			}
			else if(task.getThat()==Task.WEIBO){
				tt=new SendWeibo(task);
				timer.schedule(tt, dateTime);
			}
		}
		else if(task.getThis()==Task.RECVM){
			tt=new CheckMail(task);
			timer.schedule(tt, 0, 10*1000);//每隔10秒執行一次
		}
		else if(task.getThis()==Task.RECVW){//监听微博发布指定内容
			tt=new CheckWeibo(new Date(),task);
			timer.schedule(tt, 0, 10*1000);//每隔10秒執行一次
		}
		else if(task.getThis()==Task.PERIOD){			
			tt = new MonitorWeibo(new Date(),task);
			timer.schedule(tt, task.getPeriod());
		}
		TaskMap.setTimerTask(taskId, tt);
		TaskMap.addTask(taskId, timer);
		response.sendRedirect("TaskManage.jsp?username="+request.getParameter("username"));
	}
}
