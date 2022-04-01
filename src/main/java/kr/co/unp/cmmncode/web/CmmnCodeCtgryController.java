package kr.co.unp.cmmncode.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmmncode.service.CmmnCodeClService;
import kr.co.unp.cmmncode.service.CmmnCodeCtgryService;
import kr.co.unp.cmmncode.vo.CmmnCodeClVO;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgry;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgryVO;
import kr.co.unp.member.vo.UsersVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.HttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 *
 * 공통코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
@Controller
public class CmmnCodeCtgryController {

	@Resource(name = "CmmnCodeCtgryService")
    private CmmnCodeCtgryService CmmnCodeCtgryService;

	@Resource(name = "CmmnCodeClService")
    private CmmnCodeClService cmmnClCodeManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCodeCtgry
	 * @param model
	 * @return "forward:/sym/ccm/cca/CmmnCodeCtgryList"
	 * @throws Exception
	 */
	@RequestMapping(value="/bos/cmmncode/CmmnCodeCtgryRemove.do")
	public void deleteCmmnCode (CmmnCodeCtgry cmmnCodeCtgry
			, ModelMap model, HttpServletResponse response
			) throws Exception {
    	String msg = null;
    	String goUrl = "/bos/cmmncode/CmmnCodeCtgryList.do";
    	 try {
    		 CmmnCodeCtgryService.deleteCmmnCodeCtgry(cmmnCodeCtgry);
    	 } catch (DataIntegrityViolationException e) {
 			msg = "사용중인 하위 코드가 있습니다.";
 		} catch (Exception e) {
 			msg = "작업실패 하였습니다.";
 			e.printStackTrace();
 		}
  		HttpUtil.goUrl(response, goUrl, msg);
 	}

	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCodeCtgry
	 * @param bindingResult
	 * @param model
	 * @return "/cmmncode/CmmnCodeCtgryRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeCtgryRegist")
	public String insertCmmnCode (@ModelAttribute("cmmnCode") CmmnCodeCtgry cmmnCodeCtgry
			, BindingResult bindingResult
			, ModelMap model
			) throws Exception {
    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
    	if   (cmmnCodeCtgry.getClCode() == null
    		||cmmnCodeCtgry.getClCode().equals("")) {

    		CmmnCodeClVO searchVO;
    		searchVO = new CmmnCodeClVO();
    		searchVO.setRecordCountPerPage(999999);
    		searchVO.setFirstIndex(0);
    		searchVO.setCurrentSize(999999);
    		searchVO.setSearchCondition("CodeList");
            List CmmnCodeList = cmmnClCodeManageService.selectCmmnCodeClList(searchVO);
            model.addAttribute("cmmnClCode", CmmnCodeList);

    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeCtgryRegist.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	}

        beanValidator.validate(cmmnCodeCtgry, bindingResult);
		if (bindingResult.hasErrors()){
    		CmmnCodeClVO searchVO;
    		searchVO = new CmmnCodeClVO();
    		searchVO.setRecordCountPerPage(999999);
    		searchVO.setFirstIndex(0);
    		searchVO.setCurrentSize(999999);
    		searchVO.setSearchCondition("CodeList");
            List CmmnCodeList = cmmnClCodeManageService.selectCmmnCodeClList(searchVO);
            model.addAttribute("cmmnClCode", CmmnCodeList);

    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeCtgryRegist.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
		}

    	cmmnCodeCtgry.setFrstRegisterId(user.getUserId());
    	CmmnCodeCtgryService.insertCmmnCodeCtgry(cmmnCodeCtgry);
        return "forward:/bos/cmmncode/CmmnCodeCtgryList.do";
    }

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCodeCtgry
	 * @param model
	 * @return "cmmncode/CmmnCodeCtgryDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/bos/cmmncode/CmmnCodeCtgryDetail/{codeId}")
 	public String selectCmmnCodeDetail (@ModelAttribute("cmmnCode")CmmnCodeCtgry cmmnCodeCtgry
 			, @PathVariable String codeId
 			, ModelMap model
 			) throws Exception {
		cmmnCodeCtgry.setCodeId(codeId);
		CmmnCodeCtgry vo =CmmnCodeCtgryService.selectCmmnCodeCtgryDetail(cmmnCodeCtgry);
		model.addAttribute("result", vo);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeCtgryDetail.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

    /**
	 * 공통코드 목록을 조회한다.
     * @param searchVO
     * @param model
     * @return "/cmmncode/CmmnCodeCtgryList"
     * @throws Exception
     */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeCtgryList")
	public String selectCmmnCodeList (@ModelAttribute("searchVO") CmmnCodeCtgryVO searchVO
			, ModelMap model
			) throws Exception {
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

        int totCnt =CmmnCodeCtgryService.selectCmmnCodeCtgryListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        int currentSize = totCnt - ((searchVO.getPageIndex()-1)*searchVO.getPageUnit());
		searchVO.setCurrentSize(currentSize);

        List CmmnCodeList =CmmnCodeCtgryService.selectCmmnCodeCtgryList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);

        CmmnCodeClVO cmmnCodeClVO = new CmmnCodeClVO();
        cmmnCodeClVO.setRecordCountPerPage(999999);
        cmmnCodeClVO.setFirstIndex(0);
        cmmnCodeClVO.setCurrentSize(999999);
        cmmnCodeClVO.setSearchCondition("CodeList");
        List clList = cmmnClCodeManageService.selectCmmnCodeClList(cmmnCodeClVO);
        model.addAttribute("cmmnClCode", clList);

        model.addAttribute("paginationInfo", paginationInfo);

    	String link = "/bos/cmmncode/CmmnCodeCtgryList.do" +
    			"?searchCondition="+searchVO.getSearchCondition()+
    			"&searchKeyword="+searchVO.getSearchKeyword()+
    			"&clCode="+searchVO.getClCode()+
    			"&menuNo="+searchVO.getMenuNo();
    	String pageNav = pageInfo.getPageNavString(searchVO.getPageUnit(), totCnt, searchVO.getPageIndex(), link);
    	model.addAttribute("resultCnt", totCnt);
    	model.addAttribute("pageNav", pageNav);
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeCtgryList.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCodeCtgry
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/cmmncode/CmmnCodeCtgryModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeCtgryModify")
	public String updateCmmnCode (@ModelAttribute("cmmnCode") CmmnCodeCtgry cmmnCodeCtgry
			, BindingResult bindingResult
			, @RequestParam("cmd") String sCmd
			, ModelMap model
			) throws Exception {
    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if (sCmd.equals("")) {
    		CmmnCodeCtgry vo =CmmnCodeCtgryService.selectCmmnCodeCtgryDetail(cmmnCodeCtgry);
    		model.addAttribute("cmmnCode", vo);

    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeCtgryModify.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	} else if (sCmd.equals("Modify")) {
            beanValidator.validate(cmmnCodeCtgry, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnCodeCtgry vo =CmmnCodeCtgryService.selectCmmnCodeCtgryDetail(cmmnCodeCtgry);
        		model.addAttribute("cmmnCode", vo);

        		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeCtgryModify.jsp");
        		return Globals.BOS_TEMPLATE_VIEW;
    		}

    		cmmnCodeCtgry.setLastUpdusrId(user.getUserId());
	    	CmmnCodeCtgryService.updateCmmnCodeCtgry(cmmnCodeCtgry);
	        return "forward:/bos/cmmncode/CmmnCodeCtgryList.do";
    	} else {
    		return "forward:/bos/cmmncode/CmmnCodeCtgryList.do";
    	}
    }

}