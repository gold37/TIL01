package myshop.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;

public class MallDisplayJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		String pspec = request.getParameter("pspec");
		String start = request.getParameter("start");
		String len = request.getParameter("len");
		
	/*
       	맨 처음에는 pspec("HIT")상품을  start("1") 부터 len("8")개를 보여준다.
       	더보기 버튼을 클릭하면  pspec("HIT")상품을  start("9") 부터 len("8")개를 보여준다.
       	또  더보기 버튼을 클릭하면  pspec("HIT")상품을  start("17") 부터 len("8")개를 보여준다.      
	*/
	
		InterProductDAO pdao = new ProductDAO();

		HashMap<String, String> paraMap = new HashMap<>();
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(len) - 1);
		
		paraMap.put("pspec", pspec);
		paraMap.put("startRno", start);  // startRno 1	9 	17	25
		paraMap.put("endRno", end);	 	 // endRno 	 8	16	24	32
		
		List<ProductVO> productList = pdao.selectByPspec(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // [] 
		
		if(productList.size() > 0) {
			for(ProductVO pvo : productList) {
				JSONObject jsobj = new JSONObject();
				
				jsobj.put("pnum", pvo.getPnum());
				jsobj.put("pname", pvo.getPname());
				jsobj.put("pcategory_fk", pvo.getPcategory_fk());
				jsobj.put("pcompany", pvo.getPcompany());
				jsobj.put("pimage1", pvo.getPimage1());
				jsobj.put("pimage2", pvo.getPimage2());
				jsobj.put("pqty", pvo.getPqty());
				jsobj.put("price", pvo.getPrice());
				jsobj.put("saleprice", pvo.getSaleprice());
				jsobj.put("pspec", pvo.getPspec());
				jsobj.put("pcontent", pvo.getPcontent());
				jsobj.put("point", pvo.getPoint());
				jsobj.put("pinputdate", pvo.getPinputdate());
				jsobj.put("discoutPercent", pvo.getDiscountPercent());

				jsonArr.put(jsobj);
				
			} // end of for ---------------------------------
		}
		
		String json = jsonArr.toString();
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
