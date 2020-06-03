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


@WebServlet("/memberDelete.do")
public class MemberDeleteCtrl extends HttpServlet {
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
			
			String userides = request.getParameter("userides");
			
		//	System.out.println("-------- 확인용 : "+ userides);

			String[] useridArr = userides.split(",");
			
			MemberDAO mdao = new MemberDAO();
			
			int sum = 0;
			
			for(int i=0; i<useridArr.length; i++) {

				try {
					int n = mdao.memberDelete(useridArr[i]);
					sum += n;
				} catch (SQLException e) {
					e.printStackTrace();
					
					// Exception이 발생되면 에러페이지를 보여줄 View단으로 가야한다.
					request.setAttribute("errMsg", e.getMessage());

					RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/beginOracle/error.jsp");
					dispatcher.forward(request, response);
					
					break;
				}
			} // end of for ------------------
			
			
			if(sum == useridArr.length) { // 선택한 userid 만큼 다 지웠다면
				
			//	System.out.println("----- 확인용 : 선택한 회원 모두 삭제함");
				
				// 삭제하고 다시 남은 회원정보를 보여주기위해 단순하게 "URL 페이지 이동"만 시키자 --> response 사용
				response.sendRedirect("selectAllMember.do");
				/* 상대 경로 : 맨 마지막 / 뒤에 값을 지우고 적어준게 들어옴 */
			}
	
	}

}
