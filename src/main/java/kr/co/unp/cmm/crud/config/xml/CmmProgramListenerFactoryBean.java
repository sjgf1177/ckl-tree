package kr.co.unp.cmm.crud.config.xml;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import kr.co.unp.cmm.crud.listener.CmmProgramListener;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerContainer;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.springframework.aop.framework.Advised;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;
import org.springframework.util.MethodInvoker;
import org.springframework.util.StringUtils;
/**
 * Service객체의 각 메소드를 Listener로 연결하는 빈설정
 * @author KHD
 *
 */
public class CmmProgramListenerFactoryBean implements FactoryBean<Object>, InitializingBean {

	private Object delegate;
	private String beforeMethod;
	private String afterMethod;
	private String targetMethods;

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.notNull(delegate, "Delegate must not be null");
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object getObject() throws Exception {
		CmmProgramListenerContainer<ZValue> listenerContainer = new CmmProgramListenerContainer<ZValue>();
		listenerContainer.setTargetMethods(targetMethods);
		if( !StringUtils.hasText(beforeMethod) && !StringUtils.hasText(afterMethod) ){
			listenerContainer.setCmmProgramListener((CmmProgramListener<ZValue>)delegate);
			return listenerContainer;
		}
		MethodInvoker beforeInvoker = getMethodInvokerByName(delegate, beforeMethod, new Class<?>[]{ ParameterContext.class });
		MethodInvoker afterInvoker = getMethodInvokerByName(delegate, afterMethod, new Class<?>[]{ ParameterContext.class });
		Map<String, Set<MethodInvoker>> invokerMap = new HashMap<String, Set<MethodInvoker>>();
		if( beforeInvoker != null ){
			Set<MethodInvoker> beforeInvokers = new HashSet<MethodInvoker>();
			beforeInvokers.add(beforeInvoker);
			invokerMap.put("before", beforeInvokers);
		}
		if( afterInvoker != null ){
			Set<MethodInvoker> afterInvokers = new HashSet<MethodInvoker>();
			afterInvokers.add(afterInvoker);
			invokerMap.put("after", afterInvokers);
		}
		
		ProxyFactory proxyFactory = new ProxyFactory();
		if (delegate instanceof Advised) {
			proxyFactory.setTargetSource(((Advised) delegate).getTargetSource());
		}
		else {
			proxyFactory.setTarget(delegate);
		}
		proxyFactory.setInterfaces(new Class<?>[]{ CmmProgramListener.class });
		proxyFactory.addAdvisor(new DefaultPointcutAdvisor(new CmmProgramListenerMethodInterceptor(invokerMap)));
		Object proxy = proxyFactory.getProxy();
		listenerContainer.setCmmProgramListener((CmmProgramListener<ZValue>)proxy);
		return listenerContainer;
	}

	@Override
	public Class<?> getObjectType() {
		return CmmProgramListenerContainer.class;
	}

	@Override
	public boolean isSingleton() {
		return true;
	}

	public MethodInvoker getMethodInvokerByName(Object object, String methodName, Class<?>... paramTypes) {
		Assert.notNull(object, "Object to invoke must not be null");
		if( methodName == null ){
			return null;
		}
		Method method = ClassUtils.getMethodIfAvailable(object.getClass(), methodName, paramTypes);
		if (method == null) {
			method = ClassUtils.getMethodIfAvailable(object.getClass(), methodName, new Class[] {});
			Assert.notNull(method);
		}
		MethodInvoker invoker = new MethodInvoker();
		invoker.setTargetObject(object);
		invoker.setTargetMethod(methodName);
		return invoker;
	}

	public Object getDelegate() {
		return delegate;
	}

	public void setDelegate(Object delegate) {
		this.delegate = delegate;
	}

	public String getBeforeMethod() {
		return beforeMethod;
	}

	public void setBeforeMethod(String beforeMethod) {
		this.beforeMethod = beforeMethod;
	}

	public String getAfterMethod() {
		return afterMethod;
	}

	public void setAfterMethod(String afterMethod) {
		this.afterMethod = afterMethod;
	}

	public String getTargetMethods() {
		return targetMethods;
	}

	public void setTargetMethods(String targetMethods) {
		this.targetMethods = targetMethods;
	}
	
}
