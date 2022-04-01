package kr.co.unp.util;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class NamedMapBeanFactory implements ApplicationContextAware {

	Logger log = Logger.getLogger(this.getClass());
	
	protected final String DEFAULT_KEY = "default";
	protected ApplicationContext context;
	protected Map<String, String> beanNameMap;

	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.context = applicationContext;
	}
	
	public Map<String, String> getBeanNameMap() {
		return beanNameMap;
	}

	public void setBeanNameMap(Map<String, String> beanNameMap) {
		this.beanNameMap = beanNameMap;
	}

	public String getServiceName(String key)
	{
		return beanNameMap.get(key);
	}

	public <T> T getBean(String key, String defaultKey, Class<T> requireType)
	{
		String serviceName = beanNameMap.get(key);
		if( serviceName == null ) serviceName = beanNameMap.get(defaultKey);
		if( log.isDebugEnabled() ){
			log.debug("NamedMapBeanFactory real bean is [" + serviceName + "]");
		}
		T obj = context.getBean(serviceName, requireType);
		return obj;	
	}
	
	public <T> T getBean(String id, Class<T> requireType)
	{
		return getBean(id, DEFAULT_KEY, requireType);
	}

	public Object getBean(String key, String defaultKey)
	{
		String serviceName = beanNameMap.get(key);
		if( serviceName == null ) serviceName = beanNameMap.get(defaultKey);
		if( log.isDebugEnabled() ){
			log.debug("NamedMapBeanFactory real bean is [" + serviceName + "]");
		}
		Object obj = context.getBean( serviceName );
		return obj;	
	}
	
	public Object getBean(String id)
	{
		return getBean(id, DEFAULT_KEY);
	}
	
}
