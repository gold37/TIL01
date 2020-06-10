package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {

	private DataSource ds; 
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
	public MemberDAO() {
		// 암호화/복호화 키 (양방향암호화) ==> 이메일,휴대폰의 암호화/복호화
		String key = EncryptMyKey.KEY;
		
		try {
		    Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
			aes = new AES256(key);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	public void close() {
		try {
			if(rs != null) { rs.close(); rs=null; }
			if(pstmt != null) { pstmt.close(); pstmt=null; } 
			if(conn != null) { conn.close(); conn=null; }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 회원가입(insert)
	@Override
	public int registerMember(MemberVO membervo) throws SQLException {

		int result = 0;

		try {
			 conn = ds.getConnection();
			 
			 String sql = " insert into mymvc_shopping_member(IDX, USERID, NAME, PWD, EMAIL, HP1, HP2, HP3, POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, GENDER, BIRTHDAY, COIN, POINT, REGISTERDAY, STATUS, CLIENTIP) "       
				        + " values(seq_shopping_member.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, default, default, default, ?) ";
			 
			 pstmt = conn.prepareStatement(sql);
				
			 pstmt.setString(1, membervo.getUserid());
			 pstmt.setString(2, membervo.getName());
			 pstmt.setString(3, Sha256.encrypt(membervo.getPwd()) ); // 암호를 SHA256 알고리즘으로 단방향암호화 시킨다. 
			 pstmt.setString(4, aes.encrypt(membervo.getEmail()) );  // 이메일을 AES256 알고리즘으로 양방향암호화 시킨다.
			 pstmt.setString(5, membervo.getHp1());    
			 pstmt.setString(6, aes.encrypt(membervo.getHp2()));    // 휴대폰번호를 AES256 알고리즘으로 양방향암호화 시킨다.
			 pstmt.setString(7, aes.encrypt(membervo.getHp3()));    // 휴대폰번호를 AES256 알고리즘으로 양방향암호화 시킨다.
			 pstmt.setString(8, membervo.getPostcode());
			 pstmt.setString(9, membervo.getAddress());
			 pstmt.setString(10, membervo.getDetailAddress());
			 pstmt.setString(11, membervo.getExtraAddress());
			 
			 String gender = "";
			 if("남".equals(membervo.getGender()))
				 gender = "1";
			 else
				 gender = "2";
			 
			 pstmt.setString(12, gender);
			 			 
			 pstmt.setString(13, membervo.getBirthyyyy()+membervo.getBirthmm()+membervo.getBirthdd());
			 pstmt.setString(14, membervo.getClientip());
			 
			 result = pstmt.executeUpdate();
			 
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

	// ID중복 검사 (userid가 중복이 없어서 사용가능하다라면 true, userid가 이미 존재하여 사용 불가능하면 false 를 리턴) 
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {

		boolean isUse = false;
		
		try {
			conn = ds.getConnection();
			String sql = " select userid "
					   + " from mymvc_shopping_member "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			isUse = !rs.next();
			
		} finally {
			close();
		}
		
		return isUse;
	}

	
}
