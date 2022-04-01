package kr.co.unp.cmm.crud.config.xml;

import java.util.Map;
import java.util.Set;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.util.MethodInvoker;

/**
 * 
 * @author KHD
 *
 */
public class CmmProgramListenerMethodInterceptor implements MethodInterceptor {

	private final Map<String, Set<MethodInvoker>> invokerMap;
	
	public CmmProgramListenerMethodInterceptor(Map<String, Set<MethodInvoker>> invokerMap){
		this.invokerMap = invokerMap;
	}
	
	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {
		String methodName = invocation.getMethod().getName();
		Set<MethodInvoker> invokers = invokerMap.get(methodName);

		if (invokers == null) {
			return true;
		}
		boolean result = true;
		for (MethodInvoker invoker : invokers) {
			invoker.setArguments(invocation.getArguments());
			invoker.prepare();
			Object retVal = invoker.invoke();
			if (retVal instanceof Boolean) {
				result = (result && (Boolean)retVal);
			}
		}
		
		return result;
		
	}

}
