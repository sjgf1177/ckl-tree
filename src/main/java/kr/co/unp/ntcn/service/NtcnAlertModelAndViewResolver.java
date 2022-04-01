package kr.co.unp.ntcn.service;

import kr.co.unp.cmm.crud.mvr.UriModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class NtcnAlertModelAndViewResolver extends UriModelAndViewResolver<ZValue> {

	@Override
	protected String setAdditionalOperation(String includePage, ParameterContext<ZValue> paramCtx){
		ZValue param = paramCtx.getParam();
		String type = param.getString("type", "01");
		includePage = StrUtils.replace(includePage, "[type]", type);
		return includePage;
	}

	@Override
	public String determineTargetUri(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) return null;

		String type = param.getString("type");
		String siteId = param.getString("siteId");
		String siteName = param.getString("siteName");
		if( "".equals(siteName) ) siteName = SiteMngService.BOS_SITE_NAME;

		StringBuilder result = new StringBuilder();
		String pageQueryString = param.getString("pageQueryString");
		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getString("menuNo");
		}
		if( ERROR.equals(resultCode) ){
			result.append("javascript:history.back();");
		}
		else{
			result.append("/").append(siteName).append("/ntcnAlert/list.do?type=").append(type).append("&siteId=").append(siteId).append("&").append(pageQueryString);
		}
		return result.toString();
	}
}
