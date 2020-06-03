<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === JSTL(JSP Standard Tag Library) 사용하기 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<!--       ▲ c는 커스텀 액션 -->	

<%-- === 변수의 선언방법 === --%>
<c:set var="no1" value="${param.num1}"/>
<!-- form 에서 넘어온 num1 값을 읽고 no1에 저장하자 -->
<c:set var="no2" value="${param.num2}"/>
<c:set var="result" value="${no1 * no2}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>두개의 수를 입력받아서 곱셈한 결과 출력하기</title>
</head>
<body>
	${no1} 와 ${no2}의 곱은 ? ${result}입니다. <br/>
	${param.num1} 와 ${param.num2}의 곱은 ? ${result}입니다.
</body>
</html>