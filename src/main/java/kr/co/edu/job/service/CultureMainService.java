package kr.co.edu.job.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.ntcn.service.NtcnAlertProgramService;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.ZValue;
import kr.co.unp.member.vo.UsersVO;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class CultureMainService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	private final String[] MAIN_BBS_ID = { "B0000011", "B0000020", "B0000047" }; // 공지사항, 콘텐츠미래를 만나다, 발로 뛰는 취창업실

	@Resource(name = "ntcnAlertService")
	private NtcnAlertProgramService ntcnAlertService;

	@Resource(name = "empmnInfoService")
	private EmpmnInfoService empmnInfoService;

	public CultureMainService(){
	}

	public void main(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		// --로그인 회원 정보 rsg20170825
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("user", user);
		// --//로그인 회원 정보 rsg20170825 

		// 팝업존
		param.put("type", "02");
		param.put("siteId", "5");
		List<ZValue> popupList = ntcnAlertService.selectPublishList(param);
		model.addAttribute("popupList", popupList);

		for (String bbsId : MAIN_BBS_ID) { // 공통게시판
			List<ZValue> boardList = getBbs(bbsId);
			model.addAttribute(bbsId + "List", boardList);
		}

		// 취업프로그램
		/*param.put("queryId", "progrmMasterDAO.listSubMain");
		param.put("mainRecordCountPerPage", 9);
		param.put("prgSe", "02");
		param.put("prgCl", "20");
		List<ZValue> progrmList = getList(param);
		model.addAttribute("progrmList", progrmList);*/

		// 채용정보
		param.put("queryId", "empmnPblanc.selectEmpmnPblancList");
		param.put("firstIndex", 0);
		param.put("recordCountPerPage", 4);
		param.put("useAt", "Y");
		List<ZValue> empmnLogoList = getList(param);
		model.addAttribute("empmnLogoList", empmnLogoList); 
	}

	private List<ZValue> getList(ZValue param) throws Exception {
		List<ZValue> list = new ArrayList<ZValue>();
		list = sqlDao.listDAO(param.getString("queryId"), param);

		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, list);
		UnpCollectionUtils.setFirstFile(list, fileMap, "atchFileId");
		return list;
	}

	private List<ZValue> getBbs(String bbsId) throws Exception {
		ZValue param = new ZValue();

		int num = 3; // 게시물 갯수
		if ("B0000047".equals(bbsId)) num = 3;
		if ("B0000011".equals(bbsId)) {
			param.put("option1", "02");
			num = 5;
		}

		param.put("bbsId", bbsId);
		param.put("id", bbsId);
		param.put("mainRecordCountPerPage", num);
		param.put("queryId", "optionalBoardDAO.selectMainBoardArticleList");
		List<ZValue> boardList = getList(param);

		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, boardList);

		if ("B0000020".equals(bbsId)) {
			setFirstFile(boardList, fileMap, "atchFileId");
		}
		else {
			UnpCollectionUtils.setFirstFile(boardList, fileMap, "atchFileId");
		}

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
    					if ("main_image".equals(vo.getFileFieldName())) {
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
