package kr.co.unp.siteMng;
import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.ui.ModelMap;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "classpath*:egovframework/spring/com/*.xml",
})
public class SiteMngServiceTest {

	@Resource(name="siteMngService")
	SiteMngService service;
	
	@Before
	public void setUp() throws Exception {
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testList() throws Exception {
		ZValue param = new ZValue();
		ModelMap model = new ModelMap();
		ParameterContext<ZValue> paramCtx = new ParameterContext<ZValue>();
		paramCtx.setParam(param);
		paramCtx.setModel(model);
		
		service.list(paramCtx);
		
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		System.out.println(resultList);
	}

	@Test
	public void testGetSiteList() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetSiteBySiteId() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetSiteBySiteName() {
		fail("Not yet implemented");
	}

}
