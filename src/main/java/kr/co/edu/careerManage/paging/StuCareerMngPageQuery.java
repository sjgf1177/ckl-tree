package kr.co.edu.careerManage.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class StuCareerMngPageQuery implements PageQuery<ZValue>{

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception {
		
		StringBuilder queryString = new StringBuilder();

		if(param.getString("eduSn").length() > 0 && param.getString("eduSn") != null) {
			queryString.append("&amp;eduSn=" + param.getString("eduSn"));
		}
		if(param.getString("stuNm").length() > 0 && param.getString("stuNm") != null) {
			queryString.append("&amp;stuNm=" + param.getString("stuNm"));
		}
		if(param.getString("gender").length() > 0 && param.getString("gender") != null) {
			queryString.append("&amp;gender=" + param.getString("gender"));
		}
		if(param.getString("generation").length() > 0 && param.getString("generation") != null) {
			queryString.append("&amp;generation=" + param.getString("generation"));
		}
		if(param.getString("interField").length() > 0 && param.getString("interField") != null) {
			queryString.append("&amp;interField=" + param.getString("interField"));
		}
		if(param.getString("phone").length() > 0 && param.getString("phone") != null) {
			queryString.append("&amp;phone=" + param.getString("phone"));
		}
		if(param.getString("email").length() > 0 && param.getString("email") != null) {
			queryString.append("&amp;email=" + param.getString("email"));
		}
		if(param.getString("finalSch").length() > 0 && param.getString("finalSch") != null) {
			queryString.append("&amp;finalSch=" + param.getString("finalSch"));
		}
		if(param.getString("major").length() > 0 && param.getString("major") != null) {
			queryString.append("&amp;major=" + param.getString("major"));
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
