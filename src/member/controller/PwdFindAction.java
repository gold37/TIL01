package member.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class PwdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" or "POST"
		
		if("POST".equalsIgnoreCase(method)) { // 전달 방식이 post라면 값을 받아옴
		// 비밀번호 찾기 모달창에서 찾기 버튼을 클랙했을 경우
			
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			//DB에 가서 그런 아이디와 핸드폰번호가 있는지 알아옴
			InterMemberDAO memberdao = new MemberDAO();
			
			HashMap<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("userid", userid); // paraMap안에 넣자 ~ .put
			paraMap.put("email", email); // paraMap안에 넣자 ~ .put
		
			boolean isUserExist = memberdao.isUserExist(paraMap); // 해당 userid와 email을 가진 사용자가 있는지 확인
			
			int n = 0; // 회원으로 존재하는 경우인지 회원으로 존재하지 않는 경우인지 구분하기 위한 표식이다.
			
			if(isUserExist) { // 회원으로 존재하는 경우
				
				n = 1;
				
			//	mail.sendmail("ouo825@naver.com", "메일 발송 테스트입니다. 잘 갔나요?");
				
				// 인증키 랜덤하게 생성
				Random rnd = new Random();
				
				String certificationCode = "";
				// certificationCode ==> "swfet0933651"
				
				char randchar = ' ';
				for(int i=0; i<5; i++) {
				/*
				    min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
				    int rndnum = rnd.nextInt(max - min + 1) + min;
				       영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.  	
				 */
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certificationCode += randchar;
				}
				
				int randnum = 0;
				for(int i=0; i<7; i++) {
					randnum = rnd.nextInt(9 - 0 + 1) + 0;
					certificationCode += randnum;
				}
				
			//	System.out.println("~~~~ 확인용 certificationCode => " + certificationCode);
			//  ~~~~ 확인용 certificationCode => yjslt2732451
				
				// 랜덤하게 생성한 인증코드(certificationCode)로 비밀번호를 찾고자 하는 사용자의 email로 전송시킨다.
				GoogleMail mail = new GoogleMail();
				
				HttpSession session = request.getSession(); // 자동으로 만들어진 세션을 불러옴
				
				try {
					mail.sendmail(email, certificationCode); // mail 발송
					session.setAttribute("certificationCode", certificationCode);
					// 자바에서 발급한 인증코드를 세션에 저장
				} catch (Exception e) {
					e.printStackTrace();

					n = -1; // 메일 발송 실패
				}
			} // end of if() ----------------
			else {
				// 회원으로 존재하지 않는 경우
				n = 0;
				
			} // end of else ----------------

			request.setAttribute("n", n);
			request.setAttribute("userid", userid);
			request.setAttribute("email", email);
			
		} // end of if("POST".equalsIgnoreCase(method)) --------------- 

		request.setAttribute("method", method);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdFind.jsp");
		
	}

}
