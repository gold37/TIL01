package myshop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class MallHome2Action extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getCategoryList(request);
		
		InterProductDAO pdao = new ProductDAO();
		
		// Ajax(JSON)를 사용하여 HIT 상품목록을 '더보기' 방식으로 페이징처리하기
		int totalHITCount = pdao.totalPspecCount("HIT"); // 히트상품이 총 몇개있는지 알아봄
	//	System.out.println("### 확인용 totalHITCount : " +totalHITCount);
		// ### 확인용 totalHITCount : 36

		request.setAttribute("totalHITCount", totalHITCount); // 총 갯수 36개라는걸 mallHome.jsp에게 정보 넘겨줌
		super.setViewPage("/WEB-INF/myshop/mallHome2.jsp");
		
	}

}
