package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class MemberEditEndAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      // *** POST 방식으로 넘어온 것이 아니라면 *** //
      
      String method = request.getMethod();
      
      if (!"POST".equalsIgnoreCase(method)) {
         String message = "비정상적인 경로를 통해 들어왔습니다.!!";
         String loc = "javascript:history.back()";
         
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);
         
         super.setViewPage("/WEB-INF/msg.jsp");
         return;
      }
      else {
         String idx = request.getParameter("idx");
         String name = request.getParameter("name");
         String pwd = request.getParameter("pwd");
         String email = request.getParameter("email");
         String hp1 = request.getParameter("hp1");
         String hp2 = request.getParameter("hp2");
         String hp3 = request.getParameter("hp3");
         String postcode = request.getParameter("postcode");
         String address = request.getParameter("address");
         String detailAddress = request.getParameter("detailAddress");
         String extraAddress= request.getParameter("extraAddress");
         
         MemberVO membervo = new MemberVO();
         membervo.setIdx(Integer.parseInt(idx));
         membervo.setName(name);
         membervo.setPwd(pwd);
         membervo.setEmail(email);
         membervo.setHp1(hp1);
         membervo.setHp2(hp2);
         membervo.setHp3(hp3);
         membervo.setPostcode(postcode);
         membervo.setAddress(address);
         membervo.setDetailAddress(detailAddress);
         membervo.setExtraAddress(extraAddress);
         
         InterMemberDAO memberdao = new MemberDAO();
         
         int n = memberdao.updateMember(membervo); // update 되면 1 값이 나옴
         
         String message = "";

         
         if(n == 1) {
            message = "회원정보 수정 성공!!";      
            
            // session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경 해 주어야 한다.
            HttpSession session = request.getSession();
            MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
            
            loginuser.setName(name);
            loginuser.setEmail(email);
            loginuser.setHp1(hp1);
            loginuser.setHp2(hp2);
            loginuser.setHp3(hp3);
            loginuser.setPostcode(postcode);
            loginuser.setAddress(address);
            loginuser.setDetailAddress(detailAddress);
            loginuser.setExtraAddress(extraAddress);
            
            session.setAttribute("loginuser", loginuser); // 변경되어진 새로운 유저를 넣는다
            
         }
         else {
            message = "회원정보 수정 실패!!";
         }
         
         String loc = "javascript:history.back()";
         
         request.setAttribute("message", message);
         request.setAttribute("loc", loc);

         super.setRedirect(false);
         super.setViewPage("/WEB-INF/msg.jsp");
         
      }
      
      

   }

}