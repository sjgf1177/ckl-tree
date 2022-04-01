package kr.co.unp.cmmncode.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmmncode.service.CmmnCodeClService;
import kr.co.unp.cmmncode.service.CmmnCodeCtgryService;
import kr.co.unp.cmmncode.service.CmmnCodeDetailService;
import kr.co.unp.cmmncode.vo.CmmnCodeClVO;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgry;
import kr.co.unp.cmmncode.vo.CmmnCodeCtgryVO;
import kr.co.unp.cmmncode.vo.CmmnCodeDetail;
import kr.co.unp.cmmncode.vo.CmmnCodeDetailVO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.HttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 *
 * 공통상세코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
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
public class CmmnCodeDetailController {

	@Resource(name = "CmmnCodeDetailService")
    private CmmnCodeDetailService cmmnCodeDetailService;

	@Resource(name = "CmmnCodeClService")
    private CmmnCodeClService cmmnClCodeManageService;

	@Resource(name = "CmmnCodeCtgryService")
    private CmmnCodeCtgryService cmmnCodeManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    @Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

	@Resource(name = "mappingJacksonJsonView")
	private MappingJacksonJsonView mappingJacksonJsonView;

	/**
	 * 공통상세코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnCodeDetail
	 * @param model
	 * @return "forward:/sym/ccm/cde/CmmnCodeDetailList"
	 * @throws Exception
	 */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeDetailRemove")
	public String deleteCmmnCodeDetail (CmmnCodeDetail cmmnCodeDetail
			, ModelMap model
			) throws Exception {
    	cmmnCodeDetailService.deleteCmmnCodeDetail(cmmnCodeDetail);
        return "forward:/bos/cmmncode/CmmnCodeDetailList.do";
	}

	/**
	 * 공통상세코드를 등록한다.
	 * @param loginVO
	 * @param cmmnCodeDetail
	 * @param cmmnCodeCtgry
	 * @param bindingResult
	 * @param model
	 * @return "/cmmncode/CmmnCodeDetailRegist"
	 * @throws Exception
	 */

    @RequestMapping(value="/bos/cmmncode/CmmnCodeDetailRegist")
	public String insertCmmnCodeDetail	(@ModelAttribute("cmmnDetailCode") CmmnCodeDetail cmmnCodeDetail
			, @ModelAttribute("cmmnCode") CmmnCodeCtgry cmmnCodeCtgry
			, BindingResult bindingResult
			, ModelMap model
			, HttpServletRequest request
			, HttpServletResponse response
			)	throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
    	String contestYn = zvl.getString("contest");
    	if(contestYn.equals("Y")){

    		int COM080Max = cmmnClCodeManageService.selectCOM080Max();
    		model.addAttribute("COM080Max", COM080Max);
    	}

    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if   (cmmnCodeDetail.getCodeId() == null
        		||cmmnCodeDetail.getCodeId().equals("")
        		||cmmnCodeDetail.getCode() == null
        		||cmmnCodeDetail.getCode().equals("")
        		) {

        		CmmnCodeClVO searchClCodeVO;
        		searchClCodeVO = new CmmnCodeClVO();
        		searchClCodeVO.setRecordCountPerPage(999999);
        		searchClCodeVO.setFirstIndex(0);
        		searchClCodeVO.setCurrentSize(999999);
        		searchClCodeVO.setSearchCondition("CodeList");
                List CmmnCodeClList = (List)cmmnClCodeManageService.selectCmmnCodeClList(searchClCodeVO);
                model.addAttribute("cmmnClCodeList", CmmnCodeClList);

                CmmnCodeCtgryVO searchCodeVO;
                searchCodeVO = new CmmnCodeCtgryVO();
                searchCodeVO.setRecordCountPerPage(999999);
                searchCodeVO.setFirstIndex(0);
                searchCodeVO.setCurrentSize(999999);
                searchCodeVO.setSearchCondition("clCode");
                if (cmmnCodeCtgry.getClCode().equals("")) {
                	EgovMap emp = (EgovMap)CmmnCodeClList.get(0);
                	cmmnCodeCtgry.setClCode(emp.get("clCode").toString());
                }
                searchCodeVO.setSearchKeyword(cmmnCodeCtgry.getClCode());

                List CmmnCodeList = cmmnCodeManageService.selectCmmnCodeCtgryList(searchCodeVO);
                model.addAttribute("cmmnCodeList", CmmnCodeList);

        		/*model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailRegist.jsp");
        		return Globals.BOS_TEMPLATE_VIEW;*/
                return "bos/cmmncode/CmmnCodeDetailRegist";
    	}
	        beanValidator.validate(cmmnCodeDetail, bindingResult);
			if (bindingResult.hasErrors()){
	    		CmmnCodeClVO searchClCodeVO;
	    		searchClCodeVO = new CmmnCodeClVO();
	    		searchClCodeVO.setRecordCountPerPage(999999);
	    		searchClCodeVO.setFirstIndex(0);
        		searchClCodeVO.setCurrentSize(999999);
	            List CmmnCodeClList = (List)cmmnClCodeManageService.selectCmmnCodeClList(searchClCodeVO);
	            model.addAttribute("cmmnClCodeList", CmmnCodeClList);

	            CmmnCodeCtgryVO searchCodeVO;
	            searchCodeVO = new CmmnCodeCtgryVO();
	            searchCodeVO.setRecordCountPerPage(999999);
	            searchCodeVO.setFirstIndex(0);
	            searchCodeVO.setCurrentSize(999999);
	            searchCodeVO.setSearchCondition("clCode");
	            if (cmmnCodeCtgry.getClCode().equals("")) {
	            	EgovMap emp = (EgovMap)CmmnCodeClList.get(0);
	            	cmmnCodeCtgry.setClCode(emp.get("clCode").toString());
	            }
	            searchCodeVO.setSearchKeyword(cmmnCodeCtgry.getClCode());

	            List CmmnCodeList = cmmnCodeManageService.selectCmmnCodeCtgryList(searchCodeVO);
	            model.addAttribute("cmmnCodeList", CmmnCodeList);

        		/*model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailRegist.jsp");
        		return Globals.BOS_TEMPLATE_VIEW;*/
	            return "bos/cmmncode/CmmnCodeDetailRegist";
			}

