package kr.co.unp.cmm.crud.paging;

import java.net.URLEncoder;

import org.springframework.stereotype.Component;

import kr.co.unp.util.ZValue;

@Component
public class DefaultPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();

		if(param.getString("searchCnd").length() > 0) {
			queryString.append("&amp;searchCnd=").append(param.getString("searchCnd"));
		}
		if(param.getString("searchWrd").length() > 0) {
			queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("searchWrd"), "UTF-8" ));
		}
		if(param.getString("gubun").length() > 0) {
			queryString.append("&amp;gubun=").append(param.getString("gubun"));
		}
		if(param.getString("delcode").length() > 0) {
			queryString.append("&amp;delCode=").append(param.getString("delcode"));
		}
		if(param.getString("useAt").length() > 0) {
		queryString.append("&amp;useAt=").append(param.getString("useAt"));
		}
		if(param.getString("replyAt").length() > 0) {		
		queryString.append("&amp;replyAt=").append(param.getString("replyAt"));
		}
		if(param.getString("menuNo").length() > 0) {		
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		}
		if(param.getString("sdate").length() > 0) {		
		queryString.append("&amp;sdate=").append(param.getString("sdate"));
		}
		if(param.getString("edate").length() > 0) {		
		queryString.append("&amp;edate=").append(param.getString("edate"));
		}
		if(param.getString("viewType").length() > 0) {		
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
		}
		if(param.getString("type").length() > 0) {		
		queryString.append("&amp;type=").append(param.getString("type"));
		}
		if(param.getString("siteId").length() > 0) {		
		queryString.append("&amp;siteId=").append(param.getString("siteId"));
		}
		if(param.getString("option1").length() > 0) {		
		queryString.append("&amp;option1=").append(param.getString("option1"));
		}
		if(param.getString("option5").length() > 0) {		
		queryString.append("&amp;option5=").append(param.getString("option5"));
		}
		if(param.getString("workField").length() > 0) {		
		queryString.append("&amp;workField=").append(param.getString("workField"));
		}
		return queryString.toString();
	}

	@Override
	public String getPageQueryString(ZValue zvl) throws Exception
	{
		String queryString = getPageLinkQueryString(zvl)
			+ "&amp;pageIndex=" + zvl.getString("pageIndex");
		return queryString;

	}
}
