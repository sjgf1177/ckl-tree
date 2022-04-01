package kr.co.unp.cmm.crud.handler;

import kr.co.unp.cmm.crud.service.ParameterContext;

public interface Handler<T> {

	public static final boolean CONTINUE = true;
	public static final boolean STOP = false;

	public boolean invoke(ParameterContext<T> paramCtx) throws Exception;
}
