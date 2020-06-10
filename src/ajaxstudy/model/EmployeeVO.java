package ajaxstudy.model;

import java.util.Calendar;

public class EmployeeVO {

	private String ename;
	private String jik;
	private String tel;
	private String email;
	private String birthday;
	private int age;  // Gson 에서 사용되는 키값으로 사용하기 위해서 넣어두는 것임.
	
	public String getEname() {
		return ename;
	}
	
	public void setEname(String ename) {
		this.ename = ename;
	}
	
	public String getJik() {
		return jik;
	}
	
	public void setJik(String jik) {
		this.jik = jik;
	}
	
	public String getTel() {
		return tel;
	}
	
	// *** Gson 에서 사용되는 키값 tel 에 해당하는 value 값을 만듦. *** //
	public void setTel(String tel) {
		this.tel = tel.substring(0, 3)+"-"+tel.substring(3, 7)+"-"+tel.substring(7);
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getBirthday() {
		return birthday;
	} 

	public void setBirthday(String birthday) { // setAge()도 여기서 함
		
		this.birthday = birthday.substring(0, 4)+"."+birthday.substring(4, 6)+"."+birthday.substring(6);
		
		// *** Gson 에서 사용되는 키값 age 에 해당하는 value 값을 만듦. *** //
		Calendar currentDate = Calendar.getInstance(); // 현재날짜와 시간을 얻어온다.
		int currentYear = currentDate.get(Calendar.YEAR);
		String birthYear = birthday.substring(0, 4);
		this.age = currentYear - Integer.parseInt(birthYear) + 1;
	}
	
	
	public int getAge() {  
		return age;
	}
	
}
