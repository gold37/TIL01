package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CoinPurchaseTypeChoiceAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// get방식은 주소창 복사해서 악용할 수 있으니 로그인 한 사람만 가능하게
		// 코인충전을 하기위한 전제조건은 먼저 로그인을 해야 한다는 것이다.
		if( super.checkLogin(request) ) {
			// 로그인을 했으면 
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String idx = request.getParameter("idx");
			
			if(String.valueOf(loginuser.getIdx()).equals(idx)) {
				// 로그인 된 사용자의 세션정보에서 idx를 꺼내와 int를 String타입으로 바꿔주고 비교
				// 로그인을 해서 자신의 코인을 충전하는 경우
				super.setViewPage("/WEB-INF/member/coinPurchaseTypeChoice.jsp");
			}
			else {
				// 로그인을 했지만, 로그인한 자신의 것이 아닌 다른 사용자의 코인을 충전하려고 접근한 경우
				String message = "다른 사용자의 코인충전은 불가합니다!";
				String loc = "javascript:history.back()";
				 
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				 
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
		}
		else {
			// 로그인을 안했으면
			String message = "코인충전을 하기위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			 
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
	}

}
