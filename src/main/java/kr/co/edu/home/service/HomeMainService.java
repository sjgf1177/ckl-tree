package kr.co.edu.home.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class HomeMainService extends DefaultCmmProgramService {

	private final String[] MAIN_BBS_ID = { "B0000011" }; // 공지사항 , 문의하기

	Logger log = Logger.getLogger(this.getClass());

	public HomeMainService() {
	}

	public void main(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		for (String bbsId : MAIN_BBS_ID) { // 공통게시판
			int num = 8; // 게시물 갯수
			if ("B0000011".equals(bbsId)) num = 5;

			List<ZValue> boardList = getBbs(bbsId, num);
			model.addAttribute(bbsId + "List", boardList);
		}

		// 문의사항
		param.put("queryId", "optionalBoardDAO.selectCnslBoardList");
		param.put("bbsId", "B0000038");
		param.put("mainRecordCountPerPage", 5);
		List<ZValue> cnslBoardList = getList(param);
		model.addAttribute("cnslBoardList", cnslBoardList);

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
