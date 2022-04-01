package kr.co.unp.bbs.mvr;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class BosBbsModelAndViewResolver extends BbsModelAndViewResolver{

	@Override
	public String determineTargetUri(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) return null;

    	ZValue param = paramCtx.getParam();
    	String bbsId = param.getString("bbsId");
		StringBuffer result = new StringBuffer();
		String pageQueryString = param.getString("pageQueryString");
		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getString("menuNo");
		}
		if( SUCCESS.equals(resultCode) || FAIL.equals(resultCode) )
			result.append("/bos/bbs/").append(bbsId).append("/list.do?").append(pageQueryString);
		else if( REPLY_SUCCESS.equals(resultCode) )
			result.append("/bos/bbs/").append(bbsId).append("/view.do?nttId=").append(param.getString("parnts")).append("&").append(pageQueryString);
		else if( MODIFY_FAIL.equals(resultCode) )
			result.append("/bos/bbs/").append(bbsId).append("/forUpdate.do?nttId=").append(param.getString("nttId")).append("&").append(pageQueryString);
		else if( ERROR.equals(resultCode)  )
			result.append("javascript:history.back();");
		return result.toString();
	}

}
