package kr.co.unp.util.tag;


import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import kr.co.unp.util.StrUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@SuppressWarnings("serial")
public class NoTagString extends TagSupport{
	protected static final Log log = LogFactory.getLog(HeadStringTag.class);

    private String value;

    private int length;
    
    private int bytes;

    private String brTp;


	public String getBrTp() {
		return brTp;
	}

	public void setBrTp(String brTp) {
		this.brTp = brTp;
	}

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
	
	public int getBytes() {
		return bytes;
	}

	public void setBytes(int bytes) {
		this.bytes = bytes;
	}

	public int doEndTag() throws JspTagException
    {
		String result = StrUtils.getNotTagString(value, length);

		if ("true".equals(brTp)) {
			result = result.replaceAll("\n", "<br />");
		}
		if(bytes > 0){
			result = result.replaceAll("&nbsp;", " ");
			result = substrByte(result, bytes);
		}
		
		try {
			pageContext.getOut().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
        return EVAL_PAGE;
    }
	
	/**
	 * byte단위로 물자열 자르기
	 * @param str
	 * @param bytes
	 * @return
	 */
	public static String substrByte(String str, int bytes){
		String result = str;
		if(!str.isEmpty()){
			if(str.getBytes().length > bytes){
				StringBuffer sb = new StringBuffer(bytes);
				int cnt = 0;
				for(char ch : str.toCharArray()){
					cnt += String.valueOf(ch).getBytes().length;
					if(cnt > bytes) break;
					sb.append(ch);
				}
				sb.append("...");
				result = sb.toString();
			}
		}
		return result;
	}

}


