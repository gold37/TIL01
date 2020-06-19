package myshop.model;

import java.io.UnsupportedEncodingException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import member.model.EncryptMyKey;
import util.security.AES256;

public class ProductDAO implements InterProductDAO {

	private DataSource ds; 
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
	public ProductDAO() {
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

	
	// shopping_product 테이블에서 pspec 컬럼의 값 (HIT, NEW, BEST) 별로 전체 상품목록 가져오기
	@Override
	public List<ProductVO> selectByPspec(String pspec) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>(); 
	
		try {
			conn = ds.getConnection();

			String sql = " select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point "+
						 "     , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate "+
						 " from shopping_product "+
						 " where pspec = ? "+
						 " order by pnum asc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pspec);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				int    pnum = rs.getInt("pnum");                     // 제품번호
				String pname = rs.getString("pname");                // 제품명
				String pcategory_fk = rs.getString("pcategory_fk");  // 카테고리코드
				String pcompany = rs.getString("pcompany");          // 제조회사명
				String pimage1 = rs.getString("pimage1");            // 제품이미지1
				String pimage2 = rs.getString("pimage2");            // 제품이미지2
				int    pqty = rs.getInt("pqty");                     // 제품 재고량
				int    price = rs.getInt("price");                   // 제품 정가
				int    saleprice = rs.getInt("saleprice");           // 제품 판매가
				pspec = rs.getString("pspec");                       // "HIT", "BEST", "NEW" 등의 값을 가짐 
				String pcontent = rs.getString("pcontent");          // 제품설명
				int    point = rs.getInt("point");                   // 포인트 점수
				String pinputdate = rs.getString("pinputdate");      // 제품입고일자
				
				ProductVO pvo = new ProductVO (pnum, pname, pcategory_fk, pcompany, pimage1, pimage2,pqty, price, saleprice, pspec, pcontent, point, pinputdate);
				
				productList.add(pvo);
				
			} // end of while {} --------------
			
		} finally {
			close();
		}
		
		
		return productList;
	}
	
}
