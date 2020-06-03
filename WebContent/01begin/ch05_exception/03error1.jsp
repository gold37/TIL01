<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String num1 = request.getParameter("num1");
	String num2 = request.getParameter("num2");
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NumberFormatException 페이지 내용 만들기</title>
</head>
<body>
	<h1>03error1.jsp 페이지의 내용</h1>
	<h2>try ~ catch ==> RequestDispatcher 를 이용한 에러페이지 출력</h2> 
	<br/>
	입력한 데이터는 숫자가 아닌 값을 입력하셨습니다.<br/><br/>
	첫번째 수 : <%= num1%><br/>
	두번째 수 : <%= num2%><br/>
</body>
</html>