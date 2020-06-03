<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form 태그를 사용해 useBean으로 데이터 전송한 결과 보기</title>
</head>
<body>
	<!-- ☆★☆★ 중요하니까 암기하기 ☆★☆★ -->
	
	<jsp:useBean id="user" class="begin.ch04_StandardAction.UserDTO"></jsp:useBean>
	<!-- 기본생성자로 객체를 만들어 옴 -->
	<%-- 	
	<jsp:setProperty property="userid" name="user" value="${param.userid}"/>
	<jsp:setProperty property="passwd" name="user" value="${param.passwd}"/>
	<jsp:setProperty property="name" name="user" value="${param.name}"/>
	<jsp:setProperty property="email" name="user" value="${param.email}"/>
	<jsp:setProperty property="tel" name="user" value="${param.tel}"/>
	<jsp:setProperty property="jubun1" name="user" value="${param.jubun1}"/>
	<jsp:setProperty property="jubun2" name="user" value="${param.jubun2}"/>
	<jsp:setProperty property="school" name="user" value="${param.school}"/>
	
	<jsp:setProperty property="interest" name="user" value="${paramValues.interest}"/>
	 --%>
	<jsp:setProperty property="*" name="user"/> 
	 
	<h2>회원가입 정보 결과(JSP 표준액션 중 useBean을 사용한 것)</h2>
	
	<ul>
		<li>아이디 : <jsp:getProperty property="userid" name="user"/></li>
		<li>암호 : <jsp:getProperty property="passwd" name="user"/></li>
		<li>성명 : <jsp:getProperty property="name" name="user"/></li>
		<li>이메일 : <jsp:getProperty property="email" name="user"/></li>
		<li>전화번호 : <jsp:getProperty property="tel" name="user"/></li>
		<li>주민번호 : <jsp:getProperty property="jubun" name="user"/></li>
		<li>학력 : <jsp:getProperty property="school" name="user"/></li>
		<li>관심분야 : <jsp:getProperty property="interestStr" name="user"/></li>
		<li>성별 : <jsp:getProperty property="gender" name="user"/></li>
		<li>현재나이 : <jsp:getProperty property="age" name="user"/></li>
	</ul>
	
</body>
</html>