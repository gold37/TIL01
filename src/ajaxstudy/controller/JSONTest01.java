package ajaxstudy.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jsontest01")
public class JSONTest01 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
	     // ***** 웹브라우저에 출력하기 시작 **** //
	     // HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할 때 쓰임
	     response.setContentType("text/html; charset=UTF-8");
	      
	     PrintWriter out = response.getWriter(); //웹에 글 쓸 볼펜 
	     // out은 웹브라우저에 기술하는 대상체
		
		 out.print("{\"name\":\"김개똥\", \"age\":20, \"address\":\"서울시 강남구\"}"); // "{}"은 JS에서의 객체 표기법
		 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		doGet(request, response);
		
	}

}
