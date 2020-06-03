package index.bootstrap.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ImageDAO implements InterImageDAO {

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


	// 생성자
	public ImageDAO() {
		
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	
	}
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	private void close() {
		try {
			if(rs != null) {rs.close(); rs=null;} 
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null) {conn.close(); conn=null;}
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}


	// 모든 상품 이미지 조회 (select)
	@Override
	public List<ImageVO> selectAll() throws SQLException {
		
		List<ImageVO> imgList = new ArrayList<ImageVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select imgno, imgfilename " + 
						 " from mymvc_main_image " + 
						 " order by imgno asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				
				ImageVO imgvo = new ImageVO();
				imgvo.setImgno(rs.getInt("IMGNO"));
				imgvo.setImgfilename(rs.getString("IMGFILENAME"));
				
				imgList.add(imgvo); // 차곡차곡 쌓아 넣음
				
			} // end of while -------------
			
		} finally {

			close(); // 자원 반납
		}
		
		return imgList;
	} // end of public List<ImageVO> selectAll() throws SQLException -------------
		
	
	
	
	
	
	
	
	
	
	
	
	
}
