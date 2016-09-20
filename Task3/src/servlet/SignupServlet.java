package servlet;

import javax.servlet.http.*;

import database.DBFunction;
import user.User;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;

//用户注册
public class SignupServlet extends HttpServlet{
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		User user = new User();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		if(DBFunction.userIsExist(username)){
			request.setAttribute("message", "用户名已存在！");
			request.getRequestDispatcher("/signerror.jsp").forward(request, response);
			return;
		}
		user.setUsername(username);
		user.setPassword(password);
		user.setSex(request.getParameter("sex"));
		user.setEmail(email);
		user.setLevel(1);
		user.setAccount(1000);
		DBFunction.insertUser(user);
		response.sendRedirect("signsuccess.jsp");
	}
}
