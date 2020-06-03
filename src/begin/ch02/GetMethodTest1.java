package begin.ch02;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
      === Servlet 이란 ? 웹서비스 기능을 해주는 자바 클래스를 말한다. ===
      
       *** Servlet 이 되기 위한 조건은 3가지 규칙을 따라야 한다. ***
       
      1. 서블릿(Servlet)은 반드시 
         javax.servlet.http.HttpServlet 클래스를 부모 클래스로 상속을 받아와야 한다. 
      
      2. 웹클라이언트의 요청방식이 GET 방식으로 요청을 해오면
         doGet() 메소드로 응답을 해주도록 코딩을 해야하고,
            웹클라이언트의 요청방식이 POST 방식으로 요청을 해오면
         doPost() 메소드로 응답을 해주도록 코딩을 해주어야만 한다.
            그러므로  반드시  doGet() 메소드와  doPost() 메소드를 
         Overriding(재정의)를 해주어야만 한다.
         
         doGet() 메소드와 doPost() 메소드의 
            첫번째 파라미터는 HttpServletRequest 타입이고,
            두번째 파라미터는 HttpServletResponse 타입이다. 
                 
      3. 만약에  서블릿(Servlet)에서 결과물을 웹브라우저상에 출력하고자 한다라면 
         doGet() 메소드와 doPost() 메소드 모두 
            서블릿(Servlet)의 두번째 파라미터인 HttpServletResponse response 를 
            사용하여 출력해준다.
 */

public class GetMethodTest1 extends HttpServlet {

   private static final long serialVersionUID = 1L; // GetMethodTest1에 노란줄떠서 default해준것
   
   
   @Override 
   protected void doGet(HttpServletRequest request, HttpServletResponse response) 
         
      throws IOException { //doGet메소드를 호출 하는 쪽에서 Exception 처리를 해주겠다 -> WAS
      
      System.out.println(">>> 확인용 : doGet(request, response) 메소드 호출됨");
      
      // HttpServletRequest request 객체는 전송된 데이터를 처리해주는 용도
      String name = request.getParameter("name");
      String school = request.getParameter("school");
      String color = request.getParameter("color");
      /* String food = request.getParameter("food");    --> 복수개 선택해도 한개만 출력됨 */
      String[] foodArr = request.getParameterValues("food"); // 복수개 선택에는 getParameterValues
      
      
      System.out.println("name =>" + name);
      System.out.println("school =>" + school);
      System.out.println("color =>" + color);
      /* System.out.println("color =>" + food); */
      
      if(foodArr != null) {
         for(int i=0; i<foodArr.length; i++) {
            System.out.println("foodArr["+i+"] => " + foodArr[i]);
         }
      }
      
      // ***** 콘설에 출력하기 끝 **** //
      
      
      // ***** 웹브라우저에 출력하기 시작 **** //
      // HttpServletResponse response 객체는 넘어온 데이터를 조작해서 결과물을 나타내고자 할 때 쓰임
      response.setContentType("text/html; charset=UTF-8");
      
      
      PrintWriter out = response.getWriter(); //웹에 글 쓸 볼펜 
      // out은 웹브라우저에 기술하는 대상체
      
      out.println("<html>");
      out.println("<head><title>개인 성향 테스트 결과화면</title></head>");
      out.println("<body>");
      out.println("<h2>개인 성향 테스트 결과(GET)</h2>");
      out.printf("<span style='color: blue; font-weight: bold;'>%s</span>님의 개인 성향은<br/><br/>", name);
      
      if(color != null) {
         out.printf("학력은 %s이며, %s색을 좋아합니다<br/><br/>", school, color);
      }
      else {
         out.printf("학력은 %s이며, 좋아하는 색이 없습니다<br/><br/>", school);
         
         /*
            %d ==> decimal 정수
            %f ==> float   실수
            %s ==> string  문자열
          */
      }
      
      out.println("좋아하는 음식은 ");
      
      if(foodArr != null) {
         for(int i=0; i<foodArr.length; i++) {
            String comma = (i < foodArr.length-1)?",":"";
            out.printf("%s%s", foodArr[i], comma);
         }
         out.println(" 입니다.");
      }
      else {
         out.println(" 없습니다.");
      }
      
      out.println("</body>");
      out.println("</html>");
      
   }
   
   @Override 
   protected void doPost(HttpServletRequest request, HttpServletResponse response) {
      System.out.println(">>> 확인용 : doPost(request, response) 메소드 호출됨");
   }
}