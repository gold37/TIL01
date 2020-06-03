<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주민번호를 입력받아서 1,3(남자)/2,4(여자)로 나타내기</title>
<script type="text/javascript">
	function goSubmit(){
		// 주민번호 정규표현식
	    var regExp =  /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/;
		
	    var sJubun1 = document.getElementById("jubun1").value;
	    var sJubun2 = document.getElementById("jubun2").value;
	    
	    var isValid = regExp.test(sJubun1+"-"+sJubun2);
	    
	    if(!isValid) {
	    	alert("주민번호 형식에 맞지 않습니다.");
	    	return; // 종료
	    }
	    
		var frm = document.myFrm;
		frm.jubun.value = sJubun1 + sJubun2;
		frm.action = "03Choose_substring_TestEnd.jsp";
	//	frm.method = "get";
		frm.submit();
	}
</script>
</head>
<body>
	<form name="myFrm">
		주민번호 : <input type="text" id="jubun1"/>&nbsp;-&nbsp;<input type="password" id="jubun2" />
		<input type="hidden" name="jubun" />
		<br/><br/>
		<button type="button" onclick="goSubmit()">확인</button>
		<button type="reset">취소</button>
	</form>
</body>
</html>