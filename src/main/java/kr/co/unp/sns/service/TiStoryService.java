package kr.co.unp.sns.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.sns.vo.TiStory;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;


public class TiStoryService extends DefaultCmmProgramService implements SnsService{

	final String AUTH_HOST = "https://www.tistory.com";						// auth 호출 호스트

	final String codeRequestUrl = AUTH_HOST + "/oauth/authorize?";			// 로그인-code 받기
	final String tokenRequestUrl = AUTH_HOST + "/oauth/access_token/?";		// 로그인-access_token 받기
    final String infoRequestUrl = AUTH_HOST + "/apis/blog/info?";			// 프로필 정보 조회
    final String postWriteUrl = AUTH_HOST + "/apis/post/write";				// 로그인-코드받기

	public void tokenChk(ParameterContext<ZValue> paramCtx) throws Exception{

		String appID = propertyService.getString("Sns.tistoryAppKey"); // 자신의 AppID
		String appSecret = propertyService.getString("Sns.tistorySecretKey"); // 자신의 App Secret
		String accessToken = paramCtx.getRequest().getSession().getAttribute("tistoryAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("tistoryAccessToken") : "";


		ModelMap model = paramCtx.getModel();
		if (!"".equals(accessToken)) {

			model.addAttribute("tistoryAuthResponse",true);
		}
		else {
			model.addAttribute("tistoryAccessToken",accessToken);
			model.addAttribute("tistoryAuthResponse",false);
		}
	}

	public void token(ParameterContext<ZValue> paramCtx) throws Exception{

		String CLIENT_ID = propertyService.getString("Sns.tistoryAppKey"); // 자신의 AppID


        try {

        	String authUrl = codeRequestUrl+"client_id="+CLIENT_ID+"&redirect_uri=http://pms.ccbrain.co.kr:9999/portal/sns/tiStory/callbackUrl.do&response_type=code";
        	ModelMap model = paramCtx.getModel();
        	model.addAttribute(ModelAndViewResolver.GO_URL_KEY, authUrl);
        }
        catch (Exception e) {
        	e.printStackTrace();
        }
	}

	public void callbackUrl(ParameterContext<ZValue> paramCtx) throws Exception{

		ZValue param = paramCtx.getParam();

		paramCtx.getResponse().setContentType("text/html;charset=UTF-8");
		String tistoryDomain = propertyService.getString("Sns.tistoryDomain"); // 카카오 fintech 계정 도메인

		String CLIENT_ID = propertyService.getString("Sns.tistoryAppKey"); // 해당 앱의 REST API KEY 정보. 개발자 웹사이트의 대쉬보드에서 확인 가능
		String CLIENT_PW = propertyService.getString("Sns.tistorySecretKey"); // 해당 앱의 패스워드. 개발자 웹사이트의 대쉬보드에서 확인 가능
	    String REDIRECT_URI = tistoryDomain + "/portal/sns/tiStory/callbackUrl.do"; // 해당 앱의 설정된 uri. 개발자 웹사이트의 대쉬보드에서 확인 및 설정 가능

	    String code = param.getString("code"); // 로그인 과정중 얻은 authorization code 값

		HttpsURLConnection conn = null;
	    OutputStreamWriter writer = null;
	    BufferedReader reader = null;
	    InputStreamReader isr= null;

		try {

			String params =

					String.format("code=%s&client_id=%s&client_secret=%s&redirect_uri=%s&grant_type=authorization_code",code, CLIENT_ID, CLIENT_PW, REDIRECT_URI);

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

			String accessToken = buffer.toString().replaceAll("access_token=", "");


			paramCtx.getRequest().getSession().setAttribute("tistoryAccessToken", accessToken);

			ModelMap model = paramCtx.getModel();
			model.addAttribute(ModelAndViewResolver.WINDOW_MODE,ModelAndViewResolver.WIN_CLOSE_RELOAD_WINDOW_MODE);

			return;

		}
        catch (Exception e) {
        	//HttpUtil.winClose(response, "처리중 오류가 발생 하였습니다.");
        	e.printStackTrace();
        	return;
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


	public void profile(ParameterContext<ZValue> paramCtx) throws Exception{


		paramCtx.getResponse().setContentType("text/html;charset=UTF-8");


		String accessToken = paramCtx.getRequest().getSession().getAttribute("tistoryAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("tistoryAccessToken") : "";

		HttpsURLConnection conn = null;
	    OutputStreamWriter writer = null;
	    BufferedReader reader = null;
	    InputStreamReader isr= null;
	    ModelMap model = paramCtx.getModel();
		try {

			String params = String.format("access_token=%s",accessToken);

			URL url = new URL(infoRequestUrl);

			conn = (HttpsURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			writer = new OutputStreamWriter(conn.getOutputStream());
			writer.write(params);
			writer.flush();

			int responseCode = conn.getResponseCode();
			System.out.println("\nSending 'POST' request to URL : " + infoRequestUrl);
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

			JAXBContext jusuJaxbContext = JAXBContext.newInstance(TiStory.class);
			Unmarshaller jusuJaxbUnmarshaller = jusuJaxbContext.createUnmarshaller();
			TiStory tiStory = (TiStory) jusuJaxbUnmarshaller.unmarshal(new StringReader(data));


			model.addAttribute("tiStory", tiStory);
			model.addAttribute("resultCode","success");


			model.addAttribute(ModelAndViewResolver.WINDOW_MODE,ModelAndViewResolver.WIN_CLOSE_RELOAD_WINDOW_MODE);

			return;

		}
        catch (Exception e) {
        	//HttpUtil.winClose(response, "처리중 오류가 발생 하였습니다.");
        	e.printStackTrace();
        	model.addAttribute("resultCode","fail");
        	return;
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


		String accessToken = paramCtx.getRequest().getSession().getAttribute("tistoryAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("tistoryAccessToken") : "";


		HttpsURLConnection conn = null;
	    OutputStreamWriter writer = null;
	    BufferedReader reader = null;
	    InputStreamReader isr= null;
		ModelMap model = paramCtx.getModel();
		try {
			if (!"".equals(accessToken)) {

				String params = String.format("access_token=%s&targetUrl=%s&title=test&content=%s&slogan=http:www.naver.com&visibility=2",accessToken, paramCtx.getRequest().getParameter("id").replace("http://", "").replace(".tistory.com", ""), paramCtx.getRequest().getParameter("message"));

				URL url = new URL(postWriteUrl);

				conn = (HttpsURLConnection) url.openConnection();

				conn.setRequestMethod("POST");
				conn.setDoOutput(true);

				writer = new OutputStreamWriter(conn.getOutputStream());
				writer.write(params);
				writer.flush();

				int responseCode = conn.getResponseCode();
				System.out.println("\nSending 'POST' request to URL : " + postWriteUrl);
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


				model.addAttribute("resultCode","success");

				model.addAttribute(ModelAndViewResolver.WINDOW_MODE,ModelAndViewResolver.WIN_CLOSE_RELOAD_WINDOW_MODE);

				return;

			}
			else {
				model.addAttribute("resultCode","fail");
			}
		}
		 catch (Exception e) {
	        	//HttpUtil.winClose(response, "처리중 오류가 발생 하였습니다.");
	        	e.printStackTrace();
	        	model.addAttribute("resultCode","fail");
	        	return;
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

}
