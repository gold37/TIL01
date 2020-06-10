package ajaxstudy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import ajaxstudy.model.AjaxDAO;
import ajaxstudy.model.InterAjaxDAO;
import common.controller.AbstractController;

public class JSONtestEmailDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String email = request.getParameter("email");
		InterAjaxDAO dao = new AjaxDAO();
		boolean isUse = dao.emailDuplicateCheck(email);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isUse", isUse);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/ajaxstudy/jsontest/jsonview.jsp");
		
	}

}
