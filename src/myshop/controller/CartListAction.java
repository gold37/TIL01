package myshop.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.*;

public class CartListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 카테고리 목록 조회해오기
		super.getCategoryList(request); 
		
		// 장바구니 보기는 반드시 해당사용자가 로그인을 해야만 볼 수 있다.
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()"); 
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}

		else {
			// *** 페이징 처리를 안한 상태로 장바구니 목록 보여주기 *** //
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterProductDAO pdao = new ProductDAO();
			
			List<CartVO> cartList = pdao.selectProductCart(loginuser.getUserid());
			
			HashMap<String, String> sumMap = pdao.selectCartSumPricePoint(loginuser.getUserid());
			
			// 뷰단으로 보내줌
			request.setAttribute("cartList", cartList);
			request.setAttribute("sumMap", sumMap);

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/myshop/cartList.jsp");
		}
		
		
		
	}

}
