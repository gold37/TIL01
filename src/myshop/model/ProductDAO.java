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

	
	// 제품번호를 가지고 해당 제품의 정보 조회해오기
	@Override
	public ProductVO selectOneProductPnum(String pnum) throws SQLException {

		ProductVO pvo = null; 
		
		try {
			conn = ds.getConnection();

			String sql = " select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point "+
						 "     , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate "+
						 " from shopping_product "+
						 " where to_char(pnum) = ? " ;
								//▲ 사용자의 장난에도 SQL 오류 안뜨게 문자열로 타입 변환해서 넣음  
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pnum);

			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				int    npnum = rs.getInt("pnum");                     // 제품번호
				String pname = rs.getString("pname");                // 제품명
				String pcategory_fk = rs.getString("pcategory_fk");  // 카테고리코드
				String pcompany = rs.getString("pcompany");          // 제조회사명
				String pimage1 = rs.getString("pimage1");            // 제품이미지1
				String pimage2 = rs.getString("pimage2");            // 제품이미지2
				int    pqty = rs.getInt("pqty");                     // 제품 재고량
				int    price = rs.getInt("price");                   // 제품 정가
				int    saleprice = rs.getInt("saleprice");           // 제품 판매가
				String pspec = rs.getString("pspec");                       // "HIT", "BEST", "NEW" 등의 값을 가짐 
				String pcontent = rs.getString("pcontent");          // 제품설명
				int    point = rs.getInt("point");                   // 포인트 점수
				String pinputdate = rs.getString("pinputdate");      // 제품입고일자
				
				pvo = new ProductVO (npnum, pname, pcategory_fk, pcompany, pimage1, pimage2,pqty, price, saleprice, pspec, pcontent, point, pinputdate);
				
			} // end of if {} --------------
			
		} finally {
			close();
		}
		
		return pvo;

	}

	
	// shopping_category 테이블에서 카테고리코드(code)와 카테고리명(cname)을 조회해오기  
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		
		List<HashMap<String, String>> categoryList = new ArrayList<>(); 
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select code, cname "  
			 		    + " from shopping_category "
			 		    + " order by cnum asc ";
			 		    
			pstmt = conn.prepareStatement(sql);
					
			rs = pstmt.executeQuery();
						
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("code", rs.getString("code"));
				map.put("cname", rs.getString("cname"));
				
				categoryList.add(map);
			}// end of while(rs.next())----------------------------------
			
		} finally {
			close();
		}	
		
		return categoryList;
	}

	
	// 특정 카테고리 코드에 해당하는 제품목록 조회해오기
	@Override
	public List<ProductVO> selectByCategoryCode(String code) throws SQLException {
		List<ProductVO> productList = new ArrayList<>(); 
		
		try {
			conn = ds.getConnection();

			String sql = " select pnum, pname, pcategory_fk, pcompany, pimage1, pimage2, pqty, price, saleprice, pspec, pcontent, point "+
						 "     , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate "+
						 " from shopping_product "+
						 " where pcategory_fk = ? "+
						 " order by pnum asc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);

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
				String pspec = rs.getString("pspec");                       // "HIT", "BEST", "NEW" 등의 값을 가짐 
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

	
	// Ajax 를 이용한 특정 제품의 상품구매후기를 입력(insert)하기
	@Override
	public int addComment(PurchaseReviewsVO prvo) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into shopping_purchase_reviews(no, fk_userid, fk_pnum, reviewsContents, writeDate) "
					   + " values(seq_purchase_reviews.nextval, ?, ?, ?, default) ";
					   
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, prvo.getFk_userid());
			pstmt.setInt(2, prvo.getFk_pnum());
			pstmt.setString(3, prvo.getReviewsContents());
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	}
	
	
   // *** Ajax를 이용한 특정 제품의 상품후기를 조회하는 메소드 
   @Override
   public List<PurchaseReviewsVO> commentList(String pnum) throws SQLException {
      
      List<PurchaseReviewsVO> CommentList = null;
      
      try {
         conn = ds.getConnection();
         
         String sql = " select reviewsContents, name, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate "+
                    " from shopping_purchase_reviews A join mymvc_shopping_member B "+
                    " on A.fk_userid = B.userid "+
                    " where fk_pnum = ? "+
                    " order by no desc ";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, Integer.parseInt(pnum));
         
         rs = pstmt.executeQuery();
         
         int cnt = 0;
         while(rs.next()) {
            cnt++;
            
            if(cnt==1)
               CommentList = new ArrayList<PurchaseReviewsVO>();
            
            String reviewsContents = rs.getString("reviewsContents");
            String name = rs.getString("name");
            String writeDate = rs.getString("writeDate");
                                    
            PurchaseReviewsVO prvo = new PurchaseReviewsVO();
            prvo.setReviewsContents(reviewsContents);
            prvo.setName(name);
            prvo.setWriteDate(writeDate);
            
            CommentList.add(prvo);
         }         
         
      } finally {
         close();
      }
      
      return CommentList;   
   }
   
    // === 장바구니 담기 === 
	// 장바구니 테이블에 해당 제품이 존재하지 않는 경우는 shoppin_cart 테이블에 insert 를 해야하고,
	// 장바구니 테이블에 해당 제품이 존재하는 경우에 또 그 제품을 추가해서 장바구니 담기를 한다라면  shoppin_cart 테이블에 update 를 해야 한다. 
	@Override
	public int addCart(String userid, String pnum, String oqty)  throws SQLException {
		
		int result = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 /*
			     먼저 장바구니 테이블(shopping_cart)에 어떤 회원이 새로운 제품을 넣는 것인지,
			     아니면 또 다시 제품을 추가로 더 구매하는 것인지를 알아야 한다.
			     이것을 알기위해서 어떤 회원이 어떤 제품을  장바구니 테이블(shopping_cart) 넣을때
			     그 제품이 이미 존재하는지 select 를 통해서 알아와야 한다.
			     
			   ----------------------------------------------------
			    cartno   fk_userid     fk_pnum   oqty  status
			   -----------------------------------------------------
			      1      leess          7         2     1
			      2      leess          6         3     1
			      3      hongkd         7         5     1
			  */
			 
			 String sql = " select cartno "
			 		    + " from shopping_cart "
			 		    + " where status = 1 and"
			 		    + " fk_userid = ? and"
			 		    + " fk_pnum = ? ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userid);
			 pstmt.setString(2, pnum);
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 // 어떤 제품을 추가로 장바구니에 넣고자 하는 경우
				 
				 int cartno = rs.getInt("cartno");
				 
				 sql = " update shopping_cart set oqty = oqty + ? "
				 	 + " where cartno = ? ";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setInt(1, Integer.parseInt(oqty));
				 pstmt.setInt(2, cartno);
				 
				 result = pstmt.executeUpdate();
			 }
			 else {
				// 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
				 
				 sql = " insert into shopping_cart(cartno, fk_userid, fk_pnum, oqty, status) "
				 	 + " values(seq_shopping_cart_cartno.nextval, ?, ?, ?, default) ";
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, userid);
				 pstmt.setInt(2, Integer.parseInt(pnum));
				 pstmt.setInt(3, Integer.parseInt(oqty));
				 
				 result = pstmt.executeUpdate();
			 }
			 
		} finally {
			close();
		}
		
		return result;
	}// end of int addCart(String userid, String pnum, String oqty) ---------------	

	
	// 로그인한 사용자의 장바구니 목록 조회하기
   @Override
   public List<CartVO> selectProductCart(String userid) throws SQLException {

      List<CartVO> cartList = null; // 장바구니에 아무것도 안담은 사람도 있기때문에
      
      try {
         
         conn = ds.getConnection();
         
         String sql = " select A.cartno, A.fk_userid, A.fk_pnum, B.pname, B.pcategory_fk, "+
	                   "        B.pimage1, B.price, B.saleprice, B.point, A.oqty, A.status "+
	                   " from shopping_cart A join shopping_product B "+
	                   " on A.fk_pnum = B.pnum "+
	                   " where A.status = 1 and A.fk_userid = ? "+
	                   " order by A.cartno desc ";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, userid);
         
         rs = pstmt.executeQuery();
         
         int cnt = 0;
         while(rs.next()) {
            cnt++;
            
            if(cnt == 1) {
               cartList = new ArrayList<CartVO>();   // 한번만 만들 수 있게 만든다.
            }
            
            int cartno = rs.getInt("cartno");
            String fk_userid = rs.getString("fk_userid");
            int fk_pnum = rs.getInt("fk_pnum");
            String pname = rs.getString("pname");
            String pcategory_fk = rs.getString("pcategory_fk");
            String pimage1 = rs.getString("pimage1");
            int price = rs.getInt("price");
            int saleprice = rs.getInt("saleprice");
            int point = rs.getInt("point");
            int oqty = rs.getInt("oqty");  // 주문량 
            int status = rs.getInt("status");

            ProductVO prod = new ProductVO();
            prod.setPnum(fk_pnum);
            prod.setPname(pname);
            prod.setPcategory_fk(pcategory_fk);
            prod.setPimage1(pimage1);
            prod.setPrice(price);
            prod.setSaleprice(saleprice);
            prod.setPoint(point);
            
            // *** !!! 중요함 !!! *** //
            // ProductVO에서 작성된 메소드
            prod.setTotalPriceTotalPoint(oqty);
            // *** !!! 중요함 !!! *** //
            
            CartVO cvo = new CartVO();
            cvo.setCartno(cartno);
            cvo.setUserid(fk_userid);
            cvo.setPnum(fk_pnum);
            cvo.setOqty(oqty);
            cvo.setStatus(status);
            cvo.setProd(prod);
            
            cartList.add(cvo);            
            
         } // end of while -------------
                  
      } finally {
         close();
      }
      
      return cartList;
   }

   
   // 로그인한 사용자의 장바구니에 담긴 주문총액 및 합계 포인트 구하기
	@Override
	public HashMap<String, String> selectCartSumPricePoint(String userid) throws SQLException {

		HashMap<String, String> sumMap = new HashMap<>(); // 장바구니에 아무것도 안담은 사람도 있기때문에
	      
	      try {
	         
	         conn = ds.getConnection();
	         
	         String sql = "select nvl(sum(oqty * saleprice), 0) AS SUMTOTALPRICE "+
		        		  "     , nvl(sum(oqty * point), 0) AS SUMTOTALPOINT "+
		        		  " from shopping_cart A join shopping_product B "+
		        		  " on A.fk_pnum = B.pnum "+
		        		  " where status = 1 and fk_userid = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         sumMap.put("SUMTOTALPRICE", rs.getString("SUMTOTALPRICE"));
	         sumMap.put("SUMTOTALPOINT", rs.getString("SUMTOTALPOINT"));
	            
	                  
	      } finally {
	         close();
	      }
	      
	      return sumMap;
	
	}

}
