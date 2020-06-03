package begin.ch03;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/personInterestResult.do")
public class PersonInterestResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		
		// 전송 되어져 온 방식(method)이 GET인지 POST인지 알아오기
		String method = request.getMethod();
		
		String name = request.getParameter("name");
		String school = request.getParameter("school");
		String color = request.getParameter("color");
		String[] foodNumArr = request.getParameterValues("food");
		
		String foodImages = ""; // 음식 좋아하는거 없으면 아무것도 안넘김
		
		if(foodNumArr != null) {
			
			String[] foodImgFilenameArr = new String[foodNumArr.length]; // 넘어온 배열 개수(foodArr)와 배열의 크기가 똑같아야 함
																		 // 모두 체크했으면 5
			for(int i=0; i<foodNumArr.length; i++) {
				
				switch (foodNumArr[i]) {
					case "1": // 짜장면
						foodImgFilenameArr[i] = "jjm.png"; 
						break;
	
					case "2": // 짬뽕
						foodImgFilenameArr[i] = "jjbong.png"; 
						break;
						
					case "3": // 탕수육
						foodImgFilenameArr[i] = "tangsy.png"; 
						break;
						
					case "4": // 양장피
						foodImgFilenameArr[i] = "yang.png"; 
						break;
						
					case "5": // 팔보채
						foodImgFilenameArr[i] = "palbc.png"; 
						break;

					} // end of switch -------------
				
			} // end of for ---------------
			
			foodImages = String.join(",", foodImgFilenameArr); // 배열을 하나의 문자열로 만들기 위해 join해줌. 구분자는 콤마.
			
		} // end of if --------------
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("method", method);
		map.put("name", name);
		map.put("school", school);
		map.put("color", color);
		map.put("foodImages", foodImages);
		
		
		// ☆★☆★☆ == request 는 또한 저장소 기능을 가지고 있다. == ☆★☆★☆ //
		request.setAttribute("map", map); // request 저장영역에 데이터 map을 "map"이라는 키 이름으로 저장해둠
	
		/*
			MVC 
			
			M => Model 단 (DB와 관련된 업무를 처리해주는 곳 -> DAO 클래스, DTO 클래스)
			V => View 단 (결과물을 보여주는 곳 -> .jsp)
			C => Controller 단 (.java)
		*/
		
		// ☆★☆★☆ == View 단 (.jsp 파일) 지정하기 == ☆★☆★☆ //
		RequestDispatcher dispatcher = request.getRequestDispatcher("/01begin/ch03/personInterestResult.jsp");
		dispatcher.forward(request, response); // 저장소에 있던 request를 넘겨주겠음
		
		/*
			웹브라우저 상에서 URL 주소는 그대로 /personInterestResult.do 인데
			웹브라우저 상에 보여지는 내용물은 /01begin/ch03/personInterestResult.jsp의 내용이 보여진다. 
		 */
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
