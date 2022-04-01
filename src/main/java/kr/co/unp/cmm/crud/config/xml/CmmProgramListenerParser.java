package kr.co.unp.cmm.crud.config.xml;

import org.springframework.beans.BeanMetadataElement;
import org.springframework.beans.factory.config.RuntimeBeanReference;
import org.springframework.beans.factory.support.AbstractBeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.xml.ParserContext;
import org.springframework.util.StringUtils;
import org.w3c.dom.Element;
/**
 * 
 * @author KHD
 *
 */
public class CmmProgramListenerParser {

	public AbstractBeanDefinition parse(Element element, ParserContext parserContext) {
		BeanDefinitionBuilder builder = BeanDefinitionBuilder.genericBeanDefinition(CmmProgramListenerFactoryBean.class);
		doParse(element, parserContext, builder);
		return builder.getBeanDefinition();
	}

	public void doParse(Element element, ParserContext parserContext, BeanDefinitionBuilder builder) {
		String targetMethods = element.getAttribute("target-methods");
		if( StringUtils.hasText(targetMethods) ){
			builder.addPropertyValue("targetMethods", targetMethods);
		}
		String listenerRef = element.getAttribute("ref");
		if(!StringUtils.hasText(listenerRef)){
			parserContext.getReaderContext().error(
					"The '<listener/>' element must have ref attribute", element);
		}
		BeanMetadataElement listener = new RuntimeBeanReference(listenerRef);
		builder.addPropertyValue("delegate", listener);

		String beforeMethod = element.getAttribute("before-method");
		if( StringUtils.hasText(beforeMethod) ){
			builder.addPropertyValue("beforeMethod", beforeMethod);
		}
		String afterMethod = element.getAttribute("after-method");
		if( StringUtils.hasText(beforeMethod) ){
			builder.addPropertyValue("afterMethod", afterMethod);
		}
	}
}
