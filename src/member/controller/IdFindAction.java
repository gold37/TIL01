package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" or "POST"
		
		if("POST".equalsIgnoreCase(method)) { // 전달 방식이 post라면 값을 받아옴
			// 아이디 찾기 모달창에서 찾기 버튼을 클랙했을 경우
			String name = request.getParameter("name");
			String mobile = request.getParameter("mobile");
			
			//DB에 가서 그런 아이디와 핸드폰번호가 있는지 알아옴
			InterMemberDAO memberdao = new MemberDAO();
			
			HashMap<String, String> paraMap = new HashMap<String, String>();
			
			paraMap.put("name", name); // paraMap안에 넣자 ~ .put
			paraMap.put("mobile", mobile); // paraMap안에 넣자 ~ .put
			
			String userid = memberdao.findUserid(paraMap);
			
			if(userid != null) {
				request.setAttribute("userid", userid);
			}
			else {
				request.setAttribute("userid", "존재하지 않습니다.");
			}
			
			request.setAttribute("name", name);
			request.setAttribute("mobile", mobile);
			
		} // end of if() --------------------
		
		request.setAttribute("method", method);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/idFind.jsp");
		
	}

}
