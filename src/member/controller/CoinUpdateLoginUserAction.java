package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class CoinUpdateLoginUserAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {
		
		String idx = request.getParameter("idx");
		String coin = request.getParameter("coin");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("idx", idx);
		paraMap.put("coin", coin);
		
		InterMemberDAO memberdao = new MemberDAO(); 
		int n = memberdao.coinUpdate(paraMap);
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid(); // 아이디를 알아옴
		String name = loginuser.getName();
		
		String message = "";
		String loc = "";
		
		if(n==1) {
			loginuser.setCoin( loginuser.getCoin() + Integer.parseInt(coin) );
							 // 현재 코인을 알아옴
			loginuser.setPoint( loginuser.getPoint() + (int) (Integer.parseInt(coin)*0.01) );
			
			message = userid+"["+name+"]"+"님의 코인액"+coin+"원 결제가 완료되었습니다.";
			loc = request.getContextPath()+"/index.up";
						// /MyMVC
			
		}
		else {
			message = "코인액 결제를 실패했습니다.";
			loc = "history.back()";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
		
	}

}
