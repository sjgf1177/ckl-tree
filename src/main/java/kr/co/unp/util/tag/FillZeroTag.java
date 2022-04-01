package kr.co.unp.util.tag; 


import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import kr.co.unp.util.StrUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@SuppressWarnings("serial")
public class FillZeroTag extends TagSupport{
	protected static final Log log = LogFactory.getLog(FillZeroTag.class);
	
    private String source;

    private int resultLen;
    
    private String isFront = "true";

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public int getResultLen() {
		return resultLen;
	}

	public void setResultLen(int resultLen) {
		this.resultLen = resultLen;
	}

	public String isFront() {
		return isFront;
	}

	public void setIsFront(String isFront) {
		this.isFront = isFront;
	}

	public int doEndTag() throws JspTagException
    { 
		boolean front = "true".equals(isFront) ? true : false;
		String result = StrUtils.fillZero(source, resultLen, front);
		try {
			pageContext.getOut().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}  
        return EVAL_PAGE;
    }
	
}


