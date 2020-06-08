<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
	// 		/MyMVC
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery Ajax 예제(JSON으로 처리)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">

	div#mycontainer {
		/* border: solid 1px red; */
		width: 90%;
		margin: 0 auto;
	}

	div#imgList {
		width: 40%;
		margin: 0 auto;
		padding: 30px 0 0 0;
	}
	
	div#newsTitleList {
		/* border: solid 1px red;  */
		width: 50%;
		height: 300px;
		overflow: auto;
		margin: 30px 30px 0 0;
		float: left;
	}
	
	div#newsContent {
		border: solid 1px blue; 
		width: 40%;
		height: 250px;
		overflow: auto;
		margin: 30px 0 0 0;
		float: left;
	}

	table {
		width: 90%;
	}

	th {
		background-color: #eee;
	}

	th, td {
		border: solid 1px gray;
		padding: 5px;
	} 
	
	td:hover {
		cursor: pointer;
	}
	
	div#newsWrite {
		/* border: solid 1px red; */
		clear: both;
		padding: 40px 0;
	}
	
	li {
		margin-bottom: 10px;
	}
	
	button {
		margin-left: 20px;
	}
	
	div#employeeList {
		/* border: solid 1px red; */
		width: 50%;
		height: 300px;
		overflow: auto;
		margin: 30px 30px 0 0;
		float: left;
	}
	
	div#employeeDetail {
		border: solid 1px red; 
		width: 40%;
		height: 250px;
		overflow: auto;
		margin: 30px 0 0 0;
		float: left;
	}
	
	div#employeeWrite {
		/* border: solid 1px red;  */
		clear: both;
		padding: 40px 0;
	}
	
	table#employeeTbl {
		width: 40%;
	}
	
	table#employeeTbl th {
		text-align: center;
		font-size: 14pt;
	}
	
	table#employeeTbl th, table#employeeTbl td {
		border: none;
	}
	
	table#employeeTbl td {
		padding: 10px;
	}
	
	table#employeeTbl td:first-child {
		font-size: 12pt;
		font-weight: bolder;
	}
	
	table#employeeTbl td>input {
		width: 200px;
	}
	
	table#employeeTbl td>select {
		width: 100px;
		height: 30px;
	}

	.empcss {
		color: navy;
		background-color: #ffe6f0;
	}

	span.empspan {
		display: inline-block;
		width: 70px;
		background-color: #ffffcc;
		font-weight: bold;
		margin-right: 20px;
	}
	
	span#emailDuplicateCheck {
		display: inline-block;
		margin: 0 0 0 5px;
		padding: 2px 0;
		width: 120px;
		border-radius: 5px;
		cursor: pointer;
		color: #fff;
		background-color: #ff0066;
		text-align: center;
	}
