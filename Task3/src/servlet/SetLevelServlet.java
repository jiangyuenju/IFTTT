package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ConnectDB;

//设置用户的等级
public class SetLevelServlet extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		String username = request.getParameter("username");
		String level = request.getParameter("level");
		Connection con=ConnectDB.getConnection();
		String sql="update ifttt_user set level=? where username=?;";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,level);
			ps.setString(2, username);
			ps.executeUpdate();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
			String url="UserDetail.jsp?username="+username;
			response.sendRedirect(url); 
		}
	}
}
