<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="05error02.jsp" %>
    
    
<%--
	이 페이지에서 어떠한 Exception이 발생되어지면
	URL 이동 없이 errorPage 속성에 기술한 페이지 (지금은 05error02.jsp 페이지)로 이동하라는 말이다.
--%>
    
<%
	String num1 = request.getParameter("num1");
	String num2 = request.getParameter("num2");
	
	int nNum1 = Integer.parseInt(num1);
	int nNum2 = Integer.parseInt(num2);

	int sum = nNum1 + nNum2;
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04directiveErrorPage.jsp 페이지 입니다.</title>
</head>
<body>
	<%= nNum1 %> + <%= nNum2 %> = <%= sum %>
</body>
</html>