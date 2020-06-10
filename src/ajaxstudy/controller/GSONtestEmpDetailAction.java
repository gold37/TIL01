package ajaxstudy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ajaxstudy.model.*;
import common.controller.AbstractController;

public class GSONtestEmpDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String email = request.getParameter("email");
		InterAjaxDAO dao = new AjaxDAO();
		EmployeeVO empvo = dao.empDetail(email);
		
		Gson gson = new Gson();
		String json = gson.toJson(empvo);
		
		System.out.println("---- 3. 확인용 json -> " + json);
		
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/ajaxstudy/jsontest/jsonview.jsp");

		
	}

}
