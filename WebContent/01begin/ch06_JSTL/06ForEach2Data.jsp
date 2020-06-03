<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[] nameArr1 = {"토마토", "참외", "바나나", "체리", "수박"};
	request.setAttribute("nameArr1", nameArr1);

	String[] nameArr2 = {};
	request.setAttribute("nameArr2", nameArr2);
	
	String[] nameArr3 = null;
	request.setAttribute("nameArr3", nameArr3);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("06ForEach2View.jsp");
	dispatcher.forward(request, response);
%>