package common.controller;

import java.io.*;
import java.util.*;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		description = "사용자가 웹에서 *.up 을 했을 경우 이 서블릿이 먼저 응답 하도록 한다.", 
		urlPatterns = { "*.up" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties", description = "*.up에 대한 클래스 매핑파일")
															//  ▲ *.up은 여기에 기술돼있음
		})

public class FrontController extends HttpServlet { // 큰 빌딩의 프론트(안내 데스크) 역할
	
	private static final long serialVersionUID = 1L;
      
	Map<String, Object> cmdMap = new HashMap<String, Object> ();
	
	
	public void init(ServletConfig config) throws ServletException {
		// 맨 처음 딱 한번만 실행됨
		
		/*
		 	웹브라우저 주소창에서 *.up을 하면 FrontController 서블릿이 응답하는데
		 	맨 처음 자동으로 실행되는 메소드가 init(ServletConfig config) 이다.
		 	여기서 중요한것은 init(ServletConfig config) 메소드는 WAS(톰캣)가 구동되어진 후
		 	딱 한 번만 실행되고, 그 이후에는 실행되지않는다. 
		 */
		
		// *** 확인용 *** //
		System.out.println("확인용 --> 서블릿 FrontController의 init(ServletConfig config) 메소드가 실행됨");
	
		Properties pr = new Properties();
		// Properties 는 Collection 중 HashMap 계열중의  하나로써
		// "key","value"으로 이루어져 있는것이다.
		// 그런데 중요한 것은 Properties 는 key도 String 타입이고, value도 String 타입만 가능하다는 것이다.
		// key는 중복을 허락하지 않는다. value 값을 얻어오기 위해서는 key값만 알면 된다.

		FileInputStream fis = null; // 특정 파일의 내용을 읽어오기 위한 용도의 객체
		
		try {
		
			String props = config.getInitParameter("propertyConfig");
			System.out.println("--- 확인용 : " + props);
			// ---확인용 : C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties
		
			fis = new FileInputStream(props);
			// fis 는 C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용을 읽어오기 위한 용도로 쓰이는 객체를 생성함.

			pr.load(fis);
			/*
			    fis 객체를 사용하여 C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용을 읽어다가 
			    Properties 클래스의 객체인 pr 에 로드시킨다. 
			       그러면 pr 은 읽어온 파일(Command.properties)의 내용에서
			    = 을 기준으로 왼쪽은 key로 보고, 오른쪽은 value 로 인식한다.	  
			 */

			Enumeration<Object> en = pr.keys();
			/*
			    pr.keys(); 은 
			    C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용물에서 
			    = 을 기준으로 왼쪽에 있는 모든 key 들만 가져오는 것이다.  	
			 */
			
			while(en.hasMoreElements()) {
				
				String key = (String) en.nextElement();
			//	System.out.println("---- 확인용 key : " + key);
			//	System.out.println("---- 확인용 value : " + pr.getProperty(key));
			/*
			 	---- 확인용 key : /main.up
				---- 확인용 value : common.controller.MainController
				---- 확인용 key : /index.up
				---- 확인용 value : common.controller.IndexController
			 */
				String className = pr.getProperty(key);
				
				if(className != null) { // 무엇인가 찍혀옴
					
					className = className.trim(); // 양쪽 사이드에 공백을 없앰
					
					Class<?> cls = Class.forName(className); // common.~ 글자를 클래스로 인식하겠다.
					// String 타입으로 되어진 className 을 클래스화 시켜주는 것이다.
				    // 주의할 점은 실제로 String 으로 되어져 있는 문자열이 클래스로 존재해야만 한다는 것이다.

					Object obj = cls.newInstance();
					// 클래스로부터 실제 객체(인스턴스)를 생성해주는 것
					
					System.out.println("--- 확인용 obj.toString() : " + obj.toString());
					/*
					 	--- 확인용 obj.toString() : 클래스 MainController의 인스턴스 메소드 toString() 호출함
						--- 확인용 obj.toString() : 클래스 IndexController의 인스턴스 메소드 toString() 호출함
						
						인스턴스화(객체)로 만들었음을 확인함
					 */
					
					cmdMap.put(key, obj);
					// cmdMap 에서 키값으로 Command.properties 파일에 저장되어진 url 을 주면 
 				    // cmdMap 에서 해당 클래스에 대한 객체(인스턴스)를 얻어오도록 만든 것이다.

					
				} // end of if(className != null)
			
			}

		} catch(ClassNotFoundException e) {
			System.out.println(">>> 문자열로 명명된 클래스가 존재하지 않습니다. <<<");
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			System.out.println(">>> C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일이 없습니다. <<<");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	} // end of public void init(ServletConfig config) throws ServletException {} --------
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			requestProcess(request, response); // get, post 둘 다 여기에 넘겨주겠음
			
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			requestProcess(request, response); // get, post 둘 다 여기에 넘겨주겠음

	}
	
	
	private void requestProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
			// 웹브라우저의 주소 입력창에서
			// http://localhost:9090/MyMVC/member/idDuplicateCheck.up?userid=less 와 같이 입력되면
		//	String url = request.getRequestURL().toString();
		//	System.out.println("--- 확인용 URL : " + url);
			// --- 확인용 URL : http://localhost:9090/MyMVC/member/idDuplicateCheck.up
			
			String uri = request.getRequestURI().toString();
		//	System.out.println("--- 확인용 URI :"+uri);
			// --- 확인용 URI :/MyMVC/member/idDuplicateCheck.up
			
			String ctxPath = request.getContextPath();
		//	System.out.println("--- 확인용 URI :" + ctxPath);
			// --- 확인용 URI : /MyMVC
		
			String key = uri.substring(ctxPath.length());
			System.out.println("--- 확인용 key :" + key); 
			// --- 확인용 key :/index.up
			
			AbstractController action = (AbstractController) cmdMap.get(key);

			if(action == null) {
				System.out.println(">>> " + key +" URL 패턴에 매핑된 클래스는 없습니다. <<<");
			} else {
				
				try {
					action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
	}

}
