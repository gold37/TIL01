<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[] nameArr1 = {"토마토", "참외", "바나나", "체리", "수박"};
	request.setAttribute("nameArr1", nameArr1);

	String[] nameArr2 = {}; // nameArr2는 null이 아님
	request.setAttribute("nameArr2", nameArr2);
	
	String[] nameArr3 = null; // nameArr3은 null임
	request.setAttribute("nameArr3", nameArr3);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("07ForEach2View.jsp");
	dispatcher.forward(request, response);
%>