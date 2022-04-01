package kr.co.unp.cmm.crud.listener;

import org.apache.log4j.Logger;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

public class LogCmmProgramListener extends CmmProgramListenerSupport<ZValue> {

	Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public boolean doBefore(ParameterContext<ZValue> paramCtx) throws Exception {
		log.debug(paramCtx.getTargetMethod() + " before");
		log.debug(paramCtx.getParam());
		return CONTINUE;
	}

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		log.debug(paramCtx.getTargetMethod() + " after");
		return CONTINUE;
	}

}
