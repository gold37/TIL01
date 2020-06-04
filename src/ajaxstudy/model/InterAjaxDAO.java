package ajaxstudy.model;

import java.sql.SQLException;
import java.util.*;

public interface InterAjaxDAO {

	// 추상 메소드 만들기
	
	// 광고 이미지 전체 목록 조회
	List<HashMap<String, String>> imgList() throws SQLException;
	
	// 뉴스제목 목록 조회
	List<NewsTitleVO> newsTitleList() throws SQLException; 
	
}
