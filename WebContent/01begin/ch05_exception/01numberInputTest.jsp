<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 페이지에서 Exception 처리 방법 3가지</title>

<script type="text/javascript">
	function goSubmit(btn) {
		
		var frm;
		
		switch (btn) {
			case 'btn1':
				frm = document.frm1;
				break;
	
			case 'btn2':
				frm = document.frm2;
				break;
	
			case 'btn3':
				frm = document.frm3;
				break;
		} // end of switch ---------------------
		
		frm.submit();
	}

</script>

</head>
<body>
	<h2>try ~ catch ==> RequestDispatcher 를 이용한 에러페이지 출력</h2>
	<form name="frm1" action="02tryCatchRequestDispatcher.jsp" method="post"> 
		num1 : <input type="text" name="num1" /><br/> 
	    num2 : <input type="text" name="num2" /><br/> 
	    <button type="button" onclick="goSubmit('btn1');">전송</button>
	</form>	
	
	<br/>
	<hr style="border: solid 1px red;" />
	
	<h2>JSP 페이지 directive(지시어)에서 errorPage 속성과 isErrorPage 속성을 이용한 에러페이지 출력</h2>
	<form name="frm2" action="04directiveErrorPage.jsp" method="post"> 
		num1 : <input type="text" name="num1" /><br/> 
	    num2 : <input type="text" name="num2" /><br/> 
	    <button type="button" onclick="goSubmit('btn2');">전송</button>
	</form>	
	
	<br/>
	<hr style="border: solid 1px red;" />
	
	<h2>배치서술자인 web.xml을 이용한 에러페이지 출력</h2>
	<form name="frm3" action="06webXml.jsp" method="post"> 
		num1 : <input type="text" name="num1" /><br/> 
	    num2 : <input type="text" name="num2" /><br/> 
	    <button type="button" onclick="goSubmit('btn3');">전송</button>
	</form>	
</body>
</html>