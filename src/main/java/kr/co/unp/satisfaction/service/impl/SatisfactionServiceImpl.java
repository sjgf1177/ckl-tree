package kr.co.unp.satisfaction.service.impl;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.mpm.dao.MenuManageDAO;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.satisfaction.dao.SatisfactionDAO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.map.ListOrderedMap;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.com.cmm.EgovMessageSource;

@Service("satisfactionService")
public class SatisfactionServiceImpl {

	@Resource(name="satisfactionDAO")
	private SatisfactionDAO satisfactionDAO;
	
	@Resource(name = "menuManageDAO")
    protected MenuManageDAO menuManageDAO;
	
	@Resource(name="siteMngService")
	private SiteMngService siteMngService; 

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;
	
	/** egovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	private final String PREFIX = "S_";
	
	public void saveSatisfaction(ZValue zvl) throws Exception {
		satisfactionDAO.saveSatisfaction(zvl);
	}
	
	public int existsUserIp(ZValue zvl) throws Exception {
		return satisfactionDAO.existsUserIp(zvl);
	}

	public Map<String, Object> selectOpinionList(ZValue zvl) throws Exception{
		
		List<ZValue> resultList = satisfactionDAO.selectOpinionList(zvl);
		int cnt = satisfactionDAO.selectOpinionListCnt(zvl);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}
	
	public Map<String, Object> menuStatusList(ZValue zvl) throws Exception{
		
		List<ZValue> resultList = satisfactionDAO.menuStatusList(zvl);
		int cnt = satisfactionDAO.menuStatusListCnt(zvl);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", resultList);
		map.put("resultCnt", Integer.toString(cnt));
		return map;
	}
	
	public void selectStatusView(ZValue zvl, ModelMap model) throws Exception {
		
		List<ZValue> siteList = siteMngService.getSiteList();
		String siteId = CollectionUtils.isNotEmpty(siteList) ? siteList.get(1).getString("siteId") : "2";
		if(zvl.getString("siteId")== null || "".equals(zvl.getString("siteId"))) zvl.put("siteId",siteId);
		
    	ListOrderedMap resultMap = new ListOrderedMap();
    	ZValue initVal5 = new ZValue();
    	initVal5.put("status", "5");
    	initVal5.put("statusName", "매우만족");
    	initVal5.put("siteId", zvl.getString("siteId"));
    	initVal5.put("statusCnt", "0");
    	initVal5.put("totCnt", "0");
    	initVal5.put("statusPercent", "0");
    	resultMap.put("S_5", initVal5);

    	ZValue initVal4 = new ZValue();
    	initVal4.put("status", "4");
    	initVal4.put("statusName", "만족");
    	initVal4.put("siteId", zvl.getString("siteId"));
    	initVal4.put("statusCnt", "0");
    	initVal4.put("totCnt", "0");
    	initVal4.put("statusPercent", "0");
    	resultMap.put("S_4", initVal4);

    	ZValue initVal3 = new ZValue();
    	initVal3.put("status", "3");
    	initVal3.put("statusName", "보통");
    	initVal3.put("siteId", zvl.getString("siteId"));
    	initVal3.put("statusCnt", "0");
    	initVal3.put("totCnt", "0");
    	initVal3.put("statusPercent", "0");
    	resultMap.put("S_3", initVal3);

    	ZValue initVal2 = new ZValue();
    	initVal2.put("status", "2");
    	initVal2.put("statusName", "불만");
    	initVal2.put("siteId", zvl.getString("siteId"));
    	initVal2.put("statusCnt", "0");
    	initVal2.put("totCnt", "0");
    	initVal2.put("statusPercent", "0");
    	resultMap.put("S_2", initVal2);

    	ZValue initVal1 = new ZValue();
    	initVal1.put("status", "1");
    	initVal1.put("statusName", "매우불만");
    	initVal1.put("siteId", zvl.getString("siteId"));
    	initVal1.put("statusCnt", "0");
    	initVal1.put("totCnt", "0");
    	initVal1.put("statusPercent", "0");
    	resultMap.put("S_1", initVal1);
    	
    	String resultMsg    = "";
		MenuManageVO vo = new MenuManageVO();
		
    	vo.setSiteId(zvl.getString("siteId"));
    	List<MenuManageVO> list_menulist = menuManageDAO.selectAllMenuBySiteId(vo);
    	resultMsg = egovMessageSource.getMessage("success.common.select");
        model.addAttribute("list_menulist", list_menulist);
        model.addAttribute("resultMsg", resultMsg);
        model.addAttribute("siteList", siteList);
    	
//    	if("".equals(zvl.getString("cMenuNo"))){
//    		if(CollectionUtils.isNotEmpty(list_menulist)){
//    			zvl.put("cMenuNo",list_menulist.get(1).getMenuNo());
//    		}
//    	}
		List<ZValue> resultList = satisfactionDAO.selectStatusList(zvl);
    	if(CollectionUtils.isNotEmpty(resultList)) 
    	{
    		
    		for(ZValue val : resultList)
    		{        		
        		String status = PREFIX + val.getString("status");
    			resultMap.put(status, val);
    		}
    		
    	}
    	model.addAttribute( "resultMap", resultMap);
    	
	}
	
	public void selectStatusList(ZValue zvl, ModelMap model) throws Exception {
		
		List<ZValue> siteList = siteMngService.getSiteList();
		String siteId = CollectionUtils.isNotEmpty(siteList) ? siteList.get(1).getString("siteId") : "2";
		if(zvl.getString("siteId")== null || "".equals(zvl.getString("siteId"))) zvl.put("siteId",siteId);
		
		ZValue page = pageInfo.getPaginationInfo(zvl);
		Map<String, Object> map = menuStatusList(zvl);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
    	zvl.put("totCnt", totCnt);

    	String link = 
    		"/bos/satisfaction/menuStatusList?" +
    		"siteId="+zvl.getString("siteId")+
    		"&searchType="+zvl.getString("searchType")+
    		"&searchTxt="+URLEncoder.encode(zvl.getString("searchTxt"),"UTF-8");
    	zvl.put("link", link);
		
		String pageNav = pageInfo.getPageNavString(page);
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("zvl", zvl);
		model.addAttribute("pageNav", pageNav);
		model.addAttribute("siteList", siteList);
	
	}
	
	
	public void menuStatusListExcel(ZValue zvl, ModelMap model) throws Exception
	{
		List<ZValue> resultList = satisfactionDAO.menuStatusListExcel(zvl);
		String fileName = "페이지만족도";
		
		String[] titles = {"메뉴명","매우만족","만족","보통","불만족","매우불만족"};
		
		ExcelGenerateVO eVO = new ExcelGenerateVO(fileName, titles, resultList);
		model.addAttribute("excel", eVO);
	}

}
