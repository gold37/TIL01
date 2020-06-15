package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userid = request.getParameter("userid");
		String userCertificationCode = request.getParameter("userCertificationCode");
		
		HttpSession session = request.getSession();
		String certificationCode = (String) session.getAttribute("certificationCode"); // 세션에 저장된 값을 불러오자
		
		String message = "";
	 	String loc = "";
	 	
	 	if( certificationCode.equals(userCertificationCode) ) {
	 		message = "인증성공 되었습니다.";
	 		loc = request.getContextPath()+"/login/pwdUpdateEnd.up?userid="+userid;
	 	}
	 	else {
	 		message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
	 		loc = request.getContextPath()+"/login/pwdFind.up";
	 	}
		
	 	request.setAttribute("message", message);
	 	request.setAttribute("loc", loc);
	 	
	 	super.setViewPage("/WEB-INF/msg.jsp");
	 	
	 	// !!! 중요 !!! //
	 	// 세션에 저장된 인증코드 삭제하기 !!!!
	 	session.removeAttribute("certificationCode"); //특정 내용물만 지움
		
	}

}
