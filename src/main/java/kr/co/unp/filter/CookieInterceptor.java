package kr.co.unp.filter;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.unp.util.CookieUtil;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.cmm.service.EgovProperties;


public class CookieInterceptor extends HandlerInterceptorAdapter {



	@Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView modelAndView) throws Exception {

		/*
		HttpSession session = req.getSession();

		String token = session.getAttribute("ssoAuthToken") == null ? null : (String)session.getAttribute("ssoAuthToken");
		if (token != null) {
			Cookie info = new Cookie("ssotoken", token);
			info.setSecure(true);
			info.setMaxAge(60*60);
			info.setPath("/");
			String domain = EgovProperties.getProperty("Globals.sso.domain");
			info.setDomain(domain);
			res.addCookie(info);
			session.removeAttribute("ssoAuthToken");
		}
		*/
    }

}
