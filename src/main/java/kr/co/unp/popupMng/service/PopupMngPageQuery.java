package kr.co.unp.popupMng.service;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Component;

@Component
public class PopupMngPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchCnd=").append(param.getString("searchCnd"));
		queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("searchWrd"), "UTF-8" ));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;sdate=").append(param.getString("sdate"));
		queryString.append("&amp;edate=").append(param.getString("edate"));
		queryString.append("&amp;siteId=").append(param.getString("siteId"));
		return queryString.toString();
	}

	@Override
	public String getPageQueryString(ZValue zvl) throws Exception
	{
		String queryString = getPageLinkQueryString(zvl)
			+ "&amp;pageIndex=" + zvl.getString("pageIndex", "1");
		return queryString;

	}
}
