package ajaxstudy.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;


//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
import ajaxstudy.model.AjaxDAO;
import ajaxstudy.model.InterAjaxDAO;
import common.controller.AbstractController;

public class JSONtestImageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterAjaxDAO dao = new AjaxDAO();
		
		List<HashMap<String, String>> imgList = dao.imgList();
		
		// DB에서 얻어온 결과물을 JSON 형식의 문자열로 바꿔주는 .jar 파일을 다운받으러 간다.
		// https://mvnrepository.com에 가서 json 검색
		
		
		// *** DB에서 얻어온 결과물인 imgList을 JSON 형식의 문자열로 바꾸는 작업을 한다. *** //
		
		
		
		/*
		
		// ---------  org.json.simple.* 을 사용한것  --------- //
		
		JSONArray jsonArr = new JSONArray(); // simple을 import함
		
		for(HashMap<String, String> map : imgList) {
			JSONObject jsobj = new JSONObject(); // simple을 import함
			jsobj.put("IMGNO", map.get("IMGNO"));
			jsobj.put("IMGFILENAME", map.get("IMGFILENAME"));
		
			jsonArr.add(jsobj); // simple은 add해줌
			
		}
		
		String json = jsonArr.toString();
		request.setAttribute("result", json);
		
		
		*/
		
		
		
		// ---------  org.json.* 을 사용한것  --------- //
		
		JSONArray jsonArr = new JSONArray(); 
		
		for(HashMap<String, String> map : imgList) {
			JSONObject jsobj = new JSONObject(); 
			jsobj.put("IMGNO", map.get("IMGNO"));
			jsobj.put("IMGFILENAME", map.get("IMGFILENAME"));
		
			jsonArr.put(jsobj); // 여기는 위에랑 다르게 add 아니고 put!!
			
		}
		
		String json = jsonArr.toString();
		request.setAttribute("json", json);
		
		
	//	super.setRedirected(false);
		super.setViewPage("/WEB-INF/ajaxstudy/jsontest/jsonview.jsp");
	}
	
}