package kr.co.unp.cmm.crud.config.xml;

import java.util.List;

import org.springframework.beans.BeanMetadataElement;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.BeanDefinitionHolder;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.ManagedList;
import org.springframework.beans.factory.xml.AbstractSingleBeanDefinitionParser;
import org.springframework.beans.factory.xml.ParserContext;
import org.springframework.util.StringUtils;
import org.springframework.util.xml.DomUtils;
import org.w3c.dom.Element;
/**
 * 
 * @author KHD
 *
 */
public class CmmProgramParser extends AbstractSingleBeanDefinitionParser {

	private final String REF_ATTR = "ref";
	private final CmmProgramListenerParser cmmProgramListenerParser = new CmmProgramListenerParser();
	
	@SuppressWarnings("rawtypes")
	@Override
	protected Class<? extends CmmProgramParserCpFactoryBean> getBeanClass(Element element) {
		return CmmProgramParserCpFactoryBean.class;
	}

	@Override
	protected void doParse(Element element, ParserContext parserContext, BeanDefinitionBuilder builder) {
		addPropertyReference(element, builder, "accessor", "passThroughArticleAccessor");
		doParseCommon(element, parserContext, builder);
	}
	

	protected void doParseCommon(Element element, ParserContext parserContext, BeanDefinitionBuilder builder) {
		addPropertyReference(element, builder, "sqlDao", "SqlDAO");
		addPropertyReference(element, builder, "fileMngService", "fnwFileMngService");
		addPropertyReference(element, builder, "listHandler", "defaultListHander");
		addPropertyReference(element, builder, "pageInfo", "pageInfo");
		addPropertyReference(element, builder, "pageQuery", "defaultPageQuery");

		String excelUploadService = element.getAttribute("excelUploadService");
		if (StringUtils.hasText(excelUploadService)) {
			builder.addPropertyReference("excelUploadService", excelUploadService);
		}
		
		String targetClass = element.getAttribute("class");
		if (StringUtils.hasText(targetClass)) {
			BeanDefinitionHolder holder = parserContext.getDelegate().parseBeanDefinitionElement(element);
			BeanDefinition bd = holder.getBeanDefinition();
			bd.setBeanClassName(targetClass);
			builder.addPropertyValue("targetObject", bd);
		}
		String listQueryId = element.getAttribute("list-query-id");
		if (StringUtils.hasText(listQueryId)) {
			builder.addPropertyValue("listQueryId", listQueryId);
		}
		String countQueryId = element.getAttribute("count-query-id");
		if (StringUtils.hasText(countQueryId)) {
			builder.addPropertyValue("countQueryId", countQueryId);
		}
		String viewQueryId = element.getAttribute("view-query-id");
		if (StringUtils.hasText(viewQueryId)) {
			builder.addPropertyValue("viewQueryId", viewQueryId);
		}
		String insertQueryId = element.getAttribute("insert-query-id");
		if (StringUtils.hasText(insertQueryId)) {
			builder.addPropertyValue("insertQueryId", insertQueryId);
		}
		String updateQueryId = element.getAttribute("update-query-id");
		if (StringUtils.hasText(updateQueryId)) {
			builder.addPropertyValue("updateQueryId", updateQueryId);
		}
		String deleteQueryId = element.getAttribute("delete-query-id");
		if (StringUtils.hasText(deleteQueryId)) {
			builder.addPropertyValue("deleteQueryId", deleteQueryId);
		}
		String excelQueryId = element.getAttribute("excel-query-id");
		if (StringUtils.hasText(excelQueryId)) {
			builder.addPropertyValue("excelQueryId", excelQueryId);
		}

		List<Element> listenersElements = DomUtils.getChildElementsByTagName(element, "listeners");
		if (listenersElements.size() == 1) {
			Element listenersElement = listenersElements.get(0);
			ManagedList<BeanMetadataElement> listenerContainers = new ManagedList<BeanMetadataElement>();
			List<Element> listenerElements = DomUtils.getChildElementsByTagName(listenersElement, "listener");
			for (Element listenerElement : listenerElements) {
				String listenerRef = listenerElement.getAttribute(REF_ATTR);
				if(!StringUtils.hasText(listenerRef)){
					parserContext.getReaderContext().error(
							"The '<listener/>' element must have ref attribute", element);
				}
				listenerContainers.add(cmmProgramListenerParser.parse(listenerElement, parserContext));
			}
			builder.addPropertyValue("listenerContainers", listenerContainers);
		}
		else if (listenersElements.size() > 1) {
			parserContext.getReaderContext().error(
					"The '<listeners/>' element may not appear more than once in a single <cps/>.", element);
		}
	}
	
	protected void addPropertyReference(Element element, BeanDefinitionBuilder builder, String attr, String defaultAttr){
		String attribute = element.getAttribute(attr);
		attribute = StringUtils.hasText(attribute) ? attribute : defaultAttr;
		builder.addPropertyReference(attr, attribute);
	}
}
