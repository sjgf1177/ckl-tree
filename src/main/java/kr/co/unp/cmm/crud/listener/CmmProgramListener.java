package kr.co.unp.cmm.crud.listener;

import kr.co.unp.cmm.crud.service.ParameterContext;
/**
 * 프로그램 실행전후의 추가작업
 * @author KHD
 *
 * @param <T>
 */
public interface CmmProgramListener<T> {

	public static final boolean CONTINUE = true;
	public static final boolean STOP = false;
	
	/**
	 * 프로그램 실행전
	 * @param paramCtx - paramCtx.getTargetMethod()의 메소드명으로 실행할 작업을 제어
	 */
	public boolean before(ParameterContext<T> paramCtx) throws Exception;
	
	/**
	 * 프로그램 실행후
	 * @param paramCtx - paramCtx.getTargetMethod()의 메소드명으로 실행할 작업을 제어
	 */
	public boolean after(ParameterContext<T> paramCtx) throws Exception;
}
