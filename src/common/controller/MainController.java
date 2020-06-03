package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController {
	
	/* 부모클래스에서 인터페이스 재정의를 안했기 때문에 자식 클래스가 일반 클래스가 되기위해서는 재정의(오버라이딩)를 해야함  */
	
	@Override 
	public String toString() {
		return "클래스 MainController의 인스턴스 메소드 toString() 호출함";
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {

	//	System.out.println("--- 확인용 MainController의 execute 메소드가 호출됨.");
		
		super.setRedirect(true); // 우리끼리 약속 - true면 sendRedirect로 
		super.setViewPage("index.up"); // 상대경로. 맨 뒤에것만 바뀜. main.up해도 index.up 페이지로 이동함.
		
		
	}
	
}
