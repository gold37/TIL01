package myshop.model;

import java.sql.SQLException;
import java.util.List;

public interface InterProductDAO {

	// shopping_product 테이블에서 pspec 컬럼의 값 (HIT, NEW, BEST) 별로 전체 상품목록 가져오기 
	List<ProductVO> selectByPspec(String pspec) throws SQLException;

	
	
}
