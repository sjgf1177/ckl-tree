package kr.co.unp.bbs.accessor;

import kr.co.unp.cmm.crud.service.ParameterContext;

public class PassThroughArticleAccessor<T> implements ArticleAccessor<T> {

	@Override
	public boolean canAccess(ParameterContext<T> paramCtx) throws Exception {
		return true;
	}

	@Override
	public String getAccessDenyPage(ParameterContext<T> paramCtx) {
		//nothing happend
		return null;
	}

}
