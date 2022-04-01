package kr.co.edu.careerManage.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class EduMngPageQuery implements PageQuery<ZValue>{

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception {
		StringBuilder queryString = new StringBuilder();

		if(param.getString("eduNm").length() > 0 && param.getString("eduNm") != null) {
			queryString.append("&amp;eduNm=" + param.getString("eduNm"));
		}
		if(param.getString("eduCode").length() > 0 && param.getString("eduCode") != null) {
			queryString.append("&amp;eduCode=" + param.getString("eduCode"));
		}
		if(param.getString("useAt").length() > 0 && param.getString("useAt") != null) {
			queryString.append("&amp;useAt=" + param.getString("useAt"));
		}
		if(param.getString("pageUnit").length() > 0 && param.getString("pageUnit") != null) {
			queryString.append("&amp;pageUnit=" + param.getString("pageUnit"));
		}
		if(param.getString("menuNo").length() > 0 && param.getString("menuNo") != null) {
			queryString.append("&amp;menuNo=" + param.getString("menuNo"));
		}
		return queryString.toString();
	}

	@Override
	public String getPageQueryString(ZValue zvl) throws Exception {
		String queryString = getPageLinkQueryString(zvl)
				+ "&amp;pageIndex=" + zvl.getString("pageIndex");
			return queryString;
	}

}
