<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	String ctxPath = request.getContextPath();
	// /MyMVC
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경하기</title>

<style type="text/css">
	
	body {
	      font-family: Arial, "MS Trebuchet", sans-serif;
	      font-size: 16pt; 
	}
	
	* {margin: 0;}

	div#container { 
		width: 90%;
	    margin: 0 auto;
	    padding: 50px 0;
		text-align: center;					
		/* border: 1px solid red; */
	}
	
	fieldset {
	          text-align: left;
	          background: #ffffe6;}
	
	legend {font-size: 24pt;}
	
	fieldset>ul {
		list-style: none;
		padding: 0;
	}
	
	fieldset>ul>li {
		line-height: 40px;
	}
	
	fieldset>ul>li>label:first-child {
		display: inline-block;
		width: 10%;
		/* border: solid 1px green; */
	}
	
	fieldset>ul>li>input {
		width: 20%;
		height: 20px;
		/* border: solid 1px blue; */
	}
	
	div.schoolInterest {
		display: inline-block;
		width: 50%;
		/* border: solid 1px gray; */
	}
	
	div.schoolInterest>label {
		margin-right: 2%;
	}
	
	div.schoolInterest>input {
		margin-right: 5%;
	}
	
    fieldset>ul>li:last-child>input {
    	width: 10%;
    	height: 50px;
    	margin: 2% 4% 0 0;
    	font-size: 16pt;
    	font-weight: bold;
    	background: #006600;
    	color: #eee;
    	border: none;
    }
    
    fieldset>ul>li:last-child>input:hover {
    	opacity: 0.8;
    	cursor: pointer;
    	color: #ffffcc;
    }
	
	span.error {
		color: red;
		font-size: 10pt;
	}
	
	label#agree {
		font-size: 10px;
	}
	

</style>

<script type="text/javascript" src="<%= ctxPath %>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/util/myutil.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		var attention = "${mvo.attention}";
	//	alert(attention);	Oracle
	
		if(attention != "없음") {
			
			var arrAttention = attention.split(","); // 쪼개서 배열로 만들기
			
			$("input:checkbox[name=interest]").each(function(){ // each는 반복문
				
				for(var i=0; i<arrAttention.length; i++) {
					
					if( $(this).val() == arrAttention[i] ) { // Oracle == Oracle 일치하면
						$(this).prop("checked", true); // 체크박스에 체크
						break;
					}
					
				} // end of for ----------------
				
			}); // end of $("input:checkbox[name=interest]").each() ------------
		}
		
		$("span.error").css('display', 'none'); // 맨 처음엔 error메세지 감추기
		
		
		$("input#passwd").blur(function () {
			
			// 암호는 8글자 이상 15글자 이하의 영문자,숫자,특수기호가 혼합된 것이어야 한다.
			
			var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;         
			
			var bool = regExp.test($(this).val()); 
			
			if(!bool){ // 올바르지 않을 때
				
				$("span.password_error").css('display','');
				$(":input").attr("disabled", true);
				
				$(this).attr("disabled", false);
				$(this).val(""); // 값 비움
				$(this).focus();
			}
			else { // 올바를 때

				$("span.password_error").css('display', 'none'); // error메세지 감추기
				$(":input").prop("disabled", false);
				$("input#passwdCheck").focus();
			}
			
		});
		
		
		$("input#passwdCheck").blur(function () {
			
			if($(this).val() !=  $("input#passwd").val()){ // 올바르지 않을 때
				
				$("span.passwdCheck_error").html("암호와 암호확인 값이 서로 일치하지않습니다.").css('display', '');
				
				$("input#passwd").val("");
				$(this).val(""); // 값 비움
				
				$(":input").attr("disabled", true);
				
				$("input#passwd").attr("disabled", false);
				$(this).attr("disabled", false);
				
				$("input#passwd").focus();
			}
			else { // 올바를 때

				$("span.passwdCheck_error").empty();
				$(":input").attr("disabled", false);
				
				$("input#name").focus();
			}
			
		});
		
		
		$("input#name").blur(function () {
			
			if($(this).val().trim()=="") {
				$("span.name_error").html("성명은 필수입력란 입니다.").css('display', '');
				
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
				$(this).val(""); // 값 비움
				$(this).focus();
			}
			
			else { // 올바를 때

				$("span.name_error").empty(); // error메세지 감추기
				$(":input").prop("disabled", false);
				$("input#email").focus();
			}
			
		});
		
		
		
		$("input#email").blur(function () {
		
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
			var bool = regExp.test($(this).val());
		
			if(!bool){ // 올바르지 않을 때
				
				$("span.email_error").html("올바른 이메일이 아닙니다.").css('display','');
				
				$(":input").attr("disabled", true);
				$(this).attr("disabled", false);
				$(this).val(""); // 값 비움
				$(this).focus();
			}
			
			else { // 올바를 때

				$("span.email_error").empty(); // error메세지 감추기
				$(":input").prop("disabled", false);
				$("input#tel").focus();
			}
		
		});
		
		
		$("#btnUpdate").click(function() {
			// name이 registerFrm인 form을 submit하려고 할 때 발생하는 이벤트

			var frm = document.updateFrm;
			frm.action = "updateMember.do";
			frm.method = "post";
			frm.submit();
			
		}); // end of $("#btnRegister").click(function() {})----------------
		
		
	});// end of $(document).ready()------------------

</script>

</head>
<body>
<div id="container">
	<form name="updateFrm">
		<fieldset>
			<legend>회원정보 변경하기 ( ${method} )</legend>
			<ul>
				<li>
					<label for="userid">아이디</label>
					<input type="text" name="userid" id="userid" value="${requestScope.mvo.userid}" readonly />
					<span class="error userid_error">아이디는 5글자 이상 10글자 이하로 첫글자는 영문대문자이고 나머지는 영문자,숫자로 혼합되어져야 합니다.</span>     
				</li>
				<li>
					<label for="passwd">암호</label>
					<input type="password" name="passwd" id="passwd" value="" maxlength="20" required />
					<span class="error password_error">암호는 8글자 이상 15글자 이하의 영문자,숫자,특수기호가 혼합된 것이어야 합니다.</span>
				</li>
				<li>
					<label for="passwdCheck">암호확인</label>
					<input type="password" id="passwdCheck" value="" required />
				    <span class="error passwdCheck_error"></span>
				</li>
				<li>
					<label for="name">성명</label>
					<input type="text" name="name" id="name" value="${mvo.name}" maxlength="20" required />
				    <span class="error name_error"></span>
				</li>
				<li>
               		<label for="email">e메일</label>
               		<input type="email" name="email" id="email" value="${mvo.email}" maxlength="40" placeholder="예 abc@gmail.com" required />
                	<span class="error email_error"></span>
            	</li>
				<li>
					<label>관심분야</label>
					<div class="schoolInterest">
						<label for="interest1">Java</label><input type="checkbox" name="interest" id="interest1" value="Java" />&nbsp;
				        <label for="interest2">Oracle</label><input type="checkbox" name="interest" id="interest2" value="Oracle" />&nbsp;
				        <label for="interest3">HTML</label><input type="checkbox" name="interest" id="interest3" value="HTML" />&nbsp;
				        <label for="interest4">JavaScript</label><input type="checkbox" name="interest" id="interest4" value="JavaScript" />&nbsp;
					</div> 
				</li>
				<li>
					<input type="button" id="btnUpdate" value="회원변경" />
					<input type="reset" value="취소" />
				</li>
			</ul>
		</fieldset>
	</form>
</div>
</body>
</html>