package kr.co.ckl.search;

import java.net.URLEncoder;
import java.util.List;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

@Component
public class SearchPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		List<String> categoryData = param.getList("category");
		StringBuilder queryString = new StringBuilder();
		queryString.append("re=").append(param.getString("re"));
		queryString.append("&amp;q=").append(URLEncoder.encode(param.getString("q"), "UTF-8" ));
		if( CollectionUtils.isNotEmpty(categoryData) ){
			for(String category : categoryData){
				queryString.append("&category=").append(category);
			}
		}
		queryString.append("&amp;range=").append(param.getString("range"));
		queryString.append("&amp;rangeView=").append(param.getString("rangeView"));
		queryString.append("&amp;sdate=").append(param.getString("sdate"));
		queryString.append("&amp;edate=").append(param.getString("edate"));
		queryString.append("&amp;s=").append(param.getString("s"));
		queryString.append("&amp;progrsSttus=").append(param.getString("progrsSttus"));
		queryString.append("&amp;beginDt=").append(param.getString("beginDt"));
		queryString.append("&amp;endDt=").append(param.getString("endDt"));
		queryString.append("&amp;prgSe=").append(param.getString("prgSe"));
		queryString.append("&amp;prgCl=").append(param.getString("prgCl"));
		queryString.append("&amp;gubunSe=").append(param.getString("gubunSe"));
		queryString.append("&amp;gubun=").append(param.getString("gubun"));
		queryString.append("&amp;category01=").append(param.getString("category01"));
		queryString.append("&amp;category02=").append(param.getString("category02"));
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