</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		
		func_imgList();
	//	func_newsTitleList();
		
	/*
		$(document).on("click", ".mynews", function(){
			var seqno = $(this).find(".seqno").text(); // td 태그 안의 element로 감
		//	alert(seqno);
			func_newsContents(seqno);
		});
		
	*/
	

		$("#btnSubmit").click(function(){
			$.ajax({
				url:"<%= ctxPath%>/ajaxstudy/xmltestNewsWrite.up", 
				type: "post",
				data: {"title": $("#title").val(),
					   "newscontents":$("#newscontents").val()},
			    success: function(){
			    	func_newsTitleList();
			    	$("#title").val("");
			    	$("#newscontents").val("");
				}, // 실패했을 경우
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		}); // end of $("#btnSubmit").click(function(){})-----------------------

		
		// email 중복 검사를 했는지 알아보기
		var bIsClickEmailCheck = false;
		
		$("#emailDuplicateCheck").click(function(){
		
			bIsClickEmailCheck = true;
			
			$.ajax({
				url:"<%= ctxPath%>/ajaxstudy/jsontestEmailDuplicateCheck.up",
				data:{"email":$("#email").val()},
				dataType:"json",
				success:function(json){
					if(json.isUse) { // json.isUse -> true (중복이 되지 않은 이메일로 email로 사용 가능하다) 
						$("#emailResult").html("사용가능합니다.").css("color","navy");
					}
					else { // json.isUse -> false (중복이 된 이메일로 email로 사용 불가능하다)
						$("#emailResult").html($("#email").val()+"은 중복된 email 입니다.").css("color","red");
						$("#email").val(""); // 입력된 값 없앰
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
			});
			
		});
		
		
		$("#btnEmpSubmit").click(function(){ // 신규사원 입력 버튼 눌렀을때
			
			if(!bIsClickEmailCheck) {
				alert("email 중복 검사를 하세요 !");
				return; // 종료
			}
			
			else {
				// 유효성 검사는 생략. 입력대상값이 모두 입력되었다는 전제하에 실행
				
				var employee = {"ename":$("#ename").val()
							   ,"jik":$("#jik").val()
							   ,"tel":$("#tel").val()
							   ,"email":$("#email").val()
							   ,"birthday":$("#birthday").val()
								};
			
				var strEmployee = JSON.stringify(employee);
				// JSON.stringify(자바스크립트객체); 메소드는 자바스크립트객체를 JSON 문자열로 변환해주는 것이다.
				
				// 그 반대는 JSON.parse(text); 메소드로서 JSON 형식으로 된 문자열을 자바스크립트 객체로 변환해주는 것이다.
				// 주의할건 text는 반드시 JSON 형식으로 된 문자열이어야 한다.
				
				
				console.log("확인용 strEmployee => " +strEmployee);
				// 확인용 strEmployee => {"ename":"곽대표","jik":"사장","tel":"01012345678","email":"super@naver.com","birthday":"19970825"}
			 		
				$.ajax({
					url:"<%= ctxPath%>/ajaxstudy/gsontestEmpWrite.up",
					type:"post",
					data:{"employee":strEmployee}, // JSON형식의 문자열로 보냄
					success:function(){
						func_empList(); // 모든 사원정보 출력해주기
						document.empFrm.reset(); // 입력버튼 누르면 다시 새로 쓸 수 있게 초기화 시키기
						$("#emailResult").empty(); // email 중복검사 결과물 제거하기
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
			} // end of if ~ else -----------------------------
			
		});
		
		func_empList(); // 모든 사원정보 출력해주기
		
		$(document).on("mouseover",".myemp", function(){ // .myemp 선택자에 마우스오버되면 뭐할지 적음
			$(this).addClass("empcss");
		}); 		
		
		$(document).on("mouseout",".myemp", function(){ // .myemp 선택자에 마우스빠지면 뭐할지 적음
			$(this).removeClass("empcss");
		}); 		
		
		// 특정 사원에 대한 정보 조회하기
		$(document).on("click", ".myemp", function(){
			var email = $(this).find(".email").text();
		//	alert(email);
			func_empDetail(email); // 직원 한명에 대한 상세 정보보기 함수 
		
		});
		
	
		
	}); // end of $(document).ready() --------------------------
	
	function func_imgList(){
	      $.ajax({
	         url: "<%= ctxPath%>/ajaxstudy/jsontestImage.up",
	         dataType: "json",
	      //   async: true,   //비동기처리
	         success: function(json){
	            
	            var html = "<div id='myCarousel' class='carousel slide' data-ride='carousel'>";
	            
	            <%-- Indicators --%>
	            html += " <ol class='carousel-indicators'>";
	            
	            for(var i=0;i<json.length;i++) {
	               if(i==0){
	                  html += "<li data-target='#myCarousel' data-slide-to='"+i+"' class='active'></li>"
	               } else {
	                  html +=  "<li data-target='#myCarousel' data-slide-to='"+i+"'></li>"
	               }
	            }
	            
	            html += "</ol>";
	            
	            <%-- Wrapper for slides --%>
	            html += "<div class='carousel-inner'>";
	            
	            $.each(json, function(index, item){ //헷갈릴까봐 picture 적어줌 보통 item 씀 //무조건         
	               
	               if(index==0) {
	                  html += "<div class='item active'><img src='/MyMVC/images/" + item.IMGFILENAME + "' style='width:100%;'></div>";
	               } else {
	                  html += "<div class='item'><img src='/MyMVC/images/"+ item.IMGFILENAME +"' style='width:100%;'></div>";
	               }//$(this)가 <picture>한 덩어리들
	               
	            });
	            
	            
	            /* 
	            
	            for(var i=0; i<arrPicture.length; i++){               
	               console.log($(arrPicture[i]).find("imgfilename").text());               
	            }
	            
	            */
	             
	             
	            <%-- Left and right controls --%>
	            html += " <a class='left carousel-control' href='#myCarousel' data-slide='prev'>" + 
	                     "<span class='glyphicon glyphicon-chevron-left'></span><span class='sr-only'>Previous</span></a>" +
	                         "<a class='right carousel-control' href='#myCarousel' data-slide='next'>"+
	                        "<span class='glyphicon glyphicon-chevron-right'></span>" +
	                        "<span class='sr-only'>Next</span>" +
	                      "</a>" +
	                   "</div>";
	               
	         
	            $("#imgList").html(html);
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	      })
	 }; // end of function func_imgList() ----------------
	
	
	 
	function func_newsTitleList() {
		
		$.ajax({
			url:"<%= ctxPath%>/ajaxstudy/xmltestNewsTitle.up", 
			// ▲ 위 url에 요청
			dataType:"xml",
			//	async:true,	// 비동기 처리. false는 동기처리
			success: function(xml) { // 콜백함수
				
				var rootElement = $(xml).find(":root"); // 넘겨받은 결과물(xml)에서 최상위 root 엘리먼트를 찾아 줌

				var arrNewsTitle = $(rootElement).find("newsTitle");
				
				
				var html = "<table id='newstbl'>";
					html += "<tr>";
					html += 	"<th>기사연번</th>";
					html += 	"<th>기사제목</th>";
					html += 	"<th>입력일자</th>";
					html += "</tr>";

					arrNewsTitle.each(function(index, item){ // 반복문
						
						if(index == 0) {
							func_newsContents($(this).find("seqtitleno").text());
						} // 가장 최근 뉴스 보이기
						
						html += "<tr class='mynews'>";
						html += 	"<td class='seqno'>"+$(this).find("seqtitleno").text()+"</td>"
						html += 	"<td>"+$(this).find("jemok").text()+"</td>"
						html += 	"<td>"+$(this).find("registerday").text()+"</td>"
						html += "</tr>";
						
					});
					
					html += "</table>";;
					
				$("#newsTitleList").html(html); // 다 했으면 여기에 꽂아주세요~
				
			}, // 실패했을 경우
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
				
		});
		
	}// end of function func_newsTitleList()------------------------
	
	
	
	function func_newsContents(seqno) {
		
		$.ajax({ 
			url:"<%= ctxPath%>/ajaxstudy/xmltestNewsContents.up", 
			type: "get",
			// method 아님! 실수하지않도록 주의~ type 안적으면 기본은 get방식.
			data:{ "seqno":seqno }, // "seqno"는 getParameter해올때 이름. seqno는 넘기는 value값
			dataType:"xml",
			success: function(xml) { // 진동벨 울리면서 성공되면 콜백함수			
				var rootElement = $(xml).find(":root");
				var html = rootElement.text();
				$("#newsContent").html(html);
			}, // 실패했을 경우
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
		
	}// end of function func_newsContents(seqno)--------------------
	
	function func_empList() {
		
		$.ajax({
			url:"<%= ctxPath%>/ajaxstudy/gsontestEmpList.up",
			dataType:"json",
			success:function(json) { // 콜백함수
				
				var html = "<table id='emptbl'>";
                	html += "<tr>";
	                html +=    "<th>사원명</th>";
	                html +=    "<th>직위</th>";
	                html +=    "<th>연락처</th>";
	                html +=    "<th>email</th>";
	                html += "</tr>";
					
				$.each(json, function(index, item){ // 반복문
					
					if(index == 0) { // 처음거라면
						func_empDetail(item.email); // 한사람것만 나온다.
					}
					
					html += "<tr class='myemp'>";
					html += 	"<td>"+ item.ename +"</td>";
					html += 	"<td>"+ item.jik +"</td>";
					html += 	"<td>"+ item.tel +"</td>";
					html += 	"<td class='email'>"+ item.email +"</td>";
					html += "</tr>"
					
				});
                
				html += "</table>";
				
			$("#employeeList").html(html); // employeeList에 넣으세요
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	}
	
	function func_empDetail(email) {
		
		$.ajax({
			url:"<%= ctxPath%>/ajaxstudy/gsontestEmpDetail.up",
			data:{"email":email},
			dataType:"json",
			success: function(json){
				
				var html = "<ol>" +
							   "<li><span class='empspan'>사원명</span>"+json.ename+"</li>"+
							   "<li><span class='empspan'>직급</span>"+json.jik+"</li>"+
							   "<li><span class='empspan'>연락처</span>"+json.tel+"</li>"+
							   "<li><span class='empspan'>email</span>"+json.email+"</li>"+
							   "<li><span class='empspan'>생년월일</span>"+json.birthday+"</li>"+
							   "<li><span class='empspan'>현재나이</span>"+json.age+"세</li>"+
						   "</ol>";
				
				$("#employeeDetail").html(html);		   
						   
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}

		});
		
	}
	
</script>

</head>

<body>
	
	<div id="mycontainer">
	
		<h3>여기는 URL이 /MyMVC/ajaxstudy/jsontestMain.up인 페이지 입니다.</h3>
		
		<!-- 여기에 넣는게 최종목표 -->
		<div id="imgList"></div> 
		<div id="newsTitleList"></div>
		<div id="newsContent"></div> 
		<div id="newsWrite">
			<form name="newsFrm">
				<ul>
					<li>
						<label>기사제목</label>
						<input type="text" name="title" id="title" size="30" />
					</li>
				
					<li>
						<label>기사내용</label>
						<textarea rows="5" cols="40" id="newscontents" name="newscontents" ></textarea>
					</li>
				</ul>
				<button type="button" id="btnSubmit">전송</button>
				<button type="reset">취소</button>
			</form>
		</div>
		
		<div id="employeeList"></div>
		<div id="employeeDetail"></div>
		<div id="employeeWrite">
		<form name="empFrm">
             <table id="employeeTbl">
                <tr>
                   <th colspan="2">신규사원 정보입력</th>
                </tr>
                <tr>
                   <td>사원명</td>
                   <td><input type="text" id="ename"/></td>
                </tr>
                <tr>
                   <td>직위</td>
                   <td>
                      <select id="jik">
                         <option>사원</option>
                         <option>대리</option>
                         <option>과장</option>
                         <option>부장</option>
                         <option>이사</option>
                         <option>사장</option>
                      </select>
                   </td>
                </tr>
                <tr>
                   <td>연락처</td>
                   <td><input type="text" id="tel" placeholder="예: 01023456789"/></td>
                </tr>
                <tr>
                   <td>email</td>
                   <td style="width:80%;">
                      <input type="email" id="email"/>
                      <span id="emailDuplicateCheck">email중복검사</span>
                      <br/><span id="emailResult"></span>
                   </td>
                </tr>
                <tr>
                   <td>생년월일</td>
                   <td><input type="text" id="birthday" placeholder="예: 19941019" /></td>
                </tr>
                <tr>
                   <td colspan="2">
                      <button type="button" id="btnEmpSubmit">입력</button>
                      <button type="reset">취소</button>
                   </td>
                </tr>
             </table>
          </form>
		</div>
		 
	</div>

</body>
</html>