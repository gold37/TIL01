package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String idx = request.getParameter("idx");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( !super.checkLogin(request) ) {
			// 로그인을 하지 않았을 경우
			
			String message = "먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else if ( super.checkLogin(request) && !String.valueOf(loginuser.getIdx()).equals(idx) ) {
			// 로그인은 했으나 다른 사용자의 회원번호(idx)를 사용하려는 경우
			
			String message = "다른 사용자의 정보 변경은 불가합니다!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else {
			// 로그인 했고 자신의 회원번호(idx)를 사용하려는 경우
			
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberEdit.jsp");
		}
		
	
	}

}
