package ajaxstudy.model;

import java.sql.SQLException;
import java.util.*;

public interface InterAjaxDAO {

	// 추상 메소드 만들기
	
	// 광고 이미지 전체 목록 조회
	List<HashMap<String, String>> imgList() throws SQLException;
	
	// 뉴스제목 목록 조회
	List<NewsTitleVO> newsTitleList() throws SQLException; 
	
	// 특정 뉴스내용 조회
	String newsContents(String seqno) throws SQLException;

	// 뉴스제목, 뉴스내용 쓰기
	void newsWrite(HashMap<String, String> map) throws SQLException;

	// 직원 추가하기
	void registerEmp(EmployeeVO empvo) throws SQLException;

	// 모든 직원 정보 조회
	List<EmployeeVO> empList() throws SQLException;

	// 특정 직원 정보 조회
	EmployeeVO empDetail(String email) throws SQLException;

	// email 중복 검사
	boolean emailDuplicateCheck(String email) throws SQLException;
	
}
