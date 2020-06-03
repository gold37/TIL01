<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	Object obj1 = request.getAttribute("nameArr1");	// set을 get으로 불러옴
	Object obj2 = request.getAttribute("nameArr2");	
	Object obj3 = request.getAttribute("nameArr3");	
	
	String[] nameArr1 = null;
	String[] nameArr2 = null;
	String[] nameArr3 = null;
	
	if(obj1 != null) {
		nameArr1 = (String[]) obj1; // string의 배열 타입으로 캐스팅해서 nameArr1에 넣어둬라
	}
	
	
	if(obj2 != null) {
		nameArr2 = (String[]) obj2; 
	}
	
	
	if(obj3 != null) {
		nameArr3 = (String[]) obj3; 
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 명단 출력하기(스크립틀릿을 사용한 것)</title>
</head>
<body>
	<h2>회원 명단 출력하기(스크립틀릿을 사용한 것)</h2>
	
	<%
		if(nameArr1 != null && nameArr1.length > 0) { %> <!-- null도 아니면서, 배열의 길이가 0 이상이면 -->
			<ol>
			<%	for(int i=0; i<nameArr1.length; i++){ %>
				<li><%= nameArr1[i] %></li>				
			<% } %>
			</ol>
	<% 	} 
	
		else { %>
			nameArr1에는 등록된 회원이 없습니다.<br/>
	<%	}  %>
	<br/>
	
	<hr style="border: solid 1px navy;" />
	
	<%
		if(nameArr2 != null && nameArr2.length == 0) { %>
			nameArr2에는 등록된 회원이 없습니다. <br/>
	<%	}  %>
	
	<hr style="border: solid 1px navy;" />
	
	
</body>
</html>