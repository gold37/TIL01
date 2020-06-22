package myshop.controller;

import javax.servlet.http.*;

import common.controller.AbstractController;
import member.model.MemberVO;
import my.util.MyUtil;
import myshop.model.*;

public class CommentRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String commentContents = request.getParameter("commentContents");
		commentContents = MyUtil.replaceParameter(commentContents); // 스크립트 공격을 피하기 위해 바꿈
		
		String pnum = request.getParameter("pnum");
		
		HttpSession ssession = request.getSession();
		MemberVO loginuser = (MemberVO)ssession.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		PurchaseReviewsVO prvo = new PurchaseReviewsVO();
		prvo.setFk_userid(userid);
		prvo.setFk_pnum(Integer.parseInt(pnum));
		prvo.setReviewsContents(commentContents.replaceAll("\r\n", "<br/>"));
		
		InterProductDAO pdao = new ProductDAO();
		pdao.addComment(prvo);
	
	}

}
