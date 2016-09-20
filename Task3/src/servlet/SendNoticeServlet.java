package servlet;

import javax.servlet.http.*;

import database.DBFunction;

import java.io.IOException;
import javax.servlet.*;

//发送公告
public class SendNoticeServlet extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("UTF-8");
		String text=request.getParameter("text");
		DBFunction.sendNotice(text);
		response.sendRedirect("SendNotice.jsp");
		return;
	}
}
