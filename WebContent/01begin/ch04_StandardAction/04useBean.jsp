<%@page import="java.lang.reflect.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "begin.ch04_StandardAction.MemberDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 표준액션 중 useBean에 대해서 알아보자</title>

<style type="text/css">

	div {margin: 20px;}

</style>


</head>
<body>
	<div>
		<h2>스크립틀릿을 사용하여 MemberDTO 클래스의 객체정보 불러오기</h2>
		<%
			MemberDTO mbrdto = new MemberDTO("한소희", "9401052123456");
		
			mbrdto.setName("한소희");
			mbrdto.setJubun("9401052123456");
			
			String name = mbrdto.getName();
			String jubun = mbrdto.getJubun();
			String gender = mbrdto.getGender();
			int age = mbrdto.getAge();
		%>
		
		<ul>
			<li>성명 : <%= name %></li>
			<li>주민번호 : <%= jubun %></li>
			<li>성별 : <%= gender %></li>
			<li>나이 : <%= age %>세</li>
		</ul>
		
	</div>
	
	<hr style="border: solid 1px red;" />
	
	<div>
		<h2>JSP 표준액션 중 useBean을 사용하여 MemberDTO 클래스의 객체정보 불러오기</h2>
		<jsp:useBean id="mbrdto2" class="begin.ch04_StandardAction.MemberDTO"></jsp:useBean> <!-- Bean은 class 객체를 뜻함 -->
		<jsp:setProperty property="name" name="mbrdto2" value="황승언"/>
		<!-- 						▲ set 다음에 나오는 이름을 써야하는데 반드시 첫글자는 소문자로 !!! -->
		<jsp:setProperty property="jubun" name="mbrdto2" value="9210112234567"/>
		
		<ul>
			<li>성명 : <jsp:getProperty property="name" name="mbrdto2"/></li>
			<li>주민번호 : <jsp:getProperty property="jubun" name="mbrdto2"/></li>
			<li>성별 : <jsp:getProperty property="gender" name="mbrdto2"/></li>
			<li>나이 : <jsp:getProperty property="age" name="mbrdto2"/></li>
		</ul>
	</div>
</body>
</html>