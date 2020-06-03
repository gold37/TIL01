<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String num1 = request.getParameter("num1");
	String num2 = request.getParameter("num2");
	
	int nNum1 = Integer.parseInt(num1);
	int nNum2 = Integer.parseInt(num2);

	/*
		NumberFormatException 처리는 
		배치서술자인 web.xml에서 처리 하도록 한다.
	*/
	int sum = nNum1 + nNum2;
%>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06webXml.jsp 페이지 입니다.</title>
</head>
<body>
	<%= nNum1 %> + <%= nNum2 %> = <%= sum %> 입니다.
</body>
</html>