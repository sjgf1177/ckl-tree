package egovframework.com.utl.filter;



import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 *
 * @author KSH
 *
 */
public class ForwardingFilter extends OncePerRequestFilter {

	protected Log log = LogFactory.getLog(this.getClass());

	private static Map<String, String> forwardMap = new HashMap<String, String>();
	static{
		forwardMap.put("http://jungnang.seoul.kr/html/06_news/kg02_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/06_news/kg02_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/01_intro/kb05_0301.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/03_execute/kd01_main.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/06_news/kg01_main.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/06_news/kg01_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/04_part/ke01_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/01_intro/kb01_main.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/01_intro/kb05_0701.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/02_civil/kc01_main.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/02_civil/kc09_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/04_part/ke01_main.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/04_part/ke07_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://jungnang.seoul.kr/html/05_info/kf08_0101.php", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://www.jungnangimc.or.kr/index.do?sgrp=S01&siteCmsCd=CM0001", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://www.jnc.go.kr/", "http://www.jungnang.seoul.kr/");
		forwardMap.put("http://www.healthcare.go.kr/doc/jin/jin_main.jsp", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/admin/gampol/oracle/bongboard/board.jsp?DB=scott&table=BOARD_TALK", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/doc/business/business_main.jsp", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/doc/health/health_main.jsp", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/doc/about/about_main.jsp", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/doc/about/about_present.jsp", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/doc/about/about_business.jsp", "http://health.jungnang.seoul.kr/health/main.do");
		forwardMap.put("http://www.healthcare.go.kr/doc/about/about_map.jsp", "http://health.jungnang.seoul.kr/health/main.do");
	}

	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
        throws ServletException, IOException
    {
		String fullUrl = request.getRequestURL().toString();
		String queryString = request.getQueryString();
		if( StringUtils.hasText(queryString) ) fullUrl += "?" + queryString;
		String toUrl = forwardMap.get(fullUrl);
		if( toUrl != null )
			response.sendRedirect(toUrl);
		else
			filterChain.doFilter(request, response);

		/*
		if( toUrl != null )
			response.sendRedirect(toUrl);
		else{
			if( fullUrl.indexOf("/ebook/") != -1 ){
				fullUrl = fullUrl.replaceAll("부", "bu");
				Debug.log("fullUrl---------------------------------------------"+fullUrl);
				response.sendRedirect(toUrl);
			}
			else{
				filterChain.doFilter(request, response);
			}
		}
		*/
    }

}


