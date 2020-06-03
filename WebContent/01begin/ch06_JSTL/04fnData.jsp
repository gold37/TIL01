<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>

<%
	List<String> strList = new ArrayList<String>();
	strList.add("아이린");
	strList.add("조이");
	strList.add("웬디");
	strList.add("슬기");
	strList.add("예리");
	
	request.setAttribute("strList", strList); // request 저장소에 저장시킴
	
	String subject = "JSTL(JSP Standard Tag Library)";
	request.setAttribute("subject", subject);
	
	String firstName = "홍";
	String lastName = "          길     동      ";
	String word = "만세";
	request.setAttribute("firstName", firstName);
	request.setAttribute("lastName", lastName);
	request.setAttribute("word", word);
	
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("04fnView.jsp");
	dispatcher.forward(request, response); // forward방식은 url은 안바뀌고 내용물만 바꿔서 보여줌
	
	
%>