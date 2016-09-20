package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBFunction;

//消息管理
public class MessageManageServlet extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		if(request.getParameter("delnot")!=null){
			String id = request.getParameter("id");
			DBFunction.deleteMessage(id);
		}
		else{
			String id = request.getParameter("id");
			String content = request.getParameter("content");
			DBFunction.changeMessage(content, id);
		}
		response.sendRedirect("MessageManage.jsp"); 
	}

}
