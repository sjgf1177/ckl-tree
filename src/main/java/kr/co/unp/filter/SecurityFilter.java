package kr.co.unp.filter;


import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.HttpUtil;

public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    	/*
    	HttpServletResponse servletResponse = (HttpServletResponse)response;
    	servletResponse.setHeader("X-UA-Compatible", "IE=Edge");
    	if( Globals.OS_TYPE.equals("UNIX") ) {
            String referer = ((HttpServletRequest) request).getHeader("referer");
            if (referer!=null && !referer.equals("") && referer.indexOf("ckl.or.kr")==-1) {
            	HttpUtil.back(servletResponse, "잘못된 접근입니다.");
            	return;
            }
    	}
    	*/
        chain.doFilter(new SecurityFilterRequestWrapper((HttpServletRequest) request), response);
    }

}
