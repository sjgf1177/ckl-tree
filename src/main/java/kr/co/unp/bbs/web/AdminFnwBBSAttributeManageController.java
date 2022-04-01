package kr.co.unp.bbs.web;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.bbs.service.FnwBBSAttributeManageService;
import kr.co.unp.bbs.vo.BoardMasterVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.pg.dao.PageGeneratorDAO;
import kr.co.unp.pg.vo.PageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdminFnwBBSAttributeManageController {

    @Resource(name = "fnwBBSAttributeManageService")
    private FnwBBSAttributeManageService bbsAttrbService;

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "pageGeneratorDAO")
    private PageGeneratorDAO pageGeneratorDAO;

    @Autowired
    private DefaultBeanValidator beanValidator;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

    @Resource(name = "siteMngService")
    private SiteMngService siteMngService;

    Logger log = Logger.getLogger(this.getClass());


	/**
     * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
     *
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/bos/bbs/addBBSMaster")
    public String addBBSMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {

		ZValue zvl = new ZValue();
		zvl.put("codeId", "COM004");
		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		model.addAttribute("typeList", codeResult);

		List<PageVO> attrbList = pageGeneratorDAO.selectPageAttributeList(null);
		model.addAttribute("attrbList", attrbList);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/bbs/EgovBoardMstrRegist.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 신규 게시판 마스터 정보를 등록한다.
     *
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/bos/bbs/insertBBSMasterInf")
    public String insertBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO,
	    BindingResult bindingResult, ModelMap model) throws Exception {

    	// 개별프로그램일 경우 임시 저장된 값을 reSetting
    	String bbsTyCode 			= boardMasterVO.getBbsTyCode();
    	String proBbsAttrbCode 		= boardMasterVO.getProBbsAttrbCode();
    	String proReplyPosblAt 		= boardMasterVO.getProReplyPosblAt();
    	String proFileAtchPosblAt 	= boardMasterVO.getProFileAtchPosblAt();

    	if (bbsTyCode.equals("BBST05"))
    	{
    		boardMasterVO.setBbsAttrbCode(proBbsAttrbCode);
    		boardMasterVO.setReplyPosblAt(proReplyPosblAt);
    		boardMasterVO.setFileAtchPosblAt(proFileAtchPosblAt);
    	}

		beanValidator.validate(boardMasterVO, bindingResult);
		if (bindingResult.hasErrors()) {

			ZValue zvl = new ZValue();
			zvl.put("codeId", "COM004");
			List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		    model.addAttribute("typeList", codeResult);

			List<PageVO> attrbList = pageGeneratorDAO.selectPageAttributeList(null);
		    model.addAttribute("attrbList", attrbList);

			model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/bbs/EgovBoardMstrRegist.jsp");
			return Globals.BOS_TEMPLATE_VIEW;
		}

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		boardMasterVO.setFrstRegisterId(user.getUserId());
		boardMasterVO.setUseAt("Y");
		boardMasterVO.setTrgetId("SYSTEMDEFAULT_REGIST");

	    bbsAttrbService.insertBBSMastetInf(boardMasterVO);

		return "forward:/bos/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 목록을 조회한다.
     *
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/bos/bbs/SelectBBSMasterInfs")
    public String selectBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
    	boardMasterVO.setPageUnit(propertyService.getInt("pageUnit"));
		boardMasterVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
		paginationInfo.setPageSize(boardMasterVO.getPageSize());

		boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		int totCnt = bbsAttrbService.selectBBSMasterInfListCnt(boardMasterVO);
		paginationInfo.setTotalRecordCount(totCnt);

		List<BoardMasterVO> resultList = bbsAttrbService.selectBBSMasterInfList(boardMasterVO);

		String link = "/bos/bbs/SelectBBSMasterInfs.do" +
				"?searchCnd="+boardMasterVO.getSearchCnd()+
				"&popupYn="+boardMasterVO.getPopupYn()+
				"&siteId="+boardMasterVO.getSiteId()+
				"&bbsAttrbCode="+boardMasterVO.getBbsAttrbCode()+
				"&searchWrd="+boardMasterVO.getSearchWrd()+
				"&menuNo="+boardMasterVO.getMenuNo();
		String pageNav = pageInfo.getPageNavString(boardMasterVO.getPageUnit(), totCnt, boardMasterVO.getPageIndex(), link);

		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNav", pageNav);

		List<PageVO> attrbList = pageGeneratorDAO.selectPageAttributeList(null);
	    model.addAttribute("attrbList", attrbList);

		String jspPage = "/bos/bbs/EgovBoardMstrList.jsp";
		if( "Y".equals(boardMasterVO.getPopupYn()) )
		{
			jspPage = "bos/bbs/EgovBoardMstrListPop";
			model.addAttribute("siteMng", siteMngService.getSiteBySiteId(boardMasterVO.getSiteId()));
			return jspPage;
		}
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, jspPage);
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 게시판 마스터 상세내용을 조회한다.
     *
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/bos/bbs/SelectBBSMasterInf/{bbsId}")
    public String selectBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO searchVO, @PathVariable String bbsId, ModelMap model) throws Exception {
		searchVO.setBbsId(bbsId);
    	BoardMasterVO result = bbsAttrbService.selectBBSMasterInf(searchVO);

		model.addAttribute("result", result);

		ZValue zvl = new ZValue();
		zvl.put("codeId", "COM004");
		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
	    model.addAttribute("typeList", codeResult);

		List<PageVO> attrbList = pageGeneratorDAO.selectPageAttributeList(null);
	    model.addAttribute("attrbList", attrbList);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/bbs/EgovBoardMstrUpdt.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
     * 게시판 마스터 정보를 수정한다.
     *
     * @param boardMasterVO
     * @param boardMaster
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/bos/bbs/UpdateBBSMasterInf")
    public String updateBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO,
	    BindingResult bindingResult, ModelMap model) throws Exception {

		beanValidator.validate(boardMasterVO, bindingResult);
		if (bindingResult.hasErrors()) {
		    BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(boardMasterVO);

		    model.addAttribute("result", vo);

		    return "bos/bbs/EgovBoardMstrUpdt";
		}

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		boardMasterVO.setFrstRegisterId(user.getUserId());
		boardMasterVO.setLastUpdusrId(user.getUserId());
	    bbsAttrbService.updateBBSMasterInf(boardMasterVO);

	    return "forward:/bos/bbs/SelectBBSMasterInfs.do";
    }

    /**
     * 게시판 마스터 정보를 삭제한다.
     *
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/bos/bbs/DeleteBBSMasterInf")
    public String deleteBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO) throws Exception {

    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
    	boardMasterVO.setFrstRegisterId(user.getUserId());
    	bbsAttrbService.deleteBBSMasterInf(boardMasterVO);
    	return "forward:/bos/bbs/SelectBBSMasterInfs.do";
    }

}
