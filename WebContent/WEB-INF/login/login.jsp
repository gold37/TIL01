<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
	table#loginTbl {
		width: 95%;
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	table#loginTbl #th {
		background-color: silver;
		font-size: 14pt;
		text-align: center;
	}
	
	table#loginTbl td {
		border: solid 1px gray;
	}
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$("#btnSubmit").click(function(){ // 로그인 버튼을 클랙했을때
			// 로그인을 시도한다.
			goLogin();
		});
		
		$("#loginPwd").keydown(function(event){ // 엔터쳤을 때
			// 로그인을 시도한다.
			if(event.keyCode == 13) { // 13은 엔터
			// 암호 입력란에 엔터를 치면 
				goLogin(); // 로그인 함수 실행
			}
		});  
		
	}); // end of $(document).ready(function() --------------
			
	
	// * === 로그인 처리 함수 === *//
	function goLogin() {
		
	//	alert("확인용 로그인");
		
	var loginUserid = $("#loginUserid").val().trim();
	var loginPwd = $("#loginPwd").val().trim();
	
	if(loginUserid == "") {
		alert("아이디를 입력하세요!");
		$("#loginUserid").val("");
		$("#loginUserid").focus();
		return;
	}
	
	if(loginPwd == "") {
		alert("암호를 입력하세요!");
		$("#loginUserid").val("");
		$("#loginUserid").focus();
		return;
	}
	
	var frm = document.loginFrm;
	frm.method = "post";
	frm.action = "<%= request.getContextPath()%>/login/login.up";
	frm.submit();
	
	
	} // end of function goLogin() ------------------

	
	function goLogOut() {
			
		// 로그아웃을 처리해주는 페이지로 이동
		location.href = "<%= request.getContextPath()%>/login/logout.up";
		
	} // end of function goLogOut() ----------------------
	
	
</script>
 
	<%-- *** 로그인 하기 위한 폼을 생성 *** --%>
 	<%--
 	 
 	<c:if test="${sessionScope.loginuser == null}" > 
 	
 	또는
 	--%>
 	<c:if test="${empty sessionScope.loginuser}" >
 	
    <form name="loginFrm">
    	<table id="loginTbl">
			<thead>
				<tr>
					<th colspan="2" id="th">LOGIN</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td style="width: 30%; border-bottom: hidden; border-right: hidden; padding: 10px;">ID</td>
					<td style="width: 70%; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="text" id="loginUserid" name="userid" size="13" class="box" /></td>
				</tr>	
				<tr>
					<td style="width: 30%; border-top: hidden; border-bottom: hidden; border-right: hidden; padding: 10px;">암호</td>
					<td style="width: 70%; border-top: hidden; border-bottom: hidden; border-left: hidden; padding: 10px;"><input type="password" id="loginPwd" name="pwd" size="13" class="box" /></td>
				</tr>
				
				<%-- 아이디 찾기, 비밀번호 찾기 --%>
				<tr>
					<td colspan="2" align="center">
						<a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a> /
						<a style="cursor: pointer;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center" style="padding: 10px;">
						<input type="checkbox" id="saveid" name="saveid" style="vertical-align: text-top;" /><label for="saveid" style="margin-right: 20px; vertical-align: middle;">아이디저장</label>
						<button type="button" id="btnSubmit" style="width: 67px; height: 27px; background-image: url('<%= request.getContextPath()%>/images/login.png'); vertical-align: middle; border: none;"></button>
					</td>
				</tr>
			</tbody>
    	</table>
    </form>
	</c:if>

	<%-- *** 로그인 된 화면 *** --%>
	<%-- 
	
	<c:if test="${sessionScope.loginuser != null}" > 
	
	또는
	--%>
	<c:if test="${not empty sessionScope.loginuser}" >
		<table style="width: 95%; height: 130px;">
    		<tr style="background-color: pink;">
    			<td align="center">
    				<span style="color: blue; font-weight: bold;">${(sessionScope.loginuser).name}</span>
    				[<span style="color: red; font-weight: bold;">${(sessionScope.loginuser).userid}</span>]님
    				<br/><br/>
    				<div align="left" style="padding-left: 20px; line-height: 150%;">
    					<span style="font-weight: bold;">코인액:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).coin}" pattern="###,###" /> 원
    					<br/>
    					<span style="font-weight: bold;">포인트:</span>&nbsp;&nbsp; <fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /> POINT
    				</div>
    				<br/>로그인 중...<br/><br/>
    				[<a href="javascript:goEditPersonal('${(sessionScope.loginuser).idx}');">나의정보</a>]&nbsp;&nbsp;
				  	[<a href="javascript:goCoinPurchaseTypeChoice('${(sessionScope.loginuser).idx}');">코인충전</a>] 
				  	<br/><br/>
    				<button type="button" onclick="goLogOut();">로그아웃</button>
    			</td>
    		</tr>
    	</table>
	</c:if>
	
	
  <%-- ****** 아이디 찾기 Modal ****** --%>
  <div class="modal fade" id="userIdfind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">아이디 찾기</h4>
        </div>
        <div class="modal-body" style="height: 300px; width: 100%;">
          <div id="idFind">
          	<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/login/idFind.up">
          	</iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>


  <%-- ****** 비밀번호 찾기 Modal ****** --%>
  <div class="modal fade" id="passwdFind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 찾기</h4>
        </div>
        <div class="modal-body">
          <div id="pwFind">
          	<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/login/pwdFind.up">  
          	</iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

 <%--
     // *** PG(Payment Gateway 결제)에 코인금액을 카드로 결제후 DB상에 사용자의 코인액을 update 해주는 폼이다.
 --%>
 <form name="coinUpdateFrm">
 	 <input type="hidden" name="idx" />
	 <input type="hidden" name="coin" />
 </form>
	
	
	
	
	