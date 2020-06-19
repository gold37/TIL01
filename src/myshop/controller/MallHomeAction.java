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

		InterProductDAO pdao = new ProductDAO();
		
		// === HIT 상품목록을 페이징처리 안하고 가져온 것 === //
		List<ProductVO> hitList = pdao.selectByPspec("HIT");
		request.setAttribute("hitList", hitList);
		
		
		super.setViewPage("/WEB-INF/myshop/mallHome.jsp");
		
		
	}

}
