package kr.co.edu.dream.service;

import java.util.ArrayList;
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

public class DreamMainService extends DefaultCmmProgramService {

	private final String[] MAIN_BBS_ID = { "B0000041", "B0000071"}; 
										// 미디어존,  현장스토리,  창의클럽 커뮤니티,  멘토링 현장영상, 

	Logger log = Logger.getLogger(this.getClass());

	public DreamMainService() {
	}

	public void main(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		// 창의인재동반
		param.put("queryId", "optionalBoardDAO.selectEduBoardList");
		param.put("mainRecordCountPerPage", 1);
		List<ZValue> creList = getList(param);
		model.addAttribute("creList", creList);
		
		// 공통게시판
		for (String bbsId : MAIN_BBS_ID) { 
			int num = 8; // 게시물 갯수
			if ("B0000041".equals(bbsId)) num = 5;
			else if ("B0000071".equals(bbsId)) num = 5;

			List<ZValue> boardList = getBbs(bbsId, num);
			model.addAttribute(bbsId + "List", boardList);
		}
		
		ZValue paramOpenClass = paramCtx.getParam();
		paramOpenClass.put("queryId", "progrmMasterDAO.list");
		paramOpenClass.put("siteSe", SiteMngService.EDU_SITE_NAME);
		paramOpenClass.put("prgSe", "01");
		paramOpenClass.put("prgCl", "17");
		paramOpenClass.put("firstIndex", "0");
		paramOpenClass.put("lastIndex", "5");
		List<ZValue> openClassList = getList(paramOpenClass);
		model.addAttribute("openClassList", openClassList);
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
