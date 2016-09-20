package servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import database.DBFunction;
import task.Task;

//新建任务
public class NewTaskServlet extends HttpServlet{
	private Task t=new Task();	//记录新建的任务
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		String This= request.getParameter("this");
		String That=request.getParameter("that");
		int i;
		if(This!=null){
			i=Integer.parseInt(This);
			t.setThis(i);
		}
		if(That!=null){
			i=Integer.parseInt(That);
			t.setThat(i);
		}
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("UTF-8");
		if(t.getThis()==Task.RECVW){
			String flag=request.getParameter("weiboflag");
			if(flag.equals("1")){
				t.setThis(6);
			}
		}
		if(t.getThis()==Task.ALARM){
			t.setTime(request.getParameter("time"));
		}
		else if(t.getThis()==Task.RECVM){
			t.setThisId(request.getParameter("mailusern"));
			t.setThisPassw(request.getParameter("mailpassw"));
		}
		else if(t.getThis()==Task.RECVW){
			t.setThisId(request.getParameter("weibousern"));
			t.setThisPassw(request.getParameter("weibopassw"));
			t.setThisContent(request.getParameter("weibocontent"));
		}
		else if(t.getThis()==Task.PERIOD){
			t.setThisId(request.getParameter("weibousern"));
			t.setThisPassw(request.getParameter("weibopassw"));
			t.setPeriod(Integer.parseInt(request.getParameter("weiboperiod")));
		}
		if(t.getThat()==Task.SENDM){
			t.setThatId(request.getParameter("sendmailusern"));
			t.setThatPassw(request.getParameter("sendmailpassw"));
			t.setThatContent(request.getParameter("sendmailcontent"));
			t.setThatToAddrs(request.getParameter("sendmailto"));
		}
		else if(t.getThat()==Task.WEIBO){
			t.setThatId(request.getParameter("sendweibousern"));
			t.setThatPassw(request.getParameter("sendweibopassw"));
			t.setThatContent(request.getParameter("sendweibocontent"));
		}
		t.setUsername(request.getParameter("username"));
		DBFunction.insertTask(t);
		
		request.getRequestDispatcher("/TaskManage.jsp").forward(request, response);
	}
}
