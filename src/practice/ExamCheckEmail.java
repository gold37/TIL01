package practice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/practice/ExamCheckEmail")
public class ExamCheckEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		 response.setContentType("text/html; charset=UTF-8");
	      
	      String email = request.getParameter("email");
	      
	      ExamMemberDAO dao = new ExamMemberDAO();
	      
	      PrintWriter out = response.getWriter();
	      
	      try {
	         
	         boolean bool = dao.isEmailExists(email);
	         
	         if(bool) {
	            out.print("사용가능한 email 입니다.");
	         } else {
	            out.print("사용 불가능한 email 입니다.");
	         }
	         
	      } catch (SQLException e) {
	         
	         System.out.println("SQL문 오류입니다.");
	      }

		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		doGet(request, response);
	}



	
}
