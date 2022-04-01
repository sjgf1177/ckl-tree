/*****************************************************************************
 * PROJECT NAME   : 올레마켓 웹툰
 * SUBSYSTEM NAME : 사용자
 * FILE NAME      : CookieUtil.java
 * DESCRIPTION    : Cookie 관련 Util class.
 *
 * VERSION NO     author           date        content  -> info
 * ----------------------------------------------------------------------------
      1.0        InJae Yeo      2014-04-15      init
 *****************************************************************************/

package kr.co.unp.util;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CookieUtil {

	protected static Log logger = LogFactory.getLog(CookieUtil.class);
	public final static String accountSeperator = ":";

	private static String key = "1234abcd";
	private static String charset = "UTF-8"; //"UTF-8";

	/**
	 * 쿠키명을 전달받아 해당 쿠키값을 가져온다.
	 * @param HttpServletRequest request : HttpServletRequest 객체
	 * @param String cookieName          : 쿠키명
	 * @return String cookieVal          : 쿠키값
	 * @throws Exception
	 */
	public static String getCookie(HttpServletRequest request, String cookieName) throws Exception {

		Cookie[] cookies = null;
		String cookieVal = null;

		try	{

			cookies = request.getCookies();

			if(cookieName==null || cookies==null) {
				return null;
			}

			for(int i = 0; i < cookies.length; i++) {

				//쿠키값이 없거나 "null" 이라는 문자열로 들어왔는지 체크하여 쿠키값을 반환한다.
				if(cookieName.equals(cookies[i].getName())) {
					if(StringUtil.isEmptyOrWhitespace(cookies[i].getValue()) || (cookies[i].getValue()).equals("null")) {
                		return null;
                	} else {
                		cookieVal = URLDecoder.decode(cookies[i].getValue(), "UTF-8");
                		break;
                	}
				}

			}

		} catch (Exception e) {
			logger.error(e);
			throw e;
		}

		return cookieVal;

	}

	/**
	 * 쿠키를 세팅한다.
	 *
	 * @param HttpServletResponse response : HttpServletResponse 객체
	 * @param String cookieName            : 쿠키명
	 * @param String cookieValue           : 쿠키값
	 * @param int age                      : 쿠키 유효시간 (초단위, -1을 넘기면 브라우져 종료시 쿠키가 종료된다.)
	 * @param String path                  : 쿠키경로
	 * @param String domain                : 쿠키 도메인
	 * @return void
	 * @throws Exception
	 */
	public static void setCookie(HttpServletResponse response, String cookieName, String cookieValue, int age, String path, String domain) throws Exception {

		StringBuilder cookieStr = new StringBuilder();
		Date expireDate = null;
		DateFormat dateFormat = null;

		//쿠키명은 필수항목이다.
		/*if(StringUtil.isEmptyOrWhitespace(cookieName)) {
			throw new Exception();
		}*/

		try	{

			//쿠키명과 값을 세팅한다.
			cookieStr.append(cookieName + "=");
			cookieStr.append(URLEncoder.encode(StringUtil.changeNullToEmpty(cookieValue), "UTF-8") + "; ");

			//쿠키 만료일자를 세팅한다.
			if(age == 0) {
				cookieStr.append("expires=Thu, 01 Jan 1970 00:00:00 GMT; ");
			} else if (age > 0) {
				expireDate = new Date();
				expireDate.setTime(expireDate.getTime() + ((long)age * 1000));

				dateFormat = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss", Locale.ENGLISH);
				dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));

				cookieStr.append("expires=" + dateFormat.format(expireDate) + " UTC; ");
			}

			//쿠키 경로를 세팅한다.
			if(!StringUtil.isEmptyOrWhitespace(path)) {
				cookieStr.append("path=").append(path).append("; ");
			}

			//쿠키 도메인을 세팅한다.
			if(!StringUtil.isEmptyOrWhitespace(domain)) {
				cookieStr.append("domain=").append(domain).append("; ");
			}

			//쿠키를 response 객체에 세팅한다.
			response.addHeader("Set-Cookie", cookieStr.toString());

		} catch (Exception e) {
			logger.error(e);
			throw e;
		}

	}

	/**
	 * 쿠키명을 전달받아 쿠키를 삭제한다.
	 *
	 * @param HttpServletResponse response : HttpServletResponse 객체
	 * @param String cookieName            : 쿠키명
	 * @return void
	 */
	public static void deleteCookie(HttpServletResponse response, String cookieName) {

		try	{
			setCookie(response, cookieName, null, 0, "/", null);
		} catch (Exception e) {
			logger.error(e);
		}

	}

	/**
	 * 쿠키명과 도메인을 전달받아 쿠키를 삭제한다.
	 *
	 * @param HttpServletResponse response : HttpServletResponse 객체
	 * @param String cookieName            : 쿠키명
	 * @param String domain                : 도메인
	 * @return void
	 */
	public static void deleteCookie(HttpServletResponse response, String cookieName, String domain) {

		try {
			setCookie(response, cookieName, null, 0, "/", domain);
		} catch (Exception e) {
			logger.error(e);
		}

	}



	private static String decrypt(String message) throws Exception {
		byte[] bytesrc = convertHexString(message);
	    Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
	    DESKeySpec desKeySpec = new DESKeySpec(key.getBytes(charset));
	    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
	    SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
	    IvParameterSpec iv = new IvParameterSpec(key.getBytes(charset));

	    cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
	    byte[] retByte = cipher.doFinal(bytesrc);
	    return new String(retByte);
	}

	private static String encrypt(String message) throws Exception {
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		DESKeySpec desKeySpec = new DESKeySpec(key.getBytes(charset));
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		IvParameterSpec iv = new IvParameterSpec(key.getBytes(charset));
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
		return toHexString(cipher.doFinal(message.getBytes(charset)));
	}

	private static byte[] convertHexString(String ss) {
	    byte digest[] = new byte[ss.length() / 2];
	    for (int i = 0; i < digest.length; i++) {
	      String byteString = ss.substring(2 * i, 2 * i + 2);
	      int byteValue = Integer.parseInt(byteString, 16);
	      digest[i] = (byte) byteValue;
	    }
	    return digest;
	}

	private static String toHexString(byte b[]) {
	    StringBuffer hexString = new StringBuffer();
	    for (int i = 0; i < b.length; i++) {
	      String plainText = Integer.toHexString(0xff & b[i]);
	      if (plainText.length() < 2)
	        plainText = "0" + plainText;
	      hexString.append(plainText);
	    }
	    return hexString.toString();
	}

	public static String[] decodeAccount(String cookieValue) {
	    try {

			//System.out.println("+++++++++++ decodeAccount try ++++++++++++++");
	      String origi = CookieUtil.decrypt(cookieValue);	
			//System.out.println("+++++++++++ origi"+origi+" ++++++++++++++");
	      String[] parts = origi.split(CookieUtil.accountSeperator);
			//System.out.println("+++++++++++ parts"+parts[0]+" ++++++++++++++");
	      if (parts.length == 3 && !parts[0].equals("") && !parts[1].equals("") && parts[2] != null) {
	        return parts;
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	    return null;
	}

	public static String encodeAccount(String username, String password, String sttus) throws Exception {
		String encryptString = null;
		try {
			encryptString = CookieUtil.encrypt(username + CookieUtil.accountSeperator + password + CookieUtil.accountSeperator + sttus);
		} catch (Exception e) {

		}
		return encryptString;
	}


}