package kr.co.unp.ntcn.service;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.vo.CacheVO;
import kr.co.unp.main.service.MainService;
import kr.co.unp.util.ZValue;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
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
public class NtcnAlertProgramServiceTest {

	@Resource(name="ntcnAlertProgramService")
	NtcnAlertProgramService service;
	
	ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
	
	@Before
	public void setUp() throws Exception {
		ModelMap model = new ModelMap();
		ZValue param = new ZValue();
		paramCtx.setModel(model);
		paramCtx.setParam(param);
		paramCtx.setRequest(new MockHttpServletRequest());
		paramCtx.setResponse(new MockHttpServletResponse());

		CacheVO cvo = new CacheVO();
		cvo.setCacheName(MainService.PORTAL_MAIN_CACHE_NAME);
		paramCtx.setCacheVO(cvo);
	}

	@Test
	public void testCache() throws Exception {
		service.list(paramCtx);
		
		service.delete(paramCtx);

		service.list(paramCtx);
	}

}
