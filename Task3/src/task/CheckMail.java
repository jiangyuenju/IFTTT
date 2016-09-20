package task;
import java.util.Properties;
import java.util.TimerTask;
import javax.mail.Folder;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;

//检查邮箱是否收到新邮件
public class CheckMail extends TimerTask {
	String userID;
	String Password;
	Task task;
	public static int messageNum = 0;//存储上一次检查的邮件总数
	
	public CheckMail(Task task){
		userID=task.getThisId();
		Password=task.getThisPassw();
		this.task=task;
	}
	
	public static void setMessageNum(int count){
		messageNum=count;
	}
	
	public void run(){
		try{
			String user = userID;// 邮箱的用户名  
	        String password = Password; // 邮箱的密码    
	        Properties props = System.getProperties();
		    // Setup mail server
		    props.put("mail.pop3.host", "pop.qq.com"); 
		    props.put("mail.pop3.port", "995"); 
		    // Get session
		    props.put("mail.smtp.auth", "true"); //这样才能通过验证
		    props.put("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		    props.put("mail.pop3.socketFactory.fallback", "false");
		    props.setProperty("mail.pop3.socketFactory.port", "995"); 

		    MyAuthenticator myauth = new MyAuthenticator(user, password);
		    Session session = Session.getDefaultInstance(props, myauth);
		    Store store = session.getStore("pop3"); 
		    store.connect(user,password);
		    Folder folder = store.getFolder("INBOX"); 
	 
		    folder.open(Folder.READ_ONLY);
		    int total=folder.getMessageCount();
		    if(messageNum!=0){
		    if(total>messageNum){
		    	if(task.getThat()==Task.SENDM){
		    		SendMail sm =new SendMail(task);
		    		sm.run();
		    	}
		    	else if(task.getThat()==Task.WEIBO){
		    		SendWeibo sw=new SendWeibo(task);
		    		sw.run();
		    	}
		    }
		    }
		    setMessageNum(total);
	        
	        if (folder != null)  
	            folder.close(true);   
	        if (store != null)  
	            store.close();  
			}
			catch(Exception e){
				e.printStackTrace();
			}
	}
}

class MyAuthenticator extends javax.mail.Authenticator {
	private String strUser;
	private String strPwd;
	public MyAuthenticator(String user, String password) {
			this.strUser = user;
			this.strPwd = password;
	}
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(strUser, strPwd);
	}
}
