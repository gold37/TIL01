package ajaxstudy.controller;

import java.util.*;

import javax.servlet.http.*;

import ajaxstudy.model.*;
import common.controller.AbstractController;

public class XmltestNewsWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String title = request.getParameter("title");
		String newscontents = request.getParameter("newscontents");
		
		System.out.println("--------- 확인용 title: " + title);
		System.out.println("--------- 확인용 newscontents : " + newscontents);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("title", title);
		map.put("newscontents", newscontents);
		
		InterAjaxDAO dao = new AjaxDAO();
		dao.newsWrite(map);
		
		
	}

}
