package kr.co.unp.cmm.crud.interceptor;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.stereotype.Service;

@Service(value="loggerAdvice")
class LoggerAdvice implements MethodInterceptor{
	@Override
	public Object invoke(MethodInvocation mi) throws Throwable {
		String mn = mi.getMethod().getName();
		System.out.println(mn + " Start----");
		Object result = mi.proceed();
		System.out.println(mn + " End--");
		return result;
	}

}
