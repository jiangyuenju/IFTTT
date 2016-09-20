package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Timer;

import task.Task;
import task.TaskMap;
import user.User;

public class DBFunction {
	//通过task的ID获取这个Task对象
	public static Task getTaskById(int taskId){
		Task t=new Task();
		Connection con=ConnectDB.getConnection();
		String sql="select * from task where id = "+taskId+";";
		try{
			Statement s=con.createStatement();
			ResultSet rs=s.executeQuery(sql);
			rs.next();
			t.setThis(rs.getInt("This"));
			t.setThat(rs.getInt("That"));
			t.setUsername(rs.getString("username"));
			t.setPeriod(rs.getInt("period"));
			t.setTime(rs.getString("alarm"));
			t.setThisId(rs.getString("thisId"));
			t.setThisPassw(rs.getString("thisPassw"));
			t.setThisContent(rs.getString("thisContent"));
			t.setThatId(rs.getString("thatId"));
			t.setThatPassw(rs.getString("thatPassw"));
			t.setThatContent(rs.getString("thatContent"));
			t.setThatToAddrs(rs.getString("thatToAddrs"));
		}catch(Exception e){
			e.printStackTrace();
		}
		return t;
	}
	
	//通过username获取该用户
	public static User getUserByName(String username){
		User user = new User();
		Connection con=ConnectDB.getConnection();
		String sql="select * from ifttt_user where username = ?";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs=ps.executeQuery();
			rs.next();
			user.setAccount(rs.getInt("account"));
			user.setLevel(rs.getInt("level"));
			user.setEmail(rs.getString("sex"));
			user.setPassword(rs.getString("password"));
			user.setSex(rs.getString("sex"));
			user.setUsername(rs.getString("username"));
		}catch(Exception e){
			e.printStackTrace();
		}
		return user;
	}
	
	//将指定taskId对应的Task删除
	public static void deleteTask(String taskId){
		Connection con=ConnectDB.getConnection();
		String sql="delete from task where id = "+taskId+";";
		try{
			Statement s=con.createStatement();
			s.executeUpdate(sql);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//将指定task插入到Task表中
	public static void insertTask(Task task){
		Connection con=ConnectDB.getConnection();
		String sql1="select max(id) from task;";
		String sql="insert into task values(?,?,?,?,?,?,?,?,?,?,?,?,?);";
		int max = 0;
		try{
			Statement s=con.createStatement();
			ResultSet rs=s.executeQuery(sql1);
			if(!rs.next()){
				max=0;
			}
			else{
				max=rs.getInt("max(id)");
			}
			rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		TaskMap.setState(max+1,1);//TODO:
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, max+1+"");
			ps.setString(2, task.getUsername());
			ps.setString(3, task.getThis()+"");
			ps.setString(4, task.getThat()+"");
			ps.setString(5, task.getTime());
			ps.setString(6, task.getPeriod()+"");
			ps.setString(7, task.getThisId());
			ps.setString(8, task.getThisPassw());
			ps.setString(9, task.getThisContent());
			ps.setString(10, task.getThatId());
			ps.setString(11, task.getThatPassw());
			ps.setString(12, task.getThatContent());
			ps.setString(13, task.getThatToAddrs());
			ps.executeUpdate();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
			ConnectDB.closeConnection(con);
		}
	}
	
	//将指定user插入User表中
	public static void insertUser(User user){
		Connection con=ConnectDB.getConnection();
		String sql="insert into ifttt_user values(?,?,?,?,?,?)";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getSex());
			ps.setString(4, user.getEmail());
			ps.setString(5, user.getLevel()+"");
			ps.setString(6, user.getAccount()+"");
			ps.executeUpdate();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
	}
	
	//判断当前用户名是否已存在
	public static boolean userIsExist(String username){
		Connection con=ConnectDB.getConnection();
		String sql="select * from ifttt_user where username = ?";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs=ps.executeQuery();
			
			if(rs.next()==false){
				return false;
			}
			rs.close();
			ps.close();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
		return true;
	}
	
	//通过登录时输入的用户名和密码获取user
	public static User login(String username,String password){
		User user=null;
		Connection con=ConnectDB.getConnection();
		String sql="select * from ifttt_user where username = ?and password = ?";
		try{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, password);
			
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				user=new User();
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setSex(rs.getString("sex"));
				user.setEmail(rs.getString("email"));
				user.setLevel(rs.getInt("level"));
				user.setAccount(rs.getInt("account"));
			}
			rs.close();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
		return user;
	}
	
	//将指定内容的公告插入message表中
	public static void sendNotice(String text){
		Connection con=ConnectDB.getConnection();
		try{
			PreparedStatement ps=con.prepareStatement("select * from ifttt_user;");
			String sql1="select max(id) from message;";
			int max = 0;
			try{
				Statement s=con.createStatement();
				ResultSet rs1=s.executeQuery(sql1);
				if(!rs1.next()){
					max=0;
				}
				else{
					max=rs1.getInt("max(id)");
				}
				rs1.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			ResultSet rs=ps.executeQuery();
		    String username;
		    String sql="insert into message values(?,?,?,true,false,'1970-1-1');";
			while(rs.next()){
				username=rs.getString("username");
				PreparedStatement ps2=con.prepareStatement(sql);
				ps2.setString(1, max+1+"");
				ps2.setString(2, username);
				ps2.setString(3, text);
				ps2.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//将向指定用户发送的私信插入message表中
	public static void sendPrivate(String username, String text){
		Connection con=ConnectDB.getConnection();
		try{
			String sql="select * from ifttt_user where username = ?;";
			PreparedStatement ps=con.prepareStatement(sql);
			String sql1="select max(id) from message;";
			int max = 0;
			try{
				Statement s=con.createStatement();
				ResultSet rs1=s.executeQuery(sql1);
				if(!rs1.next()){
					max=0;
				}
				else{
					max=rs1.getInt("max(id)");
				}
				rs1.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			ps.setString(1, "username");
			ps.executeQuery();
		    String sql2="insert into message values(?,?,?,false,false,'1970-1-1');";
		    PreparedStatement ps2=con.prepareStatement(sql2);
		    ps2.setString(1, max+1+"");
			ps2.setString(2, username);
			ps2.setString(3, text);
			ps2.executeUpdate();			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//从message表中获取用户名为username的消息
	public String getMessages(String username) throws Exception{
		Connection con=ConnectDB.getConnection();
		String result=null;
		try{
			PreparedStatement ps=con.prepareStatement("select * from message where recvname = ?;");
			ps.setString(1, username);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				result=rs.getString("noticetext");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	//向consumption表中插入一项消费
	public static void insertConsum(User user,int id,String cost,String alarm){
		Connection con=ConnectDB.getConnection();
		String sql="insert into consumption values(?,?,?,?,?)";
		String detail = "详情：";
		if(id == 0) {detail+="充值";}
		else{
			try{
				Task task = getTaskById(id);
				if(task.getThis()==Task.ALARM)
					detail+="if the time is "+task.getTime()+", ";
				else if(task.getThis()==Task.RECVM)
					detail+="if "+task.getThisId()+" receive any email, ";
				else if(task.getThis()==Task.RECVW)
					detail+="if "+task.getThisId()+" publish a post:"+task.getThisContent()+", ";
				else if(task.getThis()==Task.PERIOD)
					detail+="if "+task.getThisId()+" doesn't publish any post in "+task.getPeriod()+" milliseconds, ";
				if(task.getThat()==Task.SENDM)
					detail+="then send a mail to "+task.getThatToAddrs()+" with content: "+task.getThatContent()+".";
				else if(task.getThat()==Task.WEIBO)
					detail+="then publish a post to "+task.getThatId()+" with content: "+task.getThatContent()+".";
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, user.getUsername());
			ps.setString(2, ""+detail);
			ps.setString(3, cost);
			ps.setString(4, alarm);
			ps.setString(5, ""+user.getAccount());
			ps.executeUpdate();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
	}
	
	//获取指定用户的消费次数
	public static int numOfConsum(String username){
		int num = 0;
		Connection con=ConnectDB.getConnection();
		String sql="select * from consumption where username = ?;";
		try{
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, username);		
			ResultSet rs=ps.executeQuery();
			while(rs.next())
				num++;	
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
		return num;
	}
	
	//将指定ID对应的消息从message表中删除
	public static void deleteMessage(String id){
		Connection con=ConnectDB.getConnection();
		String sql="delete from message where id =?;";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
			con.close();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
	}
	
	//将指定id对应的消息的内容修改
	public static void changeMessage(String content,String id){
		Connection con=ConnectDB.getConnection();
		String sql="update message set noticetext=? where id=?;";
		try{
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1,content);
			ps.setString(2, id);
			ps.executeUpdate();
			con.close();
			ps.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(con);
		}
	}
}
