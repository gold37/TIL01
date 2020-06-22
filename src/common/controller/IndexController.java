package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import index.bootstrap.model.ImageDAO;
import index.bootstrap.model.ImageVO;
import index.bootstrap.model.InterImageDAO;

public class IndexController extends AbstractController {

	/* 부모클래스에서 인터페이스 재정의를 안했기 때문에 자식 클래스가 일반 클래스가 되기위해서는 재정의(오버라이딩)를 해야함 */
	
	@Override 
	public String toString() {
		return "클래스 IndexController의 인스턴스 메소드 toString() 호출함";
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) 
		throws Exception {

	//	System.out.println("--- 확인용 IndexController의 execute 메소드가 호출됨.");
		
	//	request.setAttribute("name", "홍길동");
		
		request.setAttribute("storeName", "대박쇼핑");
		
		InterImageDAO dao = new ImageDAO(); // 다형성
		List<ImageVO> imgList = dao.selectAll();
		request.setAttribute("imgList", imgList);

		
		super.setRedirect(false); // 우리끼리 약속 - false면 forward로 
		super.setViewPage("/WEB-INF/index.jsp"); // index.jsp는 뷰단 페이지
	
	}
}
