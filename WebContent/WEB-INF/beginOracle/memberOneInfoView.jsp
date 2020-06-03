<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입된 회원의 정보출력하기</title>

<style type="text/css">

	table {
		border-collapse: collapse;
	}
	
	td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	#miss {
		color: red;
	}

	#allMemberView {
		display: inline-block;
		border: solid 1px gray;
		margin: 10px;
		padding: 2px;
		background-color: orange;
		border-radius: 10px;
		cursor: pointer; 
	}
	
</style>

</head>
<body>
	<c:if test="${mvo != null}">
		<h2>${requestScope.mvo.name}님의 회원정보</h2>
		<!--  ▲ 이 자체가 MemberVO임 ▲ get다음에 나오는 이름으로 첫글자는 반드시 소문자로 적어줘야함 -->
		<br/>
		<table>
			<tr>
				<td>아이디</td>
				<td>${mvo.userid}</td>
			</tr>	
			<tr>
				<td>성명</td>
				<td>${mvo.name}</td>
			</tr>	
			<tr>
				<td>이메일</td>
				<td>${mvo.email}</td>
			</tr>	
			<tr>
				<td>성별</td>
				<td>${mvo.sexual}</td>
			</tr>	
			<tr>
				<td>관심분야</td>
				<td>${mvo.attention}</td>
			</tr>	
			
			<!-- Quiz 1 -->
			<tr>
				<td>관심분야 갯수 1</td>
				<td>
					<c:choose>
						<c:when test="${not empty mvo.interest}">
							${ fn:length(mvo.interest) }
						</c:when>
						<c:otherwise>
				  			0
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
				
			<tr>
				<td>관심분야 갯수 2</td>
				<td>
					${ fn:length(mvo.interest) }
				</td>
			</tr>	
			
			<!-- Quiz 2 -->
			<tr>
				<td>관심분야 갯수(★)</td>
				<td>
					<c:if test="${not empty mvo.interest}">
						<c:set var="cnt" value="${ fn:length(mvo.interest) }" />
						<c:forEach begin="1" end="${cnt}">★</c:forEach>
					</c:if>
				</td>
			</tr>	
			
			<tr>
				<td>가입일자</td>
				<td>${mvo.registerday}</td>
			</tr>
			
			<tr>
				<td>가입인사</td>
				<td>${mvo.introduce}</td>
			</tr>
			<tr>
				<td colspan="2" align="center" style="border: none;"><span id="allMemberView" onclick="javascript:location.href='/MyMVC/selectAllMember.do'">모든회원정보조회</span></td>
			</tr>	
		</table>
	</c:if>
	
	<c:if test="${mvo == null}">
		<h2 id="miss">가입된 회원이 아닙니다.</h2>
	</c:if>
	
</body>
</html>