package kr.co.unp.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import Kisinfo.Check.IPINClient;
import egovframework.com.cmm.service.EgovProperties;

public class RealNameAuthUtil {

	static Logger log = Logger.getLogger(RealNameAuthUtil.class);
	
	public static String getPhoneAuth(HttpSession session, String urlCode) {
		// 날짜 생성
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String day = sdf.format(today.getTime());

		java.security.SecureRandom ran = new java.security.SecureRandom();
		// 랜덤 문자 길이
		int numLength = 6;
		String randomStr = "";

		for (int i = 0; i < numLength; i++) {
			// 0 ~ 9 랜덤 숫자 생성
			randomStr += ran.nextInt(10);
		}

		// reqNum은 최대 40byte 까지 사용 가능
		String reqNum = day + randomStr;

		// tr_cert 데이터 변수 선언 ---------------------------------------------------------------
		String tr_cert = "";
		String cpId = "JRGM1001"; // 회원사ID
		String certNum = reqNum; // 요청번호
		String date = day; // 요청일시
		String certMet = "M"; // 본인인증방법
		String name = ""; // 성명
		String phoneNo = ""; // 휴대폰번호
		String phoneCorp = ""; // 이동통신사
		if (phoneCorp == null)
			phoneCorp = "";
		String birthDay = ""; // 생년월일
		String gender = ""; // 성별
		if (gender == null)
			gender = "";
		String nation = ""; // 내외국인 구분
		String plusInfo = ""; // 추가DATA정보
		String extendVar = "0000000000000000"; // 확장변수
		// End-tr_cert 데이터 변수 선언 ---------------------------------------------------------------

		/**
		 * certNum 주의사항 ************************************************************************************** 1. 본인인증 결과값 복호화를 위한 키로 활용되므로 중요함. 2. 본인인증 요청시 중복되지 않게 생성해야함. (예-시퀀스번호) 3. certNum값은 본인인증 결과값 수신 후 복호화키로 사용함. tr_url값에 certNum값을 포함해서 전송하고, (tr_url = tr_url + "?certNum=" + certNum;)
		 * tr_url에서 쿼리스트링 형태로 certNum값을 받으면 됨. (certNum = request.getParameter("certNum"); )
		 * 
		 ***********************************************************************************************************/

		// 01. 한국모바일인증(주) 암호화 모듈 선언
		com.icert.comm.secu.IcertSecuManager seed = new com.icert.comm.secu.IcertSecuManager();

		// 02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
		String enc_tr_cert = "";
		tr_cert = cpId + "/" + urlCode + "/" + certNum + "/" + date + "/"
				+ certMet + "/" + birthDay + "/" + gender + "/" + name + "/"
				+ phoneNo + "/" + phoneCorp + "/" + nation + "/" + plusInfo
				+ "/" + extendVar;
		enc_tr_cert = seed.getEnc(tr_cert, "");

		// 03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
		String hmacMsg = "";
		hmacMsg = seed.getMsg(enc_tr_cert);

		// 04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
		tr_cert = seed
				.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");
		return tr_cert;
	}

	public static String getRealNameAuth(HttpSession session, String srvNo) {

		// 날짜 생성
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String day = sdf.format(today.getTime());

		java.security.SecureRandom ran = new java.security.SecureRandom();
		// 랜덤 문자 길이
		int numLength = 6;
		String randomStr = "";

		for (int i = 0; i < numLength; i++) {
			// 0 ~ 9 랜덤 숫자 생성
			randomStr += ran.nextInt(10);
		}

		// reqNum은 최대 30byte 까지 사용 가능
		String reqNum = day + randomStr;
		String id = "JNG001"; // 가상식별실명확인 회원사 아이디
		String exVar = "0000000000000000"; // 복호화용 임시필드

		/**
		 * 
		 * reqNum 값은 최종 결과값 복호화를 위한 SecuKey로 활용 되므로 중요합니다. reqNum 은 실명 확인 요청시 항상 새로운 값으로 중복 되지 않게 생성 해야 합니다. 쿠키 또는 Session및 기타 방법을 사용해서 reqNum 값을 vname_result_seed.jsp에서 가져 올 수 있도록 해야 함. 샘플을 위해서 쿠키를 사용한 것이므로 참고 하시길 바랍니다.
		 * 
		 */
		// Cookie c = new Cookie("reqNum", reqNum);
		// c.setMaxAge(1800); // <== 필요시 설정(초단위로 설정됩니다)
		// response.addCookie(c);
		session.setAttribute("reqNum", reqNum);

		// 01. 암호화 모듈 선언
		com.sci.v2.comm.secu.SciSecuManager seed = new com.sci.v2.comm.secu.SciSecuManager();

		// 02. 1차 암호화
		String encStr = "";
		String reqInfo = id + "/" + srvNo + "/" + reqNum + "/" + exVar; // 데이터 암호화
		encStr = seed.getEnc(reqInfo, "");

		// 03. 위변조 검증 값 생성
		com.sci.v2.comm.secu.hmac.SciHmac hmac = new com.sci.v2.comm.secu.hmac.SciHmac();
		String hmacMsg = hmac.HMacEncript(encStr);

		// 03. 2차 암호화
		reqInfo = seed.getEnc(
				encStr + "/" + hmacMsg + "/" + "0000000000000000", ""); // 2차암호화
		return reqInfo;
	}

