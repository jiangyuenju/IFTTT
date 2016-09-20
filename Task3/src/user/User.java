package user;

//用户类型
public class User {
	private String username;
	private String password;
	private String sex;
	private String email;
	private int level;		//等级
	private int account;	//余额

	public String getUsername(){
		return this.username;
	}
	
	public void setUsername(String username){
		this.username=username;
	}
	
	public String getPassword(){
		return this.password;
	}
	
	public void setPassword(String password){
		this.password=password;
	}
	
	public String getSex(){
		return this.sex;
	}
	
	public void setSex(String sex){
		this.sex=sex;
	}
	
	public String getEmail(){
		return this.email;
	}
	
	public void setEmail(String email){
		this.email=email;
	}
	
	public int getLevel(){
		return this.level;
	}
	
	public void setLevel(int level){
		this.level=level;
	}
	
	public int getAccount(){
		return this.account;
	}
	
	public void setAccount(int account){
		this.account=account;
	}
}
