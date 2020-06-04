package ajaxstudy.controller;

import java.util.*;

import javax.servlet.http.*;

import ajaxstudy.model.*;
import common.controller.AbstractController;

public class XmltestImageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		InterAjaxDAO dao = new AjaxDAO();
		
		// 메소드 호출
		List<HashMap<String, String>> imgList = dao.imgList(); // 리턴 타입 HashMap

		request.setAttribute("imgList", imgList); // imgList 정보 넘겨줌
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/ajaxstudy/xmltest/imgList.jsp");
		
	}

}
