<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../header.jsp" />
   
<style type="text/css" >
   table#tblCartList {width: 90%;
                      border: solid gray 1px;
                      margin-top: 20px;
                      margin-left: 10px;
                      margin-bottom: 20px;}
                      
   table#tblCartList th {border: solid gray 1px;}
   table#tblCartList td {border: dotted gray 1px;} 
   
   .delcss {background-color: cyan;
            font-weight: bold;
            color: blue;}
  
</style>

<script type="text/javascript">

   $(document).ready(function(){
      
      $(".spinner").spinner({
         spin: function(event, ui) {
            if(ui.value > 100) {
               $(this).spinner("value", 100);
               return false;
            }
            else if(ui.value < 0) {
               $(this).spinner("value", 0);
               return false;
            }
         }
      });// end of $(".spinner").spinner({});-----------------
      
      
      $(".del").hover(function(){
                    $(this).addClass("delcss");
                      },
                      function(){
                        $(this).removeClass("delcss");
                      });
      
      
      // 제품번호의 모든 체크박스가 체크가 되었다가 그 중 하나만 이라도 체크를 해제하면 전체선택 체크박스에도 체크를 해제하도록 한다.
      $(".chkboxpnum").click(function(){
         
         var bFlag = false;
         $(".chkboxpnum").each(function(){
            var bChecked = $(this).prop("checked");
            if(!bChecked) {
               $("#allCheckOrNone").prop("checked",false);
               bFlag = true;
               return false;
            }
         });
         
         if(!bFlag) {
            $("#allCheckOrNone").prop("checked",true);
         }
         
      });
      
      
      
   }); // end of $(document).ready()--------------------------
   
   
   function allCheckBox() {
   
      var bool = $("#allCheckOrNone").is(":checked");
      /*
         $("#allCheckOrNone").is(":checked"); 은
           선택자 $("#allCheckOrNone") 이 체크되어지면 true를 나타내고,
           선택자 $("#allCheckOrNone") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
      */
      
      $(".chkboxpnum").prop("checked", bool);
   }// end of function allCheckBox()-------------------------
   
   
   function goOqtyEdit(obj) {
      
      var index = $(".updateBtn").index(obj); // 여러개 수정 버튼 중 실제 클릭한 곳의 인덱스 번호를 알아옴
    //alert(index);
      
      var cartno = $(".cartno").eq(index).val(); // 장바구니 번호
      var oqty = $(".oqty").eq(index).val(); // 수량을 알아와서 oqty변수에 넣음
      
      var regExp = /^[0-9]+$/g; // 숫자만 체크하는 정규표현식
      var bool = regExp.test(oqty);
  
      if(!bool) {
         alert("수정하시려는 수량은 0개 이상이어야 합니다.");
         location.href="javascript:history.go(0);";
         return;
      }
            
   //  alert("장바구니번호 : " + cartno + "\n주문량 : " + oqty);
      else if(oqty == "0") {
         goDel(cartno);
      }
      else {
         $.ajax({
               url:"/MyMVC/shop/cartEdit.up",
               type:"POST",
               data:{"cartno":cartno,
                     "oqty":oqty},
               dataType:"JSON",
               success:function(json){
                  if(json.n == 1) {
                     location.href= "<%= request.getContextPath()%>/${goBackURL}"; 
                  }
               },
               error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
            });
      }
   }// end of function goOqtyEdit(obj)-----------------
   
   
   // === 장바구니에서 특정 제품을 비우기 === //  
   function goDel(cartno) {
      
      var $target = $(event.target);
      var pname = $target.parent().parent().find(".cart_pname").text();
      					/* 두단계 위로 올라감. td->tr */
      var bool = confirm(pname+"을 장바구니에서 제거하시는 것이 맞습니까?");
      			/* 한번 더 물어봄 */
    //alert(bool); // yes면 true 취소면 false

      if(bool) {
         
         $.ajax({
            url:"/MyMVC/shop/cartDel.up",
            type:"POST",
            data:{"cartno":cartno},
            dataType:"JSON",
            success:function(json){
               if(json.n == 1) { // 특정 제품을 장바구니에서 비운후 페이지이동을 해야 하는데 이동할 페이지는 페이징 처리하여 보고 있던 그 페이지로 가도록 한다. 
                  location.href= "<%= request.getContextPath()%>/${goBackURL}"; 
               }
            },
            error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
         });
         
      }
      else {
         alert("장바구니에서 "+pname+" 제품 삭제를 취소하셨습니다.");
      }
   	}// end of function goDel(cartno)---------------------------
   
   
   // === 장바구니에서 제품 주문하기 === // 
   function goOrder() {
       
      ///// == 체크박스의 체크된 갯수(checked 속성이용) == /////
       var checkCnt = $("input:checkbox[name=pnum]:checked").length;
       
      if(checkCnt < 1) {
          alert("주문하실 제품을 선택하세요!!");
          return;
       }
       
       else {
            //// == 체크박스에서 체크된 value값(checked 속성이용) == ////
            ///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. /// 
            var allCnt = $("input:checkbox[name=pnum]").length;
           
            var pnumArr = new Array();
            var oqtyArr = new Array();
            var cartnoArr = new Array();
            var totalPriceArr = new Array();
            var totalPointArr = new Array();
            
             for(var i=0; i<allCnt; i++) {
                if( $("input:checkbox[class=chkboxpnum]").eq(i).is(":checked") ) {
                  pnumArr.push( $("input:checkbox[class=chkboxpnum]").eq(i).val() );
                  oqtyArr.push( $(".oqty").eq(i).val() );
                  cartnoArr.push( $(".cartno").eq(i).val() );
                  totalPriceArr.push( $(".totalPrice").eq(i).val() );
                  totalPointArr.push( $(".totalPoint").eq(i).val() );
               }
            }
               
            for(var i=0; i<checkCnt; i++) {
               console.log("확인용 제품번호 : " + pnumArr[i] + ", 주문량 : " + oqtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액 : " + totalPriceArr[i] + ", 포인트 : " + totalPointArr[i]);
            }
            
            var pnumjoin = pnumArr.join();
            var oqtyjoin = oqtyArr.join();
            var cartnojoin = cartnoArr.join();
            var totalPricejoin = totalPriceArr.join();

            var sumtotalPrice = 0;
            for(var i=0; i<totalPriceArr.length; i++) {
               sumtotalPrice += parseInt(totalPriceArr[i]);
            }

            var sumtotalPoint = 0;
            for(var i=0; i<totalPointArr.length; i++) {
               sumtotalPoint += parseInt(totalPointArr[i]);
            }
            
            console.log("확인용 pnumjoin : " + pnumjoin);
            console.log("확인용 oqtyjoin : " + oqtyjoin);
            console.log("확인용 cartnojoin : " + cartnojoin);
            console.log("확인용 totalPricejoin : " + totalPricejoin);
            console.log("확인용 sumtotalPrice : " + sumtotalPrice);
            console.log("확인용 sumtotalPoint : " + sumtotalPoint);
            
                var currentcoin = ${sessionScope.loginuser.coin};
                 
            if( sumtotalPrice > currentcoin ) {
               alert("코인잔액이 부족하므로 주문이 불가합니다.\n주문총액:"+sumtotalPrice+" , 코인액:"+currentcoin+"");
               return;
            }
            else {
               
               $.ajax({
                  url:"/MyMVC/shop/orderAdd.up",
                  type:"POST",
                  data:{"pnumjoin":pnumjoin,
                       "oqtyjoin":oqtyjoin, 
                       "cartnojoin":cartnojoin,
                       "totalPricejoin":totalPricejoin,
                       "sumtotalPrice":sumtotalPrice,
                       "sumtotalPoint":sumtotalPoint},
                  dataType:"JSON",     
                  success:function(json){
                     if(json.isSuccess == 1) {
                        location.href="/MyMVC/shop/orderList.up";
                     }
                     else {
                        location.href="/MyMVC/shop/orderError.up";
                     }
                  },
                  error: function(request, status, error){
                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                  }
               });
               
            }   
       }
   }// end of function goOrder()----------------------
   
</script>

<h3>::: ${(sessionScope.loginuser).name} 님[ ${(sessionScope.loginuser).userid} ] 장바구니 목록 :::</h3>   

 <%-- 장바구니에 담긴 제품목록을 보여주고서 실제 주문을 하도록 form 생성한다. --%>
 <form name="orderFrm">
     <table id="tblCartList" >
    <thead>
      <tr>
       <th style="border-right-style: none;">
           <input type="checkbox" id="allCheckOrNone" onClick="allCheckBox();" />
           <span style="font-size: 10pt;"><label for="allCheckOrNone">전체선택</label></span>
       </th>
       <th colspan="5" style="border-left-style: none; font-size: 12pt; text-align: center;">
           주문하실 제품을 선택하신후 주문하기를 클릭하세요
       </th>
      </tr>
      
      <tr style="background-color: #cfcfcf;">
        <th style="width:10%; text-align: center; height: 30px;">제품번호</th>
        <th style="width:23%; text-align: center;">제품명</th>
           <th style="width:17%; text-align: center;">수량</th>
           <th style="width:20%; text-align: center;">판매가/포인트(개당)</th>
           <th style="width:20%; text-align: center;">총액</th>
           <th style="width:10%; text-align: center;">삭제</th>
      </tr>   
    </thead>
    
    <tbody>
      <c:if test="${cartList == null || empty cartList}">
      <tr>
           <td colspan="6" align="center">
             <span style="color: red; font-weight: bold;">
                장바구니에 담긴 상품이 없습니다.
             </span>
           </td>   
      </tr>
      </c:if>   
      
      <c:if test="${cartList != null && not empty cartList}">
                 
          <c:forEach var="cartvo" items="${cartList}" varStatus="status"> 
          <tr>
               <td> <%-- 체크박스 및 제품번호 --%>
                    <%-- c:forEach 에서 선택자 id를 고유하게 사용하는 방법  
                         varStatus="status" 을 이용하면 된다.
                         status.index 은 0 부터 시작하고,
                         status.count 는 1 부터 시작한다. 
                    --%> 
                    <input type="checkbox" name="pnum" class="chkboxpnum" id="pnum${status.index}" value="${cartvo.pnum}" /> &nbsp;<label for="pnum${status.index}">${cartvo.pnum}</label>   
               </td>
               <td align="center"> <%-- 제품이미지1 및 제품명 --%> 
                  <a href="/MyMVC/shop/prodView.up?pnum=${cartvo.pnum}">
                     <img src="/MyMVC/images/${cartvo.prod.pimage1}" width="130px" height="100px" />
                  </a> 
                  <br/><span class="cart_pname">${cartvo.prod.pname}</span> 
               </td>
               <td align="center"> 
                   <%-- 수량 --%>
                     <input class="spinner oqty" name="oqty" value="${cartvo.oqty}" style="width: 30px; height: 20px;">개
                     
                     <%-- 장바구니번호 --%>
                     <input class="cartno" type="hidden" name="cartno" value="${cartvo.cartno}" />
                     <button class="updateBtn" type="button" onclick="goOqtyEdit(this);">수정</button>
               </td>
               <td align="right"> <%-- 실제판매단가 및 포인트 --%> 
                   <fmt:formatNumber value="${cartvo.prod.saleprice}" pattern="###,###" /> 원
                   <input type="hidden" name="saleprice" id="" value="" />
                   <br/><span style="color: green; font-weight: bold;"><fmt:formatNumber value="${cartvo.prod.point}" pattern="###,###" /> POINT</span>
               </td>
               <td align="right"> <%-- 총금액 및 총포인트 --%> 
                   <span id="totalprice">
                      <fmt:formatNumber value="${cartvo.prod.totalPrice}" pattern="###,###" />
                   </span> 원
                   <input class="totalPrice" type="hidden" value="${cartvo.prod.totalPrice}" />
                   <br/>
                   
                   <span style="color: green; font-weight: bold;">
                   <span id="totalpoint">
                      <fmt:formatNumber value="${cartvo.prod.totalPoint}" pattern="###,###" /> 
                   </span> POINT</span>
                   <input class="totalPoint" type="hidden" value="${cartvo.prod.totalPoint}" />
               </td>
               <td align="center"> <%-- 장바구니에서 해당 제품 삭제하기 --%> 
                     <span class="del" style="cursor: pointer;" onClick="goDel('${cartvo.cartno}');">삭제</span>
               </td>
            </tr>
           </c:forEach>
      </c:if>   
      
      <tr>
           <td colspan="3" align="right">
              <span style="font-weight: bold;">장바구니 총액 :</span>
              <span style="color: red; font-weight: bold;"><fmt:formatNumber value="${sumMap.SUMTOTALPRICE}" pattern="###,###" /> 원</span>
              <br/>
              <span style="font-weight: bold;">총 포인트 :</span> 
              <span style="color: red; font-weight: bold;"><fmt:formatNumber value="${sumMap.SUMCARTPOINT}" pattern="###,###" /> POINT</span>
           </td>
           <td colspan="3" align="center">
              <%-- <span class="ordershopping" style="cursor: pointer;" onClick="goOrder();">[주문하기]</span>&nbsp;&nbsp; --%>
              <span class="ordershopping" style="cursor: pointer;" onClick="">[주문하기]</span>&nbsp;&nbsp;
              <span class="ordershopping" style="cursor: pointer;" onClick="javascript:location.href='<%= request.getContextPath() %>/shop/mallHome.up'">[계속쇼핑]</span>
           </td>
      </tr>
      
    </tbody>
   </table> 
 </form>          

 <%-- === 페이지바 === --%>
 <%--
 <div align="center" style="margin-top: 20px;">
    ${requestScope.pageBar}
 </div>
 --%>

 <%-- 장바구니에 담긴 제품수량을 수정하는 form --%>
 <form name="updateOqtyFrm">
    <input type="hidden" name="cartno" />
    <input type="hidden" name="oqty" />
 </form>
 
 
 <%-- 장바구니에 담긴 제품을 삭제하는 form --%> 
    
<jsp:include page="../footer.jsp" />    