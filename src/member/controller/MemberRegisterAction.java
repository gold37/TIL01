package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		
		else {
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress= request.getParameter("extraAddress");
			String gender = request.getParameter("gender");
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd");

			
			// *** 클라이언트의 IP 주소 알아오기 *** //
			String clientip = request.getRemoteAddr();
			
			MemberVO membervo = new MemberVO();
			membervo.setName(name);
			membervo.setUserid(userid);
			membervo.setPwd(pwd);
			membervo.setEmail(email);
			membervo.setHp1(hp1);
			membervo.setHp2(hp2);
			membervo.setHp3(hp3);
			membervo.setPostcode(postcode);
			membervo.setAddress(address);
			membervo.setDetailAddress(detailAddress);
			membervo.setExtraAddress(extraAddress);
			membervo.setGender(gender);
			membervo.setBirthyyyy(birthyyyy);
			membervo.setBirthmm(birthmm);
			membervo.setBirthdd(birthdd);
			membervo.setClientip(clientip);
			
			InterMemberDAO memberdao = new MemberDAO();
			int n = memberdao.registerMember(membervo);
			
			String message = "";
			String loc = "";
			
			if(n==1) {
				message = "회원가입 성공 ~^-^~";
				loc = request.getContextPath()+"/index.up"; //  회원가입 성공하면 이쪽 페이지로 가겠음
			}
			else { 
				message = "회원가입 실패 T-T";
				loc = "javascript:history.back()"; // 이전 페이지로 감
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
		}
		
	}

	
	
}
