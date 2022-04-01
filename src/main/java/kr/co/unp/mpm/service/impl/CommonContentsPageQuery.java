package kr.co.unp.mpm.service.impl;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Component;

@Component
public class CommonContentsPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchType=").append(param.getString("searchType"));
		queryString.append("&amp;searchTxt=").append(URLEncoder.encode(param.getString("searchTxt"), "UTF-8" ));
		queryString.append("&amp;menuNm=").append(URLEncoder.encode(param.getString("menuNm"), "UTF-8" ));
		queryString.append("&amp;assigned=").append(param.getString("assigned"));
		queryString.append("&amp;siteId=").append(param.getString("siteId"));
		queryString.append("&amp;sMenuNo=").append(param.getString("sMenuNo"));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
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
