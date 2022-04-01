package kr.co.unp.util;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service("namedMapBeansFactory")
public class NamedMapBeansFactory extends NamedMapBeanFactory {

	public Object[] getBeans(String key, String defaultKey)
	{
		Object[] result = null;
		String serviceNames = beanNameMap.get(key);
		String[] serviceNameData = StrUtils.split(serviceNames, ",");
		if( !ArrayUtils.isEmpty(serviceNameData) )
		{
			result = new Object[serviceNameData.length];
			int i = 0;
			for(String serviceName : serviceNameData)
			{
				Object obj = context.getBean( serviceName );
				if( obj == null && StringUtils.hasText(defaultKey) ) 
					obj = context.getBean( defaultKey );
				result[i++] = obj;
			}
		}
		return result;
	}

	public Object[] getBeans(String key)
	{
		return getBeans(key, null);
	}
}
