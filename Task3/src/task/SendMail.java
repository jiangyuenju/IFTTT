package task;

import java.util.Properties;
import java.util.TimerTask;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

//发送QQ邮件
public class SendMail extends TimerTask{
	private String id;
	private String password;
	private String toAddrs;
	private String content;
	
	public SendMail(Task task){
		super();
		id=task.getThatId();
		password=task.getThatPassw();
		toAddrs=task.getThatToAddrs();
		content=task.getThatContent();
	}
	
	public void run(){
		String to = toAddrs;
	    String from = id;
	    String host = "smtp.qq.com";  //QQ 邮件服务器
	    Properties properties = System.getProperties();
	    // 设置邮件服务器
	    properties.setProperty("mail.smtp.host", host);
	    properties.setProperty("mail.debug", "true");
	    properties.put("mail.smtp.auth", "true");
	    // 获取默认session对象
	    Session session = Session.getDefaultInstance(properties,new Authenticator(){
		    public PasswordAuthentication getPasswordAuthentication()
		    {
		     return new PasswordAuthentication(id, password); //发件人邮件用户名、密码
		    }
		   });

	    try{
	         // 创建默认的 MimeMessage 对象
	         MimeMessage message = new MimeMessage(session);
	         // Set From: 头部头字段
	         message.setFrom(new InternetAddress(from));
	         // Set To: 头部头字段
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));         
	         message.setSubject("IFTTT");   	 // Set Subject: 头部头字段
	         message.setText(content);   		// 设置消息体      
	         Transport.send(message);			// 发送消息
	         System.out.println("Sent message successfully");
	    }catch (MessagingException mex) {
	         mex.printStackTrace();
	    }
	}

}
