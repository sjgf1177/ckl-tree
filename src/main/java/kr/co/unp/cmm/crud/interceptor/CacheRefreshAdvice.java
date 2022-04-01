package kr.co.unp.cmm.crud.interceptor;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class CacheRefreshAdvice implements MethodInterceptor{

	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "cacheUtil")
	protected CacheUtil cacheUtil;
	
	private int count = 0;
	
	@SuppressWarnings("unchecked")
	@Override
	public Object invoke(MethodInvocation mi) throws Throwable {
		Object ret = mi.proceed();

		Object[] args = mi.getArguments();
		ParameterContext<ZValue> paramCtx = (ParameterContext<ZValue>)args[0];
		ModelMap model = paramCtx.getModel();
		
		String cacheName = (String)model.get(CmmProgramService.CACHE_KEY);
		cacheUtil.remove(cacheName);
		count++;
		log.debug(paramCtx.getParam().getString("programId") + "[" + count + "] cache has removed");
		
		return ret;
	}
}
