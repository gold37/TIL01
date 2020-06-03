package index.bootstrap.model;

import java.sql.SQLException;
import java.util.List;

public interface InterImageDAO {

	// 모든 상품 이미지 조회 (select)
	List<ImageVO> selectAll() throws SQLException;	

	
	
}
