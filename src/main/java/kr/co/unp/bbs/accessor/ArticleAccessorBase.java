package kr.co.unp.bbs.accessor;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

public class ArticleAccessorBase implements ArticleAccessor<ZValue> {

	@Override
	public boolean canAccess(ParameterContext<ZValue> paramCtx) throws Exception {
		return true;
	}

	@Override
	public String getAccessDenyPage(ParameterContext<ZValue> paramCtx) {
		ZValue param = paramCtx.getParam();
		StringBuilder goUrlLink = new StringBuilder();
		goUrlLink.append("/").append(param.getString(CmmProgramService.SITE_NAME)).append("/");
		goUrlLink.append(param.getString(CmmProgramService.PROGRAM_ID)).append("/list.do?menuNo=").append(param.getString("menuNo"));
		return goUrlLink.toString();
	}

}
