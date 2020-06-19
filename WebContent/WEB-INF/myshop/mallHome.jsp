<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<jsp:include page="../header.jsp" />

	<h2>::: 쇼핑몰 상품 :::</h2>
	<br/>

	<%-- HIT 상품을 모두 가져와 디스플레이한다. (페이징처리 안한것) --%>
	
	<table style="width: 90%; border: solid 1px gray;">
		<thead>
			<tr>
			</tr>			
		</thead>
		
		<tbody>
			<c:if test="${empty hitList}">
				<tr>
					<td colspan="4">현재 상품 준비중 ...</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty hitList}">
				<!-- status.index는 0부터 시작해서 1씩 증가한다. 
					 status.count는 1부터 시작해서 1씩 증가한다. -->
				<tr>
					<c:forEach var="pvo" items="${hitList}" varStatus="status">
					<!-- pvo가 hitList에서 한 행을 select해옴 -->
						<td>
							<img src="/MyMVC/images/${pvo.pimage1}" width="120px;" height="130px;" />
							<!-- 상품1의 이미지를 읽어 옴 -->
							<br/>제품명: ${pvo.pname}
							<br/>정가: <span style="text-decoration: line-through;"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원 </span>
							<br/>판매가: <fmt:formatNumber value="${pvo.saleprice}" pattern="###,###" />원
							<br/>할인율: [${pvo.discountPercent}%]할인
							<br/>포인트: ${pvo.point}&nbsp;POINT
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