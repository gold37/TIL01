<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 명단 출력하기</title>
</head>
<body>

	<h2>회원명단</h2>
	<c:if test="${ not empty members }">
		<ol>
			<c:forTokens var="name" items="${members}" delims=",">
			<%-- ${members}는 하나의 문자열인데 구분자(,)를 사용하여 
				 하나하나씩 잘라서 배열로 나타냄 --%>
				<li>${name}</li>
			</c:forTokens>
		</ol>
	</c:if>

	<hr style="border: solid 1px red;" />

	<h2>친구명단</h2>
	<c:if test="${ not empty members }">
		<ol>
			<c:forTokens var="friend" items="${friends}" delims=",./">
			<%-- ${members}는 하나의 문자열인데 구분자를 , 또는 . 또는 / 를 사용하여 
				 하나하나씩 잘라서 배열로 나타냄 --%>
				<li>${friend}</li>
			</c:forTokens>
		</ol>
	</c:if>
	
</body>
</html>