package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CoinPurchaseEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 아임포트 결제창을 사용하기위한 전제조건은 먼저 로그인을 해야 하는 것이다. 
		boolean bool = super.checkLogin(request);
		
		if(!bool) {
			// 로그인을 안했으면 
			String message = "결제를 하시려면 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// 로그인 했으면
			
			String idx = request.getParameter("idx");
			
			if(idx==null)
				idx = "";
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			if( !idx.equals(String.valueOf(loginuser.getIdx())) ) {
				// 로그인을 했지만 로그인한 자신의 코인충전에 대한 결제를 하는 것이 아니라 
				// 다른 사용자의 코인충전에 대한 결제를 하려고 접근한 경우 
				String message = "다른 사용자의 코인충전 결제는 불가합니다.!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			else {
				// 로그인을 해서 자신의 코인충전에 대한 결제를 하는 경우
				String coinmoney = request.getParameter("coinmoney");
				
				request.setAttribute("coinmoney", coinmoney);
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("idx", idx);
				
				super.setViewPage("/WEB-INF/member/paymentGateway.jsp"); 
			}
		}		
		
	}

}
