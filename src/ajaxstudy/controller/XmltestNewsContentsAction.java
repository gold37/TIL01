package ajaxstudy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ajaxstudy.model.AjaxDAO;
import ajaxstudy.model.InterAjaxDAO;
import common.controller.AbstractController;

public class XmltestNewsContentsAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String seqno = request.getParameter("seqno");
		
		InterAjaxDAO dao = new AjaxDAO();
		String newscontents = dao.newsContents(seqno); // 받아옴
		
		request.setAttribute("newscontents", newscontents);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/ajaxstudy/xmltest/newsContents.jsp");
		
		
	}

}
