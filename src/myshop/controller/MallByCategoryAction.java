package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;

public class MallByCategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 카테고리 목록 조회해오기
		super.getCategoryList(request);
		
		String code = request.getParameter("code"); // 카테고리 코드
		String cname = request.getParameter("cname"); // 케테고리명
		
		InterProductDAO pdao = new ProductDAO();
		List<ProductVO> productList = pdao.selectByCategoryCode(code);
		// prodList ==> 특정 카테고리 코드에 해당하는 제품목록
		
		request.setAttribute("productList", productList);
		request.setAttribute("cname", cname);
		
		super.setViewPage("/WEB-INF/myshop/mallByCategory.jsp");
		
	}

}
