<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<style type="text/css">
	div#mvoInfo {
		width: 60%; 
		text-align: left;
		border: solid 0px red;
		margin-top: 30px; 
		font-size: 13pt;
		line-height: 200%;
	}
	
	span.myli {
		display: inline-block;
		width: 90px;
		border: solid 0px blue;
	}
	
	div#sms {
		margin: 0 auto; 
		/* border: solid 1px red; */ 
		overflow: hidden; 
		width: 50%;
		padding: 10px 0 10px 80px;
	}
	
	span#smsTitle {
		display: block;
		font-size: 13pt;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	textarea#smsContent {
		float: left;
		height: 100px;
	}
	
	button#btnSend {
		float: left;
		border: none;
		width: 50px;
		height: 100px;
		background-color: navy;
		color: white;
	}
	
	div#smsResult {
		clear: both;
		color: red;
		padding: 20px;
	}
</style>


<script type="text/javascript">

	$(document).ready(function(){

		$("#smsResult").hide();
		
		$("#btnSend").click(function(){
			$.ajax({
				url:"/MyMVC/member/smsSend.up",
				type:"post",
				data:{"mobile":"${mvo.hp1}${mvo.hp2}${mvo.hp3}"
					 ,"smsContent":$("#smsContent").val()},
				dataType:"json",
				success:function(json){
					if(json.success_count == 1) {
						$("#smsResult").html("문자전송이 성공되었습니다");
						$("#smsResult").show();
					}
					else if(json.error_count != 0) {
						$("#smsResult").html("문자전송이 실패되었습니다");
						$("#smsResult").show();
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			});	
		});
		
	});
</script>

	
 <c:if test="${empty mvo}">
 	존재하지 않는 회원입니다.<br/>
 </c:if>	
	
 <c:if test="${not empty mvo}">	
	 <h3>::: ${mvo.name}님의 회원 상세정보 :::</h3>
	 <div id="mvoInfo">
	 <ol>	
		 <li><span class="myli">회원번호 : </span>${mvo.idx}</li>
		 <li><span class="myli">아이디 : </span>${mvo.userid}</li>
		 <li><span class="myli">회원명 : </span>${mvo.name}</li>
		 <li><span class="myli">이메일 : </span>${mvo.email}</li>
		 <li><span class="myli">휴대폰 : </span>${mvo.hp1}-${mvo.hp2}-${mvo.hp3}</li>
		 <li><span class="myli">우편번호 : </span>${mvo.postcode}</li>
		 <li><span class="myli">주소 : </span>${mvo.address}&nbsp;${mvo.detailAddress}&nbsp;${mvo.extraAddress}</li>
		 <li><span class="myli">성별 : </span>${mvo.gender}</li>
		 <li><span class="myli">생년월일 : </span>${mvo.birthyyyy}.${mvo.birthmm}.${mvo.birthdd}</li>
		 <li><span class="myli">나이 : </span>${mvo.age}세</li> 
		 <li><span class="myli">코인액 : </span><fmt:formatNumber value="${mvo.coin}" pattern="###,###" /> 원</li>
		 									<!-- 코인액 보여주기위해 fmt 사용 -->
		 <li><span class="myli">포인트 : </span><fmt:formatNumber value="${mvo.point}" pattern="###,###" /> POINT</li>
		 <li><span class="myli">가입일자 : </span>${mvo.registerday}</li>
	  </ol>
	  </div>
	  
	  <%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
	  <div id="sms" align="left">
	  	<span id="smsTitle">&gt;&gt;휴대폰 SMS(문자) 보내기 내용 입력란&lt;&lt;</span>
	  	<textarea rows="4" cols="40" id="smsContent"></textarea>
	  	<button id="btnSend">전송</button>
	  	<div id="smsResult"></div>
	  </div>
	  
  </c:if>
  
  <button style="margin-top: 20px;" type="button" onclick="javascript:history.back();">회원목록</button>
    
<jsp:include page="../footer.jsp" /> 
   