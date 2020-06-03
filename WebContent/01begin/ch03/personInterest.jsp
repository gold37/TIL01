<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>personInterest.jsp 페이지</title>

<style type="text/css">
	ul {
		list-style: none;
	}
	
	li {
		line-height: 200%:
	}


</style>

</head>
<body>
	<form name="memberFrm" action="<%= ctxPath%>/personInterestResult.do" method="get">

	<fieldset>
		<legend>개인성향 테스트(GET method)</legend>
		<ul>
			<li>
				<label for="name">성명</label>
				<input type="text" name="name" id="name" placeholder="성명입력"/> 
			</li>
			<li>
				<label for="school">학력</label>
				<select name="school" id="school">
					<option value="고졸">고졸</option>
					<option value="초대졸">초대졸</option>
					<option value="대졸">대졸</option>
					<option value="대학원졸">대학원졸</option>
				</select>
			</li>
			<li>
				<label for="">좋아하는 색상</label>
				<div>
					<label for="red">빨강</label>
					<input type="radio" name="color" id="red" value="red" />
					
					<label for="blue">파랑</label>
					<input type="radio" name="color" id="blue" value="blue" />
					
					<label for="green">초록</label>
					<input type="radio" name="color" id="green" value="green" />
					
					<label for="yellow">노랑</label>
					<input type="radio" name="color" id="yellow" value="yellow" />
				</div>
			</li>
			<li>
				<label for="">좋아하는 음식(다중선택)</label>
				<div>
				    <label for="food1">짜짱면</label>
					<input type="checkbox" name="food" id="food1" value="1" />
					
					<label for="food2">짬뽕</label>
					<input type="checkbox" name="food" id="food2" value="2" />
					
					<label for="food3">탕수육</label>
					<input type="checkbox" name="food" id="food3" value="3" />
					
					<label for="food4">양장피</label>
					<input type="checkbox" name="food" id="food4" value="4" />
					
					<label for="food5">팔보채</label>
					<input type="checkbox" name="food" id="food5" value="5" />
				</div>
			</li>
			<li>
				<input type="submit" value="전송" />
				<input type="reset" value="취소" />
			</li>
		</ul>
	</fieldset>
	</form>
</body>
</html>