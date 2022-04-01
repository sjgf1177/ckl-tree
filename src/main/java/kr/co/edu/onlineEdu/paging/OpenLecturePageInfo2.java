package kr.co.edu.onlineEdu.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class OpenLecturePageInfo2 implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		
		StringBuilder queryString = new StringBuilder();
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;searchCnd=").append(param.getString("searchCnd"));
		queryString.append("&amp;searchWrd=").append(param.getString("searchWrd"));
		
		queryString.append("&amp;p_type=").append(param.getString("p_type"));
		queryString.append("&amp;p_gcd1=").append(param.getString("p_gcd1"));
		queryString.append("&amp;p_gcd2=").append(param.getString("p_gcd2"));
		queryString.append("&amp;p_level=").append(param.getString("p_level"));
		queryString.append("&amp;p_sort=").append(param.getString("p_sort"));
		
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
