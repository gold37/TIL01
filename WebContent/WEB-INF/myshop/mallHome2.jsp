<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />

<style type="text/css">
	.moreProdInfo {
		display: inline-block;
		margin: 10px;
	}

</style>

<script type="text/javascript">
	
	var lenHIT = 8;
	// HIT 상품 스크롤할때 보여줄 상품의 개수(단위)

	var start = 1;
	
	$(document).ready(function(){
		
		$("#countHIT").hide();
		$("#totalHITCount").hide();
		
		// HIT 상품 게시물을 더보기 위해 초기값 호출출하기 
		displayHIT(start);
		
		// 스크롤 이벤트 발생시키기
		$(window).scroll(function(){
			
			// 스크롤탑의 위치값 (스크롤 ^ 표시와 회색 바 넓이)
		//	console.log("$(window).scrollTop() => " + $(window).scrollTop());
			// $(window).scrollTop() => 674

			// 웹브라우저 창의 높이값 (고정된 값임)
		//	console.log("$(window).height() => " + $(window).height());
			// $(window).height() => 662
			
			// 보여줘야할 문서(더보기를 해주므로 append 돼서 높이가 계속 증가함)의 높이값
		//	console.log("$(document).height() => " + $(document).height());
			// $(document).height() => 1336
			
			
			if( $(window).scrollTop() >= $(document).height() - $(window).height() ) {
				/* 스크롤탑의 위치값				      보여줘야할 문서 높이 - 창 높이   */
			
				start = start + lenHIT;
				displayHIT(start);
			}
			
			else if($(window).scrollTop()== 0) {
				// 다시 처음부터 시작하도록 함
				$("#displayHIT").empty();
				$("#end").empty();
				$("#countHIT").text("0");
				
				start = 1; // 증가된 start 다시 초기화
				displayHIT(start);
			}
			
		});
		
	}); // end of $(document).ready(function())---------------------------


	var lenHIT = 8; // 다른데서도 쓸거라서 밖으로 뺌 
	// HIT 상품 '더보기'버튼을 클릭할 때 보여줄 상품의 갯수 단위
	
	// 보여줄 HIT 상품 정보를 추가 요청하는 함수(Ajax로 처리)	
	function displayHIT(start) {
		// start가 1이라면 1~8까지 8개의 상품을 보여준다.
		// start가 9라면 9~16까지 8개의 상품을 보여준다.
		// start가 17이라면 17~24까지 8개의 상품을 보여준다.
		// start가 25라면 25~32까지 8개의 상품을 보여준다.
		// start가 33이라면 33~37까지 5개의 상품을 보여준다.
		
		$.ajax({
			
			url:"/MyMVC/shop/mallDisplayJSON.up",
		//	type:"GET",
			data:{"pspec":"HIT" /* pspec은 getParameter해 올 이름 */
				 ,"start":start
				 ,"len":lenHIT},
			dataType:"JSON",
			success:function(json){
				
				var html = "";
				
				if(start=="1" && json.length == 0) {
					// 처음부터 데이터가 존재하지 않는 경우
		    		// !!! 주의 !!!
		    		// if(json == null) 이 아님!!!
		    		// if(json.length == 0) 으로 해야함!!
		    		html += "현재 상품 준비중....";
		    		
		    		// HIT 상품 결과를 출력하기
		    		$("#displayHIT").html(html);
		    		
				}
				
				else {
					// 데이터가 존재하는 경우
					$.each(json, function(index, item){
						
						html += "<div class='moreProdInfo'><a href='/MyMVC/shop/prodView.up?pnum="+item.pnum+"'><img width='120px;' height='130px;' src='/MyMVC/images/"+item.pimage1+"'/></a>"
					          + "<br/>"
					          + "제품명 : "+item.pname+"<br/>"
	 	                 	  + "정가 : <span style=\"color: red; text-decoration: line-through;\">"+(item.price).toLocaleString('en')+" 원</span><br/>"
	 	                 	  + "판매가 : <span style=\"color: red; font-weight: bold;\">"+(item.saleprice).toLocaleString('en')+" 원</span><br/>"
	 	                 	  + "할인율 : <span style=\"color: blue; font-weight: bold;\">["+item.discoutPercent+"%] 할인</span><br/>"
	 	                 	  + "포인트 : <span style=\"color: orange;\">"+item.point+" POINT</span><br/>"
					          +"</div>";
					          
						if( (index+1)%4 == 0 ) {
							html += "<br/>";
						}
						
					}); // end of $.each() ------------------------------------
				
					// HIT 상품 결과 출력하기
					$("#displayHIT").append(html); 
					// 				 ▲ 차곡차곡 쌓아서 보여줌
					
		    		// countHIT에 지금까지 출력된 누적된 상품의 개수를 기록한다.
		    		$("#countHIT").text( Number($("#countHIT").text()) + json.length );
		    		
					// 36 36 같으면 더보기 버튼 없애기
		    		// 더보기 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
		    		if( $("#countHIT").text() == $("#totalHITCount").text() ) {
		    			$("#end").html("더이상 조회할 상품이 없습니다.");
		    			$("#btnMoreHIT").text("처음으로");
		    			$("#countHIT").text("0");
		    		}
		    		
		    		// header.jsp의 하단에 표시된 div content의 height 값을 구해서, 
		    		// header.jsp의 div sideinfo의 height값으로 설정하기
		    		
		    		func_height(); // footer.jsp에 있음	
		    		
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	} // end of function displayHIT(start) -------------------------

</script>

	<h2>::: 쇼핑몰 상품 :::</h2>
	<br/>
	
	<%-- 
	
	=== HIT 상품을 모두 가져와서 디스플레이 (페이징 처리 안 한것) ===
	
	<table style="width: 90%; border: solid 0px gray;">
		<thead>
			<tr>
				<th colspan="4" class="th" style="font-size: 14pt; background-color: #e1e1d0; height: 30px; text-align:center; padding:15px 0;">- HIT 상품 -</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${empty hitList}">
			   <tr>
			   	  <td colspan="4" class="td" align="center">현재 상품 준비중...</td>
			   </tr>			
			</c:if>
			
			<c:if test="${not empty hitList}">
				<tr>
				    <c:forEach var="pvo" items="${hitList}" varStatus="status">
				    <!-- status.index 는 0 부터 시작해서 1씩 증가한다.
				         status.count 는 1 부터 시작해서 1씩 증가한다. -->
				       <td class="td" align="center" width="25%" style="padding: 20px 0;">
						   <a href='/MyMVC/shop/prodView.up?pnum=${pvo.pnum}'><img width="120px;" height="130px;" src="/MyMVC/images/${pvo.pimage1}" /></a>
						   <!-- 제품 누르면 상세페이지 갈 수 있도록	 ▲ 제품 번호를 넘겨줌 -->
				       	   <br/>제품명: ${pvo.pname}
				       	   <br/>정가: <span style="text-decoration: line-through;"><fmt:formatNumber value="${pvo.price}" pattern="###,###" />원</span>        
				       	   <br/><span style="color: red; font-weight: bold;">판매가: <fmt:formatNumber value="${pvo.saleprice}" pattern="###,###" />원</span> 
				       	   <br/><span style="color: blue; font-weight: bold;">할인율: [${pvo.discountPercent}%]할인</span>
				       	   <br/><span style="color: orange;">포인트: ${pvo.point}&nbsp;POINT</span>
				       <!-- <br/>${status.count} -->
				       </td>
				       <c:if test="${ (status.count)%4 == 0 }">
				       </tr>
				       <tr>
				       </c:if>
				    </c:forEach>
				</tr>
			</c:if>
		</tbody>
	</table>
	
	--%>
	
	
	
	<%-- 	=== HIT 상품을 모두 가져와서 디스플레이 (더보기 방식으로 페이징 처리 한것) ===	--%>
	<div>
		<div style="margin: 20px 0;">- HIT 상품 -</div>
		<div id="displayHIT"></div> 
		<!-- ▲ 실제 상품정보가 8개씩 들어옴 -->
		<div style="margin: 20px 0;">
			<span id="end" style="font-size:  16pt; font-weight: bold; color: red;"></span><br/>
			<span id="totalHITCount">${totalHITCount}</span>
			<span id="countHIT">0</span> <!-- 지금까지 누적해서 본 상품 수 8+8+.. -->
		</div>
	</div>
	
	
<jsp:include page="../footer.jsp" />
