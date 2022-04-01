package kr.co.unp.cmm.crud.listener;

import kr.co.unp.cmm.crud.service.ParameterContext;
/**
 * 
 * @author KHD
 *
 * @param <T>
 */
public class CmmProgramListenerSupport<T> implements CmmProgramListener<T> {

	/*
	 * (non-Javadoc)
	 * @see kr.co.unp.cmm.crud.listener.CmmProgramListener#before(kr.co.unp.cmm.crud.service.ParameterContext)
	 */
	@Override
	public boolean before(ParameterContext<T> paramCtx) throws Exception {
		if( !doBefore(paramCtx) ){
			return STOP;
		}
		return CONTINUE;
	}
	
	protected boolean doBefore(ParameterContext<T> paramCtx) throws Exception {
		return CONTINUE;
	}

	/*
	 * (non-Javadoc)
	 * @see kr.co.unp.cmm.crud.listener.CmmProgramListener#after(kr.co.unp.cmm.crud.service.ParameterContext)
	 */
	@Override
	public boolean after(ParameterContext<T> paramCtx) throws Exception {
		if( !doAfter(paramCtx) ) {
			return STOP;
		}
		return CONTINUE;
	}

	protected boolean doAfter(ParameterContext<T> paramCtx) throws Exception {
		return CONTINUE;
	}
	
}
