package kr.co.unp.filter;

import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.utl.HttpUtil;

public class PrivacyInterceptor extends HandlerInterceptorAdapter {
	String[] pattern= {
			"([01][0-9]{5}[[:space:],~-]+[1-4][0-9]{6}|[2-9][0-9]{5}[[:space:],~-]+[1-2][0-9]{6})" //주민등록번호
			,"[a-zA-Z]{2}[-~.[:space:]][0-9]{7}" //여권번호
			,"[0-9]{2}[-~.[:space:]][0-9]{6}[-~.[:space:]][0-9]{2}" //운전면허번호
			,"01[016789][-~.[:space:]][0-9]{3,4}[-~.[:space:]][0-9]{4}" //핸드폰번호
			,"[34569][0-9]{3}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{4}" //신용카드번호
			,"[1257][-~.[:space:]][0-9]{10}" //건강보험번호
			,"([0-9]{2}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{6}|[0-9]{3}[-~.[:space:]]([0-9]{5,6}[-~.[:space:]][0-9]{3}|[0-9]{6}[-~.[:space:]][0-9]{5}|[0-9]{2,3}[-~.[:space:]][0-9]{6}|[0-9]{2}[-~.[:space:]][0-9]{7}|[0-9]{2}[-~.[:space:]][0-9]{4,6}[-~.[:space:]][0-9]|[0-9]{5}[-~.[:space:]][0-9]{3}[-~.[:space:]][0-9]{2}|[0-9]{2}[-~.[:space:]][0-9]{5}[-~.[:space:]][0-9]{3}|[0-9]{4}[-~.[:space:]][0-9]{4}[-~.[:space:]][0-9]{3}|[0-9]{6}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{3}|[0-9]{2}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{7})|[0-9]{4}[-~.[:space:]]([0-9]{3}[-~.[:space:]][0-9]{6}|[0-9]{2}[-~.[:space:]][0-9]{6}[-~.[:space:]][0-9])|[0-9]{5}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{6}|[0-9]{6}[-~.[:space:]][0-9]{2}[-~.[:space:]][0-9]{5,6})" //계좌번호
	};

	@Override
	public boolean preHandle(HttpServletRequest request,
	   HttpServletResponse response, Object handler) throws Exception {

	  //if ( request instanceof MultipartHttpServletRequest) {
	      // ParameterMap  을 사용하는것이 더 권장사항임.
	      @SuppressWarnings("unchecked")
		Enumeration<String> names=request.getParameterNames();
	      while ( names.hasMoreElements()) {
	         String a=names.nextElement();
	            String value=request.getParameter(a);
	               if ( ! isValidInput(value)) {
                       HttpUtil.back(response, "개인정보가 검출되었습니다. 확인 후 등록 바랍니다.");
                       return false;
		           }
	      }
	  //}
	     return true;
	 }


	private boolean isValidInput(String value) {
	    if (value != null) {
	        value = value.replaceAll("", "");
	        for ( String ptn : pattern ) {
	              Pattern scriptPattern = Pattern.compile(ptn, Pattern.CASE_INSENSITIVE);
	              if ( scriptPattern.matcher(value).find() ) return false;
	        }
	        return true;
	    } else {
	     return false;
	    }
	}
}
