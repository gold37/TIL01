package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class MemberOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
		throws Exception {
		
		// == 관리자(admin)로 로그인 했을때만 조회가 가능하도록 한다. ==
	      HttpSession session = request.getSession();
	      MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	      
	      if(loginuser == null) {
	         
	         String message = "먼저 로그인 해야 가능합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	         return;
	      }
	      
	      else {
	         String userid = loginuser.getUserid();
	         
	         if(!"admin".equals(userid)) {
	            String message = "관리자만 접근이 가능합니다.";
	            String loc = "javascript:history.back()";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            
	            return;
	         }
	      }
		
	      
	      /////////////////////////////////////////////////////////////////////
	      
	      String idx = request.getParameter("idx");
	      InterMemberDAO mdao = new MemberDAO();
	      MemberVO mvo = mdao.memberOneDetail(idx); // 한사람에 대한 정보 알아오기
	      request.setAttribute("mvo", mvo);
	      
	      super.setRedirect(false);
	      super.setViewPage("/WEB-INF/member/memberOneDetail.jsp");
	      
	}

}
