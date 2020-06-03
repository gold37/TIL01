package begin.oracle.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class MemberDAO {

	private DataSource ds;	// 아파치 톰캣이 제공하는 DBCP
	// DBCP : 손님 많은 맛집에 서빙을 많이 두는거
	private Connection conn; // 오라클 데이터베이스 서버와 연결을 맺어주는 객체
	private PreparedStatement pstmt;
	/*
	    개발자가 SQL문(편지)을 작성했는데,
	    작성한 SQL문을 어느 오라클 서버에서 실행을 해야할지 결정해야 한다.
	    이때 어느 오라클 서버인지는  Connection conn 에서 알고,
	  Connection conn 에 전송할 SQL문(편지)은 PreparedStatement pstmt(우편배달부)를 통해 전송된다.    	
	*/	
	private ResultSet rs;
	
	
	public MemberDAO() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	
	}
	
	private void close() {
		try {
			if(rs != null) {rs.close(); rs=null;} 
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null) {conn.close(); conn=null;}
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// === 회원가입(insert) 메소드 생성하기 ===
	public int memberRegister(MemberVO mvo) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection(); // 풀장에 튜브 깔아놓음
			
			String sql = " insert into mymvc_member(userid, passwd, name, email, gender, interest, introduce) "
					   + " values(?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mvo.getUserid());
			pstmt.setString(2, mvo.getPasswd());
			pstmt.setString(3, mvo.getName());
			pstmt.setString(4, mvo.getEmail());
			pstmt.setString(5, mvo.getGender());
			
			String interest = null;
			if(mvo.getInterest() != null) {
				interest = String.join(",", mvo.getInterest()); 
				// mvo.getInterest()가 null을 허용하게 설정했지만 실제로 null일때 Exception 떨어짐
				// 그래서 if문 써줌
			}
			pstmt.setString(6, interest);
			pstmt.setString(7, mvo.getIntroduce());

			result = pstmt.executeUpdate(); // DML문 이므로
			
			System.out.println(result);
			
		} finally {
			close(); // 자원반납
		}
		
		return result;
		
	} // end of memberRegister(MemberVO mvo) throws SQLException------------
 
	
	// === 특정 회원정보 조회 메소드 생성하기 ===
	public MemberVO memberOneInfoView(String userid) throws SQLException {
		
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, gender, interest, " + 
						 " to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday, introduce " + 
						 " from mymvc_member " + 
						 " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mvo = new MemberVO();
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setEmail(rs.getString(3));
				mvo.setGender(rs.getString(4));
				
				String[] interest = null;
				String str = rs.getString(5);
				if(str != null) {
					interest = str.split(",");
				}
				
				mvo.setInterest(interest);
				
				mvo.setRegisterday(rs.getString(6));
				
				mvo.setIntroduce(rs.getString(7));
			}
			
		} finally {
			
			close();
		}
		
		return mvo;
	} // end of memberOneInfoView() throws SQLException

	
	
	// === 모든 회원 정보를 조회하는 메소드 생성하기 === 
	public List<MemberVO> selectAllMember() throws SQLException {
		
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid, name, email, gender, interest, " + 
						 " to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday " + 
						 " from mymvc_member " + 
						 " order by registerday desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) { // 복수개이므로 여러번 돌려야하니까 if가 아니고 while문
				MemberVO mvo = new MemberVO();
				mvo.setUserid(rs.getString(1));
				mvo.setName(rs.getString(2));
				mvo.setEmail(rs.getString(3));
				mvo.setGender(rs.getString(4));
				
				String[] interest = null;
				String str = rs.getString(5);
				if(str != null) {
					interest = str.split(",");
				}
				
				mvo.setInterest(interest);
				
				mvo.setRegisterday(rs.getString(6));
				
				memberList.add(mvo); // 리스트를 담자! .add
			}
			
		} finally {
			
			close();
		}
		
		return memberList;
	} // end of public MemberVO memberOneInfoView() throws SQLException ----------

	
	// === 회원을 삭제하는 메소드 생성하기 === 
	public int memberDelete(String userid) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection(); // 풀장에 튜브 깔아놓음
			
			String sql = " delete from mymvc_member "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			result = pstmt.executeUpdate(); // DML문 이므로
			
			
		} finally {
			close(); // 자원반납
		}
		
		return result;
		
	} // end of public int memberDelete(String[] useridArr) throws SQLException -----------

	
	
	// === 회원의 정보를 수정하는 메소드 생성하기 === 
	public int memberUpdate(MemberVO mvo) throws SQLException {
		
		int result = 0;

		try {
			
			conn = ds.getConnection(); // 풀장에 튜브 깔아놓음
			
			String sql = " update mymvc_member set name = ? "
					   + "							,	passwd = ? "
					   + "							,	email = ? "
					   + "							, 	interest = ? "
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mvo.getName());
			pstmt.setString(2, mvo.getPasswd());
			pstmt.setString(3, mvo.getEmail());
			pstmt.setString(4, mvo.getAttention());
			pstmt.setString(5, mvo.getUserid());
			
			result = pstmt.executeUpdate(); // DML문 이므로
			
			
		} finally {
		
			close(); // 자원반납
		}
		
		return result;
		
	} // end of public int memberUpdate(MemberVO mvo) throws SQLException ------------
	
	
	
}
