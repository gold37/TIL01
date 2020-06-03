/*	
 	JavaScript
 	
 	금액 세자리 마다 콤마를 찍어서 리턴시켜주는 함수 (필요할 때 마다 갖다쓰기용) 
 	
 */

function func_comma(num) {
		
		/* var sResult = "안녕하세요";  */
		var sResult = ""; // 숫자가 아니면 두번째 칸 텅비워짐
		
		if(isNaN(num)) {	// isNaN(Not a Number)은 문자 또는 문자열인데 입력받은 값이 숫자가 아니라면 true,
			   	 		    //    										          숫자라면 false를 돌려줌
			alert("숫자가 아니군요!");
		
		}else {
			/* alert("숫자입니다!"); */
			/* alert( parseInt(num.length / 3) ); // 10/3 -> java: 3  javaScript:3.333333 나오기때문에 parseInt해서 정수만 나오게 함 */
			
			var nBlockCount = 0; // 세자리마다 분할되어 나온 블럭수 ex) 1,234,567 -> 3블럭 (블럭수-1=콤마수)
			var nStartCommaIndex = 0; // 콤마가 시작되는 지점(인덱스 값)
			
			if(num.length%3 != 0) {// 입력받은 num의 (string타입)길이를 3으로 나눈 나머지가 0이 아니라면 ( == 3의 배수가 아니다 )
				nBlockCount = parseInt(num.length / 3) + 1; // 뒤에 소수가 있기 때문에 +1로 토막 수 하나 더 늘림 
				nStartCommaIndex = num.length % 3;
				
			} else { // 3의 배수인 경우
				nBlockCount = num.length/3; 
				nStartCommaIndex = 3; // 123,456 -> 인덱스 [0123]
				
			}
			
			var nStartIndex = 0; // num.substring(0,1) 안에 있는 인덱스 숫자 매번 바뀌기 때문에 start 변수 하나 만들어줌
			for(var i=0; i<nBlockCount; i++) { // for(var i=0; i<4; i++)
				// nBlockCount는 반복횟수 
				
				/* 
					num --> 1234567890
				
					num.substring(0,1)+"," 1번째	1,
					num.substring(1,4)+"," 1번째	234,
					num.substring(4,7)+"," 1번째	567,
					num.substring(7,10) 4번째 890
					
				*/
				var sComma = (i < nBlockCount-1)? ",":"";
				sResult += num.substring(nStartIndex, nStartCommaIndex)+ sComma; 
				
				nStartIndex = nStartCommaIndex; // 시작 값 전에 콤마값이랑 똑같으니까 (위에 예시 참고) 
				nStartCommaIndex += 3; // 콤마 값 3씩 증가
				 
				 
			} // end of for() ---------------
		}
		
		return sResult; 
		
	}

function func_sort(arrArray) {

	var sString = document.getElementById("text1").value;
	var arrArray = sString.split(",");
	
	for(var i=0; i<arrArray.length; i++) {
		// i=0, i=1, i=2, i=3, i=4, 
		for(var j=0; j<arrArray.length-i-1; j++) {
			// j=0; j<4; j++ 
			// j=0; j<3; j++ 
			// j=0; j<2; j++ 
			// j=0; j<1; j++ 
			
			if(Number(arrArray[j]) > Number(arrArray[j+1])){ // 앞에것이 숫자로 바꿨을 때 뒤에것보다 크다면
								// ▲내림차순하고 싶으면 부등호 < 로 바꾸면 됨
					var temp = arrArray[j];// 자리를 바꿔라
					arrArray[j] = arrArray[j+1];
					arrArray[j+1] = temp;
				}
			} // end of for -----------
		} // end of for -----------
		var sResult = arrArray.join(","); // 해당 문자열 콤마(,) 찍어서 배열로 바꿈
		
		return sResult;
}




// === 주민번호를 검사하는 함수 === // 
/*
 	주민번호 공식에 맞으면 true를 리턴하고, 틀리면 false를 리턴한다.
 */
function func_jubunCheck(jubun) {
	
	// 9210201234567(공식에 틀린것), 2131021(공식에 맞는것)
	
	if(jubun.length != 13) {
		return false;
	}
	
	else {
		// 9*2 2*3 1*4 0*5 2*6 0*7 1*8 2*9 3*2 4*3 5*4 6*5
		var nSum = 0; //누적용 변수
		
		for(var i=0; i<12; i++) {
			
			if(i<8)
				nSum += Number(jubun.substring(i, i+1)) *(i+2);
			else
				nSum += Number(jubun.substring(i, i+1)) *(i-6);
			
		} // end of for()----------------------
		
		// nSum ==> 134
		var nResult = nSum%11; // nSum을 11로 나눈 나머지 ==> 2
		nResult = 11 - nResult;// ==> 11-2 = 9
		
		nResult %= 10; // 9%10 (9를 10으로 나눈 나머지) ==> 9
		
		if( nResult == Number(jubun.substring(12,13)) )
			return true;
		else
			return false;
	}
	
} // end of function func_jubunCheck(jubun) ------------------



