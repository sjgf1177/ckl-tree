package kr.co.unp.micro.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.ServletContextAware;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

public class MicroService extends DefaultCmmProgramService implements ServletContextAware {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	@Resource(name = "masterMenuManagerService")
	private MasterMenuManager masterMenuManagerService;

	@Resource(name = "siteMngService")
	private SiteMngService siteMngService;

	public void microContents(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param    = paramCtx.getParam();
		ModelMap model  = paramCtx.getModel();
		ZValue siteInfo = siteMngService.getSiteBySiteName(param.getString("siteName"));
		
		model.addAttribute("siteName", param.getString("siteName"));
		String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + siteInfo.getString("siteId");
		
		@SuppressWarnings("unchecked")
		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)servletContext.getAttribute(contextScopeMenuAllName);
		MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, param.getInt("menuNo"));
		
		if ( currentVo != null ) 
			// model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, currentVo.getContentsPath());
			// test 임시로 page url 을 넣어준다.
			model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/micro/main.jsp");
		else {
			model.addAttribute(ModelAndViewResolver.ERROR, "[menuNo,0][menuNm,ERROR페이지][menuLink,null][fullMenuLink,/"+param.getString("siteName")+"/archive/archive.do?menuNo=0][path,][menuNoPath,][leafNodeYn,N]");
		}
		
	}

	private ServletContext servletContext;
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}
