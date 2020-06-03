<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
    
<%--
	페이지 directive(지시어)에서  isErrorPage="true"의 의미는
	이 페이지는 일반적인 JSP 페이지가 아니라 오류가 발생했을 때 보여주는 페이지임을 나타내는 것이다.
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NumberFormatException 페이지 내용 만들기</title>
</head>
<body>
	<h1>07error3.jsp 페이지 내용</h1>
	<h2>배치서술자인 web.xml을 이용한 에러페이지 출력</h2>
	<br/>
	입력한 데이터에 오류가 있습니다. <br/><br/>
	에러메시지 : <%= exception.getMessage() %>
</body>
</html>