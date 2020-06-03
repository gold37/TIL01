<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 표준액션 중 include에 대해서 알아보자 (실행은 여기 Test에서)</title>
</head>
<body>
	<h3>책 소개</h3>
	도서명 : 삼국지 <br/>
	저자 : 정해인 <br/>
	페이지 : 300페이지 <br/>
	<div>
		<jsp:include page="01includeContent.jsp" />
	</div>
	가격 : 20,000원 <br/>
</body>
</html>