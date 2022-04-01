package kr.co.unp.poll.web;

import java.net.URLEncoder;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.poll.service.PollServiceImpl;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class PollController {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name="pollService")
	private PollServiceImpl service = null;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@RequestMapping("/{siteName}/poll/list.do")
	public String list(@PathVariable String siteName,
		 HttpServletRequest request
		, HttpServletResponse response 
		, ModelMap model) throws Exception 
	{
		// 리스트 불러오기
    	ZValue zvl = WebFactory.getAttributes(request);
		service.selectMasterList(zvl, model);

    	ZValue page = (ZValue)model.get("pageInfo");
    	if(page != null){
    		page.put("link", getListLink(zvl));
    		String pageNav = pageInfo.getPageNavString(page);
    		model.addAttribute("pageInfo", page);
    		model.addAttribute("pageNav", pageNav);
    	}
    	
		String includePage = "/"+siteName+"/poll/list.jsp";
		
		model.addAttribute("includePage", includePage);
		return siteName+"/main/"+siteName+"Index";
	}
	
	@RequestMapping("/{siteName}/poll/view.do")
	public String selectCheckStateView(@PathVariable String siteName,
			 HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{	
		// 점검표 불러오기
    	ZValue zvl = WebFactory.getAttributes(request);
		service.selectCheckStateView(zvl, model);
		
		String includePage = "/"+siteName+"/poll/view.jsp";

		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return siteName+"/main/"+siteName+"Index";
	}

	@RequestMapping("/{siteName}/poll/forCheck.do")
	public String forCheck(@PathVariable String siteName,
			 HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{	
		ZValue zvl = WebFactory.getAttributes(request);
		// 점검표 불러오기 (생략 가능)
		service.selectCheckStateView(zvl, model);

		// 업소 정보 불러오기 
		service.selectCompanyInfo(zvl, model);

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if(user == null) user = new UsersVO();

		String includePage = "/"+siteName+"/poll/check.jsp";
		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());

		model.addAttribute("user", user);
		return siteName+"/main/"+siteName+"Index";
	}

	@RequestMapping("/{siteName}/poll/check.do")
	public void check(@PathVariable String siteName,
			 HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception {
		 
		// Answer1 체크하기
		ZValue zvl = WebFactory.getAttributes(request);
		String userIp = EgovClntInfo.getClntIP(request);
		zvl.put("id", userIp);
		
		List<ZValue> answer2list = service.getZvl(zvl);
		service.check(zvl, answer2list, model);

		WebFactory.printHtml(response, "설문에 응해주셔서 감사합니다.", 
				"/"+siteName+"/poll/list.do" +
				"?menuNo="+zvl.getString("menuNo"));
	}

	/**
	 * 설문조사 체크한경ㅇ
	 * @param bean
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/{siteName}/poll/checkResult.do")
	public String checkResult(@PathVariable String siteName,
			 HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		// 리스트 조회
		ZValue zvl = WebFactory.getAttributes(request);
		service.selectQuestionList(zvl, model);
		
		String includePage = "/"+siteName+"/poll/checkResult.jsp";
		model.addAttribute("includePage", includePage);
		model.addAttribute("CURR_DATE", Calendar.getInstance().getTime());
		return siteName+"/main/"+siteName+"Index";
	}

	@RequestMapping("/{siteName}/poll/selectOtherList.do")
	public String selectOtherList(@PathVariable String siteName,
			  HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		ZValue zvl = WebFactory.getAttributes(request);
		
		// 리스트 조회
		List<ZValue> otherList = service.selectOtherList(zvl);
		model.addAttribute("otherList", otherList);
		
		String includePage = siteName+"/poll/otherList";
		model.addAttribute("includePage", includePage);
		return includePage;
	}

	@RequestMapping("/{siteName}/poll/selectEssayList.do")
	public String selectEssayList(@PathVariable String siteName,
			  HttpServletRequest request
			, HttpServletResponse response 
			, ModelMap model) throws Exception 
	{
		ZValue zvl = WebFactory.getAttributes(request);
		log.debug("--------zvl : " + zvl);
		// 리스트 조회
		List<ZValue> otherList = service.selectEssayList(zvl);
		model.addAttribute("otherList", otherList);
		
		String includePage = siteName+"/poll/otherList";
		model.addAttribute("includePage", includePage);
		return includePage;
	}

	private String getListLink(ZValue zvl) throws Exception{
    	StringBuffer goUrl = new StringBuffer();
    	goUrl.append("/bos/poll/list.do");
    	goUrl.append("?searchCnd").append(zvl.getString("searchCnd"));
    	goUrl.append("&searchWrd").append(URLEncoder.encode(zvl.getString("searchWrd"),"UTF-8"));
    	goUrl.append("&menuNo").append(zvl.getString("menuNo"));
    	return goUrl.toString();
	}
}
