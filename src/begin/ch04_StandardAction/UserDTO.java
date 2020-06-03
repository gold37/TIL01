package begin.ch04_StandardAction;

import java.util.Calendar;

public class UserDTO {
	private String userid;
	private String passwd;
	private String name;
	private String email;
	private String tel;
	private String jubun1;
	private String jubun2;
	private String school;
	private String[] interest;
	
	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPasswd() {
		return passwd;
	}
	
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getTel() {
		return tel;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getJubun1() {
		return jubun1;
	}
	
	public void setJubun1(String jubun1) {
		this.jubun1 = jubun1;
	}
	
	public String getJubun2() {
		return jubun2;
	}
	
	public void setJubun2(String jubun2) {
		this.jubun2 = jubun2;
	}
	
	public String getSchool() {
		return school;
	}
	
	public void setSchool(String school) {
		this.school = school;
	}
	
	public String[] getInterest() {
		return interest;
	}
	
	public void setInterest(String[] interest) {
		this.interest = interest;
	}
	
	/////////////////////////////////////////////////////////////////
	
	public String getJubun() {
		
		return jubun1 + jubun2;
	}
	
	public String getGender() {
		
		String gender = "";
		
		String n = getJubun().substring(6, 7);
		
		if("1".equals(n) || "3".equals(n)) {
			gender = "남자";
		}
		else {
			gender = "여자";
		}
		
		return gender; 
	}
	
	public int getAge() {
		
		int age = 0;
		
		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다.
		
		int currentyear = currentDate.get(Calendar.YEAR);
		
		String n = getJubun().substring(6,7);
		String jubunYear = getJubun().substring(0,2);
		
		if("1".equals(n) || "2".equals(n)) {
			age = currentyear - Integer.parseInt("19"+jubunYear)+1 ;
		}
		else {
			age = currentyear - Integer.parseInt("20"+jubunYear)+1 ;
		}
		
		return age;
	}
	
	public String getInterestStr() {
		String interestStr = "";
		
		if(interest != null) {
			interestStr = String.join(",", interest);
		}
		
		return interestStr;
	}
}
