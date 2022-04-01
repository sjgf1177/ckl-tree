package kr.co.unp.sns.service;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

public interface SnsService {

	/**
	 * SNS token 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void tokenChk(ParameterContext<ZValue> paramCtx) throws Exception;

	/**
	 * SNS token값 생성 호출
	 * @param paramCtx
	 * @throws Exception
	 */
	public void token(ParameterContext<ZValue> paramCtx) throws Exception;

	/**
	 * SNS CallbackUrl 호출
	 * @param paramCtx
	 * @throws Exception
	 */
	public void callbackUrl(ParameterContext<ZValue> paramCtx) throws Exception;

	/**
	 * SNS profile 조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void profile(ParameterContext<ZValue> paramCtx) throws Exception;

	/**
	 * SNS 게시글 작성
	 * @param paramCtx
	 * @throws Exception
	 */
	public void snsPost(ParameterContext<ZValue> paramCtx) throws Exception;
}
