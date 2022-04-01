package kr.co.edu.onlineEdu.paging;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

public class RealmPageInfo implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		
		StringBuilder queryString = new StringBuilder();
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
		queryString.append("&amp;menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;year=").append(param.getString("year"));
		queryString.append("&amp;insttNm=").append(param.getString("insttNm"));
		
		queryString.append("&amp;pGubun1=").append(param.getString("pGubun1"));
		queryString.append("&amp;pGubun2=").append(param.getString("pGubun2"));
		queryString.append("&amp;pGubun3=").append(param.getString("pGubun3"));
		
		queryString.append("&amp;p_subj=").append(param.getString("p_subj"));
		queryString.append("&amp;p_subjnm=").append(param.getString("p_subjnm"));
		queryString.append("&amp;p_isonoff=").append(param.getString("p_isonoff"));
		queryString.append("&amp;p_scupperclass=").append(param.getString("p_scupperclass"));
		queryString.append("&amp;p_uclassnm=").append(param.getString("p_uclassnm"));
		queryString.append("&amp;p_year=").append(param.getString("p_year"));
		queryString.append("&amp;p_subjseq=").append(param.getString("p_subjseq"));
		queryString.append("&amp;p_tabselect=").append(param.getString("p_tabselect"));
		queryString.append("&amp;p_orders=").append(param.getString("p_orders"));
		queryString.append("&amp;p_ordersnm=").append(param.getString("p_ordersnm"));
		queryString.append("&amp;p_searchtext=").append(param.getString("p_searchtext"));
		
		queryString.append("&amp;pDataSearch=").append(param.getString("pDataSearch"));
		queryString.append("&amp;pDataSearchtext=").append(param.getString("pDataSearchtext"));
		
		queryString.append("&amp;p_type=").append(param.getString("p_type"));
		queryString.append("&amp;p_gcd1=").append(param.getString("p_gcd1"));
		queryString.append("&amp;p_gcd2=").append(param.getString("p_gcd2"));
		queryString.append("&amp;p_level=").append(param.getString("p_level"));
		queryString.append("&amp;p_sort=").append(param.getString("p_sort"));
		
		queryString.append("&amp;pageSize=").append(param.getString("pageUnit").isEmpty() ? param.getString("pagaSize") : param.getString("pageUnit"));
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
