package kr.co.unp.cmmncode.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmmncode.service.CmmnCodeClService;
import kr.co.unp.cmmncode.vo.CmmnCodeCl;
import kr.co.unp.cmmncode.vo.CmmnCodeClVO;
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
 * 공통분류코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
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
public class CmmnCodeClController {
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
	 * 공통분류코드를 삭제한다.
	 * @param cmmnCodeCl
	 * @param model
	 * @return "forward:/cmmncode/CmmnCodeClList"
	 * @throws Exception
	 */
	@RequestMapping(value="/bos/cmmncode/CmmnCodeClRemove")
	public void deleteCmmnCodeCl (CmmnCodeCl cmmnCodeCl
			, ModelMap model, HttpServletResponse response
			) throws Exception {
    	String msg = null;
    	String goUrl = "/bos/cmmncode/CmmnCodeClList.do";
    	 try {
			cmmnClCodeManageService.deleteCmmnCodeCl(cmmnCodeCl);
		} catch (DataIntegrityViolationException e) {
			msg = "사용중인 하위 코드가 있습니다.";
		} catch (Exception e) {
			msg = "작업실패 하였습니다.";
			e.printStackTrace();
		}
 		HttpUtil.goUrl(response, goUrl, msg);
	}

	/**
	 * 공통분류코드를 등록한다.
	 * @param cmmnCodeCl
	 * @param bindingResult
	 * @return "/cmmncode/EgovCmmnCodeClRegist"
	 * @throws Exception
	 */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeClRegist")
	public String insertCmmnCodeCl (@ModelAttribute("cmmnClCode") CmmnCodeCl cmmnCodeCl
			, BindingResult bindingResult
			, ModelMap model) throws Exception {
    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
    	if   (cmmnCodeCl.getClCode() == null
    		||cmmnCodeCl.getClCode().equals("")) {
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeClRegist.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	}

        beanValidator.validate(cmmnCodeCl, bindingResult);
		if (bindingResult.hasErrors()){
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeClRegist.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
		}

    	cmmnCodeCl.setFrstRegisterId(user.getUserId());
    	cmmnClCodeManageService.insertCmmnCodeCl(cmmnCodeCl);
        return "forward:/bos/cmmncode/CmmnCodeClList.do";

    }

	/**
	 * 공통분류코드 상세항목을 조회한다.
	 * @param cmmnCodeCl
	 * @param model
	 * @return "cmmncode/CmmnCodeClDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/bos/cmmncode/CmmnCodeClDetail/{clCode}")
 	public String selectCmmnCodeClDetail (@ModelAttribute("cmmnClCode") CmmnCodeCl cmmnCodeCl
 			, @PathVariable String clCode
 			, ModelMap model
 			) throws Exception {
		cmmnCodeCl.setClCode(clCode);
		CmmnCodeCl vo = cmmnClCodeManageService.selectCmmnCodeClDetail(cmmnCodeCl);
		model.addAttribute("result", vo);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeClDetail.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

    /**
	 * 공통분류코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmmncode/CmmnCodeClList"
     * @throws Exception
     */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeClList")
	public String selectCmmnCodeClList (@ModelAttribute("searchVO") CmmnCodeClVO searchVO
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

        int totCnt = cmmnClCodeManageService.selectCmmnCodeClListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        int currentSize = totCnt - ((searchVO.getPageIndex()-1)*searchVO.getPageUnit());
		searchVO.setCurrentSize(currentSize);

        List CmmnCodeList = cmmnClCodeManageService.selectCmmnCodeClList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);

    	String link = "/bos/cmmncode/CmmnCodeClList.do" +
    			"?searchCondition="+searchVO.getSearchCondition()+
    			"&searchKeyword="+searchVO.getSearchKeyword();
    	String pageNav = pageInfo.getPageNavString(searchVO.getPageUnit(), totCnt, searchVO.getPageIndex(), link);

    	model.addAttribute("resultCnt", totCnt);
    	model.addAttribute("pageNav", pageNav);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeClList.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

	/**
	 * 공통분류코드를 수정한다.
	 * @param loginVO
	 * @param cmmnCodeCl
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/cmmncode/CmmnCodeClModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeClModify")
	public String updateCmmnCodeCl (@ModelAttribute("administCode") CmmnCodeCl cmmnCodeCl
			, BindingResult bindingResult
			, @RequestParam("cmd") String sCmd
			, ModelMap model
			) throws Exception {
    	//String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
    	if (sCmd.equals("")) {
    		CmmnCodeCl vo = cmmnClCodeManageService.selectCmmnCodeClDetail(cmmnCodeCl);
    		model.addAttribute("cmmnClCode", vo);
    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeClModify.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	} else if (sCmd.equals("Modify")) {
            beanValidator.validate(cmmnCodeCl, bindingResult);
            if (bindingResult.hasErrors()){
        		CmmnCodeCl vo = cmmnClCodeManageService.selectCmmnCodeClDetail(cmmnCodeCl);
        		model.addAttribute("cmmnClCode", vo);

        		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeClModify.jsp");
        		return Globals.BOS_TEMPLATE_VIEW;
    		}
    		cmmnCodeCl.setLastUpdusrId(user.getUserId());
	    	cmmnClCodeManageService.updateCmmnCodeCl(cmmnCodeCl);
	        return "forward:/bos/cmmncode/CmmnCodeClList.do";
    	} else {
    		return "forward:/bos/cmmncode/CmmnCodeClList.do";
    	}
    }

}