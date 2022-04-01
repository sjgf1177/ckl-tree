package kr.co.unp.cmm.crud.mvr;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.web.servlet.view.DefaultRequestToViewNameTranslator;


public class DefaultRequestToViewNameTranslatorTest {

	@Test
	public void testTranslator(){
		MockHttpServletRequest request = new MockHttpServletRequest();
		request.setRequestURI("/bos/app/integrateApp/list.do");
		DefaultRequestToViewNameTranslator d = new DefaultRequestToViewNameTranslator();
		assertEquals("bos/app/integrateApp/list", d.getViewName(request));

		request.setRequestURI("/portal/app/integrateApp/list.do");
		d.setPrefix("/");
		d.setSuffix(".jsp");
		assertEquals("/portal/app/integrateApp/list.jsp", d.getViewName(request));

	}
}
