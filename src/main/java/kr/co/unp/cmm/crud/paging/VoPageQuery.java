package kr.co.unp.cmm.crud.paging;

import java.net.URLEncoder;

import kr.co.unp.bbs.vo.SearchVO;

public class VoPageQuery<T extends SearchVO> implements PageQuery<T> {

	@Override
	public String getPageLinkQueryString(T param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchCnd=").append(param.getSearchCnd());
		queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getSearchWrd(), "UTF-8" ));
		queryString.append("&amp;delCode=").append(param.getDelCode());
		queryString.append("&amp;menuNo=").append(param.getMenuNo());
		queryString.append("&amp;sdate=").append(param.getSdate());
		queryString.append("&amp;edate=").append(param.getEdate());
		return queryString.toString();
	}

	@Override
	public String getPageQueryString(T param) throws Exception
	{
		String queryString = getPageLinkQueryString(param)
			+ "&amp;pageIndex=" + param.getPageIndex();
		return queryString;

	}
}
