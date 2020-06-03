<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- ==== JSTL(JSP Standard Tag Library) 사용하기 ==== --%>     
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 명단 출력하기(JSTL을 사용한 것)</title>
</head>
<body>
	<h2>회원 명단 출력하기(JSTL을 사용한 것)</h2>
	
	<c:if test="${ nameArr1 != null && fn:length(nameArr1) > 0 }">
		<ol>
			<c:forEach var="fruit" items="${nameArr1}"> 
			<!-- begin 과 end 는 반복 횟수를 알고 있을 때, 모를 땐 items -->
				<li>${fruit}</li>
			</c:forEach>
		</ol>
	</c:if>
	
	<br/>
	또는
	<br/>
	
	<c:if test="${ !empty nameArr1 }">
		<ol>
			<c:forEach var="fruit" items="${nameArr1}"> 
				<li>${fruit}</li>
			</c:forEach>
		</ol>
	</c:if>

	<br/>
	또는
	<br/>
	
	<c:if test="${ not empty nameArr1 }">
		<ol>
			<c:forEach var="fruit" items="${nameArr1}"> 
				<li>${fruit}</li>
			</c:forEach>
		</ol>
	</c:if>

	<hr style="border: solid 1px navy;" />
	
	<c:if test="${ requestScope.nameArr2 != null && fn:length(nameArr2) == 0 }"> 
			   <!-- requestScope는 생략 가능 -->
		nameArr2에는 등록된 회원이 없습니다. <br/>
	</c:if>
	
	<br/>
	또는
	<br/>
	
	<c:if test="${ empty nameArr2 }">  
	<!-- nameArr2가 null 이거나 null은 아니지만 등록된 데이터가 없으면 true --> 
		nameArr2에는 등록된 회원이 없습니다. <br/>
	</c:if>
	
	<hr style="border: solid 1px navy;" />
	
	<c:if test="${ nameArr3 == null }"> 
		nameArr3에는 등록된 회원이 없습니다. <br/>
	</c:if>
	
	<br/>
	또는
	<br/>
	
	<c:if test="${ empty nameArr3 }">  
	<!-- nameArr2가 null 이거나 null은 아니지만 등록된 데이터가 없으면 true --> 
		nameArr3에는 등록된 회원이 없습니다. <br/>
	</c:if>
	
	
	
</body>
</html>