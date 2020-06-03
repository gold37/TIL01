<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 페이지</title>

<style type="text/css">

	span#name {
		color: red;
		font-size: 14pt; 
	}

</style>
</head>
<body>
	<h2>오류발생</h2>
	발생된 오류메시지 : <span id="error">${requestScope.errMsg}</span>
</body>
</html>