package kr.co.edu.ablman.paging;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Component;

@Component
public class AcademyPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;prgCl=").append(param.getString("prgCl"));
		queryString.append("&amp;prgNm=").append(URLEncoder.encode(param.getString("prgNm"), "UTF-8" ));
		queryString.append("&amp;nm=").append(URLEncoder.encode(param.getString("nm"), "UTF-8" ));
		queryString.append("&amp;partcptnComptAt=").append(param.getString("partcptnComptAt"));
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
		return queryString.toString();
	}

	@Override
	public String getPageQueryString(ZValue zvl) throws Exception
	{
		String queryString = getPageLinkQueryString(zvl)
			+ "&amp;pageIndex=" + zvl.getString("pageIndex", "1");
		return queryString;

	}
}
