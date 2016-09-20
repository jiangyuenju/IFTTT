package task;

import java.util.TimerTask;

import weibo4j.Oauth;
import weibo4j.Timeline;
import weibo4j.http.AccessToken;
import weibo4j.model.WeiboException;
import weibo4j.util.BareBonesBrowserLaunch;

//发送QQ微博
public class SendWeibo extends TimerTask{
	static String content;
	String id;
	String password;
	String token;
	
	public SendWeibo(Task task){
		content = task.getThatContent();
		id = task.getThatId();
		password = task.getThatPassw();
		Oauth oauth = new Oauth();
		try {
			BareBonesBrowserLaunch.openURL(oauth.authorize("code"));
		} catch (WeiboException e) {
			e.printStackTrace();
		}
	}
	
	public SendWeibo(Task task,String tok){
		token = tok;
		content = task.getThatContent();
		id = task.getThatId();
		password = task.getThatPassw();
		Oauth oauth = new Oauth();
		try {
			BareBonesBrowserLaunch.openURL(oauth.authorize("code"));
		} catch (WeiboException e) {
			e.printStackTrace();
		}
	}
//	
//	public static void setToken(String code) throws WeiboException{
//		Oauth oauth = new Oauth();
//		token=(oauth.getAccessTokenByCode(code));
//		Timeline tm = new Timeline(token.getAccessToken());
//		try {
//			tm.updateStatus(content);
//			System.out.println("发送成功");
//		}catch (WeiboException e) {
//			System.out.println("发送失败");
//			e.printStackTrace();
//		}	
//	}
	public void setToken(String token){
		this.token=token;
	}
	
	public void run(){
			Timeline tm = new Timeline(token);
			try {
				tm.updateStatus(content);
				System.out.println("发送成功");
			}catch (WeiboException e) {
				System.out.println("发送失败");
				e.printStackTrace();
			}	
		//}
	}
}
