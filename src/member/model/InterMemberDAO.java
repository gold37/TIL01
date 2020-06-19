package member.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterMemberDAO {

	// 회원가입(insert)
	int registerMember(MemberVO membervo) throws SQLException;

	// ID중복 검사 (userid가 중복이 없어서 사용가능하다라면 true, userid가 이미 존재하여 사용 불가능하면 false 를 리턴) 
	boolean idDuplicateCheck(String userid) throws SQLException;

	// 아이디와 암호를 입력받아서 그 회원에 대한 정보를 리턴(로그인 처리)
	MemberVO selectOneMember(HashMap<String, String> paraMap) throws SQLException;

	// 휴면상태인 사용자 계정을 휴면이 아닌 상태로 바꾸기
	// 즉, lastlogindate 컬럼의 값을 sysdate로 update해준다.
	void expireIdle(int idx) throws SQLException;

	// 아이디 찾기 (성명, 핸드폰 번호를 입력받아서 해당 사용자의 아이디를 알려준다.)
	String findUserid(HashMap<String, String> paraMap) throws SQLException;

	// 비밀번호 찾기 (아이디, 이메일을 입력받아서 해당 사용자의 존재 유무를 알려준다.) 
	boolean isUserExist(HashMap<String, String> paraMap) throws SQLException;

	// 암호 변경하기
	int pwdUpdate(String pwd, String userid) throws SQLException;

	// 회원의 coin 변경하기
	int coinUpdate(HashMap<String, String> paraMap) throws SQLException;

	// 특정 회원 정보 수정하기
	int updateMember(MemberVO membervo) throws SQLException;
	
	// 관리자를 제외한 모든 회원 정보 조회하기
	List<MemberVO> selectAllMember() throws SQLException;

	// 페이징처리를 한 관리자를 제외한 모든 회원 정보 조회하기
	List<MemberVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException;

	// 페이징처리를 위한 전체회원에 대한 총페이지갯수 알아오기(select)
	int getTotalPage(HashMap<String, String> paraMap) throws SQLException;

	// idx 값을 입력받아 회원 1명에 대한 상세 정보 알아오기(select)
	MemberVO memberOneDetail(String idx) throws SQLException;
	
}
