package my.util;

public class MyUtil {
	
	// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드)를 작성해주는 메소드 생성 *** // 
	public static String replaceParameter(String param) {
		String result = param;
		
		if(param != null) {
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
		//	result = result.replaceAll("&", "&amp;");
		//	result = result.replaceAll("\"", "&quot;");
		}

		return result;
	}

}
