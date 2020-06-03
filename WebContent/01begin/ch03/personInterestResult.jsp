<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>    
    
<%
	String ctxPath = request.getContextPath();
	//ctxPath --> /MyMVC
	
	Object obj = request.getAttribute("map");
	
	Map<String, String> map = (Map<String, String>)obj; // 캐스팅
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 성향 결과 페이지</title>

<style type="text/css">
	span.customFont {
		font-size: 14pt;
		font-weight: bold;
	}
	
	li {
		line-height: 200%;
	}
	
	label {
		/* border: solid 1px red; */
		
		display: inline-block;
		width: 150px;
		text-align: left;
	}
	
	div#colorDiv {
		display: inline-block;
		position: relative;
		top: 10px;
	}
	
	img {
		margin: 20px;
	}
	
</style>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		var foodImages = "<%= map.get("foodImages")%>"; 
		<%-- 자바스크립트에서도 <% %> 쓸 수 있는데 대신 "쌍따옴표" 또는 '홑따옴표' 꼭 써줘야됨 --%> 
		
		// 문자열 foodImages를 배열로 변환
		var arrFoodImages = foodImages.split(",");

		for(var i=0; i<arrFoodImages.length; i++) {
			
			$("div#foodDiv").append("<img src='<%= ctxPath%>/01begin/ch03/images/"+arrFoodImages[i]+"' />");
			
		} // end of for --------------
		
		$("div#colorDiv").css({'width':'30px'
							  ,'height':'30px'
							  ,'background-color': '<%= map.get("color") %>'});
		
	});

</script>

</head>
<body>
	<ol>
		<li>
			<label>성명 :</label><span class="customFont"><%= map.get("name") %></span>
		</li>
		
		<li>
			<label>좋아하는 색 :</label><div id="colorDiv"></div>
		</li>
		
		<li>
			<label>학력 :</label><span class="customFont"><%= map.get("school") %></span> 
		</li>
		
		<li>
			<label>좋아하는 음식</label>
			<div id="foodDiv"></div>
		</li>
	</ol>
</body>
</html>