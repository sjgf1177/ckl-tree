package kr.co.unp.cmm.crud.mvr;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class DefaultCmmUriModelAndViewResolver extends UriModelAndViewResolver<ZValue> {

	Logger log = Logger.getLogger(this.getClass());

	@Override
	public String determineTargetUri(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) return null;

    	ZValue param = paramCtx.getParam();
		String siteName = param.getString("siteName");
		if( "".equals(siteName) ) siteName = SiteMngService.BOS_SITE_NAME;

		StringBuilder result = new StringBuilder();
		String pageQueryString = param.getString("pageQueryString");
		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getString("menuNo") + "&programId=" + param.getString("programId");
		}
		if( SUCCESS.equals(resultCode) || FAIL.equals(resultCode) )
			result.append("/").append(siteName).append("/").append(param.getString("programId")).append("/list.do").append("?").append(pageQueryString);
		else if( MODIFY_FAIL.equals(resultCode) || REPLY_SUCCESS.equals(resultCode) )
			result.append("/").append(siteName).append("/").append(param.getString("programId")).append("/list.do").append("?").append(pageQueryString);
		else if( ERROR.equals(resultCode) )
			result.append("javascript:history.back();");
		return result.toString();
	}

}
