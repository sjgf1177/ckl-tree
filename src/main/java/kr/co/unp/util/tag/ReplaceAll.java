package kr.co.unp.util.tag;


import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@SuppressWarnings("serial")
public class ReplaceAll extends TagSupport{
	protected static final Log log = LogFactory.getLog(ReplaceAll.class);

    private String string;
    private String pattern;
    private String replacement;

	public String getString() {
		return string;
	}

	public void setString(String string) {
		this.string = string;
	}

	public String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

	public String getReplacement() {
		return replacement;
	}

	public void setReplacement(String replacement) {
		this.replacement = replacement;
	}

	public int doEndTag() throws JspTagException
    {
		String value = string.replaceAll(pattern, replacement);
		try {
			pageContext.getOut().write(value);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return EVAL_PAGE;
    }

}


