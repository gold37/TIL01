<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JPS 표준액션 중 forward에 대해서 알아보자 (실행은 여기 Test에서)</title>
<script type="text/javascript">
	
	function goSubmit() {
		
		var frm = document.myFrm;
		
		var num1 = frm.firstNum.value.trim(); // 이렇게 id값 없더라도 name값 가져와서 쓸 수 있음
		
		var num2 = frm.secondNum.value.trim();
		
		if(num1=="" || num2=="") {
			alert("값을 입력하세요!!");
			frm.firstNum.value = "";
			frm.secondNum.value = "";
			frm.firstNum.focus();
			return; // 종료
		}
		
		var regExp = /^[0-9]{1,5}$/; //정규표현식 객체
		if( !( regExp.test(num1) && regExp.test(num2) ) ) {// 둘 다 true가 아니라면 (한개라도 false라면)
			alert("값을 입력하세요!!");
			frm.firstNum.value = "";
			frm.secondNum.value = "";
			frm.firstNum.focus();
			return; // 종료
		}
		
		frm.action = "02forwardCalc.jsp";  
		/* frm.method = "get"; // 메소드에는 get과 set이 있음. method를 명기하지 않으면 기본은 get임. */
		frm.submit();
		
	}

</script>

</head>
<body>
	<h2>입력한 두개의 수 사이를 누적한 값 알아오기</h2>
	
	<form name="myFrm">
		<p>
			첫번째 수 : <input type="text" name="firstNum" size="5" maxlength="5" /><br/>
			두번째 수 : <input type="text" name="secondNum" size="5" maxlength="5" /><br/>
			<button type="button" onclick="goSubmit()">계산하기</button>
		</p>
	</form>
	
</body>
</html>