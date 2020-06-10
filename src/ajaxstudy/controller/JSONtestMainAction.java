package ajaxstudy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class JSONtestMainAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

	//	super.setRedirect(false); // default가 false기 때문에 생략가능
		super.setViewPage("/WEB-INF/ajaxstudy/jsontest/main.jsp");
		
	}

}
