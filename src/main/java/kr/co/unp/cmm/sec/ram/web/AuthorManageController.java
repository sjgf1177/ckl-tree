package kr.co.unp.cmm.sec.ram.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.AuthorManage;
import kr.co.unp.cmm.sec.ram.service.AuthorManageService;
import kr.co.unp.cmm.sec.ram.service.AuthorManageVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.HttpUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

 
@Controller
public class AuthorManageController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "AuthorManageService")
    private AuthorManageService AuthorManageService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Autowired
	private DefaultBeanValidator beanValidator;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

    /**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/bos/cmm/sec/ram/AuthorListView")
    public String selectAuthorListView(ModelMap model)
            throws Exception {
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/sec/ram/AuthorManage.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }    
    
    /**
	 * 권한 목록을 조회한다
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/bos/cmm/sec/ram/AuthorList")
    public String selectAuthorList(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
    		                        ModelMap model)
            throws Exception {
    	
    	/** EgovPropertyService.sample */
    	//authorManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	//authorManageVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());
		
		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        int totCnt = AuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		authorManageVO.setAuthorManageList(AuthorManageService.selectAuthorList(authorManageVO));
        model.addAttribute("authorList", authorManageVO.getAuthorManageList());

    	String link = "/bos/cmm/sec/ram/AuthorList.do" +
    			"?searchKeyword="+authorManageVO.getSearchKeyword();
    	String pageNav = pageInfo.getPageNavString(authorManageVO.getPageUnit(), totCnt, authorManageVO.getPageIndex(), link);

    	model.addAttribute("resultCnt", totCnt);	
    	model.addAttribute("pageNav", pageNav);

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/sec/ram/AuthorManage.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    } 
    
    /**
	 * 권한 세부정보를 조회한다.
	 * @param authorCode String
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */   
    @RequestMapping(value="/bos/cmm/sec/ram/Author/{authorCode}")
    public String selectAuthor(@PathVariable String authorCode,
    	                       @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
    		                    ModelMap model) throws Exception {
    	
    	authorManageVO.setAuthorCode(authorCode);

    	model.addAttribute("authorManage", AuthorManageService.selectAuthor(authorManageVO));
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/sec/ram/AuthorUpdate.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }     

    /**
	 * 권한 등록화면 이동
	 * @return String
	 * @exception Exception
	 */     
    @RequestMapping("/bos/cmm/sec/ram/AuthorInsertView")
    public String insertAuthorView(ModelMap model)
            throws Exception {
		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/sec/ram/AuthorInsert.jsp");
		return Globals.BOS_TEMPLATE_VIEW;
    }
    
    /**
	 * 권한 세부정보를 등록한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */ 
    @RequestMapping(value="/bos/cmm/sec/ram/AuthorInsert")
    public String insertAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
    		                    BindingResult bindingResult,
    		                    SessionStatus status, 
    		                    ModelMap model) throws Exception {
    	
    	beanValidator.validate(authorManage, bindingResult); //validation 수행
    	if (bindingResult.hasErrors()) { 
			model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/sec/ram/AuthorInsert.jsp");
			return Globals.BOS_TEMPLATE_VIEW;
		} else {
	    	AuthorManageService.insertAuthor(authorManage);
	        status.setComplete();
	        model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
	        return "forward:/bos/cmm/sec/ram/Author/" + authorManage.getAuthorCode() + ".do?menuNo=" + authorManage.getMenuNo();
		}
    }
    
    /**
	 * 권한 세부정보를 수정한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */   
    @RequestMapping(value="/bos/cmm/sec/ram/AuthorUpdate")
    public String updateAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
    		                    BindingResult bindingResult,
    		                    SessionStatus status, 
    		                    Model model) throws Exception {

    	beanValidator.validate(authorManage, bindingResult); //validation 수행
    	
		if (bindingResult.hasErrors()) {
			model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/bos/cmm/sec/ram/AuthorUpdate.jsp");
			return Globals.BOS_TEMPLATE_VIEW;
		} else {
	    	AuthorManageService.updateAuthor(authorManage);
	        status.setComplete();
	        model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
	        return "forward:/bos/cmm/sec/ram/Author/" + authorManage.getAuthorCode() + ".do?menuNo=" + authorManage.getMenuNo();
		}
    }    

    /**
	 * 권한 세부정보를 삭제한다.
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */  
    @RequestMapping(value="/bos/cmm/sec/ram/AuthorDelete")
    public String deleteAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
    		                    SessionStatus status,
    		                    Model model) throws Exception {
    	
    	AuthorManageService.deleteAuthor(authorManage);
    	status.setComplete();
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
        return "forward:/bos/cmm/sec/ram/AuthorList.do?menuNo=" + authorManage.getMenuNo();
    }   
    
    /**
	 * 권한목록을 삭제한다.
	 * @param authorCodes String
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */  
    @RequestMapping(value="/bos/cmm/sec/ram/AuthorListDelete")
    public String deleteAuthorList(@RequestParam("authorCodes") String authorCodes,
    		                       @ModelAttribute("authorManage") AuthorManage authorManage, 
    		                        SessionStatus status,
    		                        Model model) throws Exception {

    	String [] strAuthorCodes = authorCodes.split(";");
    	for(int i=0; i<strAuthorCodes.length;i++) {
    		authorManage.setAuthorCode(strAuthorCodes[i]);
    		AuthorManageService.deleteAuthor(authorManage);
    	}
    	status.setComplete();
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
        return "forward:/bos/cmm/sec/ram/AuthorList.do?menuNo=" + authorManage.getMenuNo();
        
    }    
    
    /**
	 * 권한제한 화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/bos/cmm/sec/ram/accessDenied")
    public void accessDenied(
			HttpServletResponse response
    		)throws Exception {
        HttpUtil.back(response, "권한이 없습니다.");
    } 

    @RequestMapping(value="/bos/cmm/sec/ram/searchNewEmployee")
    public String deleteAuthorList(@ModelAttribute("authorManage") AuthorManage authorManage, Model model) throws Exception {
    	
        return "forward:/bos/cmm/sec/ram/AuthorList.do?menuNo=" + authorManage.getMenuNo();
    }    
}
