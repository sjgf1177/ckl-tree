package kr.co.unp.sns.service;

import java.io.Serializable;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.sns.api.twitter.UnpTwitter;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;

import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;

public class TwitterService extends DefaultCmmProgramService implements SnsService, Serializable {

	private static final long serialVersionUID = -4965857087821123941L;
	private Twitter twitter;

	public void tokenChk(ParameterContext<ZValue> paramCtx) throws Exception{

		String appID = propertyService.getString("Sns.twitterAppKey"); // 자신의 AppID
		String appSecret = propertyService.getString("Sns.twitterSecretKey"); // 자신의 App Secret
		String accessToken = paramCtx.getRequest().getSession().getAttribute("twitterAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("twitterAccessToken") : "";
		String accessTokenSecret = paramCtx.getRequest().getSession().getAttribute("twitterAccessTokenSecret") != null ? (String)paramCtx.getRequest().getSession().getAttribute("twitterAccessTokenSecret") : "";

		ModelMap model = paramCtx.getModel();
		if (!"".equals(accessToken)) {

			model.addAttribute("twitterAuthResponse",true);
		}
		else {
			model.addAttribute("twitterAccessToken",accessToken);
			model.addAttribute("twitterAuthResponse",false);
		}

	}

	public void token(ParameterContext<ZValue> paramCtx) throws Exception{

		System.setProperty("twitter4j.loggerFactory", "twitter4j.internal.logging.StdOutLoggerFactory");
		//System.setProperty("twitter4j.http.useSSL", "true");
		twitter = new TwitterFactory().getInstance();
		RequestToken rquestToken = null;

		//request.getSession().setAttribute("rt_url", rt_url); //reurn 될 Url 세션에 저장

		//Protocol.registerProtocol("myhttps", new Protocol("https", new SSLSocketFactory(), 9443));
		String appID = propertyService.getString("Sns.twitterAppKey"); // 자신의 AppID
		String appSecret = propertyService.getString("Sns.twitterSecretKey"); // 자신의 App Secret
        twitter.setOAuthConsumer(appID, appSecret);

        try {
        	//propertyService.getString("Sns.twitterCallBackUrl");
        	rquestToken = twitter.getOAuthRequestToken();

        	paramCtx.getRequest().getSession().setAttribute("requestToken", rquestToken);

        	String authUrl = rquestToken.getAuthorizationURL();
        	ModelMap model = paramCtx.getModel();
        	model.addAttribute(ModelAndViewResolver.GO_URL_KEY, authUrl);
        }
        catch (Exception e) {
        	e.printStackTrace();
        }
	}

	public void callbackUrl(ParameterContext<ZValue> paramCtx) throws Exception{

		String oAuthToken = paramCtx.getRequest().getParameter("oauth_token");
		String oAuthVerifier = paramCtx.getRequest().getParameter("oauth_verifier");

		RequestToken requestToken = (RequestToken)paramCtx.getRequest().getSession().getAttribute("requestToken");
		//String rt_url = request.getSession().getAttribute("rt_url")==null ? "" : request.getSession().getAttribute("rt_url").toString();

		String appID = propertyService.getString("Sns.twitterAppKey"); // 자신의 AppID
		String appSecret = propertyService.getString("Sns.twitterSecretKey"); // 자신의 App Secret

        try {
        	twitter = new TwitterFactory().getInstance();
            twitter.setOAuthConsumer(appID, appSecret);
            if (requestToken.getToken().equals(oAuthToken)) {
            	AccessToken accessToken =  null;
            	accessToken = twitter.getOAuthAccessToken(requestToken,oAuthVerifier);
            	twitter.setOAuthAccessToken(accessToken);
            	paramCtx.getRequest().getSession().setAttribute("twitterAccessToken", accessToken.getToken());
            	paramCtx.getRequest().getSession().setAttribute("twitterAccessTokenSecret", accessToken.getTokenSecret());
                //response.sendRedirect(rt_url + "?twt_id="+twitter.getId()+"&twt_sid="+twitter.getScreenName()+"&twt_token="+accessToken.getToken()+"&twt_access_token="+accessToken.getTokenSecret());
            	ModelMap model = paramCtx.getModel();
            	model.addAttribute(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_RELOAD_WINDOW_MODE);
            	//webFactory.printHtmlReload(paramCtx.getResponse(), null, "opener");
                return;
            }
        }
        catch (Exception e) {
        	//HttpUtil.winClose(response, "처리중 오류가 발생 하였습니다.");
        	e.printStackTrace();
        	return;
        }
	}

	public void profile(ParameterContext<ZValue> paramCtx) throws Exception{


		String appID = propertyService.getString("Sns.twitterAppKey"); // 자신의 AppID
		String appSecret = propertyService.getString("Sns.twitterSecretKey"); // 자신의 App Secret
		String accessToken = paramCtx.getRequest().getSession().getAttribute("twitterAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("twitterAccessToken") : "";
		String accessTokenSecret = paramCtx.getRequest().getSession().getAttribute("twitterAccessTokenSecret") != null ? (String)paramCtx.getRequest().getSession().getAttribute("twitterAccessTokenSecret") : "";

		ModelMap model = paramCtx.getModel();

		if (!"".equals(accessToken)) {


			UnpTwitter twtObj =  new UnpTwitter( appID,appSecret, new twitter4j.auth.AccessToken(accessToken,accessTokenSecret) );
			Twitter twitter = twtObj.getTwitter();
			User twtUser = twitter.showUser(twitter.getId());

			model.addAttribute("id",twtUser.getId());
			model.addAttribute("name",twtUser.getName());
			model.addAttribute("image",twtUser.getProfileImageURL());
			model.addAttribute("resultCode","success");
		}
		else {
			model.addAttribute("resultCode","fail");
		}


	}

	public void snsPost(ParameterContext<ZValue> paramCtx) throws Exception{


		String appID = propertyService.getString("Sns.twitterAppKey"); // 자신의 AppID
		String appSecret = propertyService.getString("Sns.twitterSecretKey"); // 자신의 App Secret
		String accessToken = paramCtx.getRequest().getSession().getAttribute("twitterAccessToken") != null ? (String)paramCtx.getRequest().getSession().getAttribute("twitterAccessToken") : "";
		String accessTokenSecret = paramCtx.getRequest().getSession().getAttribute("twitterAccessTokenSecret") != null ? (String)paramCtx.getRequest().getSession().getAttribute("twitterAccessTokenSecret") : "";

		ModelMap model = paramCtx.getModel();
		if (!"".equals(accessToken)) {


			UnpTwitter twtObj =  new UnpTwitter( appID,appSecret, new twitter4j.auth.AccessToken(accessToken,accessTokenSecret) );
			Twitter twitter = twtObj.getTwitter();

			String content = paramCtx.getRequest().getParameter("message");

			twitter.updateStatus(content);
			model.addAttribute("resultCode","success");

		}
		else {
			model.addAttribute("resultCode","fail");
		}


	}

}
