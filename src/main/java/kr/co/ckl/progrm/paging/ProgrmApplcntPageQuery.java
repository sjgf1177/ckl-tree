package kr.co.ckl.progrm.paging;

import java.net.URLEncoder;

import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Component;

@Component
public class ProgrmApplcntPageQuery implements PageQuery<ZValue> {

	@Override
	public String getPageLinkQueryString(ZValue param) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("menuNo=").append(param.getString("menuNo"));
		queryString.append("&amp;prgSe=").append(param.getString("prgSe"));
		queryString.append("&amp;prgCl=").append(param.getString("prgCl"));
		queryString.append("&amp;prgNm=").append(URLEncoder.encode(param.getString("prgNm"), "UTF-8" ));
		queryString.append("&amp;sdate=").append(param.getString("sdate"));
		queryString.append("&amp;edate=").append(param.getString("edate"));
		queryString.append("&amp;reqstMthd=").append(param.getString("reqstMthd"));
		queryString.append("&amp;progrsSttus=").append(param.getString("progrsSttus"));
		queryString.append("&amp;deptId=").append(param.getString("deptId"));
		queryString.append("&amp;useAt=").append(param.getString("useAt"));
		queryString.append("&amp;prgCn=").append(URLEncoder.encode(param.getString("prgCn"), "UTF-8" ));
		queryString.append("&amp;siteSe=").append(param.getString("siteSe"));
		queryString.append("&amp;viewType=").append(param.getString("viewType"));
		queryString.append("&amp;prgSn=").append(param.getString("prgSn"));
		queryString.append("&amp;userId=").append(param.getString("userId"));
		queryString.append("&amp;nm=").append(param.getString("nm"));
		queryString.append("&amp;rceptSttus=").append(param.getString("rceptSttus"));
		queryString.append("&amp;pageUnit=").append(param.getString("pageUnit"));
		return queryString.toString();
	}

	@Override
	public String getPageQueryString(ZValue zvl) throws Exception
	{
		String queryString = getPageLinkQueryString(zvl)
			+ "&amp;pageIndex=" + zvl.getString("pageIndex", "1");
		System.out.println("queryString = "+queryString);
		
		return queryString;

	}
}
