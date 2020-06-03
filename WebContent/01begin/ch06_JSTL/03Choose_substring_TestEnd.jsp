<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       
<%-- === JSTL(JSP Standard Tag Library) 사용하기 --%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="jubun" value="${param.jubun}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주민번호를 입력받아서 1,3(남자)/2,4(여자)로 나타내기</title>
</head>
<body>
	주민번호 : ${jubun} <br/>
	주민번호 문자열 길이 : ${ fn:length(jubun) } <br/>
	성별 : ${ fn:substring(jubun,6,7) } <br/><br/>  
	
	<c:choose>
		<c:when test="${ fn:substring(jubun,6,7) eq '1'}">
			남자입니다. <br/>
		</c:when>
	
		<c:when test="${ fn:substring(jubun,6,7) eq '3'}">
			남자입니다. <br/>
		</c:when>
		
		
		<c:otherwise> <!-- else 와 같은 의미 -->
			여자입니다. <br/>
		</c:otherwise>
		
		
	</c:choose>
</body>
</html>