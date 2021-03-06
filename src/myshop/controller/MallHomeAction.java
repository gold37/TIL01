package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.*;

public class MallHomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response)
		throws Exception {

		super.getCategoryList(request);
		
		InterProductDAO pdao = new ProductDAO();
		
		// === HIT 상품목록을 페이징처리 안하고 가져온 것 === //
	//	List<ProductVO> hitList = pdao.selectByPspec("HIT");
	//	request.setAttribute("hitList", hitList);
		
		
		// Ajax(JSON)를 사용하여 HIT 상품목록을 '더보기' 방식으로 페이징처리하기
		int totalHITCount = pdao.totalPspecCount("HIT"); // 히트상품이 총 몇개있는지 알아봄
	//	System.out.println("### 확인용 totalHITCount : " +totalHITCount);
		// ### 확인용 totalHITCount : 36

		request.setAttribute("totalHITCount", totalHITCount); // 총 갯수 36개라는걸 mallHome.jsp에게 정보 넘겨줌
		
		
		super.setViewPage("/WEB-INF/myshop/mallHome.jsp");
		
		
	}

}
