package myshop.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterProductDAO {

	// shopping_product 테이블에서 pspec 컬럼의 값 (HIT, NEW, BEST) 별로 전체 상품목록 가져오기 
	List<ProductVO> selectByPspec(String pspec) throws SQLException;

	// 제품번호를 가지고 해당 제품의 정보 조회해오기
	ProductVO selectOneProductPnum(String pnum) throws SQLException;

	// shopping_category 테이블에서 카테고리코드(code)와 카테고리명(cname)을 조회해오기 
	List<HashMap<String, String>> getCategoryList() throws SQLException;

	// shopping_product 테이블에서 특정 카테고리 코드에 해당하는 제품목록 조회해오기
	List<ProductVO> selectByCategoryCode(String code) throws SQLException;

	// Ajax를 이용한 특정 제품의 상품후기 입력(insert)하기
	int addComment(PurchaseReviewsVO prvo) throws SQLException;

	// *** Ajax 를 이용한 특정 제품의 상품후기를 조회해주기 
	List<PurchaseReviewsVO> commentList(String pnum) throws SQLException;

	
	// 장바구니 담기
	// 장바구니 테이블(shopping_cart)에 해당 제품을 담아야 한다.
	// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 shopping_cart 테이블에 insert 를 해야하고, 
	// 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다라면 shopping_cart 테이블에 update 를 해야한다. 
	int addCart(String userid, String pnum, String oqty) throws SQLException;
	
	
}
