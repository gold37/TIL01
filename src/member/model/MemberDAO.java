package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import oracle.net.aso.a;
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

	
	// 아이디 찾기(성명, 핸드폰 번호를 입력받아서 해당 사용자의 아이디를 알려준다.)
	@Override
	public String findUserid(HashMap<String, String> paraMap) throws SQLException {
		String userid = null; 
		
		try {
			conn = ds.getConnection();
			
			String sql = " select userid " + 
						 " from mymvc_shopping_member " + 
						 " where status = 1 and " + 
						 "        name = ? and " + 
						 "        trim(hp1) || trim(hp2) || trim(hp3) = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("name"));
			
			String mobile = paraMap.get("mobile"); // 01023456789
			mobile = mobile.substring(0, 3)+ aes.encrypt(mobile.substring(3, 7)) + aes.encrypt(mobile.substring(7));
					// ▲ 3자리 따옴 				▲ 4자리 따와서 양방향 암호화			▲ 4자리 따와서 양방향 암호화
			
			pstmt.setString(2, mobile);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // select 된게 있다면
				userid = rs.getString("userid"); // userid를 읽어와 넣어주고 리턴함
			}
			
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userid;
	}

	
	// 비밀번호 찾기 (아이디, 이메일을 입력받아서 해당 사용자의 존재 유무를 알려준다.)
	@Override
	public boolean isUserExist(HashMap<String, String> paraMap) throws SQLException {
		boolean isUserExist = false;

		try {
			
			conn = ds.getConnection();
			String sql = " select userid " + 
					     " from mymvc_shopping_member " + 
					     " where status = 1 and " + 
					     " userid = ? and " + 
					     " email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, aes.encrypt(paraMap.get("email")));
			
			rs = pstmt.executeQuery();
			
			isUserExist =rs.next();
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isUserExist;

		
	}

	// 암호 변경하기
	@Override
	public int pwdUpdate(String pwd, String userid) throws SQLException {

		int result = 0;

		try {
			
			conn = ds.getConnection();
			
			String sql = " update mymvc_shopping_member set pwd = ? " + 
						 " where userid = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Sha256.encrypt(pwd)); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
			pstmt.setString(2, userid);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	
	}

	
	// 회원의 coin 변경하기
	@Override
	public int coinUpdate(HashMap<String, String> paraMap) throws SQLException {

		int result = 0;
		
		try {

			conn = ds.getConnection();
			
			String sql = " update mymvc_shopping_member set coin = coin+? , point = point+? "
					   + " where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("coin"));
			pstmt.setInt(2, (int)(Integer.parseInt(paraMap.get("coin"))*0.01)); // (int)3000.0 ==> 3000
			pstmt.setString(3, paraMap.get("idx"));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		
		}
		
		return result;
	}

	
	// 특정 회원 정보 수정하기
	@Override
	public int updateMember(MemberVO membervo) throws SQLException {

	      int result=0;
	      
	      try {
	         
	         conn = ds.getConnection();
	         String sql = " update mymvc_shopping_member set name=?, pwd=?, email=?, hp1=?, hp2=?, hp3=?, postcode=?, address=?, detailAddress=?, extraAddress=?, lastpwdchangedate=sysdate "
	                  	 +" where idx = ? ";               
	         
	         pstmt = conn.prepareStatement(sql);
	         
	           pstmt.setString(1, membervo.getName());
	           pstmt.setString(2, Sha256.encrypt(membervo.getPwd()) ); // 단방향 
	           pstmt.setString(3, aes.encrypt(membervo.getEmail()) );  // 양방향
	           pstmt.setString(4, membervo.getHp1());    
	           pstmt.setString(5, aes.encrypt(membervo.getHp2()));    
	           pstmt.setString(6, aes.encrypt(membervo.getHp3()));    
	           pstmt.setString(7, membervo.getPostcode());
	           pstmt.setString(8, membervo.getAddress());
	           pstmt.setString(9, membervo.getDetailAddress());
	           pstmt.setString(10, membervo.getExtraAddress());
	           pstmt.setInt(11, membervo.getIdx());
	              
	              
	         result = pstmt.executeUpdate();      
	         
	      } catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         close();
	      }
	                        
	      return result;   
	
		}

	
	// 관리자를 제외한 모든 회원 정보 조회하기
	@Override
	public List<MemberVO> selectAllMember() throws SQLException {

		List<MemberVO> memberList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select idx, userid, name, email, gender "+
						 " from mymvc_shopping_member "+
						 " where userid != 'admin' "+
					     " order by idx desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				
				mvo = new MemberVO();
				mvo.setIdx(rs.getInt("idx"));
				mvo.setUserid(rs.getString("userid"));
				mvo.setName(rs.getString("name"));
				mvo.setEmail(aes.decrypt(rs.getString("email"))); // 복호화
			    mvo.setGender(rs.getString("gender"));
			    
			    memberList.add(mvo);
			}
			
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return memberList;
	
	}
	
	// 페이징처리를 한 관리자를 제외한 모든 회원 정보 조회하기
	@Override
	public List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException {
		
		List<MemberVO> memberList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select RNO, idx, userid, name, email, gender "+
						 " from "+
						 " ("+
						 "    select rownum AS RNO, idx, userid, name, email, gender "+
						 "    from"+
						 "    ("+
						 "    select idx, userid, name, email, gender "+
						 "    from mymvc_shopping_member "+
						 " 	  where userid != 'admin' ";
						 
				String searchWord = paraMap.get("searchWord");
				String colname = ""; // 컬럼명
				
				if( searchWord != null && !searchWord.trim().isEmpty() ) {
					
					String searchType = paraMap.get("searchType");
					
					switch (searchType) {
						case "name": // 검색대상이 이름이라면
							colname = "name"; // 컬럼이름도 이름이 돼야한다.
							break;
							
						case "userid":
							colname = "userid";
							break;
							
						case "email":
							colname = "email";
							break;
	
						default:
							break;
					}
					
					sql += " and "+colname+" like '%' || ? || '%' ";
				
				} // end of if ----------------------------------
			
					sql += "    order by idx desc "+
						   "    ) V "+
						   " ) T "+
						   " where T.RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);

			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) { // 검색어가 있는 경우
				
				if("email".equals(colname))
					pstmt.setString(1, aes.encrypt(searchWord));
				else
					pstmt.setString(1, searchWord);
				
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));// 공식
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));// 공식
				
			}
			else {
				
	            pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage -1 ) );// 공식
	            pstmt.setInt(2, (currentShowPageNo * sizePerPage) );// 공식
	            
	         }

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				
				mvo = new MemberVO();
				mvo.setIdx(rs.getInt("idx"));
				mvo.setUserid(rs.getString("userid"));
				mvo.setName(rs.getString("name"));
				mvo.setEmail(aes.decrypt(rs.getString("email"))); // 복호화
			    mvo.setGender(rs.getString("gender"));
			    
			    memberList.add(mvo);
			}
			
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		  System.out.println(memberList);
          
	      return memberList;

	}

	// 페이징처리를 위한 전체회원에 대한 총페이지갯수 알아오기(select)
	@Override
	public int getTotalPage(HashMap<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil (count(*)/?) AS totalPage " + 
						 " from mymvc_shopping_member" +
					  	 " where userid != 'admin' ";
			
			 
			String searchWord = paraMap.get("searchWord");
			String colname = ""; // 컬럼명
			
			if( searchWord != null && !searchWord.trim().isEmpty() ) {
				
				String searchType = paraMap.get("searchType");
				
				switch (searchType) {
					case "name": // 검색대상이 이름이라면
						colname = "name"; // 컬럼이름도 이름이 돼야한다.
						break;
						
					case "userid":
						colname = "userid";
						break;
						
					case "email":
						colname = "email";
						break;

					default:
						break;
				}
				
				sql += " and "+colname+" like '%' || ? || '%' ";
			
			} // end of if ----------------------------------
			
			
			 pstmt = conn.prepareStatement(sql);
	         
	         if( searchWord != null && !searchWord.trim().isEmpty() ) {
	            // 검색어가 있는 경우
	            pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")) );
	            
	            if("email".equals(colname)) // 컬럼이름이 이메일이면 암호화
	            	pstmt.setString(2, aes.encrypt(searchWord));
	            else // 아니면 그냥 
	            	pstmt.setString(2,  searchWord);
	         }
	         else {
	            // 검색어가 없는 경우
	            pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")) );
	         }    
	         
	         rs = pstmt.executeQuery();
	         
	         rs.next();
	         
	         totalPage = rs.getInt("totalPage");
	         
	      } catch( UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
	      } finally {
	         close();
	      }

		return totalPage;
	}

	
	// idx 값을 입력받아 회원 1명에 대한 상세 정보 알아오기(select)
	@Override
	public MemberVO memberOneDetail(String idx) throws SQLException {
		
		MemberVO mvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select idx, userid, name, email, hp1, hp2, hp3, postcode, address, detailaddress, extraAddress, gender "+
						 "     , substr(birthday,1,4) AS birthyyyy, substr(birthday,5,2) AS birthmm, substr(birthday, 7) AS birthdd "+
						 "     , coin, point, to_char(registerday,'yyyy-mm-dd') AS registerday "+
						 "     , trunc( months_between(sysdate, lastPwdChangeDate) ) AS pwdchangegap "+
						 "     , trunc( months_between(sysdate, lastLoginDate) ) AS lastlogindategap "+
						 " from mymvc_shopping_member \n"+
						 " where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, idx);
			
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
			  
			}
			
		} catch( UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return mvo;

	
	}
	
}
