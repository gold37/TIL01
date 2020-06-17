package member.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을때만 조회가 가능하도록 한다. ==
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null) {
			
			String message = "먼저 로그인 해야 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		else {
			String userid = loginuser.getUserid();
			
			if(!"admin".equals(userid)) {
				String message = "관리자만 접근이 가능합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
			}
		}
		
		InterMemberDAO memberdao = new MemberDAO();
		
		
		// *** 페이징처리를 안한 관리자를 제외한 전체회원 목록 보여주기 *** // 
	//	List<MemberVO> memberList = memberdao.selectAllMember();
		
		// *** 페이징처리를 한 관리자를 제외한 전체회원 목록 보여주기 *** // 
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		String sizePerPage = request.getParameter("sizePerPage");
		// "10" or "5" or "3" or null
		
		
		if(currentShowPageNo == null)
			currentShowPageNo = "1";
		
		if( sizePerPage == null || 
				!("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) )
			// sizePerPage가 없든지, 3/5/10이 아닌것은 
			sizePerPage = "10"; // 무조건 10 주겠다.
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		
		////////////////////////////////////////////////////////////////////////////////
		
		// *** 검색대상 및 검색어를 가져온다. *** //
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
	//	System.out.println("🔎🔎🔎🔎🔎🔎🔎🔎🔎🔎🔎🔎🔎");
	//	System.out.println("확인용 searchType : "+searchType);
	//	System.out.println("확인용 searchWord : "+searchWord);
	
		if( searchWord != null && !searchWord.trim().isEmpty() ) {
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
		}
		
		
		////////////////////////////////////////////////////////////////////////////////
		
		List<MemberVO> memberList = memberdao.selectPagingMember(paraMap);
		
		request.setAttribute("memberList", memberList);
		request.setAttribute("sizePerPage", sizePerPage); // 받은 값 그대로 되돌려 줌
		
		// *** 페이지바 만들기 *** //
		
		/*
		   1개블럭당 10개씩 잘라서 페이지 만든다.
		   1개 페이지당 3개행 또는 5개행 또는 10개행을 보여주는데
		      만약에 1개 페이지당 5개행을 보여준다라면
		      몇개블럭이 나와야 할까?
		   207(총 회원수)/5(1개 페이지당 보여줄 회원수) = 41.4 ==> 42(totalPage)
		    
		   1블럭                 1 2 3 4 5 6 7 8 9 10 [다음] 
		   2블럭     [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
		   3블럭     [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
		   4블럭     [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
		   5블럭     [이전] 41 42 
		 */
		
		// 페이징처리를 위한 전체회원에 대한 총페이지갯수 알아오기(select)
		int totalPage = memberdao.getTotalPage(paraMap);
		
		
		//=== !!! 페이징처리 공식 !!! ===//
		/*
        1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
        11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
        21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
        
        currentShowPageNo         pageNo
        ---------------------------------
             1                      1 = ((1 - 1)/10) * 10 + 1
             2                      1 = ((2 - 1)/10) * 10 + 1
             3                      1 = ((3 - 1)/10) * 10 + 1
             4                      1
             5                      1
             6                      1
             7                      1 
             8                      1
             9                      1
             10                     1 = ((10 - 1)/10) * 10 + 1
            
             11                    11 = ((11 - 1)/10) * 10 + 1
             12                    11 = ((12 - 1)/10) * 10 + 1
             13                    11 = ((13 - 1)/10) * 10 + 1
             14                    11
             15                    11
             16                    11
             17                    11
             18                    11 
             19                    11 
             20                    11 = ((20 - 1)/10) * 10 + 1
             
             21                    21 = ((21 - 1)/10) * 10 + 1
             22                    21 = ((22 - 1)/10) * 10 + 1
             23                    21 = ((23 - 1)/10) * 10 + 1
             ..                    ..
             29                    21
             30                    21 = ((30 - 1)/10) * 10 + 1
		 */
		
		int pageNo = 1; // pageNo는 페이지바에서 보여지는 첫번째 페이지 번호를 의미
		
		int blockSize = 10; // 한 페이지당 보여지는 페이지 번호의 갯수, 10개씩 잘라서 보여줌
		
		int loop = 1; // 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(지금은 10개)까지만 증가하는 용도 
		
		// !!! pageNo를 구하는 공식 !!! //
		pageNo = ( (Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		
		/*
		 	currentShowPageNo => 3 		pageNo => ( (3-1)/10)*10 + 1) ==> 1
		 											정수/정수 = 몫
		 	currentShowPageNo => 7
		 	currentShowPageNo => 10
		 	
		 	같은 패밀리이기때문에 pageNo는 모두 1이 나옴
		 	
		 	currentShowPageNo => 13
		 	currentShowPageNo => 17
		 	currentShowPageNo => 20
		 	
		 	같은 패밀리이기때문에 pageNo는 모두 11이 나옴
		 	
		 */
		
		String pageBar = "";
		
		// *** ◀이전 만들기 *** //
        if( pageNo != 1 ) {
        	pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>◀이전</a>&nbsp;";
        }
        
		while( !(loop > blockSize || pageNo > totalPage  ) ) { 
			// 탈출 조건. 매번 1씩 증가하다가 블럭 사이즈보다 커지거나, 페이지바가 총페이지수보다 커졌을때  탈출
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				  pageBar += "&nbsp;<span style='color: red; border: solid 1px grey; padding: 2px 4px'>" + pageNo + "</span>&nbsp;";			  
			} 
			else {			  
				  pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
			  }
			
			pageNo++; // 1 2 3 4 5 .. 40 41 42 ... 계속 증가
			loop++;
			
		}
		
		// *** ▶다음 만들기 *** //
		if( !(pageNo > totalPage) ) { // 맨 마지막이 아닐때만 다음을 붙여라
			pageBar += "&nbsp;<a href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>▶다음</a>&nbsp;";
		}
		
		request.setAttribute("pageBar", pageBar);
		
		request.setAttribute("searchType", searchType); // 받은걸 그대로 다시 넘겨줌
		request.setAttribute("searchWord", searchWord); // 받은걸 그대로 다시 넘겨줌
		
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/memberList.jsp");
	}

}
