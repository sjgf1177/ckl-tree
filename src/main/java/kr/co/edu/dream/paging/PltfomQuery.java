package kr.co.edu.dream.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class PltfomQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;year=").append(param.getString("year"));
		queryString.append("&amp;insttNm=").append(param.getString("insttNm"));
		queryString.append("&amp;pageSize=").append(param.getString("pageUnit").isEmpty() ? param.getString("pagaSize") : param.getString("pageUnit"));
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
