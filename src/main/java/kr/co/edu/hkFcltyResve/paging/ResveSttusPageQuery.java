package kr.co.edu.hkFcltyResve.paging;


import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class ResveSttusPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		//queryString.append("searchCnd=").append(param.getString("searchCnd"));
		//queryString.append("&amp;searchWrd=").append(URLEncoder.encode(param.getString("spnm"), "UTF-8" ));
		if(param.getString("areaSe").length() > 0) {
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
		if(param.getString("eqpmnSn").length() > 0) {
			queryString.append("&amp;eqpmnSn=").append(param.getString("eqpmnSn"));
		}
		if(param.getString("resveNo").length() > 0) {
			queryString.append("&amp;resveNo=").append(param.getString("resveNo"));
		}
		if(param.getString("resveNm").length() > 0) {
			queryString.append("&amp;resveNm=").append(param.getString("resveNm"));
		}
		if(param.getString("mbtlnum").length() > 0) {
			queryString.append("&amp;mbtlnum=").append(param.getString("mbtlnum"));
		}
		if(param.getString("resveStDt").length() > 0) {
			queryString.append("&amp;resveStDt=").append(param.getString("resveStDt"));
		}
		if(param.getString("resveEdDt").length() > 0) {
			queryString.append("&amp;resveEdDt=").append(param.getString("resveEdDt"));
		}
		if(param.getString("resveBeginTime").length() > 0) {
			queryString.append("&amp;resveBeginTime=").append(param.getString("resveBeginTime"));
		}
		if(param.getString("resveEndTime").length() > 0) {
			queryString.append("&amp;resveEndTime=").append(param.getString("resveEndTime"));
		}
		if(param.getString("resveSttus").length() > 0) {
			queryString.append("&amp;resveSttus=").append(param.getString("resveSttus"));
		}
		if(param.getString("useAt").length() > 0) {
			queryString.append("&amp;useAt=").append(param.getString("useAt"));
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
