package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.PurchaseReviewsVO;

public class CommentListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pnum = request.getParameter("pnum"); // 제품번호
		
		InterProductDAO pdao = new ProductDAO();
		
		JSONArray jsArr = new JSONArray(); // []
		
		List<PurchaseReviewsVO> commentList = pdao.commentList(pnum);
		
		
		if(commentList != null) {
			for(PurchaseReviewsVO prvo : commentList) {
				 JSONObject jsobj = new JSONObject(); // {}
				 jsobj.put("commentContents", prvo.getReviewsContents()); // {"commentContents":"제품후기 내용물"}
				 jsobj.put("name", prvo.getName()); // {"commentContents":"제품후기 내용물", "name":"지원지원"}
				 jsobj.put("writeDate", prvo.getWriteDate()); // {"commentContents":"제품후기 내용물", "name":"지원지원", "writeDate":"작성일자"}
				 
				 jsArr.put(jsobj);
			}
		}
		
		String json = jsArr.toString(); // 문자열 형태로 변환해줌
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonResult.jsp");
		
	}
}
