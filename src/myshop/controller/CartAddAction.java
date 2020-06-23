package myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class CartAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			// GET 방식이라면
			
			String message = "비정상적인 경로로 들어왔습니다";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		else {
			// POST 방식이라면
			
			// === 로그인 유무 검사하기 === //
			boolean isLogin = super.checkLogin(request); // 부모에다 만들어놨었음
			
			HttpSession session = request.getSession();
			
			if(!isLogin) {
				// 로그인을 안한상태
				/*
				   사용자가 로그인을 하지 않은 상태에서 특정제품을 장바구니에 담고자 하는 경우 
				   사용자가 로그인을 하면 장바구니에 담고자 했던 그 특정제품 페이지로 이동하도록 해야 한다.
				 */
				
				String goBackURL = request.getParameter("goBackURL");
				
			//	session.setAttribute("goBackURL", "shop/prodView.up?pnum=6");
				session.setAttribute("goBackURL", goBackURL);
				
				request.setAttribute("message", "장바구니에 담으려면 먼저 로그인을하세요!");
				request.setAttribute("loc", "javascript:history.back()");
				
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			
			else {  // 로그인을 한 상태라면
				// 장바구니 테이블(shopping_cart)에 해당 제품을 담아야 한다.
				// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 shopping_cart 테이블에 insert 를 해야하고, 
				// 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다라면 shopping_cart 테이블에 update 를 해야한다. 

				String pnum = request.getParameter("pnum"); // 제품번호
				String oqty = request.getParameter("oqty"); // 주문량
				
				InterProductDAO pdao = new ProductDAO();
				int n = pdao.addCart( ((MemberVO)session.getAttribute("loginuser")).getUserid(), pnum, oqty);
				
				if(n==1) {
					request.setAttribute("message", "장바구니 담기 성공!!");
					request.setAttribute("loc", "cartList.up");
					// 장바구니 목록보여주기 페이지로 이동
					
				}
				else {
					request.setAttribute("message", "장바구니 담기 실패");
					request.setAttribute("loc", "javascript:history.back()");
					
				}
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
			
		}
	}

}
