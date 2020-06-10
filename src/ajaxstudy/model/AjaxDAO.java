package ajaxstudy.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;

import javax.sql.DataSource;


public class AjaxDAO implements InterAjaxDAO {
		// DAO는 DBCP
	
	
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
	
	
	public AjaxDAO() {
		
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
	
	
	// 광고 이미지 전체 목록 조회하는 메소드 생성하기 //
	@Override
	public List<HashMap<String, String>> imgList() throws SQLException {
		 
		List<HashMap<String, String>> imgList = new ArrayList<HashMap<String,String>>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgno, imgfilename " + 
						 " from mymvc_main_image " + 
						 " order by imgno asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				HashMap<String, String> map = new HashMap<String, String>();
				
			//	map.put("IMGNO", rs.getInt("IMGNO")); // map에 넣자
				// map은 key, value 다 string인데 ↑ int 타입이라서 데이터 타입이 안맞아서 빨간줄이 뜸.
				
				map.put("IMGNO", rs.getString("IMGNO")); // map에 넣자
				map.put("IMGFILENAME", rs.getString("IMGFILENAME")); // map에 넣자
				
				
				imgList.add(map); // 차곡차곡 쌓아 넣음
				
			} // end of while -------------
			
		} finally {

			close(); // 자원 반납
		}
		
		
		return imgList;
	}

	
	
	// 뉴스제목 목록 조회하는 메소드 생성하기 //
	@Override
	public List<NewsTitleVO> newsTitleList() throws SQLException {
		
	List<NewsTitleVO> newsTitleList = new ArrayList<NewsTitleVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seqtitleno "+
						 "     , case when length(title) > 22 then substr(title, 1, 20)||'..' "+
						 "       else title end AS title "+
						 "     , to_char(registerday, 'yyyy-mm-dd hh24:mi:ss') AS registerday "+
						 " from test_ajaxnews "+
						 " order by seqtitleno desc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				NewsTitleVO vo = new NewsTitleVO();
				vo.setSeqtitleno(rs.getInt(1)); // 위치값은 제일 처음이 1
				vo.setTitle(rs.getString(2));
				vo.setRegisterday(rs.getString(3));
				
				newsTitleList.add(vo);
				
			} // end of while -------------
			
		} finally {

			close(); // 자원 반납
		}
		
		
		return newsTitleList;
	}

	
	// 특정 뉴스내용을 조회하는 메소드 생성하기 //
	@Override
	public String newsContents(String seqno) throws SQLException {
	
		String newsContents = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = " select newscontents " + 
						 " from test_ajaxnews_contents " + 
						 " where fk_seqtitleno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, seqno);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) { // 항상 한 개밖에 안나오기 때문에 while 아니고 if
				
				newsContents = rs.getString(1);
				
			} // end of while -------------
			
		} finally {
		
			close(); // 자원 반납
		}

		return newsContents;
	}
	

	// 뉴스제목, 뉴스내용 쓰기 메소드 생성하기 // 
	@Override
	public void newsWrite(HashMap<String, String> map) throws SQLException {
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seq_test_ajaxnews_seqtitleno.nextval " + 
						 " from dual "; // 시퀀스 값 채번해오기 
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			int seqtitleno = rs.getInt(1);
			
			//////////////////////////////////////////////////////////////////////////////////
			
			
			
		    sql = " insert into test_ajaxnews(seqtitleno, title) " +
			   	  " values(?, ?) ";
			 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seqtitleno);
			pstmt.setString(2, map.get("title"));
			
			pstmt.executeUpdate();
			
			//////////////////////////////////////////////////////////////////////////////////
			
			
			sql = " insert into test_ajaxnews_contents(fk_seqtitleno, newscontents) "
			    + " values(?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seqtitleno);
			pstmt.setString(2, map.get(""));
			
			pstmt.executeUpdate();
			
			
		} finally {
		
			close(); // 자원 반납
		}
		
	}

	
	// 직원 추가하기 메소드 생성하기 // 
	@Override
	public void registerEmp(EmployeeVO empvo) throws SQLException {

		try {
			conn = ds.getConnection();
			
			String sql = " insert into test_ajaxemp(ename, jik, tel, email, birthday) "
					   + " values(?,?,?,?,?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, empvo.getEname());
			pstmt.setString(2, empvo.getJik());
			pstmt.setString(3, empvo.getTel());
			pstmt.setString(4, empvo.getEmail());
			pstmt.setString(5, empvo.getBirthday());
			
			pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
	}
	
	
	// 모든 직원 정보를 조회하는 메소드 생성하기 // 
	@Override
	public List<EmployeeVO> empList() throws SQLException {
		
		List<EmployeeVO> empList = new ArrayList<EmployeeVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ename, jik, tel, email " + 
						 " from test_ajaxemp " + 
						 " order by ename ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				EmployeeVO empvo = new EmployeeVO();
				empvo.setEname(rs.getString(1));
				empvo.setJik(rs.getString(2));
				empvo.setTel(rs.getString(3));	// "01012345678" 이 "010-1234-5678"으로 set됨
				empvo.setEmail(rs.getString(4));
				
				empList.add(empvo);
				
			} // end of while -------------
			
		} finally {
			close(); // 자원 반납
		}
		
		return empList;
	
	}

	
	// 특정 직원 정보 조회하는 메소드 생성하기 //
	@Override
	public EmployeeVO empDetail(String email) throws SQLException {

		EmployeeVO empvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ename, jik, tel, email, birthday " + 
						 " from test_ajaxemp " + 
						 " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				empvo = new EmployeeVO();
				empvo.setEname(rs.getString(1));
				empvo.setJik(rs.getString(2));
				empvo.setTel(rs.getString(3));	// "01012345678" 이 "010-1234-5678"으로 set됨
				empvo.setEmail(rs.getString(4));	
				empvo.setBirthday(rs.getString(5));	// "19910501" 이 "1991.05.01"으로 set되고,
													// empvo의 나이(age)도 동시에 set 됨 
				
			} // end of while -------------
			
		} finally {
			close(); // 자원 반납
		}
		
		return empvo;
	
	}


	// email 중복 검사하는 메소드 생성하기 //
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		boolean isUse;
		
		try {

			conn = ds.getConnection();
			
			String sql = " select email " + 
						 " from test_ajaxemp " + 
						 " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			isUse = !rs.next(); // false면 true 줌
					
		} finally {
			
			rs.close();
		}
		
		return isUse;
	}
	
	
	
}
