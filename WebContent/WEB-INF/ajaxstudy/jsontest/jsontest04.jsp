<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSON 테스트</title>

<style type="text/css">

	div {
		margin: 20px;
	}

</style>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$.ajax({
			url:"<%= ctxPath%>/jsontest02",
			success: function(text) {
				<%--  text에는 url 주소 <%= ctxPath%>/jsontest02 로 부터 받은
					    문자열 [{\"name\":\"김개똥\", \"age\":20, \"address\":\"서울시 강남구\"}, {\"name\":\"김말똥\", \"age\":33, \"address\":\"인천시 연수구\"}, {\"name\":\"김소똥\", \"age\":41, \"address\":\"수원시 팔달구\"}] 이 들어온다.
			     --%>
				
				var arrObj = JSON.parse(text);
				// JSON 형식으로 된 문자열을 자바스크립트 객체로 변환해주는 것이다.
				// 주의할건 text는 반드시 JSON 형식으로 된 문자열이어야 한다.
				
				// 그 반대는 JSON.stringify(자바스크립트 객체);메소드로서 자바스크립트 객체를 JSON 문자열로 변환해주는 것이다.
				
				
				var html = "";
				
				$.each(arrObj, function(index, item){ // 반복문
					
					html += "<ul>"+
						    "<li>"+ item.name +"</li>"+
						    "<li>"+ item.age +"</li>"+
						    "<li>"+ item.address +"</li>"+
						    "</ul>";
				});
				
				$("#div1").html(html);
					    
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
		// 또는
		
		$.ajax({
			url:"<%= ctxPath%>/jsontest02",
			dataType:"json",
			success: function(json) {
				<%--  text에는 url 주소 <%= ctxPath%>/jsontest02 로 부터 받은
					    문자열 [{\"name\":\"김개똥\", \"age\":20, \"address\":\"서울시 강남구\"}, {\"name\":\"김말똥\", \"age\":33, \"address\":\"인천시 연수구\"}, {\"name\":\"김소똥\", \"age\":41, \"address\":\"수원시 팔달구\"}] 이 
					    자바스크립트 객체배열로 변화된 것이 들어온다.
			     --%>

				var html = "<ol>";

				
				$.each(arrObj, function(index, item){ // 반복문
					
					html += "<li>" + item.name + "</li>" +
							"<li>" + item.age + "</li>" +
							"<li>" + item.address + "</li>";
											
				});
				
				html += "</ol>"

				
				$("#div2").html(html);
					    
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
			});
	});

</script>
</head>
<body>
	<div id="div1"></div>
	<div id="div2"></div>
</body>
</html>