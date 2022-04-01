package kr.co.unp.bbs.accessor;

import kr.co.unp.cmm.crud.service.ParameterContext;

public interface ArticleAccessor<T> {
	
	public static final String ACCESS_APPLIED = "_ACCESS_APPLIED_";

	public boolean canAccess(ParameterContext<T> paramCtx) throws Exception;

	public String getAccessDenyPage(ParameterContext<T> paramCtx);
}
