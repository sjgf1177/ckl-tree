package kr.co.unp.util.tag; 


import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

@SuppressWarnings("serial")
public class PagingTag extends TagSupport{
	
	private int pageSize = 10; 
	private int total = 0; 
	private int cpage = 1;
	private String link;


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getTotal() {
		return total;
	}


	public void setTotal(int total) {
		this.total = total;
	}


	public int getCpage() {
		return cpage;
	}


	public void setCpage(int cpage) {
		this.cpage = cpage;
	}


	public String getLink() {
		return link;
	}


	public void setLink(String link) {
		this.link = link;
	}


	public int doEndTag() throws JspTagException
    { 
		// 전체페이지
		int totalPage = (total - 1) / pageSize + 1;
		// 이전10개, 다음10개
		// 이전 마지막 페이지 0 이면 이전10개 없음
		int prev10 = (int) Math.floor((cpage - 1) / 10.0) * 10;
		// 다음 첫페이지 totalPage 보다 크면 다음10개 없음
		int next10 = prev10 + 11;
		StringBuffer sbuf = new StringBuffer();

		if( link.indexOf("?") == -1) link += "?";
		
		if (prev10 > 0) 
		{
			sbuf.append("<a href='").append(link).append("&pageIndex=1'><img src=\"/plaza/memorial_new/imgs/bt_prev1.gif\" width=\"15\" height=\"11\" align=\"absmiddle\" border=\"0\" alt=\"5페이지앞으로\"></a>");
			sbuf.append("<a href=\"").append(link).append("&pageIndex=").append(prev10).append("\"><img src=\"/plaza/memorial_new/imgs/bt_prev.gif\" width=\"11\" height=\"11\" align=\"absmiddle\" border=\"0\" alt=\"한페이지 앞으로\"></a>");
		} // end if 이전10개
		else
		{
			sbuf.append("<img src=\"/plaza/memorial_new/imgs/bt_prev1.gif\" width=\"15\" height=\"11\" align=\"absmiddle\" border=\"0\" alt=\"5페이지앞으로\"> ");
			sbuf.append("<img src=\"/plaza/memorial_new/imgs/bt_prev.gif\" width=\"11\" height=\"11\" align=\"absmiddle\" border=\"0\" alt=\"한페이지 앞으로\">" );
		}
		
		for (int i = 1 + prev10; i < next10 && i <= totalPage; i++) 
		{
			if (i == cpage) 
			{
				sbuf.append("<li><a class=\"current_page\" href=\"javascript:;\"><strong>").append(i).append("</strong></a></li>");
			} 
			else 
			{
				sbuf.append("<li><a href=\"").append(link).append("&pageIndex=").append(i).append("\">").append(i).append("</a></li>");
			} // end if 현재페이지 링크제거
		} // end for

		if (totalPage >= next10) 
		{
			
			sbuf.append("<a href=\"").append(link).append("&pageIndex=").append(next10).append("\"><img src=\"/plaza/memorial_new/imgs/bt_next.gif\" width=\"11\" height=\"11\" align=\"absmiddle\" border=\"0\" alt=\"한페이지 뒤로\"></a>");
			sbuf.append("<a href=\"").append(link).append("&pageIndex=").append(totalPage).append("\"><img src=\"/plaza/memorial_new/imgs/bt_next1.gif\" width=\"15\" height=\"11\" border=\"0\" align=\"absmiddle\" alt=\"다섯페이지 뒤로\"></a>");
		} // end if 다음10개
		else
		{
			sbuf.append("<img src=\"/plaza/memorial_new/imgs/bt_next.gif\" width=\"11\" height=\"11\" align=\"absmiddle\" border=\"0\" alt=\"한페이지 뒤로\">");
			sbuf.append("<img src=\"/plaza/memorial_new/imgs/bt_next1.gif\" width=\"15\" height=\"11\" border=\"0\" align=\"absmiddle\" alt=\"다섯페이지 뒤로\">");
		}
		try {
			pageContext.getOut().write(sbuf.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}  
        return EVAL_PAGE;
    }
	
}


