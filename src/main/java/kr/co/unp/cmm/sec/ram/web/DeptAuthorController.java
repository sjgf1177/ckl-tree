package kr.co.unp.cmm.sec.ram.web;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.AuthorManageVO;
import kr.co.unp.cmm.sec.ram.service.DeptAuthor;
import kr.co.unp.cmm.sec.ram.service.DeptAuthorService;
import kr.co.unp.cmm.sec.ram.service.DeptAuthorVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 부서권한에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *
 * </pre>
 */

@Controller
public class DeptAuthorController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "DeptAuthorService")
    private DeptAuthorService DeptAuthorService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

    /**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/bos/cmm/sec/ram/DeptAuthorListView")
    public String selectDeptAuthorListView() throws Exception {
        return "bos/cmm/sec/ram/DeptAuthorManage";
    }

	/**
	 * 부서별 할당된 권한목록 조회
	 *
	 * @param deptAuthorVO DeptAuthorVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/bos/cmm/sec/ram/DeptAuthorList")
	public String selectDeptAuthorList(@ModelAttribute("deptAuthorVO") DeptAuthorVO deptAuthorVO,
			                            @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
			                             ModelMap model) throws Exception {

    	DeptAuthorService.selectDeptAuthorList(deptAuthorVO, authorManageVO, model);

        return "bos/cmm/sec/ram/DeptAuthorManage";
	}

	/**
	 * 부서에 권한정보를 할당하여 데이터베이스에 등록
	 *
	 * @param userIds String
	 * @param authorCodes String
	 * @param regYns String
	 * @param deptAuthor DeptAuthor
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/bos/cmm/sec/ram/DeptAuthorInsert")
	public String insertDeptAuthor(@RequestParam("userIds") String userIds,
			                       @RequestParam("authorCodes") String authorCodes,
			                       @RequestParam("regYns") String regYns,
			                       @ModelAttribute("deptAuthor") DeptAuthor deptAuthor,
			                         SessionStatus status,
			                         ModelMap model) throws Exception {

    	String [] strUserIds = userIds.split(";");
    	String [] strAuthorCodes = authorCodes.split(";");
    	String [] strRegYns = regYns.split(";");

    	for(int i=0; i<strUserIds.length;i++) {
    		deptAuthor.setUniqId(strUserIds[i]);
    		deptAuthor.setAuthorCode(strAuthorCodes[i]);
    		if(strRegYns[i].equals("N"))
    			DeptAuthorService.insertDeptAuthor(deptAuthor);
    		else
    			DeptAuthorService.updateDeptAuthor(deptAuthor);
    	}

        status.setComplete();
        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
		return "forward:/bos/cmm/sec/ram/DeptAuthorList.do";
	}

	/**
	 * 부서별 할당된 시스템 메뉴 접근권한을 삭제
	 * @param userIds String
	 * @param deptAuthor DeptAuthor
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/bos/cmm/sec/ram/DeptAuthorDelete")
	public String deleteDeptAuthor (@RequestParam("userIds") String userIds,
			                        @ModelAttribute("deptAuthor") DeptAuthor deptAuthor,
                                     SessionStatus status,
                                     ModelMap model) throws Exception {

    	String [] strUserIds = userIds.split(";");
    	for(int i=0; i<strUserIds.length;i++) {
    		deptAuthor.setUniqId(strUserIds[i]);
    		DeptAuthorService.deleteDeptAuthor(deptAuthor);
    	}

		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/bos/cmm/sec/ram/DeptAuthorList.do";
	}

    /**
	 * 부서조회 팝업 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/bos/cmm/sec/ram/DeptSearchView")
    public String selectDeptListView() throws Exception {
        return "bos/cmm/sec/ram/DeptSearch";
    }

	/**
	 * 부서별 할당된 권한목록 조회
	 * @param deptAuthorVO DeptAuthorVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/bos/cmm/sec/ram/DeptSearchList")
	public String selectDeptList(@ModelAttribute("deptAuthorVO") DeptAuthorVO deptAuthorVO,
			                             ModelMap model) throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(deptAuthorVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(deptAuthorVO.getPageUnit());
		paginationInfo.setPageSize(deptAuthorVO.getPageSize());

		deptAuthorVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		deptAuthorVO.setLastIndex(paginationInfo.getLastRecordIndex());
		deptAuthorVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        int totCnt = DeptAuthorService.selectDeptListTotCnt(deptAuthorVO);
		paginationInfo.setTotalRecordCount(totCnt);

        int currentSize = totCnt - ((deptAuthorVO.getPageIndex()-1)*deptAuthorVO.getPageUnit());
        deptAuthorVO.setCurrentSize(currentSize);

		deptAuthorVO.setDeptList(DeptAuthorService.selectDeptList(deptAuthorVO));
        model.addAttribute("deptList", deptAuthorVO.getDeptList());

        model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

    	String link = "/bos/cmm/sec/ram/DeptSearchList" +
    			"?searchKeyword="+deptAuthorVO.getSearchKeyword();
    	String pageNav = pageInfo.getPageNavString(deptAuthorVO.getPageUnit(), totCnt, deptAuthorVO.getPageIndex(), link);

    	model.addAttribute("resultCnt", totCnt);
    	model.addAttribute("pageNav", pageNav);

        return "bos/cmm/sec/ram/DeptSearch";
	}
}