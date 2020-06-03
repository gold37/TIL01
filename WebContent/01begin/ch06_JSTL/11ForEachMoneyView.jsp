<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- fmt는 형변환 할 때 있어야하는 taglib --> 

<%--
     fmt 태그는 Formatting 태그로 포맷에 관련된 태그입니다.
         참조사이트  https://sinna94.tistory.com/11
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정수로 된 데이터를 세자리 마다 콤마 찍어서 나타내기</title>
</head>
<body>
		
	<h2>정수로 된 데이터를 세자리 마다 콤마 찍어서 나타내기 (JSTL을 사용한 것)</h2>
	
	<c:set var="sum" value="0" /> 
	<!-- sum 변수는 숫자로 인식. value에는 문자든 숫자든 "쌍따옴표" 꼭 써줘야함 --> 
	<c:if test="${ not empty priceArr }">
		<ul>
			<c:forEach var="price" items="${priceArr}">
				<li>${price}</li>
				<c:set var="sum" value="${ sum + price }"></c:set>
				<!-- 자동 형변환. 문자열 결합이 아니라 숫자 결합 ▲ -->
			</c:forEach>
		</ul>
		priceArr 누적 합계 : ${sum}
	</c:if>	
	
	<br/><br/>
	
	<c:set var="sum" value="0" /> 
	<!-- sum 변수는 숫자로 인식. value에는 문자든 숫자든 "쌍따옴표" 꼭 써줘야함 --> 
	<c:if test="${ not empty priceArr }">
		<ul>
			<c:forEach var="price" items="${priceArr}">
				<li><fmt:formatNumber value="${price}" pattern="#,###" /> </li>
								<!-- 세자리마다 콤마찍는 형식으로 나타내겠다. ▲ -->
				<c:set var="sum" value="${ sum + price }"></c:set>
			</c:forEach>
		</ul>
		priceArr 누적 합계 : <fmt:formatNumber value="${sum}" pattern="#,###"/>
	</c:if>	
	
</body>
</html>