package kr.co.ckl.cmm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.cmm.service.EgovProperties;

public class SiteNameLocaleChangeInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws ServletException, IOException {

		/*
		Locale newLocale  = Locale.getDefault();
		String siteName = SiteMngService.CKL_SITE_NAME;


		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
		if (localeResolver == null) {
			throw new IllegalStateException("No LocaleResolver found: not in a DispatcherServlet request?");
		}
		localeResolver.setLocale(request, response, newLocale);
		*/


		String url = request.getRequestURL().toString();
		String uri = request.getRequestURI();
		String protocol = "http://";
		String realMode = EgovProperties.getProperty("Globals.realMode");
		//System.out.println("::: Globals.realMode :: " + realMode);
		if ("Y".equals(realMode))  protocol = "https://";
		else protocol = "http://";
		String domain = EgovProperties.getProperty("Globals.sso.domain");
		
		//System.out.println("#########################################################");
		//System.out.println("protocol : " + protocol);
		//System.out.println("domain : " + domain);//rsg 20170711
		//System.out.println("#########################################################");//rsg 20170711

		
/*		if ("N".equals(realMode)) {
			//domain = "sso.ckl.dev.kr";
			domain = "localhost:8080";
		}*/

		String returnUrl = protocol +domain+"/sso/member/forLoginSSO.do?service=ckl" ;
		if (url.indexOf(domain) > -1 && uri.indexOf("/member/forLoginSSO.do") == -1 && uri.indexOf("/member/toLoginSSO.do") == -1
				&& uri.indexOf("/member/checkSSO.do") == -1 && uri.indexOf("/member/incForLoginSSO.do") == -1  && uri.indexOf("/member/incJoin01.do") == -1
				&& uri.indexOf("/member/logoutSSO.do") == -1 && uri.indexOf("/member/incSimpleLogin.do") == -1 && uri.indexOf("/userMember/insertSimpleLogin.json") == -1
				&& uri.indexOf("/userMember/deleteSimpleLogin.json") == -1
		) {
			response.sendRedirect(returnUrl); //rsg 20170711
			return false;
		}
		else if (url.indexOf(domain) == -1 && (
					uri.indexOf("/member/forLoginSSO.do") > -1 || uri.indexOf("/member/toLoginSSO.do") > -1
					|| uri.indexOf("/member/checkSSO.do") > -1 || uri.indexOf("/member/incForLoginSSO.do") > -1 || uri.indexOf("/member/incJoin01.do") > -1
					|| uri.indexOf("/member/logoutSSO.do") > -1 || uri.indexOf("/member/incSimpleLogin.do") > -1 || uri.indexOf("/userMember/insertSimpleLogin.json") > -1
					|| uri.indexOf("/userMember/deleteSimpleLogin.json") > -1
				)
		) {
			if ( url.indexOf(EgovProperties.getProperty("Globals.edu.domain")) > -1 && uri.indexOf("/member/logoutSSO.do") > -1 ){ System.out.println("=========== url "+url+"=========="); returnUrl = protocol +domain+"/sso/member/logoutSSO.do?service=edu" ; } //rsg20180108
			response.sendRedirect(returnUrl);
			return false;
		}

		request.setAttribute("ssoDomain", protocol +domain);

		/*
		String siteName = "ckl";
		String reqUri = request.getRequestURI();
		String[] reqUriData = StrUtils.split(reqUri, "/");
		if( reqUriData.length >= 1) {
			siteName = reqUriData[1];
		}

		if( SiteMngService.CKL_SITE_NAME.equals(siteName) ) {

		}
		*/

		return true;
	}
}
