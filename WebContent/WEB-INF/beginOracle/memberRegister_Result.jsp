<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	// ctxPath  => /MyMVC/myInfoView.do 주소로 URL페이지를 이동하겠다는 의미
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 결과 페이지</title>

<style type="text/css">

	span#name {
		color: blue;
		font-size: 14pt; 
	}
	
</style>

<script type="text/javascript">
	
	
	function goMyinfo(userid) {
		location.href = "/MyMVC/myInfoView.do?userid="+userid+"";
		/* ?를 중심으로 왼쪽은 URL주소, 오른쪽은 보내야 할 데이터가 들어간다. */
		// /MyMVC/myInfoView.do?userid=Superman 주소로 URL페이지를 이동하겠다는 의미
	}


</script>


</head>
<body>
	<h2>회원가입 결과</h2>
	<c:if test="${requestScope.result == 'success'}">
		<span id="name">${requestScope.name}</span>님! 회원가입이 정상적으로 처리되었습니다.
		<br/><br/>
		<button onclick="goMyinfo('${userid}')">내 정보 조회1</button>
		<!-- 자신의 아이디를 가지고 넘어감 -->
		&nbsp;&nbsp;
		<button onclick="javascript:location.href='<%= ctxPath%>/myInfoView.do?userid=${userid}'">내 정보 조회2</button>		
	</c:if>
	
	<c:if test="${result == 'fail'}">
		회원가입에 실패하셨습니다.
	</c:if>
	
</body>
</html>