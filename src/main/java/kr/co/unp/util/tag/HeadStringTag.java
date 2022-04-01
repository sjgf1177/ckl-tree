package kr.co.unp.util.tag; 


import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import kr.co.unp.util.StrUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@SuppressWarnings("serial")
public class HeadStringTag extends TagSupport{
	protected static final Log log = LogFactory.getLog(HeadStringTag.class);
	
    private String value;

    private int length;
    

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public int doEndTag() throws JspTagException
    { 
		String result = StrUtils.head(value, length);
		try {
			pageContext.getOut().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}  
        return EVAL_PAGE;
    }
	
}


