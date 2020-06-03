<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String firstNum = request.getParameter("firstNum");	/* request는 내장객체 변수 */
	String secondNum = request.getParameter("secondNum");
	
	int nFirstNum = Integer.parseInt(firstNum); // 기본은 String이기때문에 Int형으로 바꿈
	int nSecondNum = Integer.parseInt(secondNum);
	
	int sum = 0; 
	for(int i=nFirstNum; i<=nSecondNum; i++) {
		sum += i;
	}
	
	/* request.setAttribute("sum", new Integer(sum)); // 원래 object로 와야하는데 sum은 자료형이라  캐스팅해서 new Integer(sum)으로 래퍼클레스를 만들어야하는데 귀찮으니까 자동으로 auto boxing할 수 있는 아래처럼 씀 */
	/*
	   == request 내장객체는 클라이언트(02forwardCalcTest.jsp) 가 
	           보내온 데이터를 읽어들이는( request.getParameter("변수명"); ) 역할도 있고 
	           저장소 기능( request.setAttribute("키", 저장할객체); )을 하는 역할도 있다. 
	*/
	request.setAttribute("sum", sum); // 원래는 위처럼 객체로 만들어서 저장을 해야 하지만 자바가 알아서 auto boxing(자동적으로 객체로 만들어주는 것) 해주기 때문에 아래처럼 쓸 수 있다.
	
%>    

<jsp:forward page="02forwardCalcView.jsp"/> <!-- 뷰단 찍어줌 -->
<%-- 웹브라우저 상에서 URL 주소는 그대로 /MyMVC/ch04_StandardAction/02forwardCalc.jsp 인데
	  웹브라우저 상에 보여지는 내용물은 /MyMVC/ch04_StandardAction/02forwardCalcView.jsp의 내용이 보여진다.  --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>