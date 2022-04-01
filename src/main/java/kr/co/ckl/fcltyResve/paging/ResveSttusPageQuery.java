package kr.co.ckl.fcltyResve.paging;


import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class ResveSttusPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		//queryString.append("searchCnd=").append(param.getString("searchCnd"));
		//queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("spnm"), "UTF-8" ));
		queryString.append("&amp;areaSe=").append(param.getString("areaSe"));
		queryString.append("&amp;lcSe=").append(param.getString("lcSe"));
		queryString.append("&amp;fcltySe=").append(param.getString("fcltySe"));
		queryString.append("&amp;spceNm=").append(param.getString("spceNm"));
		queryString.append("&amp;eqpmnSn=").append(param.getString("eqpmnSn"));
		queryString.append("&amp;resveNo=").append(param.getString("resveNo"));
		queryString.append("&amp;resveNm=").append(param.getString("resveNm"));
		queryString.append("&amp;mbtlnum=").append(param.getString("mbtlnum"));
		queryString.append("&amp;resveStDt=").append(param.getString("resveStDt"));
		queryString.append("&amp;resveEdDt=").append(param.getString("resveEdDt"));
		queryString.append("&amp;resveBeginTime=").append(param.getString("resveBeginTime"));
		queryString.append("&amp;resveEndTime=").append(param.getString("resveEndTime"));
		queryString.append("&amp;resveSttus=").append(param.getString("resveSttus"));
		queryString.append("&amp;useAt=").append(param.getString("useAt"));
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
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
