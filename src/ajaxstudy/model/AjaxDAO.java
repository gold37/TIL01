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

}
