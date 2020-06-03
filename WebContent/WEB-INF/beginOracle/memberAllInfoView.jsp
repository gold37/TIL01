<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	// 	/MyMVC
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 회원정보를 조회 해주는 페이지</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="<%= ctxPath%>/js/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<style type="text/css">
	
	body {
		padding: 20px;
	}

	a {
		text-decoration: none !important; /* 부트스트랩 때문에 적용 안돼서 강제로 시킴  */
		font-size: 13pt;
	}
		
	div#content {
		width: 80%;	
		margin: 30px auto;
	}
	
	th {
		font-size: 12pt;
	}


</style>

<script type="text/javascript">


	$(document).ready(function(){
		
		// 체크박스에 선택된 회원들 삭제하기
		$("button#btnMemberDelete").click(function() {
			
			// == 체크박스에서 체크된 value 값 (each사용) == //
			var arrCheckedVal = new Array();
			
			$("input:checkbox[name=chkboxUserid]:checked").each(function(){
				arrCheckedVal.push($(this).val());
			});
			
			arrCheckedVal = arrCheckedVal.join(",");
			
		//	alert("확인용 : "+arrCheckedVal);
		
			var frm = document.deleteFrm;
			frm.userides.value = arrCheckedVal;
			frm.action = "<%= ctxPath%>/memberDelete.do";
			frm.method = "post";
			frm.submit();
			
		});
		
	});
	
	
	
</script>


</head>
<body>

	<div id="navi">
		<a href="index.do">HOME</a>		
	</div>
	
	<h2>모든 회원정보를 조회 해주는 페이지</h2>
	<div id="content">
	<table class="table table-hover">
		<tr>
			<th>아이디</th>
			<th>성명</th>
			<th>관심분야</th>
			<th>가입일자</th>
			<th>상세정보 조회</th>
			<th>회원변경</th>
			<th>회원삭제</th>
		</tr>
		
		<c:forEach var="mvo" items="${memberList}">
			<%-- <tr onclick="alert('${mvo.userid}');"> --%>
			<tr>
				<td>${mvo.userid}</td>
				<td>${mvo.name}</td>			
				<td>${mvo.attention}</td>			
				<td>${mvo.registerday}</td>			
				<td><button onclick="javascript:location.href='<%= ctxPath%>/myInfoView.do?userid=${mvo.userid}'">조회</button></td>			
				<td><button onclick="javascript:location.href='<%= ctxPath%>/updateMember.do?userid=${mvo.userid}'">변경</button></td>			
				<td><input type="checkbox" name="chkboxUserid" value="${mvo.userid}" /></td>			
			</tr>
		</c:forEach>
		
		<tr align="center">
			<td colspan="6" style="padding: 30px;">
				<button id="btnMemberDelete">회원삭제하기</button>
			</td>
		</tr>
		
	</table>
	</div>
	
	<form name="deleteFrm">
		<input type="hidden" name="userides" />
	</form>
	
</body>
</html>