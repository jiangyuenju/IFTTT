package task;

import java.util.Date;
import java.util.List;
import java.util.TimerTask;
import weibo4j.Oauth;
import weibo4j.Timeline;
import weibo4j.model.Status;
import weibo4j.model.StatusWapper;
import weibo4j.model.WeiboException;
import weibo4j.util.BareBonesBrowserLaunch;

//监听指定长时间内，是否发送新微博
public class MonitorWeibo extends TimerTask{
	String token = null;
	Task t;
	Date startTime;
	
	
	public MonitorWeibo(Date date, Task t){
		this.t=t;
		startTime=date;
		try{
			Oauth oauth = new Oauth();
			BareBonesBrowserLaunch.openURL(oauth.authorize("code"));
		}catch(WeiboException e){ 
			e.printStackTrace();
		}
	}

	public void setToken(String token){
		this.token=token;
	}
	
	public void run(){
		boolean sendWeibo=false;
		try {
			Timeline tm = new Timeline(token);
			StatusWapper status = tm.getUserTimeline();
			List<Status> statuses=status.getStatuses();
			for(Status s : statuses){
				if(s.getCreatedAt().after(startTime)){
					sendWeibo=true;
				}
			}
			if(sendWeibo==false){
				SendMail sm=new SendMail(t);
				sm.run();
			}
			
		} catch (WeiboException e) {
			e.printStackTrace();
		}
	}
}
