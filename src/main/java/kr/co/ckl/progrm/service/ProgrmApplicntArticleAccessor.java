package kr.co.ckl.progrm.service;

import kr.co.unp.bbs.accessor.DefaultArticleAccessor;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

public class ProgrmApplicntArticleAccessor extends DefaultArticleAccessor {

	@Override
	public String getAccessDenyPage(ParameterContext<ZValue> paramCtx) {
		ZValue param = paramCtx.getParam();
		StringBuilder goUrl = new StringBuilder();
		goUrl.append("/").append(param.getString(CmmProgramService.SITE_NAME)).append("/");
		goUrl.append(param.getString(CmmProgramService.PROGRAM_ID)).append("/list.do?menuNo=").append(param.getString("menuNo")).append("&prgSe=").append(param.getString("prgSe")).append("&prgCl=").append(param.getString("prgCl"));
		return goUrl.toString();
	}

}