	public static String getCKEncData(HttpServletRequest request) {

		NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

		String sSiteCode = EgovProperties.getProperty("Globals.CheckPlus.siteCode"); // NICE로부터 부여받은 사이트 코드
		String sSitePassword = EgovProperties.getProperty("Globals.CheckPlus.sitePassword");; // NICE로부터 부여받은 사이트 패스워드

		String sRequestNumber = "REQ0000000001"; // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
													// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
		sRequestNumber = niceCheck.getRequestNO(sSiteCode);
		request.getSession().setAttribute("REQ_SEQ", sRequestNumber); // 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

		String sAuthType = ""; // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

		String popgubun = "N"; // Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize = ""; // 없으면 기본 웹페이지 / Mobile : 모바일페이지

		// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		String sReturnUrl = EgovProperties.getProperty("Globals.CheckPlus.returnUrl");; // 성공시 이동될 URL
		String sErrorUrl = EgovProperties.getProperty("Globals.CheckPlus.errorUrl");; // 실패시 이동될 URL

		// 입력될 plain 데이타를 만든다.
		String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length
				+ ":" + sRequestNumber + "8:SITECODE"
				+ sSiteCode.getBytes().length + ":" + sSiteCode + "9:AUTH_TYPE"
				+ sAuthType.getBytes().length + ":" + sAuthType + "7:RTN_URL"
				+ sReturnUrl.getBytes().length + ":" + sReturnUrl + "7:ERR_URL"
				+ sErrorUrl.getBytes().length + ":" + sErrorUrl
				+ "11:POPUP_GUBUN" + popgubun.getBytes().length + ":"
				+ popgubun + "9:CUSTOMIZE" + customize.getBytes().length + ":"
				+ customize;

		String sMessage = "";
		String sEncData = "";

		int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
		if (iReturn == 0) {
			sEncData = niceCheck.getCipherData();
		} else if (iReturn == -1) {
			sMessage = "암호화 시스템 에러입니다.";
		} else if (iReturn == -2) {
			sMessage = "암호화 처리오류입니다.";
		} else if (iReturn == -3) {
			sMessage = "암호화 데이터 오류입니다.";
		} else if (iReturn == -9) {
			sMessage = "입력 데이터 오류입니다.";
		} else {
			sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		}
		log.debug("sMessage : " + sMessage);
		return sEncData;
	}

