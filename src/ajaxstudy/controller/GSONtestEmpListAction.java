package ajaxstudy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import ajaxstudy.model.AjaxDAO;
import ajaxstudy.model.EmployeeVO;
import ajaxstudy.model.InterAjaxDAO;
import common.controller.AbstractController;

public class GSONtestEmpListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		InterAjaxDAO dao = new AjaxDAO();
		List<EmployeeVO> empList = dao.empList();
		
		Gson gson = new Gson();
		String json = gson.toJson(empList);
		// 한번에 간단하게 할 수 있음
		// gson.toJson(empList);은 자바 객체 또는 Collection을 JSON 형태의 문자열로 바꿔주는것이다.
		
		// 자바객체를 JSON(자바스크립트에서 사용되어지는 객체표기법)형태의 문자열로 변경해주는 것인데 
		// 키값은 자바객체의 필드(속성,어트리뷰트)명이 키값이 되어지고, value값은 자바객체의 필드(속성,어트리뷰트)에 입력된 값이다. 

		System.out.println("---- 2. 확인용 json -> " + json);
		// ---- 2. 확인용 json -> [{"ename":"곽대표","jik":"사장","tel":"010-1234-5678","email":"super@naver.com","age":0}]
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/ajaxstudy/jsontest/jsonview.jsp");
		
		
		
		
	}

}
