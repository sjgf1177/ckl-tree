package kr.co.unp.util.tag; 



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * summary :
 * @author kimhyunjun
 * @since 2010. 10. 8.
 * @see
 * @desc 
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   수정일   수정자    수정내용
 *  -------   --------  ---------------------------
 *   2010. 10. 8. 이경훈  최초 생성
 *
 * Copyright (C) 2010 by NEMOSOFT.co All right reserved.
 * </pre>
 */
@SuppressWarnings("serial")
public class UrlEncoder extends TagSupport {
	protected static final Log log = LogFactory.getLog(UrlEncoder.class);
	
    private String url;
    
    private String var;
    
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getVar() {
		return var;
	}

	public void setVar(String var) {
		this.var = var;
	}

	public int doEndTag() throws JspTagException //doEndTag:커스텀 테그 닫는 테그를 만났을때 실행, 반대:doStartTag()

    { 
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		if (var!=null && !var.equals("")){
			try {
				request.setAttribute(var, URLEncoder.encode(url, request.getCharacterEncoding()));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} else {
			try {
				pageContext.getOut().write(URLEncoder.encode(url, request.getCharacterEncoding()));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

        return EVAL_PAGE;
    }
}



