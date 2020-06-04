package ajaxstudy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ajaxstudy.model.AjaxDAO;
import ajaxstudy.model.InterAjaxDAO;
import ajaxstudy.model.NewsTitleVO;
import common.controller.AbstractController;

public class XmltestNewsTitleAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// DB에 들어있는 모든 뉴스 데이터를 가지고 옴
		InterAjaxDAO dao = new  AjaxDAO();
		
		List<NewsTitleVO> newsTitleList = dao.newsTitleList();
		
		request.setAttribute("newsTitleList", newsTitleList);
		
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/ajaxstudy/xmltest/newsTitleList.jsp");
		
		
	}

}
