package kr.co.unp.cmm.crud.service;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.aop.framework.ProxyFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.ui.ModelMap;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "classpath*:egovframework/spring/com/*.xml",
})
public class DefaultCmmProgramServiceTest {

	@Autowired
	ApplicationContext context;

	@Resource(name="doubleLoggerProgramServiceProxy")
	CmmProgramService<ZValue> dp2;

	@Resource(name="loggerProgramServiceProxy")
	CmmProgramService<ZValue> dp;

	@Resource(name="CommonCodeProgramServiceProxy")
	CmmProgramService<ZValue> dp3;

	@SuppressWarnings("unchecked")
	@Test
	public void testForInsert() throws Exception {
		ProxyFactoryBean pb = context.getBean("&loggerProgramServiceProxy", ProxyFactoryBean.class);
		System.out.println(pb.getObject());
		CmmProgramService<ZValue> dp = (CmmProgramService<ZValue>)pb.getObject();

		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		ZValue param = new ZValue();
		paramCtx.setParam(param);
		paramCtx.setRequest(new MockHttpServletRequest());
		paramCtx.setResponse(new MockHttpServletResponse());
		paramCtx.setModel(new ModelMap());
		dp.forInsert(paramCtx);
	}

	@Test
	public void testForInsert2() throws Exception {
		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		ZValue param = new ZValue();
		paramCtx.setParam(param);
		paramCtx.setRequest(new MockHttpServletRequest());
		paramCtx.setResponse(new MockHttpServletResponse());
		paramCtx.setModel(new ModelMap());
		dp.forInsert(paramCtx);
	}

	@Test
	public void testForInsert3() throws Exception {
		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		ZValue param = new ZValue();
		paramCtx.setParam(param);
		paramCtx.setRequest(new MockHttpServletRequest());
		paramCtx.setResponse(new MockHttpServletResponse());
		paramCtx.setModel(new ModelMap());
		dp3.forInsert(paramCtx);
	}

}
