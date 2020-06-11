package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

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

	
	// 아이디와 암호를 입력받아서 그 회원에 대한 정보를 리턴(로그인 처리)
	@Override
	public MemberVO selectOneMember(HashMap<String, String> paraMap) throws SQLException {
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select idx, userid, name, email, hp1, hp2, hp3, postcode, address, detailaddress, extraAddress, gender "+
						 "     , substr(birthday,1,4) AS birthyyyy, substr(birthday,5,2) AS birthmm, substr(birthday, 7) AS birthdd "+
						 "     , coin, point, to_char(registerday,'yyyy-mm-dd') AS registerday "+
						 "     , trunc( months_between(sysdate, lastPwdChangeDate) ) AS pwdchangegap "+
						 "     , trunc( months_between(sysdate, lastLoginDate) ) AS lastlogindategap "+
						 " from mymvc_shopping_member \n"+
						 " where userid = ? and pwd = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt( paraMap.get("pwd") ));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {

				mvo = new MemberVO();
				mvo.setIdx(rs.getInt("idx"));
				mvo.setUserid(rs.getString("userid"));
				mvo.setName(rs.getString("name"));
				mvo.setEmail(aes.decrypt(rs.getString("email"))); // 복호화
				mvo.setHp1(rs.getString("hp1"));
				mvo.setHp2(aes.decrypt(rs.getString("hp2"))); // 복호화
				mvo.setHp3(aes.decrypt(rs.getString("hp3"))); // 복호화
				mvo.setPostcode(rs.getString("postcode"));
			    mvo.setAddress(rs.getString("address"));
			    mvo.setDetailAddress(rs.getString("detailaddress"));
			    mvo.setExtraAddress(rs.getString("extraaddress"));
			    mvo.setGender(rs.getString("gender"));
			    mvo.setBirthyyyy(rs.getString("birthyyyy"));
			    mvo.setBirthmm(rs.getString("birthmm"));
			    mvo.setBirthdd(rs.getString("birthdd"));
			    mvo.setCoin(rs.getInt("coin"));   // int
			    mvo.setPoint(rs.getInt("point")); // int
			    mvo.setRegisterday(rs.getString("registerday"));
			    
			    // 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지났으면 true, 아니면 false로 표식한다.
			    if( rs.getInt("pwdchangegap") >= 3 ) {
			    	mvo.setRequirePwdChange(true);
			    	
			    // 마지막 로그인 날짜가 현재일로부터 1년(=12개월)이 지났으면 휴면처리
			    if( rs.getInt("lastlogindategap") >= 12 ) {
			    	mvo.setIdleStatus(true); // 계정 휴면처리
			    }
			    else {
				    // 마지막 로그인 시간 변경 기록하기
				    sql = " update mymvc_shopping_member set lastlogindate = sysdate "
				    	+ " where userid = ? ";
				    
				    pstmt = conn.prepareStatement(sql);
				    pstmt.setString(1, paraMap.get("userid"));
				    pstmt.executeUpdate();
			    }
			  }
			}
			
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return mvo;
	}

	// 휴면상태인 사용자 계정을 휴면이 아닌 상태로 바꾸기
	// 즉, lastlogindate 컬럼의 값을 sysdate로 update해준다.
	@Override
	public void expireIdle(int idx) throws SQLException {

		try {
			conn = ds.getConnection();
			
			String sql = " update mymvc_shopping_member set lastlogindate = sysdate "
					   + " where idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
	}
	
	
}
