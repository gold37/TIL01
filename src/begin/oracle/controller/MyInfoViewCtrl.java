package begin.oracle.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import begin.oracle.model.MemberDAO;
import begin.oracle.model.MemberVO;


@WebServlet("/myInfoView.do")
public class MyInfoViewCtrl extends HttpServlet {
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
		
		String userid = request.getParameter("userid");
		
		MemberDAO mdao = new MemberDAO();
		
		String path = "";
		
		try {
			MemberVO mvo = mdao.memberOneInfoView(userid);
			request.setAttribute("mvo", mvo);
			
			path = "/WEB-INF/beginOracle/memberOneInfoView.jsp";
			
		} catch(Exception e) {
			e.printStackTrace();
			
			// Exception이 발생되면 에러페이지를 보여줄 View단으로 가야한다.
			request.setAttribute("errMsg", e.getMessage());
			
			path = "/WEB-INF/beginOracle/error.jsp";
			
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}

}
