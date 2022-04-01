package kr.co.unp.bbs.mvr;

import kr.co.unp.bbs.vo.BoardMasterVO;
import kr.co.unp.cmm.crud.mvr.UriModelAndViewResolver;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class BbsModelAndViewResolver extends UriModelAndViewResolver<ZValue>{

	Logger log = Logger.getLogger(this.getClass());

	@Override
	public String determineTargetUri(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
		
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) return null;

    	ZValue param = paramCtx.getParam();
    	String bbsId = param.getString("bbsId");
    	String listType = param.getString("listType");
		String siteName = param.getString(CmmProgramService.SITE_NAME);
		StringBuilder result = new StringBuilder();
		String pageQueryString = param.getString(CmmProgramService.PAGE_QUERY_STRING);

		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getString("menuNo");
		}
		if( SUCCESS.equals(resultCode) || FAIL.equals(resultCode) ){
			if("My".equals(listType)){
					result.append("/").append(siteName).append("/bbs/").append(bbsId).append("/listMy.do?").append(pageQueryString);
			}else{
				result.append("/").append(siteName).append("/bbs/").append(bbsId).append("/list.do?").append(pageQueryString);
			}
		}else if( MODIFY_FAIL.equals(resultCode) || REPLY_SUCCESS.equals(resultCode) ){
			if("My".equals(listType)){
				result.append("/").append(siteName).append("/bbs/").append(bbsId).append("/listMy.do?").append(pageQueryString);
			}else{
				result.append("/").append(siteName).append("/bbs/").append(bbsId).append("/list.do?").append(pageQueryString);
			}
		}else if( ERROR.equals(resultCode) )
			result.append("javascript:history.back();");
		return result.toString();
	}

	@Override
	protected String setAdditionalOperation(String includePage, ParameterContext<ZValue> paramCtx){
		ModelMap model = paramCtx.getModel();
		BoardMasterVO master = (BoardMasterVO) model.get("masterVO");
		if( master != null ) includePage = StrUtils.replace(includePage, "[bbsAttrbCode]", master.getBbsAttrbCode());
		System.out.println("=============== includePage : " + includePage);
		return includePage;
	}
}
