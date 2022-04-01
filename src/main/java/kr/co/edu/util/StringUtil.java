package kr.co.edu.util;

public class StringUtil {

	public static String maskingTag(String str) throws Exception{
		String result = "";
		int len = 0;
		try{
			if( str != null && !str.equals("") ){
				len = str.length();
				for(int i=0; i<len; i++){
					if( i == 0 || (len == i+1 && len != 2) ){
						result += str.charAt(i);
					}else{
						result += "*";
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
}
