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
		
	
	
	
	
	} // end of function goLogin() ------------------

</script>

	<%-- *** 로그인 하기 위한 폼을 생성 *** --%>
 
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
