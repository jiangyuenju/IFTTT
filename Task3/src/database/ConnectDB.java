package database;

import java.sql.Connection;
import java.sql.DriverManager;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//与数据库获取链接
public class ConnectDB {
	public static Statement getStatement(){
		Statement stmt=null;
		try{
		stmt=getConnection().createStatement();
		}catch(Exception e){
			e.printStackTrace();
		}
		return stmt;
	}
	
	//与数据库进行连接
	public static Connection getConnection(){
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/Task3";
			con=DriverManager.getConnection(url,"root","123456");
		}catch(Exception e){
			e.printStackTrace();
		}
		return con;
	}
	
	//断开与数据库的连接
	public static void closeConnection(Connection con){
		if(con!=null){
			try{
				con.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	}
	
	//执行sql语句
	public static ResultSet executeQuery(String sql){  
        ResultSet rs=null;  
        try {  
            rs=getStatement().executeQuery(sql);  
        } catch (SQLException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
            System.out.println("数据库查询失败!!!"+e.getMessage());  
        }  
        return rs;  
    }  
	
	public static int executeUpdate(String sql){  
        int i=0;  
        try {  
            i=getStatement().executeUpdate(sql);  
        } catch (SQLException e) {  
            // TODO Auto-generated catch block  
            e.printStackTrace();  
            System.out.println("执行更新错误!!!"+e.getMessage());  
        }  
        return i;  
    }  
}


