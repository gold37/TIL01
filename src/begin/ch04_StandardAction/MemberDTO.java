package begin.ch04_StandardAction;

import java.util.Calendar;

public class MemberDTO {
	
	private String name;
	private String jubun;
	
	public MemberDTO(){} // JSP는 기본생성자가 필수! 그래야 Bean 쓸 수 있음
	
	public MemberDTO(String name, String jubun) {
		this.name = name;
		this.jubun = jubun;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getJubun() {
		return jubun;
	}


	public void setJubun(String jubun) {
		this.jubun = jubun;
	}
	
	/////////////////////////////////////////////////////////////////
	
	public String getGender() {
		
		String gender = "";
		
		String n = jubun.substring(6, 7);
		
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
		
		String n = jubun.substring(6,7);
		String jubunYear = jubun.substring(0,2);
		
		if("1".equals(n) || "2".equals(n)) {
			age = currentyear - Integer.parseInt("19"+jubunYear)+1 ;
		}
		else {
			age = currentyear - Integer.parseInt("20"+jubunYear)+1 ;
		}
		
		return age;
	}
	

}
