package kr.co.unp.satisfaction.web;

import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.satisfaction.service.impl.SatisfactionServiceImpl;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SatisfactionController
{
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="satisfactionService")
	private SatisfactionServiceImpl satisfactionService;

	@Resource(name = "webFactory")
	private WebFactory WebFactory;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

    @Resource(name = "masterMenuManagerService")
    protected MasterMenuManager masterMenuManagerService;

    @Resource(name = "excelGenerateView")
    protected View excelGenerateView;

	@RequestMapping("/portal/satisfaction/save.do")
	public void saveSatisfaction(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

		String resultMsg = null;
    	String userIp = EgovClntInfo.getClntIP(request);
    	zvl.put("userKey", userIp);

    	if(satisfactionService.existsUserIp(zvl) > 0)
    	{
    		resultMsg = "이미 참여하셨습니다.";
    	}
    	else
    	{
    		resultMsg = "만족도 평가에 참여해 주셔서 감사합니다.";
    		satisfactionService.saveSatisfaction(zvl);
    	}

		WebFactory.printHtml(response, resultMsg, "javascript:history.back()");

	}

	@RequestMapping("/bos/satisfaction/statusView")
	public String statusView(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	satisfactionService.selectStatusView(zvl, model);
		return "bos/satisfaction/statusView";
	}

	@RequestMapping("/bos/satisfaction/menuStatusView")
	public String menuStatusView(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	satisfactionService.selectStatusView(zvl, model);
		return "bos/satisfaction/menuStatusView";
	}

	@RequestMapping("/bos/satisfaction/menuStatusList")
	public String menuStatusList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);
    	satisfactionService.selectStatusList(zvl, model);
		return "bos/satisfaction/menuStatusList";
	}

	@RequestMapping("/bos/satisfaction/opinionList")
	public String opinionList(
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception
	{
    	ZValue zvl = WebFactory.getAttributes(request);

		ZValue page = pageInfo.getPaginationInfo(zvl);
		Map<String, Object> map = satisfactionService.selectOpinionList(zvl);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    	zvl.put("totCnt", totCnt);

    	String link =
    		"/bos/satisfaction/opinionList?" +
    		"siteId="+zvl.getString("siteId")+
    		"&searchType="+zvl.getString("searchType")+
    		"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	zvl.put("link", link);

		String pageNav = pageInfo.getPageNavString(page);

		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("zvl", zvl);
		model.addAttribute("pageNav", pageNav);

		return "bos/satisfaction/opinionList";
	}

	@RequestMapping("/bos/satisfaction/menuStatusListExcel")
	public ModelAndView satisfactionExcel(
			final HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception {

		ZValue zvl = WebFactory.getAttributes(request);

    	satisfactionService.menuStatusListExcel(zvl, model);

    	ModelAndView modelMap = new ModelAndView(excelGenerateView);
    	modelMap.addAllObjects(model);
    	return modelMap;

	}
}
