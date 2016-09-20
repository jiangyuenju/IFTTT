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
import database.DBFunction;
import user.User;

//修改用户信息
public class ChangeProfileServlet extends HttpServlet{
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		Connection con=ConnectDB.getConnection();
		PreparedStatement ps;
		
		if(request.getParameter("commit")!=null){//修改資料
		String oldusername=request.getParameter("oldusername");
		String username=request.getParameter("username");//TODO:已有用户名？
		String email=request.getParameter("email");
		String sql1="update ifttt_user set username = ? where username=?";
		String sql2="update ifttt_user set email = ? where username = ?";
		try{
			ps =con.prepareStatement(sql1);
			ps.setString(1, username);
			ps.setString(2, oldusername);
			ps.executeUpdate();
			ps.close();
			ps=con.prepareStatement(sql2);
			ps.setString(1, email);
			ps.setString(2, username);
			ps.executeUpdate();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
			String url="UserProfile.jsp?username="+username;
			response.sendRedirect(url); 
		}
		}
		else if(request.getParameter("deposit")!=null){
			String money=request.getParameter("money");
			String sql="update ifttt_user set account=account+?,level=? where username=?;";
			String username=request.getParameter("oldusername");
			try{
				User user = DBFunction.getUserByName(username);
				int conLev = DBFunction.numOfConsum(username)/10+1;
				if(conLev > user.getLevel()) conLev = user.getLevel();
				ps=con.prepareStatement(sql);
				ps.setString(1,money);
				ps.setString(2, ""+conLev);
				ps.setString(3, username);
				ps.executeUpdate();
				ps.close();
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String t = df.format(new Date());
				DBFunction.insertConsum(user, 0, money, t);
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				ConnectDB.closeConnection(con);
				String url="UserProfile.jsp?username="+username;
				response.sendRedirect(url); 
			}
		}
	}
}
