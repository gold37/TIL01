<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- === JSTL(JSP Standard Tag Library) 사용하기 --%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	첫번째 문자열 : ${param.first} <br/>
	두번째 문자열 : ${param.second} <br/>
	<br/>
	
	<c:if test="${param.first == param.second}">
		${param.first} 와 ${param.second}은 같습니다.
	</c:if>
	
	<!-- else가 없기 때문에 한번 더 적어줘야됨 -->	
	<c:if test="${param.first != param.second}">
		${param.first} 와 ${param.second}은 같지않습니다.
	</c:if>
	
	<br/>
	
	<hr style="border: solid 1px orange;" />
	
	<c:if test="${param.first eq param.second}">
		${param.first} 와 ${param.second}은 같습니다.
	</c:if>
	
	<!-- else가 없기 때문에 한번 더 적어줘야됨 -->	
	<c:if test="${param.first ne param.second}">
		${param.first} 와 ${param.second}은 같지않습니다.
	</c:if>
	
	<br/>
	<hr style="border: solid 1px orange;" />
	
	<c:set var="name" value="태연" />
	<c:if test="${!empty name }">
	<!-- name 변수가 비어있지 않다. 값이 들어있다. -->
		변수 name에는 정보가 들어있습니다.
	</c:if>
	<c:if test="${empty name }">
		변수 name에는 정보가 들어있지 않습니다.
	</c:if>
	
	<br/>
	
	<c:set var="address" value="" />
	<c:if test="${ not empty address }">
	<!-- address 변수가 비어있지 않다. 값이 들어있다. -->
		변수 address에는 정보가 들어있습니다.
	</c:if>
	<c:if test="${empty address }">
		변수 address에는 정보가 들어있지 않습니다.
	</c:if>

</body>
</html>