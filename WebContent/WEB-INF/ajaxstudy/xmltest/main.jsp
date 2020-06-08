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
<title>jQuery Ajax 예제(데이터는 XML로 처리)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


<style type="text/css">

   div#mycontainer {
      /* border : solid 1px red; */
      width: 90%;
      margin: 0 auto;      
   }

   div#imgList {
      width: 40%;
      margin: 0 auto;
      padding-top: 30px;
   }
   
   div#newsTitleList {
      /* border: solid 1px red; */
      width: 50%;
      height: 300px;
      overflow: auto; /* 200 넘어가면 스크롤바 생김*/
      margin: 30px 30px 0 0;
      float: left;
   }
   
   div#newsContent {
      border: solid 1px blue;
      width: 40%;
      height: 300px;
      overflow: auto;
      margin: 30px 0 0 0;
      float: left;
   }
   
   table#newstbl, table#newstbl th, table#newstbl td {
      border: solid 1px gray;   
         
   }
   
   table#newstbl th, table#newstbl td {
      padding: 5px;
   }

   div#newsWrite {
	  border: solid 1px red; 
	  clear: both;
	  padding: 40px 0;
   }
   
   li {
   	  margin-bottom: 10px;
   }
   
   button {
   	  margin-left: 20px;
   }   
</style>


<script type="text/javascript">
	$(document).ready(function(){
		
		func_imgList();
		func_newsTitleList();
		
		$(document).on("click", ".mynews", function(){
			var seqno = $(this).find(".seqno").text(); // td 태그 안의 element로 감
		//	alert(seqno);
			func_newsContents(seqno);
		});
		
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
		
		
	}); // end of $(document).ready() --------------------------
	
	
	function func_imgList() {
		
		$.ajax({
			url:"<%= ctxPath%>/ajaxstudy/xmltestImage.up", 
				// ▲ 위 url에 요청
			dataType:"xml",
		//	async:true,	// 비동기 처리. false는 동기처리
			success: function(xml) { // 식당 진동벨이 울림. 콜백함수
				// xml ==> ajax 요청에 의해 url(xmltestImage.up)로 부터 리턴받은 데이터. 보통은 data라고 씀
				
				// xml 데이터 가져오기
				var rootElement = $(xml).find(":root"); // 넘겨받은 결과물(xml)에서 최상위 root 엘리먼트를 찾아 줌
			//	console.log("확인용: "+$(rootElement).prop("tagName"));
				// 확인용: pictures
				
				var arrPicture = $(rootElement).find("picture");
				/*
					최상위 root 엘리먼트에서 picture 라는 엘리먼트를 찾는 것.
					검색되어진 picture라는 엘리먼트는 복수개 이므로 
					arrPicture 변수는 타입이 배열타입으로 된다.
				
				*/
				
				var html = " <div id='myCarousel' class='carousel slide' data-ride='carousel'>";
				
				<%-- Indicators --%>
					html += "<ol class='carousel-indicators'>";
					
					for(var i=0; i<arrPicture.length; i++) {
						
						if(i==0) {
			    			html += "<li data-target='#myCarousel' data-slide-to='"+i+"' class='active' ></li>";
						}
						else {
			    			html += "<li data-target='#myCarousel' data-slide-to='"+i+"'>";
						}
						
					}// end of for -------------------------
				
					html += "</ol>";
					
					<%-- Wrapper for slides --%>
					html += "<div class='carousel-inner'>";
				
					arrPicture.each(function(index, picture){ // 반복문

						if(index == 0) {
							html+= "<div class='item active'>";
							html+= 	"<img src='/MyMVC/images/"+$(this).find("imgfilename").text()+"' alt='Los Angeles' style='width:100%;'>";
							html+= "</div>";
						}
						else {
							html+= "<div class='item'>";
							html+= 	"<img src='/MyMVC/images/"+$(this).find("imgfilename").text()+"' alt='Los Angeles' style='width:100%;'>";
							html+= "</div>";
						}
						
					});
					
					html += "</div>";
					
					
					<!-- Left and right controls -->
					   html+= "<a class='left carousel-control' href='#myCarousel' data-slide='prev'>";
					   html+= 	"<span class='glyphicon glyphicon-chevron-left'></span>";
					   html+=	"<span class='sr-only'>Previous</span>";
					   html+= "</a>"
					   
					   html+= "<a class='right carousel-control' href='#myCarousel' data-slide='next'>";
					   html+= "<span class='glyphicon glyphicon-chevron-right'></span>";
					   html+= "<span class='sr-only'>Next</span>";
					   html+= "</a>";
					   html+= "</div>";
					
					
				$("#imgList").html(html);
				
			}, // 실패했을 경우
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
		});
		
	} // end of function func_imgList()----------------------------
	
	
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
	
	
	
	
	
</script>

</head>

<body>
	
	<div id="mycontainer">
	
		<h3>여기는 URL이 /MyMVC/ajaxstudy/xmltestMain.up인 페이지 입니다.</h3>
		
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
		<!-- 풀어보기 ~~~ -->
		<div id="memberList"></div> 
	
	</div>

</body>
</html>