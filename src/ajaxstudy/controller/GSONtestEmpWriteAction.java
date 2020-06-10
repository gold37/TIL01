package ajaxstudy.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ajaxstudy.model.*;
import common.controller.AbstractController;

public class GSONtestEmpWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String employee = request.getParameter("employee");
		
		System.out.println("------- 1. 확인용 employee -> " + employee);
		// ------- 1. 확인용 employee -> {"ename":"곽대표","jik":"사장","tel":"01012345678","email":"super@naver.com","birthday":"19970825"}
		
		
		/*	
			Gson 은 Java 객체를 JSON 표현식으로 변환할 수 있게 하는 Java 라이브러리 이다.
			물론 JSON 표현식 형태의 스트링을 Java 객체로 변환 또한 가능하다. 
			주로 사용할 클래스는 Gson 이고 그냥 new Gson() 으로 객체생성 하면 된다.
			Gson 객체는 다수의 Json  직렬화(serialization)와 역직렬화(deserialization) 처리시에 계속 재사용해도 된다.
		 */

		Gson gson = new Gson();
		EmployeeVO empvo = gson.fromJson(employee, EmployeeVO.class);
		// gson.fromJson() 메소드는 JSON(자바스크립트에서 사용되어지는 객체표기법)문자열을 객체로 변환시켜주는 것이다.
		
		/*
			private String ename = "곽대표";
			private String jik ="사장";
			private String tel = "01012345678";
			private String email = "super@naver.com";
			private String birthday = "19970825";
			으로 EmployeeVO empvo 객체를 생성해준다.
		 */
		
		
		InterAjaxDAO dao = new AjaxDAO();
		dao.registerEmp(empvo);
		
	}

}
