package begin.ch02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/get_postMethodTest4.do")
public class Get_postMethodTest4 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		// 웹 브라우저에 아래와 같이 써주겠다. 
		// Served at: /MyMVC
		
		// HttpServletRequest request 객체는 전송되어져온 데이터를 처리해주는 용도로 쓰인다.
		String name = request.getParameter("name");
		String school = request.getParameter("school");
		String color = request.getParameter("color");
		String[] foodArr = request.getParameterValues("food"); // 복수개의 값 받아오기
		
			
		// *** 웹브라우저에 출력하기 *** // ----------------------------------------
		// HttpServletResponse response 객체는 넘어온 데이터를 조작하여 결과물을 나타내고자 할 때 쓰인다.
				
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		// out은 웹브라우저에 기술하는 대상체라고 생각하자.
		
		String method = request.getMethod();
		
		out.println("<html>");
		out.println("<head><title>개인 성향 테스트 결과화면</title></head>");
		out.println("<body>");
		out.println("<h2>개인 성향 테스트 결과("+method+")</h2>");
		out.printf("<span style='color: red; font-weight: bold;'>%s</span>님의 개인 성향은 <br/><br/>", name);
		
		if(color != null) {
			out.printf("학력은 %s이며, %s색을 좋아합니다.<br/><br/>", school, color);
		}
		else {
			out.printf("학력은 %s이며, 좋아하는 색이 없습니다.<br/><br/>", school);
	//				%d ==> decimal 정수
	//				%f ==> float 실수
	//				%s ==> string 문자열
		}
		
		out.println("좋아하는 음식은 ");
		
		if (foodArr != null) {
			for(int i=0; i<foodArr.length; i++) {
				String comma = (i < foodArr.length -1)?", ":"";
				
				out.printf("%s%s", foodArr[i], comma);
			} // end of for ----------------
			out.println(" 입니다.");
		}
		
		else {
			out.println("없습니다.");			
		}
		
		out.println("</body>");
		out.println("</html>");

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		
		throws ServletException, IOException {

			doGet(request, response);
	}

}
