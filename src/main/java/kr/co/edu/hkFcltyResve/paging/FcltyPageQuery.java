package kr.co.edu.hkFcltyResve.paging;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class FcltyPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		
		if(param.getString("searchCnd").length() > 0) {
		queryString.append("&amp;searchCnd=").append(param.getString("searchCnd"));
		}
		if(param.getString("areaSe").length() > 0) {
		//queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("spnm"), "UTF-8" ));
		queryString.append("&amp;areaSe=").append(param.getString("areaSe"));
		}
		if(param.getString("lcSe").length() > 0) {
		queryString.append("&amp;lcSe=").append(param.getString("lcSe"));
		}
		if(param.getString("fcltySe").length() > 0) {
		queryString.append("&amp;fcltySe=").append(param.getString("fcltySe"));
		}
		if(param.getString("spceNm").length() > 0) {
		queryString.append("&amp;spceNm=").append(param.getString("spceNm"));
		}
		if(param.getString("prpos").length() > 0) {
		queryString.append("&amp;prpos=").append(param.getString("prpos"));
		}
		if(param.getString("pageUnit").length() > 0) {
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
		}
		if(param.getString("menuNo").length() > 0) {
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
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
