<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String members = "토마토,참외,바나나,체리,수박";
	request.setAttribute("members", members);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("08ForEach3View.jsp");
	dispatcher.forward(request, response);
%>