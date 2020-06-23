package myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;

public class ProdViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록 조회해오기
		super.getCategoryList(request); // 특정 제품 상세보기를 눌렀을때도 카테고리 보고싶을때 
		
		String pnum = request.getParameter("pnum");
		
		InterProductDAO pdao = new ProductDAO();
		
		// 제품번호를 가지고 해당 제품의 정보 조회해오기
		ProductVO pvo = pdao.selectOneProductPnum(pnum);
		
		if(pvo == null) {
			// 사용자가 장난쳤을 때
			// GET 방식이므로 사용자가 웹브라우저 주소창에 존재하지 않은 제품을 입력한 경우
			String message = "검색하신 제품은 존재하지 않습니다.";
			
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		else {
			// 제품이 있는 경우 
			// 뷰단으로 한 개의 제품을 넘겨줘야 함
			request.setAttribute("pvo", pvo); // pvo에는 DB에서 읽어온 특정 제품에 대한 정보가 들어있음
			
			// *** ? 다음의 데이터까지 포함한 URL 주소를 알아오는 메소드 생성 *** //
			String currentURL = request.getRequestURL().toString(); // 물음표 앞까지만 나옴
			// http://localhost:9090/MyMVC/shop/prodView.up
			
			String queryString = request.getQueryString(); // 물음표 뒤에만 나옴
			// pnum=6
			
			currentURL += "?"+queryString;
			// http://localhost:9090/MyMVC/shop/prodView.up?pnum=6
			
			String ctxPath = request.getContextPath();
			//	   /MyMVC
			
			int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
			// 					21번째부터		6 글자
			currentURL = currentURL.substring(beginIndex+1);
			//										28
			// shop/prodView.up?pnum=6
			
			request.setAttribute("goBackURL", currentURL);
		//	request.setAttribute("goBackURL", "어디서나 이 글씨");
			
			super.setViewPage("/WEB-INF/myshop/prodView.jsp");
			
		}
		
		
	}

}
