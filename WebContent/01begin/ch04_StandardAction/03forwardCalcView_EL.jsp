<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String firstNum = request.getParameter("firstNum");
	String secondNum = request.getParameter("secondNum");
	
	int sum = (Integer)request.getAttribute("sum"); // auto Unboxing;
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계산된 결과값 보여주는 곳</title>
</head>
<body>
	<h3>계산된 결과 값(EL을 사용한 것)</h3>
	<br/><br/>
	${requestScope.firstNum}부터 ${requestScope.secondNum}까지의 합은?<br/> 
	<!-- 리퀘스트 영역.키값 -->
	결과값 : <span style="color: red;">${requestScope.sum}</span>
	<br/><br/>
	${firstNum}부터 ${secondNum}까지의 합은?<br/> 
	<!-- 리퀘스트 영역 생략 가능 -->
	결과값 : <span style="color: blue;">${sum}</span>
	<br/><br/>
	${firstNum+1}부터 ${secondNum+1}까지의 합은?<br/>
	<!-- 단순히 결과물만 찍어주는게 아니라 +1같은 연산도 가능 --> 
	결과값 : <span style="color: green;">${sum}</span>
</body>
</html>