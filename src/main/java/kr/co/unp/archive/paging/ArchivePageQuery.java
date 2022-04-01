package kr.co.unp.archive.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class ArchivePageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		if(param.getString("taskSeq").length() > 0) {
			queryString.append("&amp;taskSeq=").append(param.getString("taskSeq"));
		}
		if(param.getString("menuNo").length() > 0) {
			queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		}
		queryString.append("&amp;year=").append(param.getString("year"));
		queryString.append("&amp;workField=").append(param.getString("workField"));
		queryString.append("&amp;taskNm=").append(param.getString("taskNm"));
		queryString.append("&amp;organNm=").append(param.getString("organNm"));
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
