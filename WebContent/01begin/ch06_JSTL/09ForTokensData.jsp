<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String members = "토마토,참외,바나나,체리,수박";
	request.setAttribute("members", members);
	
	String friends = "아이린,조이.웬디,슬기/예리";
	request.setAttribute("friends", friends);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("09ForTokensView.jsp");
	dispatcher.forward(request, response);
%>