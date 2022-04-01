package kr.co.edu.job.paging;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class EmpymnCnslListQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
		queryString.append("&amp;cnslSn=").append(param.getString("cnslSn"));
		queryString.append("&amp;histSn=").append(param.getString("histSn"));
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;userId=").append(URLEncoder.encode(param.getString("userId"), "UTF-8" ));
		queryString.append("&amp;sdate=").append(param.getString("sdate"));
		queryString.append("&amp;edate=").append(param.getString("edate"));
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
