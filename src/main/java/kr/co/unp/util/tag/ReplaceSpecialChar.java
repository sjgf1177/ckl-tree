package kr.co.unp.util.tag; 

 

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * summary :
 * @author kimhyunjun
 * @since 2010. 10. 15.
 * @see
 * @desc 
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   수정일   수정자    수정내용
 *  -------   --------  ---------------------------
 *   2010. 10. 15. 이경훈  최초 생성
 *
 * Copyright (C) 2010 by NEMOSOFT.co All right reserved.
 * </pre>
 */
@SuppressWarnings("serial")
public class ReplaceSpecialChar extends TagSupport{
	protected static final Log log = LogFactory.getLog(ReplaceSpecialChar.class);
	
    private String value;
    

	public String getValue() {
		return value;
	}


	public void setValue(String value) {
		this.value = value;
	}


	public int doEndTag() throws JspTagException //doEndTag:커스텀 테그 닫는 테그를 만났을때 실행, 반대:doStartTag()

    { 
		String temp = "";
		@SuppressWarnings("unused")
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		if (value!=null && !value.equals("")){
			try {
				temp = value.replaceAll("&apos;", "\'");
				temp = temp.replaceAll("&amp;", "&");
				temp = temp.replaceAll("&lt;", "<");
				temp = temp.replaceAll("&gt;", ">");
				//temp = temp.replaceAll("&gt;", '"');
				pageContext.getOut().write(temp);  
				//JspWriter w = pageContext.getOut();
				//writeEscapedXml(temp.toCharArray(), temp.length(), w);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

        return EVAL_PAGE;
    }
	
    private static void writeEscapedXml(char buffer[], int length, JspWriter w)
    throws IOException
    {
    int start = 0;
    for(int i = 0; i < length; i++)
    {
        char c = buffer[i];
        if(c > '>')
            continue;
        char escaped[] = org.apache.taglibs.standard.tag.common.core.Util.specialCharactersRepresentation[c];
        if(escaped == null)
            continue;
        if(start < i)
            w.write(buffer, start, i - start);
        w.write(escaped);
        start = i + 1;
    }

    if(start < length)
        w.write(buffer, start, length - start);
	}
}


