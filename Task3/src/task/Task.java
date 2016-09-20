package task;

public class Task {//任务
	public final static int ALARM=1;//定时
	public final static int RECVM=2;//收到邮件
	public final static int SENDM=3;//发送邮件
	public final static int WEIBO=4;//发微博
	public final static int RECVW=5;//监听新浪微博
	public final static int PERIOD=6;//在一段时间未发微博
	
	//private String name;
	private String username;
	private int This;
	private int That;
	//private String detail;
	private int state=1;//1表示未开始，2表示正在运行，3表示暂停中
	private String time;//定时时钟
	private int period;//时间段的秒数
	private String thisId;//收到邮件的指定邮箱地址或微博账号
	private String thisPassw;//收到邮件的邮箱密码或微博密码
	private String thisContent;
	private String thatId;
	private String thatPassw;
	private String thatContent;
	private String thatToAddrs;//发送邮件的收件人地址
	
	public int getPeriod(){
		return period;
	}
	
	public void setPeriod(int period){
		this.period=period;
	}
	
	public String getUsername(){
		return username;
	}
	
	public void setUsername(String username){
		this.username=username;
	}
	
	public int getThis(){
		return This;
	}
	
	public void setThis(int This){
		this.This=This;
	}
	
	public int getThat(){
		return That;
	}
	
	public void setThat(int That){
		this.That=That;
	}
	
	public String getTime(){
		return time;
	}
	
	public void setTime(String time){
		this.time=time;
	}
	
	public String getThatId(){
		return thatId;
	}
	
	public void setThatId(String thatId){
		this.thatId=thatId;
	}
	
	public String getThatPassw(){
		return thatPassw;
	}
	
	public void setThatPassw(String password){
		this.thatPassw=password;
	}
	
	public String getThatContent(){
		return thatContent;
	}
	
	public void setThatContent(String content){
		this.thatContent=content;
	}
	
	public String getThisId(){
		return this.thisId;
	}
	
	public void setThisId(String thisId){
		this.thisId=thisId;
	}
	
	public String getThisPassw(){
		return thisPassw;
	}
	
	public void setThisPassw(String thisPassw){
		this.thisPassw=thisPassw;
	}
	
	public String getThisContent(){
		return thisContent;
	}
	
	public void setThisContent(String thisContent){
		this.thisContent=thisContent;
	}
	
	public String getThatToAddrs(){
		return this.thatToAddrs;
	}
	
	public void setThatToAddrs(String thatToAddrs){
		this.thatToAddrs=thatToAddrs;
	}
	
	public int getState(){
		return state;
	}
	
	public void setState(int state){
		this.state=state;
	}
}