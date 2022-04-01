package kr.co.unp.sns.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.ui.ModelMap;

public class KakaoService extends DefaultCmmProgramService {

	final String AUTH_HOST = "https://kauth.kakao.com";						// auth 호출 호스트
	final String API_HOST = "https://kapi.kakao.com";						// api 호출 호스트
    final String codeRequestUrl = AUTH_HOST + "/oauth/authorize";			// 로그인-코드받기
    final String tokenRequestUrl = AUTH_HOST + "/oauth/token";				// 로그인-토큰받기, 로그인-토큰갱신
    final String signupRequestUrl = API_HOST + "/v1/user/signup";			// 앰연결

	public void tokenChk(ParameterContext<ZValue> paramCtx) throws Exception{

		String accessToken = paramCtx.getRequest().getSession().getAttribute("kakaoAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("kakaoAccessToken") : "";

		ModelMap model = paramCtx.getModel();
		if (!"".equals(accessToken)) {

			model.addAttribute("kakaoAuthResponse",true);
		}
		else {
			model.addAttribute("kakaoAccessToken",accessToken);
			model.addAttribute("kakaoAuthResponse",false);
		}

	}

	public void token(ParameterContext<ZValue> paramCtx) throws Exception{

		String kakaoDomain = propertyService.getString("Sns.kakaoDomain"); // 카카오 fintech 계정 도메인

		String appID = propertyService.getString("Sns.kakaoAppKey"); // REST API 키


	    ModelMap model = paramCtx.getModel();

	    model.addAttribute(ModelAndViewResolver.GO_URL_KEY, codeRequestUrl +"?client_id="+appID+"&redirect_uri="+kakaoDomain+"/portal/sns/kakao/callbackUrl.do&response_type=code");

	}

	public void callbackUrl(ParameterContext<ZValue> paramCtx) throws Exception{

		ZValue param = paramCtx.getParam();

		String kakaoDomain = propertyService.getString("Sns.kakaoDomain"); // 카카오 fintech 계정 도메인

		String CLIENT_ID = propertyService.getString("Sns.kakaoAppKey"); // 해당 앱의 REST API KEY 정보. 개발자 웹사이트의 대쉬보드에서 확인 가능
	    String REDIRECT_URI = kakaoDomain + "/portal/sns/kakao/callbackUrl.do"; // 해당 앱의 설정된 uri. 개발자 웹사이트의 대쉬보드에서 확인 및 설정 가능
	    String code = param.getString("code"); // 로그인 과정중 얻은 authorization code 값

	    HttpsURLConnection conn = null;
	    OutputStreamWriter writer = null;
	    BufferedReader reader = null;
	    InputStreamReader isr= null;

	    try {
			String params = String.format("grant_type=authorization_code&client_id=%s&redirect_uri=%s&code=%s", CLIENT_ID, REDIRECT_URI, code);

			URL url = new URL(tokenRequestUrl);

			conn = (HttpsURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			writer = new OutputStreamWriter(conn.getOutputStream());
			writer.write(params);
			writer.flush();

			int responseCode = conn.getResponseCode();
			System.out.println("\nSending 'POST' request to URL : " + tokenRequestUrl);
			System.out.println("Post parameters : " + params);
			System.out.println("Response Code : " + responseCode);

			isr = new InputStreamReader(conn.getInputStream());

			reader = new BufferedReader(isr);

			StringBuffer buffer = new StringBuffer();

			String line;

			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}



			String data = buffer.toString();
			ObjectMapper om = new ObjectMapper();
			Map<String, Object> m = om.readValue(data, new TypeReference<Map<String, Object>>(){});

			String accessToken = "";
			String refreshToken = "";

			accessToken = (String) m.get("access_token");

			refreshToken = (String) m.get("refresh_token");

			// 해당 사용자가 카카오 스토리에 가입했는지 확인
			// 가입하지 않았다면 alert으로 알림

			paramCtx.getRequest().getSession().setAttribute("kakaoAccessToken", accessToken);
			paramCtx.getRequest().getSession().setAttribute("kakaoRefreshToken", refreshToken);

			ModelMap model = paramCtx.getModel();
			model.addAttribute(ModelAndViewResolver.WINDOW_MODE,ModelAndViewResolver.WIN_CLOSE_RELOAD_WINDOW_MODE);

			return;


	    } catch (IOException e) {
	    	e.printStackTrace();
	    } finally {
	        // clear resources
	        if (writer != null) {
	          try {
	              writer.close();
	           } catch(Exception ignore) {
	           }
	        }
	        if (reader != null) {
	          try {
	              reader.close();
	          } catch(Exception ignore) {
	          }
	        }
	        if (isr != null) {
	            try {
	                isr.close();
	            } catch(Exception ignore) {
	            }
	         }
	    }

	}
	public void snsPost(ParameterContext<ZValue> paramCtx) throws Exception{

	}

	public void profile(ParameterContext<ZValue> paramCtx) throws Exception{

	}

}
