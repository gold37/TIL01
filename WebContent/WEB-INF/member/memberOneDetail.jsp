<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<style type="text/css">
	div#mvoInfo {
		width: 60%; 
		text-align: left;
		border: solid 0px red;
		margin-top: 30px; 
		font-size: 13pt;
		line-height: 200%;
	}
	
	span.myli {
		display: inline-block;
		width: 90px;
		border: solid 0px blue;
	}
</style>
	
 <c:if test="${empty mvo}">
 	존재하지 않는 회원입니다.<br/>
 </c:if>	
	
 <c:if test="${not empty mvo}">	
	 <h3>::: ${mvo.name}님의 회원 상세정보 :::</h3>
	 <div id="mvoInfo">
	 <ol>	
		 <li><span class="myli">회원번호 : </span>${mvo.idx}</li>
		 <li><span class="myli">아이디 : </span>${mvo.userid}</li>
		 <li><span class="myli">회원명 : </span>${mvo.name}</li>
		 <li><span class="myli">이메일 : </span>${mvo.email}</li>
		 <li><span class="myli">휴대폰 : </span>${mvo.hp1}-${mvo.hp2}-${mvo.hp3}</li>
		 <li><span class="myli">우편번호 : </span>${mvo.postcode}</li>
		 <li><span class="myli">주소 : </span>${mvo.address}&nbsp;${mvo.detailAddress}&nbsp;${mvo.extraAddress}</li>
		 <li><span class="myli">성별 : </span>${mvo.gender}</li>
		 <li><span class="myli">생년월일 : </span>${mvo.birthyyyy}.${mvo.birthmm}.${mvo.birthdd}</li>
		 <li><span class="myli">나이 : </span>${mvo.age}세</li> 
		 <li><span class="myli">코인액 : </span><fmt:formatNumber value="${mvo.coin}" pattern="###,###" /> 원</li>
		 									<!-- 코인액 보여주기위해 fmt 사용 -->
		 <li><span class="myli">포인트 : </span><fmt:formatNumber value="${mvo.point}" pattern="###,###" /> POINT</li>
		 <li><span class="myli">가입일자 : </span>${mvo.registerday}</li>
	  </ol>
	  </div>
  </c:if>
  
  <button style="margin-top: 20px;" type="button" onclick="javascript:history.back();">회원목록</button>
    
<jsp:include page="../footer.jsp" /> 
   