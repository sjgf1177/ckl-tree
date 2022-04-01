package kr.co.unp.cmm.crud.config.xml;

import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.xml.ParserContext;
import org.springframework.util.StringUtils;
import org.w3c.dom.Element;
/**
 * 
 * @author KHD
 *
 */
public class BbsManageParser extends CmmProgramParser {

	@Override
	protected Class<BbsManageParserCpFactoryBean> getBeanClass(Element element) {
		return BbsManageParserCpFactoryBean.class;
	}

	@Override
	protected void doParse(Element element, ParserContext parserContext, BeanDefinitionBuilder builder) {
		super.doParseCommon(element, parserContext, builder);

		addPropertyReference(element, builder, "pageGeneratorDAO", "pageGeneratorDAO");
		addPropertyReference(element, builder, "accessor", "bbsArticleAccessor");
		
		String delPermanentlyQueryId = element.getAttribute("del-permanently-query-id");
		if (StringUtils.hasText(delPermanentlyQueryId)) {
			builder.addPropertyValue("delPermanentlyQueryId", delPermanentlyQueryId);
		}
		
		String restoreQueryId = element.getAttribute("restore-query-id");
		if (StringUtils.hasText(restoreQueryId)) {
			builder.addPropertyValue("restoreQueryId", restoreQueryId);
		}
		
		String replyListQueryId = element.getAttribute("reply-list-query-id");
		if (StringUtils.hasText(replyListQueryId)) {
			builder.addPropertyValue("replyListQueryId", replyListQueryId);
		}

		String updateInqireCoQueryId = element.getAttribute("update-inqire-co-query-id");
		if (StringUtils.hasText(updateInqireCoQueryId)) {
			builder.addPropertyValue("updateInqireCoQueryId", updateInqireCoQueryId);
		}

		String prevQueryId = element.getAttribute("prev-query-id");
		if (StringUtils.hasText(prevQueryId)) {
			builder.addPropertyValue("prevQueryId", prevQueryId);
		}

		String nextQueryId = element.getAttribute("next-query-id");
		if (StringUtils.hasText(nextQueryId)) {
			builder.addPropertyValue("nextQueryId", nextQueryId);
		}
	}
}
