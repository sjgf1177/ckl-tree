package kr.co.unp.member.service;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Component;

@Component
public class MemberPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchCnd=").append(param.getString("searchCnd"));
		queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("searchWrd"), "UTF-8" ));
		queryString.append("&amp;searchMentorYn=").append(param.getString("searchMentorYn"));
		queryString.append("&amp;searchEntScale=").append(param.getString("searchEntScale"));
		queryString.append("&amp;searchCountryGb=").append(param.getString("searchCountryGb"));
		queryString.append("&amp;searchVentureGb=").append(param.getString("searchVentureGb"));
		queryString.append("&amp;searchAwardGb=").append(param.getString("searchAwardGb"));
		queryString.append("&amp;searchEntYn=").append(param.getString("searchEntYn"));
		queryString.append("&amp;searchCate1=").append(param.getString("searchCate1"));
		queryString.append("&amp;searchCate2=").append(param.getString("searchCate2"));
		queryString.append("&amp;searchCate3=").append(param.getString("searchCate3"));
		queryString.append("&amp;searchBsnm=").append(URLEncoder.encode(param.getString("searchBsnm"), "UTF-8" ));
		queryString.append("&amp;searchRprsntv=").append(URLEncoder.encode(param.getString("searchRprsntv"), "UTF-8" ));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;sdate=").append(param.getString("sdate"));
		queryString.append("&amp;edate=").append(param.getString("edate"));
		queryString.append("&amp;targetId=").append(param.getString("targetId"));
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
