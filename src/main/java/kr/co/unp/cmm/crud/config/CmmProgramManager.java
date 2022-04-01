package kr.co.unp.cmm.crud.config;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;

public interface CmmProgramManager<T> {
	
	public static final String DEFAULT_KEY = "default";
	
	public CmmProgramService<T> getService(ParameterContext<T> paramCtx) throws Exception;
	
	public ModelAndViewResolver<T> getModelAndViewResolver(ParameterContext<T> paramCtx) throws Exception;
}
