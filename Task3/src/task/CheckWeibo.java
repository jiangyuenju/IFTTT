package task;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.TimerTask;

import weibo4j.Oauth;
import weibo4j.Timeline;
import weibo4j.http.AccessToken;
import weibo4j.model.Status;
import weibo4j.model.StatusWapper;
import weibo4j.model.WeiboException;
import weibo4j.util.BareBonesBrowserLaunch;

//监听是否发送指定内容的微博
public class CheckWeibo extends TimerTask{
	String token = null;
//	public static String code=null;
	Date startTime;
	Task t;
	boolean wait=false;
	
	public CheckWeibo(Date date, Task t){
		startTime=date;
		this.t=t;
	}
//	public static void setToken(String code) throws WeiboException{
//		Oauth oauth = new Oauth();
//		System.out.println(code);
//		token=(oauth.getAccessTokenByCode(code));
//	}
//	public static void setCode(String mycode){
//		code=mycode;		
//	}
//	
	public void setToken(String token){
		this.token=token;
	}
	
	public void run(){
		if(token==null){
			if(wait==false){
				wait=true;
				try{
					Oauth oauth = new Oauth();
					BareBonesBrowserLaunch.openURL(oauth.authorize("code"));
				}catch(WeiboException e){
					e.printStackTrace();
				}
			}
			return;
		}
		
		
		Timeline tm = new Timeline(token);
		try {
			StatusWapper status = tm.getUserTimeline();
			List<Status> statuses=status.getStatuses();
			for(Status s : statuses){
				if(s.getCreatedAt().after(startTime)){
					if(s.getText().equals(t.getThisContent())){
						if(t.getThat()==Task.WEIBO){
							startTime=s.getCreatedAt();
							SendWeibo sw=new SendWeibo(t,token);
							sw.run();
						}
						else if(t.getThat()==Task.SENDM){
							startTime=s.getCreatedAt();
							SendMail sm=new SendMail(t);
							sm.run();
						}
					}
				}
			}
		} catch (WeiboException e) {
			e.printStackTrace();
		}
	}
}
