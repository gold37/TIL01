<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오라클과 연동하는 서블릿 시작</title>

<style type="text/css">

	div#container {
		width: 80%;
		margin: 0 auto;
	}
	
	ul {
		list-style-type: none;
		padding: 0;
		margin-top: 30px;
	}
	
	li {
		border: solid 1px blue;
		display: inline-block;
		width: 150px;
		margin: 0 20px 0 0;
		padding: 5px; 
		font-size: 14pt;
		text-align: center;
		background-color: navy;
		color: white;
		cursor: pointer;
	}

</style>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#memberRegister").click(function(){
			
			location.href="<%= ctxPath%>/memberRegister.do";
			// 절대 경로
			
			// 또는
			
			location.href="memberRegister.do";
			// 상대 경로
			
		});	
		
		$("#selectAllMember").click(function(){
			
			location.href="<%= ctxPath%>/selectAllMember.do";
			
		});
		
	});
	
</script>

</head>
<body>
	<div id="container">
		<h2>오라클과 연동하는 서블릿 시작</h2>
		<ul>
			<li id="memberRegister">회원가입</li>
			<li id="selectAllMember">모든회원정보조회</li>
		</ul>
	</div>
</body>
</html>