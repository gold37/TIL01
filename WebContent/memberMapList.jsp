<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>memberVOList.jsp</title>

<style type="text/css">

	table {border: 1px solid gray; border-collapse: collapse;}
	
	th,td {border: 1px solid gray; padding: 5px 10px 5px 10px;}

</style>

</head>

<body>

	<h2>회원정보</h2>
	
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>성명</th>
				<th>나이</th>
				<th>성별</th>
			</tr>
	</thead>
	
	
	<tbody>

	<c:if test="${not empty memberMapList}">
	
		<c:forEach var="map" items="${memberMapList}" varStatus="status">
		
			<tr>
			
				<td>${status.count}</td>
				<td>${map.USERID}</td>
				<td>${map.USERNAME}</td>
				<td>${map.AGE}</td>
				<td>${map.GENDER}</td>
			
			</tr>
			
		</c:forEach>
	
	</c:if>
	
	<c:if test="${empty memberMapList}">
		
		<tr>
		<td colspan="5">가입된 회원이 없습니다.</td>
		</tr>
		
	</c:if>

	</tbody>
</table>
</body>
</html>