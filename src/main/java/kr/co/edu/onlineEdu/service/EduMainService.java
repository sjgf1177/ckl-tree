package kr.co.edu.onlineEdu.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;


public class EduMainService extends DefaultCmmProgramService {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;
	
	public static final String PORTAL_ONLINE_SUB_MAIN_CACHE_NAME = "storedOnlineSubMain";

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public EduMainService() {
		super();

	}
	

	/**
	 * 메인화면
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		param.put("tem_grcode", "N000001");
		
		
		param.put("firstIndex", "0");
		param.put("recordCountPerPage", "10");
		
		//열린강좌 목록(랜덤)
		List<ZValue> selectMainGoldClassList = lmsSqlDao.listDAO("openLecture.selectMainList", param);
		model.addAttribute("selectMainGoldClassList",selectMainGoldClassList);
		
		
		//정규과정 목록(랜덤)
		List<ZValue> realmSubjList = lmsSqlDao.listDAO("realmListDAO.realmSubjRandomList", param);
		model.addAttribute("realmSubjList",realmSubjList);
		
		//인기과정 목록 (랜덤)
		param.put("specials", "hit");
		List<ZValue> hitSubjList = lmsSqlDao.listDAO("realmListDAO.realmSubjRandomList", param);
		model.addAttribute("hitSubjList", hitSubjList);
		
		//테마과정 목록 (랜덤)
		 List<ZValue> themeList = lmsSqlDao.listDAO("themeListDAO.selectThmeList", param);
		 model.addAttribute("themeList", themeList);
		 
		 //아카데미 이야기
		 List<ZValue> academyBoardList = getBbs("B0000023", 6);
		 model.addAttribute("academyBoardList", academyBoardList);
		 
		// 이벤트
		List<ZValue> eventList = getRecentEventList();
		model.addAttribute("eventList", eventList);
		
		//테마과정 이벤트
		List<ZValue> themeEvent = getThemeEvent();
		model.addAttribute("themeEvent", themeEvent);
		
	}
	
	private List<ZValue> getBbs(String bbsId, int recordCountPerPage) throws Exception {
		ZValue param = new ZValue();
		param.put("bbsId", bbsId);
		param.put("id", bbsId);
		param.put("mainRecordCountPerPage", recordCountPerPage);
		param.put("queryId", "optionalBoardDAO.selectMainBoardArticleList");
		List<ZValue> boardList = getList(param);

		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, boardList);
		UnpCollectionUtils.setFirstFile(boardList, fileMap, "atchFileId");

		return boardList;
	}
	
	private List<ZValue> getList(ZValue param) throws Exception {
		List<ZValue> list = new ArrayList<ZValue>();
		list = sqlDao.listDAO(param.getString("queryId"), param);

		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, list);

		if ("mainRsltManage".equals(param.getString("programId"))) {
			setFirstFile(list, fileMap, "atchFileId");
		}
		else {
			UnpCollectionUtils.setFirstFile(list, fileMap, "atchFileId");
		}

		return list;
	}
	
	public void setFirstFile(List<ZValue> resultList, Map<String, List<FileVO>> fileMap, String fileField){
		if ( CollectionUtils.isEmpty(resultList) || MapUtils.isEmpty(fileMap) ) return;
    	for ( ZValue val : resultList ) {
    		String atchFileId = val.getString(fileField);
    		if ( StringUtils.hasText(atchFileId) ) {
    			List<FileVO> fileList = fileMap.get(atchFileId);
    			if ( CollectionUtils.isNotEmpty(fileList) ) {
    				for (FileVO vo : fileList) {
    					if ("bdtExpsrImage".equals(vo.getFileFieldName())) {
    						val.put("imgUrl", vo.getImgUrl());
    						val.put("fileSn", vo.getFileSn());
    						val.put("streFileNm", vo.getStreFileNm());
    					}
    				}
    			}
    		}
    	}
	}
	
	@SuppressWarnings("unchecked")
	private List<ZValue> getRecentEventList() throws Exception {
		ZValue param = new ZValue();
		
		List<ZValue> list = (List<ZValue>) cacheUtil.load(PORTAL_ONLINE_SUB_MAIN_CACHE_NAME, "recentEventList");
		if(list == null){
			list = sqlDao.listDAO("optionalBoardDAO.selectRecentEventList", param);
			cacheUtil.save(PORTAL_ONLINE_SUB_MAIN_CACHE_NAME, "recentEventList", list);
		}
		
		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, list);
		UnpCollectionUtils.setFirstFile(list, fileMap, "atchFileId");
		return list;
	}
	
	@SuppressWarnings("unchecked")
	private List<ZValue> getThemeEvent() throws Exception {
		ZValue param = new ZValue();
		
		List<ZValue> list = (List<ZValue>) cacheUtil.load(PORTAL_ONLINE_SUB_MAIN_CACHE_NAME, "themeEvent");
		if(list == null){
			list = sqlDao.listDAO("optionalBoardDAO.selectThemeEvent", param);
			cacheUtil.save(PORTAL_ONLINE_SUB_MAIN_CACHE_NAME, "themeEvent", list);
		}
		
		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, list);
		UnpCollectionUtils.setFirstFile(list, fileMap, "atchFileId");
		return list;
	}

}