			if( cmmnCodeDetailService.selectCmmnCodeDetailDetail(cmmnCodeDetail) == null ){
		    	cmmnCodeDetail.setFrstRegisterId(user.getUserId());
		    	cmmnCodeDetailService.insertCmmnCodeDetail(cmmnCodeDetail);
		        /*return "forward:/bos/cmmncode/CmmnCodeDetailPop.do?codeId="+cmmnCodeDetail.getCodeId();*/
		    	HttpUtil.goUrl(response, "/bos/cmmncode/CmmnCodeDetailPop.do?codeId="+cmmnCodeDetail.getCodeId(), "정상적으로 등록되었습니다.");
		    	return null;
			}
			else{
				HttpUtil.goUrl(response, "/bos/cmmncode/CmmnCodeDetailPop.do?codeId="+cmmnCodeDetail.getCodeId(), "중복된 코드가 있습니다.");
				return null;
			}
    }

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnCodeDetail
	 * @param model
	 * @return "cmmncode/CmmnCodeDetailDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/bos/cmmncode/CmmnCodeDetailDetail/{codeId}/{code}")
 	public String selectCmmnCodeDetailDetail (@ModelAttribute("cmmnDetailCode") CmmnCodeDetail cmmnCodeDetail
 			, @PathVariable String codeId
 			, @PathVariable String code
 			,	ModelMap model
 			)	throws Exception {
		cmmnCodeDetail.setCodeId(codeId);
		cmmnCodeDetail.setCode(code);
    	CmmnCodeDetail vo = cmmnCodeDetailService.selectCmmnCodeDetailDetail(cmmnCodeDetail);
		model.addAttribute("result", vo);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailDetail.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

    /**
	 * 공통상세코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmmncode/CmmnCodeDetailList"
     * @throws Exception
     */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeDetailList")
	public String selectCmmnCodeDetailList (@ModelAttribute("searchVO") CmmnCodeDetailVO searchVO
			, ModelMap model
			) throws Exception {
    	/** EgovPropertyService.sample */
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

        int totCnt = cmmnCodeDetailService.selectCmmnCodeDetailListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);

        int currentSize = totCnt - ((searchVO.getPageIndex()-1)*searchVO.getPageUnit());
		searchVO.setCurrentSize(currentSize);

        List CmmnCodeList = cmmnCodeDetailService.selectCmmnCodeDetailList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);

        model.addAttribute("paginationInfo", paginationInfo);

    	String link = "/bos/cmmncode/CmmnCodeDetailList" +
    			"?searchCondition="+searchVO.getSearchCondition()+
    			"&searchKeyword="+searchVO.getSearchKeyword();
    	String pageNav = pageInfo.getPageNavString(searchVO.getPageUnit(), totCnt, searchVO.getPageIndex(), link);

    	model.addAttribute("resultCnt", totCnt);
    	model.addAttribute("pageNav", pageNav);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailList.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
	}

	/**
	 * 공통상세코드를 수정한다.
	 * @param loginVO
	 * @param cmmnCodeDetail
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/cmmncode/CmmnCodeDetailModify"
	 * @throws Exception
	 */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeDetailModify")
	public String updateCmmnCodeDetail (@ModelAttribute("cmmnDetailCode") CmmnCodeDetail cmmnCodeDetail
			, BindingResult bindingResult
			, @RequestParam("cmd") String sCmd
			, ModelMap model
			) throws Exception {
    	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if (sCmd.equals("")) {
    		CmmnCodeDetail vo = cmmnCodeDetailService.selectCmmnCodeDetailDetail(cmmnCodeDetail);
    		model.addAttribute("cmmnDetailCode", vo);

    		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailModify.jsp");
    		return Globals.BOS_TEMPLATE_VIEW;
    	} else if (sCmd.equals("Modify")) {
            beanValidator.validate(cmmnCodeDetail, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnCodeDetail vo = cmmnCodeDetailService.selectCmmnCodeDetailDetail(cmmnCodeDetail);
        		model.addAttribute("cmmnDetailCode", vo);

        		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailModify.jsp");
        		return Globals.BOS_TEMPLATE_VIEW;
    		}

    		cmmnCodeDetail.setLastUpdusrId(user.getUserId());
	    	cmmnCodeDetailService.updateCmmnCodeDetail(cmmnCodeDetail);
	        return "forward:/bos/cmmncode/CmmnCodeDetailPop.do";
    	} else {
    		return "forward:/bos/cmmncode/CmmnCodeDetailPop.do";
    	}
    }

    /**
     * 코드를 JSP페이지에 include 한다.
     * Summary :
     * MethodName : cmmnDetailCodeResult
     * @return String
     * @exception
     * @param request
     * @param code
     * @param viewType
     * @param model
     * @return
     * @throws Exception
     * @desc
     *
     */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeDetailResult")
	public String cmmnDetailCodeResult (
			HttpServletRequest request,
			@RequestParam String code_id,
			@RequestParam String view_type,
			ModelMap model
			) throws Exception {

    	ZValue zvl = WebFactory.getParameterInit(request);
    	List codeVoList ;
    	List<ZValue> codeLsit = null;

    		if (view_type.equals("regist") || view_type.equals("modify") || view_type.equals("listView")){
    			//등록/수정 폼에서 사용되는 객체
    			codeLsit = cmmnCodeDetailService.getDetailCodeList(zvl);
    			model.addAttribute("detailCodeList", codeLsit);
    		} else if (view_type.equals("view")){
    			//보기 폼에서 사용되는 객체
    			if (zvl.getString("selectCode")!=null || !zvl.getString("selectCode").equals("")){
    				zvl.put("code", zvl.getString("selectCode"));
    				codeVoList = cmmnCodeDetailService.getSelectDetailCodeList(zvl);
    				model.addAttribute("selectCodeVO", codeVoList);
    			}
    		}

    		model.addAttribute("name", request.getParameter("name"));
    		model.addAttribute("detailCodeZvl", zvl);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmmncode/CmmnCodeDetailResult.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }

    /**
	 * 공통상세코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/cmmncode/CmmnCodeDetailList"
     * @throws Exception
     */
    @RequestMapping(value="/bos/cmmncode/CmmnCodeDetailPop")
	public String selectCmmnCodeDetailPop (@ModelAttribute("searchVO") CmmnCodeDetailVO searchVO
			, ModelMap model
			) throws Exception {

    	CmmnCodeCtgryVO cmmnCodeCtgryVO = new CmmnCodeCtgryVO();
    	cmmnCodeCtgryVO.setCodeId(searchVO.getCodeId());
    	CmmnCodeCtgry cdCatVO = cmmnCodeManageService.selectCmmnCodeCtgryDetail(cmmnCodeCtgryVO);
    	model.addAttribute("cdCatVO", cdCatVO);

    	ZValue zvl = new ZValue();
    	zvl.put("codeId", searchVO.getCodeId());
    	zvl.put("code", "".equals(searchVO.getCode()) ? "0" : searchVO.getCode());

        List<ZValue> cmmnCodeList = cmmnCodeDetailService.getDetailCodeLists(zvl);
        model.addAttribute("list", cmmnCodeList);


        CmmnCodeDetail cmmnDetailCode = new CmmnCodeDetail();
        cmmnDetailCode.setCodeId(searchVO.getCodeId());
        cmmnDetailCode.setCode(searchVO.getCode());
        CmmnCodeDetail dtlCdVO = cmmnCodeDetailService.selectCmmnCodeDetailDetail(cmmnDetailCode);

        model.addAttribute("result", dtlCdVO);


        return "bos/cmmncode/CmmnCodeDetailPop";
	}


    @RequestMapping(value="/cmmn/cmmncode/codeListJson")
	public ModelAndView codeListJson (@ModelAttribute("searchVO") CmmnCodeDetailVO searchVO
			, ModelMap model
			) throws Exception {

    	ZValue zvl = new ZValue();
    	zvl.put("codeId", searchVO.getCodeId());
    	zvl.put("upperCode", searchVO.getUpperCode());
        List<ZValue> cmmnCodeList = cmmnCodeDetailService.getSelectDetailCodeList(zvl);
        model.addAttribute("list", cmmnCodeList);
        return new ModelAndView(mappingJacksonJsonView);

	}

}