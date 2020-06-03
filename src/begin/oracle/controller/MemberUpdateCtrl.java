package begin.oracle.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import begin.oracle.model.MemberDAO;
import begin.oracle.model.MemberVO;

@WebServlet("/updateMember.do")
public class MemberUpdateCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		execute(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		execute(request, response);
	}

	private void execute(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
	
		String path = "";
		
		try {
			MemberDAO mdao = new MemberDAO();
	
			String userid = request.getParameter("userid");
			
			MemberVO mvo = mdao.memberOneInfoView(userid); // mvo 는 변경하려는 회원
			
			String method = request.getMethod(); // 전송방식 무엇인지 확인
			
			if("GET".equalsIgnoreCase(method)) { // GET 방식이면 변경 전 화면만 보여줌 (회원정보 변경하기 화면)
			
				request.setAttribute("mvo", mvo);
					
				path = "/WEB-INF/beginOracle/memberUpdate.jsp";
			
				RequestDispatcher dispatcher = request.getRequestDispatcher(path);
				dispatcher.forward(request, response);
				
			} // end of if("GET".equalsIgnoreCase(method)) ----------
			
			else { 
				
				// POST 방식이면 회원정보 변경 화면에서 "회원변경" 버튼을 클릭한 경우
				
				String passwd = request.getParameter("passwd");
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String[] arrInterest = request.getParameterValues("interest");

				mvo.setPasswd(passwd);
				mvo.setName(name);
				mvo.setEmail(email);
				mvo.setInterest(arrInterest);
				
				int n = mdao.memberUpdate(mvo);
				// 회원의 정보를 수정하는 메소드 호출
				
				// 회원의 정보를 변경한 다음, 변경된 회원의 정보를 보여주는 URL 페이지로 이동
				response.sendRedirect("myInfoView.do?userid="+userid);
				
			}
		
		} catch (SQLException e) {
			
			e.printStackTrace();

			// Exception이 발생되면 에러페이지를 보여줄 View단으로 가야한다.
			request.setAttribute("errMsg", e.getMessage());
			
			path = "/WEB-INF/beginOracle/error.jsp";
			
			RequestDispatcher dispatcher = request.getRequestDispatcher(path);
			dispatcher.forward(request, response);

		}

	}	
	
}
