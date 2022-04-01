package kr.co.edu.careerManage.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class StatisticsMngPageQuery implements PageQuery<ZValue>{
	
	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception {
		
		StringBuilder queryString = new StringBuilder();

		if(param.getString("eduSn").length() > 0 && param.getString("eduSn") != null) {
			queryString.append("&amp;eduSn=" + param.getString("eduSn"));
		}
		if(param.getString("year").length() > 0 && param.getString("year") != null) {
			queryString.append("&amp;year=" + param.getString("year"));
		}
		
		if(param.getString("gubun").length() > 0 && param.getString("gubun") != null) {
			queryString.append("&amp;gubun=" + param.getString("gubun"));
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
