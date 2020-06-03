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
<title>문자열로 된 숫자를 누적한 결과값(자동 형변환) 나타내기</title>
</head>
<body>
	
	<h2>문자열로 된 숫자를 누적한 결과값(자동 형변환) 나타내기(JSTL을 사용한것)</h2>
	
	<c:set var="sum" value="0" /> 
	<!-- sum 변수는 숫자로 인식. value에는 문자든 숫자든 "쌍따옴표" 꼭 써줘야함 --> 
	<c:if test="${ not empty pointArr1 }">
		<ul>
			<c:forEach var="point" items="${pointArr1}">
				<li>${point}</li>
				<c:set var="sum" value="${ sum + point }"></c:set>
				<!-- 자동 형변환. 문자열 결합이 아니라 숫자 결합 ▲ -->
			</c:forEach>
		</ul>
		pointArr1 누적 합계 : ${sum}
	</c:if>	
	
	
	<br/>
	<hr style="border:solid 1px red;" />
	<br/>

	<h2>문자열로 된 숫자를 (정수로 형변환) 하여 누적한 결과값 나타내기 (JSTL을 사용한것)</h2>
	
	<c:set var="sum" value="0" /> 
	<c:if test="${ not empty pointArr1 }">
		<ul style="list-style-type: circle;">
			<c:forEach var="point" items="${pointArr1}">
				<li>
					<fmt:parseNumber var="pointInt" value="${point}" integerOnly="true" />
					<%-- fmt:parseNumber은 문자열을 숫자형식으로 형변환 시키는 것 
						 integerOnly는 true면 정수, false면 실수 
						  정수만 취해온 값을 변수 pointInt에 넣어줌  --%>
					 ${pointInt}
				</li>
				<c:set var="sum" value="${ sum + pointInt }"></c:set>
				<!-- 자동 형변환. 문자열 결합이 아니라 숫자 결합 ▲ -->
			</c:forEach>
		</ul>
		pointArr1의 정수만 취해온 누적 합계 : ${sum}
	</c:if>	

	
	<br/>
	<hr style="border:solid 1px red;" />
	<br/>
	
	<h2>forEach를 사용하면서 index번호 나타내기</h2>
	
	<c:if test="${ not empty pointArr1 }">	
		<ul>
			<c:forEach var="point" items="${pointArr1}" varStatus="status">
				<li>${point}&nbsp;(인덱스번호 &nbsp; ${status.index})</li>
				<%-- ${status.index}는 0부터 시작한다. --%>
			</c:forEach>
		</ul>
	</c:if>

	
	<br/>
	<hr style="border:solid 1px red;" />
	<br/>
	
	<h2>forEach를 사용하면서 순서번호 나타내기</h2>
	
	<c:if test="${ not empty pointArr1 }">	
		<ul>
			<c:forEach var="point" items="${pointArr1}" varStatus="status">
				<li>${point}&nbsp;(순서번호 &nbsp; ${status.count})</li>
				<%-- ${status.count}는 1부터 시작한다. --%>
			</c:forEach>
		</ul>
	</c:if>
	
</body>
</html>