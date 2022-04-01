package kr.co.unp.util.tag; 


import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import kr.co.unp.util.StrUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@SuppressWarnings("serial")
public class SecretString extends TagSupport{
	protected static final Log log = LogFactory.getLog(SecretString.class);
	
    private String value;

    private int firstNum;
    

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}


	public int getFirstNum() {
		return firstNum;
	}

	public void setFirstNum(int firstNum) {
		this.firstNum = firstNum;
	}

	public int doEndTag() throws JspTagException
    { 
		String secretVal = StrUtils.getSecretValue(value, firstNum);
		try {
			pageContext.getOut().write(secretVal);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
        return EVAL_PAGE;
    }
	
}


