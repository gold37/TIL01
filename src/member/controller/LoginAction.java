package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" or "POST"
		
		if(!"POST".equalsIgnoreCase(method)) { // post 방식이 아니라면 (=get 이라면)
			 String message = "비정상적인 경로로 들어왔습니다.";
			 String loc = "javascript:history.back()";
			 
			 request.setAttribute("message", message);
			 request.setAttribute("loc", loc);
			 
			 super.setRedirect(false);
			 super.setViewPage("/WEB-INF/msg.jsp");
			 
			 return; // 종료
		}
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
	//	System.out.println("------ 확인용 userid : " +userid+", pwd : "+pwd);
	//	------ 확인용 userid : test, pwd : test123
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", pwd);
		
		// map에 담았으니 이제 DB로 보내준다.
		InterMemberDAO memberdao = new MemberDAO(); 
		MemberVO loginuser = memberdao.selectOneMember(paraMap); // 한 사람에 대한 정보 알아오기

		if( loginuser != null && loginuser.isIdleStatus() == false ) {
			// 로그인 성공 시 
			
			// ★ 세션(session)이라는 저장 영역에 loginuser를 저장시켜두면
			// 모든 Action 클래스 및 JSP 페이지에서  loginuser 정보를 읽어들일 수 있게 된다.
			
			HttpSession session = request.getSession(); // 세션 만들기
			session.setAttribute("loginuser", loginuser);
			
			String goBackURL = request.getContextPath()+"/index.up";
			
			if( loginuser.isRequirePwdChange() == true ) { // 비번 바꾼지 3개월 지났으면
				String message = "비밀번호를 바꾼지 3개월이 지났습니다. 암호를 변경하세요!";
				String loc = request.getContextPath()+"/index.up";
				// 원래는 사용자 정보 변경 페이지로 이동하도록 loc를 정해줘야 함
			
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
			}
			
			// 시작페이지로 이동
			super.setRedirect(true);
			super.setViewPage(goBackURL);
			
			return;
		} 
		
		else if( loginuser != null && loginuser.isIdleStatus() == true ) {
			// 로그인한지 1년이 지나 휴면 상태인 경우 
			String message = "로그인한지 1년이 지나 휴면상태입니다. 관리자에게 문의 바랍니다.";
			String loc = request.getContextPath()+"/index.up";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			 
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");

			// alert 창에서 '확인'을 클릭해주면 휴면계정 상태를 다시 정상적으로 사용되게 한다.
			HttpSession session = request.getSession(); // 세션 만들기
			session.setAttribute("loginuser", loginuser);

			// 휴면상태인 사용자 계정을 휴면이 아닌 것으로 다시 돌려준다.
			// 즉, lastlogindate 컬럼 값을 sysdate로 update 해준다.
			memberdao.expireIdle(loginuser.getIdx());
			
			return;
		}
		
		else {
			// 로그인 실패 시
			String message = "로그인 실패";
			String loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			 
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			 
		}
	}

}
