package member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
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
		
		InterMemberDAO memberdao = new MemberDAO();
		
		
		// *** 페이징처리를 안한 관리자를 제외한 전체회원 목록 보여주기 
		List<MemberVO> memberList = memberdao.selectAllMember();
		
		request.setAttribute("memberList", memberList);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/memberList.jsp");
	}

}
