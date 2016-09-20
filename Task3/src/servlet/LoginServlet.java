package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;

import database.DBFunction;
import task.TaskMap;
import user.User;

//通过按键选择调用注册界面或是进行登录
public class LoginServlet extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		if(request.getParameter("signup")!=null){
			response.sendRedirect("Signup.jsp");
			return;
		}
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		User user = DBFunction.login(username, password);
		if(user==null){
			response.sendRedirect("LoginFailed.jsp");
		}
		else{
			if(username.equals("admin")){
				response.sendRedirect("Admin.jsp");
			}
			else{
				//response.sendRedirect("LoginSuccess.jsp");
				request.getRequestDispatcher("/LoginSuccess.jsp").forward(request, response);
				return;
			}
		}
	}
}
