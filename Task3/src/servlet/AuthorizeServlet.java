package servlet;

import java.io.IOException;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import task.CheckWeibo;
import task.MonitorWeibo;
import task.SendWeibo;
import task.TaskMap;
import weibo4j.model.WeiboException;

//通过taskid判断任务类型，选择设置哪个微博任务的token值
public class AuthorizeServlet extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		String token=request.getParameter("token");
//		CheckWeibo.setCode(code);
//		MonitorWeibo.setCode(code);
		int taskId=Integer.parseInt(request.getParameter("taskid"));
		TimerTask tt =TaskMap.getTimerTask(taskId);
		if(tt instanceof CheckWeibo){
			((CheckWeibo)tt).setToken(token);
		}
		else if(tt instanceof SendWeibo){
			((SendWeibo)tt).setToken(token);
		}
		else if(tt instanceof MonitorWeibo){
			((MonitorWeibo)tt).setToken(token);
		}
		return;
	}
}
