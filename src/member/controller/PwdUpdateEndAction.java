package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		//  "GET" or "POST" 
		
		String userid = request.getParameter("userid");
		
		if("POST".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			InterMemberDAO memberdao = new MemberDAO();
			int n = memberdao.pwdUpdate(pwd, userid);
			
			request.setAttribute("n", n);
		}
		
		request.setAttribute("method", method);
		request.setAttribute("userid", userid);

		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
	}

}
