package task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;

import database.ConnectDB;

public class TaskMap {
	private static HashMap<Integer,Timer> taskMap=new HashMap<Integer,Timer>();	
	private static HashMap<Integer,TimerTask> timertaskMap=new HashMap<Integer,TimerTask>();
	private static HashMap<Integer,Integer> stateMap=new HashMap<Integer,Integer>();//TODO
	private static boolean flag=true;;
	
	public static void addTask(int taskId, Timer timer){
		taskMap.put(taskId, timer);
		stateMap.put(taskId, 2);//TODO
	}
	
	public static void setTimerTask(int id, TimerTask tt){
		timertaskMap.put(id, tt);
	}
	
	public static void setState(int id, int state){
		stateMap.put(id, state);
	}
	
	public static int getState(int taskId){
		return stateMap.get(taskId);
	}
	
	public static Timer getTimer(int taskId){
		return taskMap.get(taskId);
	}
	
	public static TimerTask getTimerTask(int taskId){
		return timertaskMap.get(taskId);
	}
	
	public static void prepareStateMap(){
		if(flag){
		Connection con=ConnectDB.getConnection();
		String sql="select * from task";
		Statement s=null;
		int id;
		try {
			s = con.createStatement();
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				id=rs.getInt("id");
				setState(id,1);
			}
			s.close();
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			ConnectDB.closeConnection(con);
			flag=false;
		}
		}
	}
}
