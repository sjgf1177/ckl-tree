package kr.co.edu.job.paging;


import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class EmpmnInfoQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
		queryString.append("&amp;region=").append(param.getString("region"));
		queryString.append("&amp;education=").append(param.getString("education"));
		queryString.append("&amp;career=").append(param.getString("career"));
		queryString.append("&amp;minCareerM=").append(param.getString("minCareerM"));
		queryString.append("&amp;maxCareerM=").append(param.getString("maxCareerM"));
		queryString.append("&amp;empTp=").append(param.getString("empTp"));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
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
