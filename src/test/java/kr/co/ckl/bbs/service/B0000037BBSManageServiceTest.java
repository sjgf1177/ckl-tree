package kr.co.ckl.bbs.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.util.ZValue;

import org.apache.commons.io.FileUtils;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "classpath*:egovframework/spring/com/*.xml",
})
public class B0000037BBSManageServiceTest {

	@Resource(name="SqlDAO")
	ISqlDAO<ZValue> sqlDao;

	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void testMigration() throws Exception{
		List<ZValue> list = sqlDao.listDAO("", null);

		File f= new File("C:\\Users\\Administrator\\Downloads\\nateon");
		String content = FileUtils.readFileToString(f, "UTF-8");
	}


}
