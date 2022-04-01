package kr.co.unp.archive.vo;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class ArchiveProjectPageInfo implements PageQuery<ZValue> {

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
