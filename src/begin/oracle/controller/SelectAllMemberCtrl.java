package begin.oracle.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import begin.oracle.model.MemberDAO;
import begin.oracle.model.MemberVO;


@WebServlet("/selectAllMember.do")
public class SelectAllMemberCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		execute(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		execute(request, response);
		doGet(request, response);
	}

	private void execute(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		MemberDAO mdao = new MemberDAO();
		
		String path = "";
		
		try {
			List<MemberVO> memberList = mdao.selectAllMember();
			
			request.setAttribute("memberList", memberList);
			
			path = "/WEB-INF/beginOracle/memberAllInfoView.jsp";
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			
			// Exception이 발생되면 에러페이지를 보여줄 View단으로 가야한다.
			request.setAttribute("errMsg", e.getMessage());
						
			path = "/WEB-INF/beginOracle/error.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
		
	}

}
