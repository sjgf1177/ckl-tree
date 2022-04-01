package kr.co.unp.cmm.crud.mvr;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class VoCmmUriModelAndViewResolver<T extends SearchVO> extends UriModelAndViewResolver<T>{

	Logger log = Logger.getLogger(this.getClass());

	@Override
	public String determineTargetUri(ParameterContext<T> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) return null;
    	T param = paramCtx.getParam();
		String siteName = param.getSiteName();
		if( "".equals(siteName) ) siteName = SiteMngService.BOS_SITE_NAME;

		StringBuilder result = new StringBuilder();
		String pageQueryString = param.getPageQueryString();
		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getMenuNo();
		}
		if( SUCCESS.equals(resultCode) || FAIL.equals(resultCode) )
			result.append("/").append(siteName).append("/").append(param.getProgramId()).append("/list.do").append("?").append(pageQueryString);
		else if( MODIFY_FAIL.equals(resultCode) || REPLY_SUCCESS.equals(resultCode) )
			result.append("/").append(siteName).append("/").append(param.getProgramId()).append("/list.do").append("?").append(pageQueryString);
		else if( ERROR.equals(resultCode) )
			result.append("javascript:history.back();");
		return result.toString();
	}

}
