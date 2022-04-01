package kr.co.edu.util;
import java.security.*;

 /**
 * <p>제목: 게인정보 암호화(단방향 암호 알고리즘)</p>
 * <p>설명: </p>
 * <p>Copyright: </p>
 * <p>Company:  </p>
 */
public class HashCipher {

     public HashCipher() {
	}

    //해쉬 생성
    public static String createHash(String data) throws Exception {

        MessageDigest md = MessageDigest.getInstance("SHA-256");

        byte[] bytedata = data.getBytes();
        md.update(bytedata);
        byte[] digest = md.digest();       //배열로 저장

        StringBuffer result = new StringBuffer();
        for (int i=0; i<digest.length; i++) {
            result.append(Integer.toHexString(digest[i] & 0xff));
        }
        return result.toString();
    }


    public static boolean isPasswordValid(String encPwd, String nonEncPwd) throws Exception {
    	if (encPwd.equals(HashCipher.createHash(nonEncPwd))) {
    		return true;
    	}
    	else {
    		return false;
    	}
    }


}
