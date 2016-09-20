package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import task.TaskMap;

//停止任务
public class StopTaskServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		int taskId=Integer.parseInt(request.getParameter("taskid"));
		TaskMap.setState(taskId, 1);
		TaskMap.getTimer(taskId).cancel();
		response.sendRedirect("TaskManage.jsp?username="+request.getParameter("username"));
	}

}
