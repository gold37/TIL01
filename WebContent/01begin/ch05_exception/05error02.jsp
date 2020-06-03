<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
    
<!-- isErrorPage는 에러 페이지 입니까? 아니면 false 맞으면 true. 기본 값은 false -->   

<%--
	페이지 directive(지시어)에서  isErrorPage="true"의 의미는
	이 페이지는 일반적인 JSP 페이지가 아니라 오류가 발생했을 때 보여주는 페이지임을 나타내는 것이다.
 --%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Exception 페이지 내용 만들기</title>
</head>
<body>
	<h1>05error02.jsp 페이지 내용</h1>
	<h2>JSP 페이지 directive(지시어)에서 errorPage 속성과 isErrorPage 속성을 이용한 에러페이지 출력</h2>
	<br/>
	입력한 데이터에 오류가 있습니다. <br/><br/>
	에러메시지 : <%= exception.getMessage() %>
	<!--	     ▲ 에러페이지 지시어 안써주면 빨간 줄 뜸 -->
	<%-- 
		페이지 directive(지시어)에서 isErrorPage="true"라고 선언했을때만
		내장객체 Exception을 사용할 수 있다.
	 --%>
</body>
</html>