	public static Map<String, String> getCKResult(HttpServletRequest request) {
		Map<String, String> result = null;

	    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
	    String sReserved1  = requestReplace(request.getParameter("type"), "");
	    String sReserved2  = requestReplace(request.getParameter("param_r2"), "");
	    String sReserved3  = requestReplace(request.getParameter("param_r3"), "");

		String sSiteCode = EgovProperties.getProperty("Globals.CheckPlus.siteCode"); // NICE로부터 부여받은 사이트 코드
		String sSitePassword = EgovProperties.getProperty("Globals.CheckPlus.sitePassword");; // NICE로부터 부여받은 사이트 패스워드

	    String sCipherTime = "";				 // 복호화한 시간
	    String sRequestNumber = "";			 // 요청 번호
	    String sResponseNumber = "";		 // 인증 고유번호
	    String sAuthType = "";				   // 인증 수단
	    String sName = "";							 // 성명
	    String sDupInfo = "";						 // 중복가입 확인값 (DI_64 byte)
	    String sConnInfo = "";					 // 연계정보 확인값 (CI_88 byte)
	    String sBirthDate = "";					 // 생일
	    String sGender = "";						 // 성별
	    String sNationalInfo = "";       // 내/외국인정보 (개발가이드 참조)
	    String sMessage = "";
	    String sPlainData = "";
	    
	    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

	    if( iReturn == 0 )
	    {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();
	        
	        // 데이타를 추출합니다.
	        result = niceCheck.fnParse(sPlainData);
	        
	        sRequestNumber  = (String)result.get("REQ_SEQ");
	        sResponseNumber = (String)result.get("RES_SEQ");
	        sAuthType 			= (String)result.get("AUTH_TYPE");
	        sName 					= (String)result.get("NAME");
	        sBirthDate 			= (String)result.get("BIRTHDATE");
	        sGender 				= (String)result.get("GENDER");
	        sNationalInfo  	= (String)result.get("NATIONALINFO");
	        sDupInfo 				= (String)result.get("DI");
	        sConnInfo 			= (String)result.get("CI");
	        
	        String session_sRequestNumber = (String)request.getSession().getAttribute("REQ_SEQ");
	        if(!sRequestNumber.equals(session_sRequestNumber))
	        {
	            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	            sResponseNumber = "";
	            sAuthType = "";
	            result = null;
	        }
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "복호화 시스템 에러입니다.";
	    }    
	    else if( iReturn == -4)
	    {
	        sMessage = "복호화 처리오류입니다.";
	    }    
	    else if( iReturn == -5)
	    {
	        sMessage = "복호화 해쉬 오류입니다.";
	    }    
	    else if( iReturn == -6)
	    {
	        sMessage = "복호화 데이터 오류입니다.";
	    }    
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }    
	    else if( iReturn == -12)
	    {
	        sMessage = "사이트 패스워드 오류입니다.";
	    }    
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }
	    
	    log.debug("sMessage : " + sMessage);
	    log.debug("result : " + result);
		return result;
	}

	public static String getIPinData(HttpServletRequest request) {

		/********************************************************************************************************************************************
			NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
			
			서비스명 : 가상주민번호서비스 (IPIN) 서비스
			페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
		*********************************************************************************************************************************************/
		
		String sSiteCode				= EgovProperties.getProperty("Globals.IPin.siteCode");			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
		String sSitePw					= EgovProperties.getProperty("Globals.IPin.sitePassword");			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
		
		
		/*
		┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
			NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
			따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
			
			* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
			* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
			
			아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
			예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
		└────────────────────────────────────────────────────────────────────
		*/
		String sReturnURL				= EgovProperties.getProperty("Globals.IPin.returnUrl");
		
		
		/*
		┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
			[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
			
			CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
			데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
			
			따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
		└────────────────────────────────────────────────────────────────────
		*/
		String sCPRequest				= "";
		
		
		
		// 객체 생성
		IPINClient pClient = new IPINClient();
		
		
		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
		sCPRequest = pClient.getRequestNO(sSiteCode);
		
		// CP 요청번호를 세션에 저장합니다.
		// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
		// 필수사항은 아니며, 보안을 위한 권고사항입니다.
		request.getSession().setAttribute("CPREQUEST" , sCPRequest);
		
		
		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);
		
		String sRtnMsg					= "";			// 처리결과 메세지
		String sEncData					= "";			// 암호화 된 데이타
		
		// Method 결과값에 따른 처리사항
		if (iRtn == 0)
		{
		
			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
			sEncData = pClient.getCipherData();		//암호화 된 데이타
			
			sRtnMsg = "정상 처리되었습니다.";
		
		}
		else if (iRtn == -1 || iRtn == -2)
		{
			sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
						"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		}
		else if (iRtn == -9)
		{
			sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		}
		else
		{
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
		}
	    log.debug("sRtnMsg : " + sRtnMsg);
		return sEncData;
	}

	public static Map<String, String> getIPinResult(HttpServletRequest request) {
		Map<String, String> result = null;
		String sSiteCode				= EgovProperties.getProperty("Globals.IPin.siteCode");			// IPIN 서비스 사이트 코드		(NICE평가정보에서 발급한 사이트코드)
		String sSitePw					= EgovProperties.getProperty("Globals.IPin.sitePassword");			// IPIN 서비스 사이트 패스워드	(NICE평가정보에서 발급한 사이트패스워드)
		
			
			// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
	    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
	    
	    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
	    String sCPRequest = (String)request.getSession().getAttribute("CPREQUEST");

	    
	    // 객체 생성
		IPINClient pClient = new IPINClient();
		
		
		/*
		┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
			Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
			
			fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
			'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)
			
			따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
		└────────────────────────────────────────────────────────────────────
		*/
		int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
		//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);
		
		String sRtnMsg				= "";							// 처리결과 메세지
		String sVNumber				= pClient.getVNumber();			// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
		String sName				= pClient.getName();			// 이름
		String sDupInfo				= pClient.getDupInfo();			// 중복가입 확인값 (DI - 64 byte 고유값)
		String sAgeCode				= pClient.getAgeCode();			// 연령대 코드 (개발 가이드 참조)
		String sGenderCode			= pClient.getGenderCode();		// 성별 코드 (개발 가이드 참조)
		String sBirthDate			= pClient.getBirthDate();		// 생년월일 (YYYYMMDD)
		String sNationalInfo		= pClient.getNationalInfo();	// 내/외국인 정보 (개발 가이드 참조)
		String sCPRequestNum		= pClient.getCPRequestNO();		// CP 요청번호
				
		// Method 결과값에 따른 처리사항
		if (iRtn == 1)
		{
			/*
				다음과 같이 사용자 정보를 추출할 수 있습니다.
				사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.
			
				사용자 정보를 다른 페이지에서 이용하실 경우에는
				보안을 위하여 암호화 데이타(sResponseData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)
				
				만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
				form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.
			*/
			
			// 사용자 인증정보에 대한 변수
			
			log.debug("가상주민번호 : " + sVNumber + "<BR>");
			log.debug("이름 : " + sName + "<BR>");
			log.debug("중복가입 확인값 (DI) : " + sDupInfo + "<BR>");
			log.debug("연령대 코드 : " + sAgeCode + "<BR>");
			log.debug("성별 코드 : " + sGenderCode + "<BR>");
			log.debug("생년월일 : " + sBirthDate + "<BR>");
			log.debug("내/외국인 정보 : " + sNationalInfo + "<BR>");
			log.debug("CP 요청번호 : " + sCPRequestNum + "<BR>");
			log.debug("***** 복호화 된 정보가 정상인지 확인해 주시기 바랍니다.<BR><BR><BR><BR>");
			
			sRtnMsg = "정상 처리되었습니다.";
			
			result = new HashMap<String, String>();
			result.put("CI", sVNumber);
			result.put("NAME", sName);
			result.put("DI", sDupInfo);
			result.put("AGE", sAgeCode);
			result.put("GENDER", sGenderCode);
			result.put("BIRTHDATE", sBirthDate);
			result.put("NATION", sNationalInfo);
			result.put("CP", sCPRequestNum);
		}
		else if (iRtn == -1 || iRtn == -4)
		{
			sRtnMsg =	"iRtn 값, 서버 환경정보를 정확히 확인하여 주시기 바랍니다.";
		}
		else if (iRtn == -6)
		{
			sRtnMsg =	"당사는 한글 charset 정보를 euc-kr 로 처리하고 있으니, euc-kr 에 대해서 허용해 주시기 바랍니다.<BR>" +
						"한글 charset 정보가 명확하다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		}
		else if (iRtn == -9)
		{
			sRtnMsg = "입력값 오류 : fnResponse 함수 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		}
		else if (iRtn == -12)
		{
			sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
		}
		else if (iRtn == -13)
		{
			sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
		}
		else
		{
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 전산 담당자에게 문의해 주세요.";
		}
		log.debug("sRtnMsg : " + sRtnMsg);
		return result;
	}
	
	private static String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
        	
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}
        	
        	result = paramValue;
            
        }
        return result;
  }
}
