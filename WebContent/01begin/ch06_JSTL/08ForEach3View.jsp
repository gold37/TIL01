<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원명단 출력하기</title>
</head>
<body>
	<h2>회원명단</h2>
	<c:if test="${ not empty members }">
		<c:set var="array" value="${ fn:split(members, ',') }" />
		<!-- , 기준으로 잘라서 array에 저장 -->
		
		<ol>
			<c:forEach var="name" items="${array}">
				<li>${name}</li>
			</c:forEach>
		</ol>
		
	</c:if>
</body>
</html>