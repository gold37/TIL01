<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

	<h2>::: ${cname} 목록 :::</h2>
	<br/>
	
	<%-- 특정 카테고리에 대한 상품을 모두 가져와서 디스플레이 (페이징 처리 안 한것) --%>
	<table style="width: 90%; border: solid 0px gray;">
				
		<tbody>
			<c:if test="${empty productList}">
			   <tr>
			   	  <td colspan="4" class="td" align="center">현재 상품 준비중...</td>
			   </tr>			
			</c:if>
			
			<c:if test="${not empty productList}">
				<tr>
				    <c:forEach var="pvo" items="${productList}" varStatus="status">
				    <!-- status.index 는 0 부터 시작해서 1씩 증가한다.
				         status.count 는 1 부터 시작해서 1씩 증가한다. -->
				       <td class="td" align="center" width="25%" style="padding: 20px 0;">
						   <a href='/MyMVC/shop/prodView.up?pnum=${pvo.pnum}'><img width="120px;" height="130px;" src="/MyMVC/images/${pvo.pimage1}" /></a>
						   <!-- 제품 누르면 상세페이지 갈 수 있도록	 ▲ 제품 번호를 넘겨줌 -->
				       	   <br/>제품명: ${pvo.pname}
				       	   <br/>정가: <span style="text-decoration: line-through;"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</span>        
				       	   <br/><span style="color: red; font-weight: bold;">판매가: <fmt:formatNumber value="${pvo.saleprice}" pattern="###,###" />원</span> 
				       	   <br/><span style="color: blue; font-weight: bold;">할인율: [${pvo.discountPercent}%]할인</span>
				       	   <br/><span style="color: orange;">포인트: ${pvo.point}&nbsp;POINT</span>
				      <%-- <br/>${status.count} --%>
				       </td>
				       <c:if test="${ (status.count)%4 == 0 }">
				       </tr>
				       <tr>
				       </c:if>
				    </c:forEach>
				</tr>
			</c:if>
		</tbody>
	</table>

<jsp:include page="../footer.jsp" />
