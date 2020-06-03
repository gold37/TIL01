package begin.oracle.model;

public class MemberVO {
	// VO(Value Object) == DTO(Data Transfer Object)
	
	private String userid;
	private String passwd;
	private String name;
	private String email;
	private String gender;
	private String[] interest;
	private String introduce;
	
	private String registerday; 
	
	public MemberVO() {}
	
	public MemberVO(String userid, String passwd, String name, String email, String gender, String[] interest, String introduce) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.interest = interest;
		this.introduce = introduce;
	}

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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String[] getInterest() {
		return interest;
	}

	public void setInterest(String[] interest) {
		this.interest = interest;
	}
	
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	
	public String getRegisterday() {
		return registerday;
	}	
	
	public String getSexual() {
		if("M".equalsIgnoreCase(gender))
			return "남자";
		else 
			return "여자";
	}
	
	public String getAttention() {
		if(interest != null) { // 관심분야 null이 아니라면
			return String.join(",", interest); // 배열을 중간에 콤마찍어서 하나의 문자열로 만들어 넘겨주겠음
		}
		else { // null 이라면
			return "관심사 없음";
		}
	}
	
	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	
}