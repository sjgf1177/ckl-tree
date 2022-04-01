package kr.co.unp.cmm.crud.config.xml;

import org.springframework.beans.factory.xml.NamespaceHandlerSupport;
/**
 * 
 * @author KHD
 *
 */
public class CmmProgramServiceNamespaceHandler extends NamespaceHandlerSupport {

	@Override
	public void init() {
		registerBeanDefinitionParser("cps", new CmmProgramParser());
		registerBeanDefinitionParser("bbs", new BbsManageParser());
	}

}
