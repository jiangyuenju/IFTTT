package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBFunction;

//删除任务
public class DeleteTaskServlet  extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		DBFunction.deleteTask(request.getParameter("taskid"));
		response.sendRedirect("http://localhost:8080/Task3/TaskManage.jsp?username="+request.getParameter("username"));
		return;
	}
}
