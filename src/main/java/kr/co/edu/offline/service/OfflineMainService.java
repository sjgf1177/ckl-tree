package kr.co.edu.offline.service;

import java.util.ArrayList;
//import java.util.Collections;
//import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

//import com.ibm.icu.text.SimpleDateFormat;

public class OfflineMainService extends DefaultCmmProgramService {

	//private final String[] MAIN_BBS_ID = { "B0000042", "B0000041", "B0000043", "B0000040" }; // 창의인물, 현장스토리, 창의클럽 커뮤니티, 보도자료

	Logger log = Logger.getLogger(this.getClass());

	public OfflineMainService() {
	}

	public void main(ParameterContext<ZValue> paramCtx) throws Exception {
//		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		// 오프라인교육 핫이슈
		/*ZValue param = paramCtx.getParam();
		param.put("queryId", "progrmMasterDAO.issueList");
		param.put("mainRecordCountPerPage", 4);
		List<ZValue> issueList = getList(param);
		for(int i=issueList.size(); i>0; i--) { // 
			for (int j=0; j<i-1; j++) { 
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMddHHmm");
				Date dateI = (Date) transFormat.parse(issueList.get(j).getString("updateDate"));
				Date dateJ = (Date) transFormat.parse(issueList.get(j+1).getString("updateDate"));
				String idI = (String) issueList.get(j).getString("frstRegiId");
				String idJ = (String) issueList.get(j+1).getString("frstRegiId");
				if ( dateJ.compareTo(dateI) > 0 && "main".equals(idI) && "main".equals(idJ) ) Collections.swap(issueList, j, j+1);
				else if ( !"main".equals(idI) && "main".equals(idJ) ) Collections.swap(issueList, j, j+1);
				else if ( !"main".equals(idI) && !"main".equals(idJ) && dateJ.compareTo(dateI) > 0 ) Collections.swap(issueList, j, j+1);
			}
		}
		model.addAttribute("issueList", issueList);*/

		// 콘텐츠 인사이트
		ZValue paramInsight = paramCtx.getParam();
		paramInsight.put("queryId", "progrmMasterDAO.list");
		paramInsight.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramInsight.put("prgSe", "01");
		paramInsight.put("prgCl", "13");
		paramInsight.put("firstIndex", "0");
		paramInsight.put("lastIndex", "4");
		List<ZValue> insightList = getList(paramInsight);
		model.addAttribute("insightList", insightList);

		// 콘텐츠 스탭업
		ZValue paramStep = paramCtx.getParam();
		paramStep.put("queryId", "progrmMasterDAO.list");
		paramStep.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramStep.put("prgSe", "01");
		paramStep.put("prgCl", "12");
		paramStep.put("firstIndex", "0");
		paramStep.put("lastIndex", "4");
		List<ZValue> stepList = getList(paramStep);
		model.addAttribute("stepList", stepList);

		// 콘텐츠 플러스
		ZValue paramPlus = paramCtx.getParam();
		paramPlus.put("queryId", "progrmMasterDAO.list");
		paramPlus.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramPlus.put("prgSe", "01");
		paramPlus.put("prgCl", "10");
		paramPlus.put("firstIndex", "0");
		paramPlus.put("lastIndex", "4");
		List<ZValue> plusList = getList(paramPlus);
		model.addAttribute("plusList", plusList);
		
		// 콘텐츠 밸류업
		ZValue paramValueUp = paramCtx.getParam();
		paramPlus.put("queryId", "progrmMasterDAO.list");
		paramPlus.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramPlus.put("prgSe", "01");
		paramPlus.put("prgCl", "15");
		paramPlus.put("firstIndex", "0");
		paramPlus.put("lastIndex", "4");
		List<ZValue> valueUpList = getList(paramValueUp);
		model.addAttribute("valueUpList", valueUpList);
		
		// 게임인재원
		ZValue paramGameSchool = paramCtx.getParam();
		paramPlus.put("queryId", "progrmMasterDAO.list");
		paramPlus.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramPlus.put("prgSe", "01");
		paramPlus.put("prgCl", "16");
		paramPlus.put("firstIndex", "0");
		paramPlus.put("lastIndex", "4");
		List<ZValue> gameSchoolList = getList(paramGameSchool);
		model.addAttribute("gameSchoolList", gameSchoolList);
		
		// 게임리터러시
		ZValue paramGameLiteracy = paramCtx.getParam();
		paramPlus.put("queryId", "progrmMasterDAO.list");
		paramPlus.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramPlus.put("prgSe", "01");
		paramPlus.put("prgCl", "14");
		paramPlus.put("firstIndex", "0");
		paramPlus.put("lastIndex", "4");
		List<ZValue> gameLiteracyList = getList(paramGameLiteracy);
		model.addAttribute("gameLiteracyList", gameLiteracyList);
		// 채용정보
		/*
		param.put("queryId", "empmnPblanc.selectEmpmnPblancList");
		param.put("firstIndex", 0);
		param.put("recordCountPerPage", 4);
		List<ZValue> EmpmnList = getList(param);
		model.addAttribute("EmpmnList", EmpmnList);
		*/
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

	/*private List<ZValue> getBbs(String bbsId, int recordCountPerPage) throws Exception {
		ZValue param = new ZValue();
		param.put("bbsId", bbsId);
		param.put("id", bbsId);
		param.put("mainRecordCountPerPage", recordCountPerPage);
		param.put("queryId", "optionalBoardDAO.selectMainBoardArticleList");
		List<ZValue> boardList = getList(param);

		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, boardList);
		UnpCollectionUtils.setFirstFile(boardList, fileMap, "atchFileId");

		return boardList;
	}*/

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

}
