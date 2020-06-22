package myshop.model;

public class PurchaseReviewsVO {

	private int no; 
	private String fk_userid;
	private String name; 
	private int fk_pnum; 
	private String reviewsContents; 
	private String writeDate;
	
	public PurchaseReviewsVO() { }
	
	public PurchaseReviewsVO(int no, String fk_userid, String name, int fk_pnum, String reviewsContents, String writeDate) {
		this.no = no;
		this.fk_userid = fk_userid;
		this.name = name;
		this.fk_pnum = fk_pnum;
		this.reviewsContents = reviewsContents;
		this.writeDate = writeDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getFk_pnum() {
		return fk_pnum;
	}

	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}

	public String getReviewsContents() {
		return reviewsContents;
	}

	public void setReviewsContents(String reviewsContents) {
		this.reviewsContents = reviewsContents;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}	
	
}