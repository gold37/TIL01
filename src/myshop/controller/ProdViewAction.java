package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import my.util.MyUtil;
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
		
		// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기
		List<String> imgList = pdao.getImagesByPnum(pnum);

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
			request.setAttribute("imgList", imgList);
			request.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
			
			super.setViewPage("/WEB-INF/myshop/prodView.jsp");
			
		}
		
		
	}

}
