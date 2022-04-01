package kr.co.edu.hkEtcResve.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class EqpmnPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		//queryString.append("searchCnd=").append(param.getString("searchCnd"));
		//queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("spnm"), "UTF-8" ));
		if(param.getString("eqpmnNm").length() > 0) {
			queryString.append("&amp;eqpmnNm=").append(param.getString("eqpmnNm"));
		}
		if(param.getString("dtlsInfo").length() > 0) {
			queryString.append("&amp;dtlsInfo=").append(param.getString("dtlsInfo"));
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
