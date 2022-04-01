package kr.co.unp.mpm.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.mpm.dao.CommonContentsDAO;
import kr.co.unp.mpm.dao.MenuManageDAO;
import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.mpm.service.MenuManageService;
import kr.co.unp.mpm.service.ProgrmManageService;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.mpm.vo.MenuSiteMapVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.FileMngUtil;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.HttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 메뉴목록 관리및 메뉴생성, 사이트맵 생성을 처리하는 비즈니스 구현 클래스
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class MenuManageController implements ServletContextAware {

	protected Log log = LogFactory.getLog(this.getClass());
	/* Validator */
	@Autowired
	private DefaultBeanValidator beanValidator;
	/** PropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** MenuManageService */
	@Resource(name = "meunManageService")
    private MenuManageService menuManageService;

    /** MenuManageService */
	@Resource(name = "progrmManageService")
	private ProgrmManageService progrmManageService;

    /** FileMngUtil */
	@Resource(name="fileMngUtil")
	private FileMngUtil fileUtil;

    @Resource(name = "masterMenuManagerService")
    protected MasterMenuManager masterMenuManagerService;

//    @Resource(name = "applyService")
//    protected ApplyService applyService;

	/** egovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** CommonContentsService */
    @Resource(name = "commonContentsDAO")
    protected CommonContentsDAO commonContentsDAO;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

	@Resource(name = "siteMngService")
	private SiteMngService siteMngService;

	private ServletContext servletContext;

	@Resource(name = "menuManageDAO")
    protected MenuManageDAO menuManageDAO;

	public void setServletContext(ServletContext servletContext)
	{
		this.servletContext = servletContext;
	}
    /**
     * 메뉴정보목록을 상세화면 호출 및 상세조회한다.
     * @param req_menuNo  String
     * @return 출력페이지정보 "mpm/MenuDetailSelectUpdt"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuManageListDetailSelect")
    public String selectMenuManage(
    		@RequestParam("req_menuNo") String req_menuNo ,
    		@ModelAttribute("searchVO") ComDefaultVO searchVO,
    		ModelMap model)
            throws Exception {

    	searchVO.setSearchKeyword(req_menuNo);

    	MenuManageVO resultVO = menuManageService.selectMenuManage(searchVO);
    	/**
    	 * 메뉴수정시 & --> &amp; 로 변경되어 수정함
    	 * 2010.04.11 이경훈
    	 */
    	if (resultVO.getMenuNm()!=null) resultVO.setMenuNm(resultVO.getMenuNm().replaceAll("&amp;", "&"));
    	if (resultVO.getMenuLink()!=null) resultVO.setMenuLink(resultVO.getMenuLink().replaceAll("&amp;", "&"));
    	if (resultVO.getMenuDc()!=null) resultVO.setMenuDc(resultVO.getMenuDc().replaceAll("&amp;", "&"));
        model.addAttribute("menuManageVO", resultVO);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuDetailSelectUpdt.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }


    /**
     * 메뉴목록 멀티 삭제한다.
     * @param checkedMenuNoForDel  String
     * @return 출력페이지정보 "forward:/mpm/MenuManageSelect"
     * @exception Exception
     */
    @RequestMapping("/bos/mpm/MenuManageListDelete")
    public String deleteMenuManageList(
            @RequestParam("checkedMenuNoForDel") String checkedMenuNoForDel ,
            @ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
            ModelMap model)
            throws Exception {
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "bos/cmm/uat/uia/LoginUsr";
    	}
		String sLocationUrl = null;
    	String resultMsg    = "";

		String [] delMenuNo = checkedMenuNoForDel.split(",");

		if (delMenuNo == null || (delMenuNo.length ==0)){
    		resultMsg = egovMessageSource.getMessage("fail.common.delete");
    		sLocationUrl = "forward:/bos/mpm/MenuManageSelect.do";
		}else{
			menuManageService.deleteMenuManageList(checkedMenuNoForDel);
			resultMsg = egovMessageSource.getMessage("success.common.delete");
			sLocationUrl ="forward:/bos/mpm/MenuManageSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
        return sLocationUrl;
    }

    /**
     * 메뉴정보를 등록화면으로 이동 및 등록 한다.
     * @param menuManageVO    MenuManageVO
     * @param commandMap      Map
     * @return 출력페이지정보 등록화면 호출시 "mpm/MenuRegist",
     *         출력페이지정보 등록처리시 "forward:/mpm/MenuManageSelect"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuRegistInsert")
    public String insertMenuManage(
    		Map commandMap,
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
		String sLocationUrl = null;
    	String resultMsg    = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/uat/uia/LoginUsr.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	}
        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if(sCmd.equals("insert")){
            beanValidator.validate(menuManageVO, bindingResult);
    		if (bindingResult.hasErrors()){
    			sLocationUrl = "/bos/mpm/MenuRegist.jsp";
    			model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, sLocationUrl);
    			return Globals.BOS_TEMPLATE_VIEW;
    		}
    		if(menuManageService.selectMenuNoByPk(menuManageVO) == 0){
    			ComDefaultVO searchVO = new ComDefaultVO();
    			searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());
    			if(progrmManageService.selectProgrmNMTotCnt(searchVO)==0){
    	    		resultMsg = egovMessageSource.getMessage("fail.common.insert");
    		        sLocationUrl = "/bos/mpm/MenuRegist.jsp";
    			}else{
    	        	menuManageService.insertMenuManage(menuManageVO);
            		resultMsg = egovMessageSource.getMessage("success.common.insert");
    		        sLocationUrl = "forward:/bos/mpm/MenuManageSelect.do";
    			}
    		}else{
        		resultMsg = egovMessageSource.getMessage("common.isExist.msg");
        		sLocationUrl = "/bos/mpm/MenuRegist.jsp";
    		}
    		model.addAttribute("resultMsg", resultMsg);
		}else{
            sLocationUrl = "/bos/mpm/MenuRegist.jsp";
        }
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, sLocationUrl);
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 메뉴정보를 수정 한다.
     * @param menuManageVO  MenuManageVO
     * @return 출력페이지정보 "forward:/mpm/MenuManageSelect"
     * @exception Exception
     */
    @RequestMapping(value="/mpm/MenuDetailSelectUpdt")
    public String updateMenuManage(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	/*
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "cmm/uat/uia/LoginUsr";
    	}
        beanValidator.validate(menuManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/mpm/MenuManageListDetailSelect";
			return sLocationUrl;
		}
		*/
		ComDefaultVO searchVO = new ComDefaultVO();
		searchVO.setSearchKeyword(menuManageVO.getProgrmFileNm());

		menuManageService.updateMenuManage(menuManageVO);
    	resultMsg = egovMessageSource.getMessage("success.common.update");
       	sLocationUrl = "forward:/bos/mpm/MenuManageSelect";
    	model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl;
    }

    /**
     * 메뉴정보를 삭제 한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "forward:/mpm/MenuManageSelect"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuManageDelete")
    public String deleteMenuManage(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception {
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/uat/uia/LoginUsr.jsp");
			return Globals.BOS_TEMPLATE_VIEW;
    	}
    	menuManageService.deleteMenuManage(menuManageVO);
    	resultMsg = egovMessageSource.getMessage("success.common.delete");
    	String _MenuNm = "%";
    	menuManageVO.setMenuNm(_MenuNm);
    	model.addAttribute("resultMsg", resultMsg);
      	return "forward:/bos/mpm/MenuManageSelect.do?cMenuNo="+menuManageVO.getcMenuNo()+"&menuNo="+menuManageVO.getMenuNo();
    }

    /**
     * 메뉴리스트를 조회한다.
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "mpm/MenuList"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuListSelect/{siteId}")
    public String selectMenuList(
    		@PathVariable String siteId,
    		HttpServletRequest request,
    		ModelMap model)
            throws Exception {
    	String resultMsg    = "";
    	if(siteId == null || "".equals(siteId)) siteId = "1"; //기본 사이트 관리자
    	MenuManageVO vo = new MenuManageVO();
    	vo.setSiteId(siteId);
    	vo.setTempValue("1");
    	List list_menulist = menuManageDAO.selectAllMenuBySiteId(vo);

    	resultMsg = egovMessageSource.getMessage("success.common.select");
        model.addAttribute("list_menulist", list_menulist);
        model.addAttribute("resultMsg", resultMsg);

        //콘텐츠 가져오기
        if (request.getParameter("cMenuNo")!=null && !request.getParameter("cMenuNo").equals("")){
        	ZValue zvl = new ZValue();
        	zvl.put("menu_no", request.getParameter("cMenuNo"));
        	model.addAttribute("menuCon", menuManageService.selectMenuByContents(zvl));
        }

        ZValue siteInfo = siteMngService.getSiteBySiteId(siteId);
        model.addAttribute("siteInfo", siteInfo);

        //2013.05.07 우정 수정 개발용 MenuList.jsp 에 menuLoad()에서 주석 해제  후 변경 실서버 용으로...
        model.addAttribute("cMenuNo", request.getParameter("cMenuNo"));
        //model.addAttribute("siteId", siteId);
        //!2013.05.07 우정 수정 개발용!
		//model.addAttribute("includePage", "/WEB-INF/jsp/framework/mpm/MenuList.jsp");

		//return Globals.ADMIN_MAIN_PAGE;
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuList.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 메뉴리스트의 메뉴정보를 등록한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "mpm/MenuList"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuListInsert")
    public String insertMenuList(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		HttpServletRequest request,
    		HttpServletResponse response,
    		ModelMap model)
            throws Exception {

        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/uat/uia/LoginUsr.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	}

    	String siteId = menuManageVO.getSiteId();
    	if( siteId == null || "".equals(siteId))
    		menuManageVO.setSiteId("1"); //기본 사이트 관리자로 지정
    	
    	int menuNo = menuManageVO.getMenuNo();
    	
    	menuManageService.insertMenuManage(menuManageVO);

		resultMsg = egovMessageSource.getMessage("success.common.insert");
		HttpUtil.goUrl(response, "/bos/mpm/MenuListSelect/"+menuManageVO.getSiteId()+".do?cMenuNo="+menuManageVO.getcMenuNo()+"&menuNo="+menuNo, resultMsg);
		//sLocationUrl = "forward:/bos/mpm/MenuListSelect/"+menuManageVO.getSiteId()+".do?cMenuNo="+menuManageVO.getMenuNo()+"&menuNo="+menuNo;
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    }

    /**
     * 메뉴리스트의 메뉴정보를 수정한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "mpm/MenuList"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuListUpdt")
    public String updateMenuList(
    		HttpServletRequest request,
    		HttpServletResponse response,
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {

        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리

    	// 수정자 등록
    	String siteId = menuManageVO.getSiteId();
    	if( siteId == null || "".equals(siteId)) menuManageVO.setSiteId(SiteMngService.BOS_SITE_ID); //기본 사이트 관리자로 지정

		menuManageService.updateMenuManage(menuManageVO);

    	// 콘테츠 관리 테이블에 내용 저장
    	if (menuManageVO.getChkConModi()!=null && menuManageVO.getChkConModi().equals("Y")){
    		commonContentsDAO.modify(menuManageVO);

    		//파일생성
    		//String contentsPath = menuManageVO.getContentsPath();
    		//String path = "/WEB-INF/jsp/framework" + contentsPath;
    		//File f = new File(path);
    		//FileUtils.writeStringToFile(f, menuManageVO.getCvCon(), "UTF-8");
    	}
    	
		resultMsg = egovMessageSource.getMessage("success.common.update");
		HttpUtil.goUrl(response, "/bos/mpm/MenuListSelect/"+siteId+".do?cMenuNo="+menuManageVO.getcMenuNo()+"&menuNo="+menuManageVO.getMenuNo(), resultMsg);

		//model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    }

    /**
     * 메뉴리스트의 메뉴정보를 삭제한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "mpm/MenuList"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuListDelete")
    public String deleteMenuList(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/uat/uia/LoginUsr.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	}

        beanValidator.validate(menuManageVO, bindingResult);
		if (bindingResult.hasErrors()){
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuList.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
		}
    	String siteId = menuManageVO.getSiteId();
    	if( siteId == null || "".equals(siteId))
    		menuManageVO.setSiteId("1"); //기본 사이트 관리자로 지정
		menuManageService.deleteMenuManage(menuManageVO);
		resultMsg = egovMessageSource.getMessage("success.common.delete");
        sLocationUrl = "forward:/bos/mpm/MenuListSelect/"+menuManageVO.getSiteId()+".do?cMenuNo="+menuManageVO.getcMenuNo()+"&menuNo="+menuManageVO.getMenuNo();
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    }


	/*********** 메뉴 생성 관리 ***************/

    /**
     * *메뉴생성목록을 조회한다.
     * @param searchVO  ComDefaultVO
     * @return 출력페이지정보 "mpm/MenuCreatManage"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuCreatManageSelect")
    public String selectMenuCreatManagList(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO,
    		ModelMap model)
            throws Exception {
    	String resultMsg ="";
    	// 내역 조회
    	/** PropertyService.sample */
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		if( !UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER") ){
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			searchVO.setDeptId(user.getDeptId());
		}
        int totCnt = menuManageService.selectMenuCreatManagTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

        int currentSize = totCnt - ((searchVO.getPageIndex()-1)*searchVO.getPageUnit());
		searchVO.setCurrentSize(currentSize);

		List list_menumanage = menuManageService.selectMenuCreatManagList(searchVO);
		model.addAttribute("list_menumanage", list_menumanage);

        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("resultMsg", resultMsg);

    	String link = "/bos/mpm/MenuCreatManageSelect.do" + 
    			"?searchKeyword="+URLEncoder.encode(searchVO.getSearchKeyword(), "UTF-8");
    	
    	String pageNav = pageInfo.getPageNavString(searchVO.getPageUnit(), totCnt, searchVO.getPageIndex(), link);
    	
    	model.addAttribute("resultCnt", totCnt);
    	model.addAttribute("pageNav", pageNav);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuCreatManage.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /*메뉴생성 세부조회*/
    /**
     * 메뉴생성 세부화면을 조회한다.
     * @param menuCreatVO MenuCreatVO
     * @return 출력페이지정보 "mpm/MenuCreat"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuCreatSelect/{authorCode}")
    public String selectMenuCreatList(@PathVariable String authorCode,HttpServletRequest request,ModelMap model) throws Exception {
    	ZValue zvl = WebFactory.getAttributes(request);
    	zvl.put("authorCode", authorCode);
    	List<MenuManageVO> list_menulist = null;
    	if( !UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER") ){
        	List<String> authorities = UnpUserDetailsHelper.getAuthorities();
        	zvl.put("authorities", authorities);
    		list_menulist = menuManageService.selectAuthoMenuListByAuthorities(zvl);
    	}
    	else{
    		list_menulist = menuManageService.selectAuthoMenuList(zvl);
    	}
    	HashMap<String, List<MenuManageVO>> adminMenuCategoryMap = masterMenuManagerService.getMenuCategories(list_menulist);
    	HashMap<String, List<MenuManageVO>> obj = masterMenuManagerService.setMenuCategory(adminMenuCategoryMap, "menu_0", 0, new String[6]);
        model.addAttribute("adminMenuCategoryMap", obj);
        model.addAttribute("resultVO", zvl);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuCreat.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }


    /**
     * 메뉴생성처리 및 메뉴생성내역을 등록한다.
     * @param checkedAuthorForInsert  String
     * @param checkedMenuNoForInsert  String
     * @return 출력페이지정보 등록처리시 "forward:/mpm/MenuCreatSelect"
     * @exception Exception
     */
    @RequestMapping("/bos/mpm/MenuCreatInsert")
    public void insertMenuCreatList(
			HttpServletRequest request,
            HttpServletResponse response,
            ModelMap model)
            throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);

    	String resultMsg = "정상처리하였습니다.";
    	String checkedAuthorForInsert = zvl.getString("checkedAuthorForInsert");
    	String checkedMenuNoForInsert = "";
    	Set<String> menuNoSet = new HashSet<String>();
    	String[] checkFieldes = request.getParameterValues("checkField");
    	if(checkFieldes != null)
    	{
    		String checkField = null;
    		String[] menuNoData = null;
    		for(int i=0; i<checkFieldes.length; i++)
    		{
    			checkField = checkFieldes[i];
    			menuNoData = checkField.split("_");
    			for(int j=0; j<menuNoData.length; j++)
    			{
    				menuNoSet.add(menuNoData[j]);
    			}
    		}

        	Object[] menuNoDataA = menuNoSet.toArray();
        	if(menuNoDataA != null)
        	{
        		for(int i=0; i<menuNoDataA.length; i++)
        		{
        			checkedMenuNoForInsert += menuNoDataA[i] + ",";
        		}
        	}

        	log.debug("checkedAuthorForInsert : " + checkedAuthorForInsert);
        	log.debug("checkedMenuNoForInsert : " + checkedMenuNoForInsert);
    	}

    	menuManageService.insertMenuCreatList(checkedAuthorForInsert, checkedMenuNoForInsert);

		//model.addAttribute("resultMsg", resultMsg);
    	StringBuffer link = new StringBuffer();
    	link.append("/bos/mpm/MenuCreatManageSelect.do");
    	link.append("?pageIndex=").append(zvl.getString("pageIndex", "1"));
    	link.append("&searchKeyword=").append(zvl.getString("searchKeyword"));
    	link.append("&menuNo=").append(zvl.getString("menuNo"));
		WebFactory.printHtml(response, resultMsg, link.toString());
    }

    /*메뉴사이트맵 생성조회*/
    /**
     * 메뉴사이트맵을 생성할 내용을 조회한다.
     * @param menuSiteMapVO MenuSiteMapVO
     * @return 출력페이지정보 등록처리시 "mpm/MenuCreatSiteMap"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuCreatSiteMapSelect")
    public String selectMenuCreatSiteMap(
    		@ModelAttribute("menuSiteMapVO") MenuSiteMapVO menuSiteMapVO,
    		ModelMap model)
            throws Exception {
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "bos/cmm/uat/uia/LoginUsr";
    	}
    	List list_menulist = menuManageService.selectMenuCreatSiteMapList(menuSiteMapVO);
        model.addAttribute("list_menulist", list_menulist);
        UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
    	menuSiteMapVO.setCreatPersonId(user.getUserId());
        model.addAttribute("resultVO", menuSiteMapVO);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuCreatSiteMap.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 메뉴사이트맵 생성처리 및 사이트맵을 등록한다.
     * @param menuSiteMapVO MenuSiteMapVO
     * @param valueHtml      String
     * @return 출력페이지정보 "mpm/MenuCreatSiteMap"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuCreatSiteMapInsert.action")
    public String selectMenuCreatSiteMapInsert(
    		@ModelAttribute("menuSiteMapVO") MenuSiteMapVO menuSiteMapVO,
    		@RequestParam("valueHtml") String valueHtml,
    		ModelMap model)
            throws Exception {
    	boolean chkCreat = false;
    	String  resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/uat/uia/LoginUsr.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	}
/*    	사이트맵 파일 생성 위치 지정
        if ("WINDOWS".equals(Globals.OsType)) {
    		menuSiteMapVO.setTmp_rootPath("D:/workspace/cmm/src/main/webapp");
    	}else{
    		menuSiteMapVO.setTmp_rootPath("/product/jeus/webhome/was_com/framework-com-1_0/framework-com-1_0_war___");
    	}
*/
    	chkCreat = menuManageService.creatSiteMap(menuSiteMapVO, valueHtml);
    	if(!chkCreat){
    		resultMsg = egovMessageSource.getMessage("fail.common.insert");
    	}else{
    		resultMsg = egovMessageSource.getMessage("success.common.insert");
    	}
    	List list_menulist = menuManageService.selectMenuCreatSiteMapList(menuSiteMapVO);
        model.addAttribute("list_menulist", list_menulist);
        model.addAttribute("resultVO", menuSiteMapVO);
    	model.addAttribute("resultMsg", resultMsg);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuCreatSiteMap.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /*### 일괄처리 프로세스 ###*/

    /**
     * 메뉴생성 일괄삭제프로세스
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "mpm/MenuBndeRegist"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuBndeAllDelete")
    public String menuBndeAllDelete(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception {
    	String resultMsg = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "bos/cmm/uat/uia/LoginUsr";
    	}
    	menuManageService.menuBndeAllDelete();
    	resultMsg = egovMessageSource.getMessage("success.common.delete");
    	model.addAttribute("resultMsg", resultMsg);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuBndeRegist.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 메뉴일괄등록화면 호출 및  메뉴일괄등록처리 프로세스
     * @param commandMap    Map
     * @param menuManageVO  MenuManageVO
     * @param request       HttpServletRequest
     * @return 출력페이지정보 "mpm/MenuBndeRegist"
     * @exception Exception
     */
    @RequestMapping(value="/bos/mpm/MenuBndeRegist")
    public String menuBndeRegist(
    		Map commandMap,
    		final HttpServletRequest request,
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception {
        String sLocationUrl = null;
        String resultMsg = "";
        String sMessage  = "";
        // 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = Boolean.TRUE;//
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "bos/cmm/uat/uia/LoginUsr";
    	}
        String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
        if(sCmd.equals("bndeInsert")){
	    	final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				file = entry.getValue();
				if (!"".equals(file.getOriginalFilename())) {
					if(menuManageService.menuBndeAllDelete()){
						sMessage = menuManageService.menuBndeRegist(menuManageVO, file.getInputStream());
			    	    resultMsg = sMessage;
					}else{
						resultMsg = egovMessageSource.getMessage("fail.common.msg");
						menuManageVO.setTmp_Cmd("MenuBndeRegist Error!!");
				        model.addAttribute("resultVO", menuManageVO);
					}
				}else{
					resultMsg = egovMessageSource.getMessage("fail.common.msg");
				}
			}
			sLocationUrl = "/bos/mpm/MenuBndeRegist.jsp";
	    	model.addAttribute("resultMsg", resultMsg);
        }else{
            sLocationUrl = "/bos/mpm/MenuBndeRegist.jsp";
        }
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, sLocationUrl);
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * Summary : 메뉴와 콘텐츠 상태를 연결하기 위한 콘텐츠 선택 기능 팝업(모달폼)
     * MethodName : getMenuLinkPopup
     * @return String
     * @exception
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     * @desc
     */
    @RequestMapping(value="/bos/mpm/MenuLinkPopup")
    public String getMenuLinkPopup(
			HttpServletRequest request,
            HttpServletResponse response,
            ModelMap model )
		throws Exception {

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuLinkPopup.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * Summary : 메뉴와 콘텐츠 상태를 연결하기 위한 콘텐츠 선택 기능 팝업
     * MethodName : getMenuLinkPopup
     * @return String
     * @exception
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     * @desc
     */
    @RequestMapping(value="/bos/mpm/MenuLinkSearchList")
    public String getMenuLinkSearchList(
			HttpServletRequest request,
            HttpServletResponse response,
            ModelMap model )
		throws Exception {

    	String pageNavForwardPage = "";
    	ZValue zvl = WebFactory.getParameterInit(request);

    	if (zvl.getString("searchType").equals("")) zvl.put("searchType", "c1");


    	zvl.put("resultCnt", menuManageService.menuLinkSearchCnt(zvl));
    	model.addAttribute("list", menuManageService.menuLinkSearch(zvl));

    	pageNavForwardPage = zvl.getString("baseUrl") + "/MenuLinkSearchList?"+zvl.getString("paramUrl")+"&searchType="+zvl.getString("searchType");
    	String pageNav = pageInfo.getPageNavString(zvl.getInt("pageUnit"), zvl.getInt("resultCnt"), zvl.getInt("pageIndex",1), pageNavForwardPage);
    	model.addAttribute("pageNav", pageNav);

    	model.addAttribute("zvl", zvl);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/mpm/MenuLinkSearchList.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    @RequestMapping(value="/bos/mpm/MenuLoadSite/{siteId}")
    public void getMenuLoadSite(
			HttpServletRequest request,
            HttpServletResponse response,
            @PathVariable String siteId,
            ModelMap model )
		throws Exception {

    	ZValue zvl = WebFactory.getAttributes(request);
    	if(siteId == null || "".equals(siteId)) siteId = "1"; //기본 사이트 관리자
    	zvl.put("siteId", siteId);
    	//String flag = (String)servletContext.getAttribute("flag");
    	String flag = "N";
    	if (flag!=null && !flag.equals("Y")){
    		menuLoad(zvl);
    		WebFactory.printWinClose(response, "정상적으로 처리되었습니다.");
    	} else {
    		WebFactory.printWinClose(response, "현재 로딩중인 매뉴가 있습니다. 잠시 후 다시 시도하여 주십시오.");
    	}

    }


    /**
     * 사용자 매뉴정보를 메모리에 올림
     * @param siteId
     * @return
     * @throws Exception
     */
	public void menuLoad(ZValue zvl) throws Exception{
    	try {
    		servletContext.setAttribute("flag", "Y");
    		String siteId = zvl.getString("siteId");
    		if (siteId.equals("")){
    			String[] siteIdData = {"2"};
    			for(String _siteId : siteIdData)
    			{
        			HashMap<String, List<MenuManageVO>> menuMap = masterMenuManagerService.getMenuCategoryMapBySiteId(_siteId);
        			servletContext.setAttribute("menuAll"+_siteId, menuMap);
    			}
    		} else {
    			HashMap<String, List<MenuManageVO>> menuMap = masterMenuManagerService.getMenuCategoryMapBySiteId(siteId);
    			servletContext.setAttribute("menuAll"+siteId, menuMap);  // 해당 사이트
    		}
		} catch (Exception e) {
			throw e;
		} finally {
			servletContext.setAttribute("flag", "N");
		}

    }

}
