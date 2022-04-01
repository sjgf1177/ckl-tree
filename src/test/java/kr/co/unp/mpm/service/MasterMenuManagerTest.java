package kr.co.unp.mpm.service;

import java.io.File;
import java.io.FileFilter;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.siteMng.service.SiteMngService;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.junit.BeforeClass;
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
public class MasterMenuManagerTest {

	@Resource(name = "masterMenuManagerService")
	private MasterMenuManager service;
	private final String SITE_ID = SiteMngService.EDU_SITE_ID;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@Test
	public void testReloadMenu() throws Exception {
		service.reloadMenu(SITE_ID);
	}

	@Test
	public void testCreateTempContentsFile() throws Exception {
		service.createTempContentsFile(SITE_ID);
	}

	@Test
	public void testSetContents() throws Exception {
		service.setContents(SITE_ID);
	}

	@Test
	public void testSetContentsAll() throws Exception {
		StringBuilder data = new StringBuilder();
		data.append("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>\n");
		data.append("<div class=\"coomings\">컨텐츠 준비중 입니다.</div>");
		String root = "D:/newProject/ckl-tree/workspace/ckl-tree/src/main/webapp/WEB-INF/jsp/mobileEng/cts";
		File f = new File(root);
		listFiles(f, data.toString());
	}

	private void listFiles(File file, String data) throws Exception{
		File[] subFiles = file.listFiles(filter);
		if( ArrayUtils.isNotEmpty(subFiles) ){
			for(File f : subFiles){
				if( f.isDirectory() ){
					listFiles(f, data);
				}
				else{
					if( f.getName().indexOf(".jsp") > 0 ){
						List<String> lines = FileUtils.readLines(f);
						if (lines.size() <= 2) {
							System.out.println(f.getAbsolutePath());
							FileUtils.writeStringToFile(f, data, "UTF-8");
						}
					}
				}
			}
		}
	}

	public static final UploadableFileFilter filter = new UploadableFileFilter();

	public static class UploadableFileFilter implements FileFilter {
		public boolean accept(File file) {
			return file.getName().indexOf(".svn") == -1;
		}

	}
}
