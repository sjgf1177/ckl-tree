package kr.co.unp.bbs.mvr;

import javax.servlet.http.HttpServletRequest;

import kr.co.unp.bbs.vo.BoardVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.mvr.UriModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;

public class CommentModelAndViewResolver extends UriModelAndViewResolver<ZValue>{

	@Override
	public String determineTargetUri(ParameterContext<ZValue> paramCtx) throws Exception
	{
		HttpServletRequest request = paramCtx.getRequest();
		ModelMap model = paramCtx.getModel();
		String requestUri = request.getRequestURI();
    	String dir[] = StrUtils.split(requestUri, "/");
    	String resultCode = (String)model.get(ModelAndViewResolver.RESULT_CODE_KEY);
    	if( resultCode == null ) return null;
    	
    	BoardVO boardVO = (BoardVO)model.get("boardVO");
		StringBuffer result = new StringBuffer();
		long nttId = boardVO.getNttId();
		if( ERROR.equals(resultCode) )
			result.append("javascript:history.back();");
		else if( MODIFY_FAIL.equals(resultCode) || REPLY_SUCCESS.equals(resultCode) || SUCCESS.equals(resultCode) )
			result.append("/").append(dir[1]).append("/bbs/view.do?");
			result.append("nttId=").append(nttId)
			.append("&amp;bbsId=").append(boardVO.getBbsId())
			.append("&amp;pageIndex=").append(boardVO.getPageIndex())
			.append("&amp;menuNo=").append(boardVO.getMenuNo());

		//model.addAttribute(GO_URL_KEY, result.toString());
		return null;
	}

}
