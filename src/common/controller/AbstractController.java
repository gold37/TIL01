package common.controller;

import java.sql.SQLException;
import java.util.*;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import member.model.*;
import myshop.model.*;

public abstract class AbstractController implements InterCommand {
	
	// 미완성 클래스 	// 부모클래스  				 	  // 인터페이스
	

	
	
	/*
	    === 다음의 나오는 것은 우리끼리한 약속이다. ===
	
	    ※ view 단 페이지(.jsp)로 이동시 forward 방법(dispatcher)으로 이동시키고자 한다라면 
	       자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
	     
	    super.setRedirect(false); // false면 
	    super.setViewPage("/WEB-INF/index.jsp"); // forward 방식으로!
	    
	    
	          ※ URL 주소를 변경하여 페이지 이동시키고자 한다라면
	          즉, sendRedirect 를 하고자 한다라면    
	          자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
	          
	    super.setRedirect(true); // true 면
	    super.setViewPage("registerMember.up"); // sendRedirect 방식으로!                

	 */

	
	private boolean isRedirect = false;
	private String viewPage;
	
	
	public boolean isRedirect() {
		return isRedirect;
	}
	
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	
	public String getViewPage() {
		return viewPage;
	}
	
	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	
	// 로그인 유무를 검사해서 로그인을 했으면 true, 아니면 false를 리턴하도록 한다.
	public boolean checkLogin(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) { // 로그인했으면
			return true;
		}
		else {
			return false;
		}
		
	}
	
	////////////////////////////////////////////////////
	// *** 제품목록(Category)을 보여줄 메소드 생성하기 *** //
	public void getCategoryList(HttpServletRequest request) throws SQLException  {
		
		InterProductDAO pdao = new ProductDAO();
		
		List<HashMap<String, String>> categoryList = pdao.getCategoryList();
		
		request.setAttribute("categoryList", categoryList);
		
	}
			

}
