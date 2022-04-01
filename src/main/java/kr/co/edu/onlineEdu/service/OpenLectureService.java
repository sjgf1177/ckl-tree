package kr.co.edu.onlineEdu.service;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import kr.co.edu.onlineEdu.paging.OpenLecturePageInfo;
import kr.co.edu.onlineEdu.paging.OpenLecturePageInfo2;
import kr.co.edu.onlineEdu.paging.RealmPageInfo;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.dom4j.*;
import org.dom4j.io.SAXReader;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class OpenLectureService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@Resource(name = "openLecturePageInfo")
    private OpenLecturePageInfo openLecturePageInfo;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

	public OpenLectureService() {
		super();
	}
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
//		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("tem_grcode", "N000001");
		param.put("pLectureCls", param.getString("gubun"));
		param.put("pageUnit", "12");	
		
		if(!StringUtils.hasText(param.getString("sortOrder"))){
	    	param.put("sortOrder", "newOrdr");
		}
		
		//분류별 탭 1depth 목록
		List<ZValue> realmTabList = lmsSqlDao.listDAO("openLecture.realmTabList", param);
		model.addAttribute("realmTabList",realmTabList);
		
		//분류별 탭 2depth 목록
		if(!"ALL".equals(param.getString("pLectureCls", "ALL"))){
			param.setValue("p_ordr", "2");
			param.setValue("p_code", param.getString("pLectureCls"));
			param.setValue("p_type", param.getString("pLectureCls"));
			
			//분류 목록
			List<ZValue> gubunList = lmsSqlDao.listDAO("openLecture.gubunList", param);
			//난이도 목록
			List<ZValue> levelList = lmsSqlDao.listDAO("openLecture.levelList", param);
		
			model.addAttribute("gubunList", gubunList);
			model.addAttribute("levelList", levelList);				
		}		

//		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		ZValue openClassCnt = lmsSqlDao.selectDAO("openLecture.selecOpenClassCntInfo", param);
		model.addAttribute("openClassCnt", openClassCnt);
		super.setCountQueryId("openLecture.selectMainGoldClassListCnt");
		super.setListQueryId("openLecture.selectMainGoldClassList");

		paramCtx.setParam(param);
		//super.setPageInfo(openLecturePageInfo);
		paramCtx.setSqlDAO(lmsSqlDao);
		paramCtx.setPageQuery(new OpenLecturePageInfo2());
		super.list(paramCtx);

	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid",user.getUserId());
		param.put("tem_grcode", "N000001");
		
		/* 열린강좌 이벤트 체크 */
		if( "".equals(param.getString("pSeq")) ){
			String seq = lmsSqlDao.selectString("openLecture.selectOpenclassEventSeq", param);
			if(seq == null || seq.equals("")){
				MVUtils.goUrl("/edu/main/main.do", "진행중인 이벤트가 없습니다.", model);
				return;
			}
			param.put("pSeq", seq);
		}
			
			
//		if("Y".equals(param.getString("event"))){
//			int eventCount = lmsSqlDao.selectCount("openLecture.selectOpenclassEventCount", param);
//			if(eventCount > 0){
//				model.addObject("event", "Y");
//			}
//		}
		
		/* 태그리스트 추출 */
		ZValue tags= lmsSqlDao.selectDAO("openLecture.selectRelatedLecutreListTag", param);
		String tag = tags.getString("tags");
		String[] tagsArr = null;
		
		/* 태그담기 */
		if(tag.length() > 0){
			tagsArr = tag.split(",");
		}

		/* 태그가 한개(null 이아닐떄 )이상일떄 */
		if(tagsArr != null){
		List<ZValue> arrList = new ArrayList<ZValue>();
		int rnkLimit = 0;
		int num = 0;

		for (String str : tagsArr) {
			ZValue vo = new ZValue();
			vo.put("arrStr",str);
			vo.put("num", num);
			arrList.add(vo);
			num++;
		}

		/*	다음 페이지 */
		int tagLength = tagsArr.length-1;
		rnkLimit = (tagsArr.length < 3) ? tagsArr.length - 1 : 2;
		param.put("tagLength", tagLength);
		param.put("rnkLimit", rnkLimit);
		param.putObject("arrList", arrList);


		List<ZValue> nextList = lmsSqlDao.listDAO("openLecture.selectRelatedLecutreTagList", param);
		model.addObject("nextList", nextList);
		}

//		List<ZValue> tmpList = new ArrayList<ZValue>();
		/*for ( ZValue nextVO :nextList) {
			String img = nextVO.getString("vodimg");
			img.replaceAll("\\", "/");
			nextVO.put("nextImg", img);
			tmpList.add(nextVO);
		}*/

		paramCtx.setSqlDAO(lmsSqlDao);
		super.setViewQueryId("openLecture.selectViewGoldClass");
		super.view(paramCtx);

//		super.setPageInfo(openLecturePageInfo);
//		super.setCountQueryId("openLecture.selectReviewListCnt");
//		super.setListQueryId("openLecture.selectReviewList");
//		super.list(paramCtx);


	}

	public void popUpVod(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		// seq 숫자형 여부 체크
		String str = param.getString("seq");
        boolean isNumeric =  str.matches("[+-]?\\d*(\\.\\d+)?");
        
        if(!isNumeric){
        	param.setValue("seq", "");
        }
		
		initCmmnParam(param);
		super.lmsSqlDao.updateDAO("openLecture.updateOpenClassViewCount", param);
		
		if("Y".equals(param.getString("event"))){
			int eventCount = lmsSqlDao.selectCount("openLecture.selectOpenclassEventCount", param);
			if(eventCount > 0){
				super.lmsSqlDao.updateDAO("openLecture.updateOpenClassEvent", param);
			}
		}
		
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
		return;
	}


	/**
	 * 찜등록
	 */
	public void regSubjFavorInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		int result = 0;
		String system_msg = "";

		String userId = param.getString("userId");

		String grcode = param.getString("grcode");
		grcode = "".equals(grcode) ? param.getString("tem_grcode"):grcode;

		param.put("userid", userId);
		param.put("grcode", "N000001");


		if("".equals(userId)){
			log.info("사용자 정보를 확인할 수 없습니다.\\n다시 로그인 하신 후 시도해주세요!");
			system_msg = "사용자 정보를 확인할 수 없습니다.\\n다시 로그인 하신 후 시도해주세요!";
			result = -1;
			return;

		}else{

			//찜목록 취소
			if("cancel".equals(param.getString("p_jobtype"))){

				result = lmsSqlDao.deleteDAO("myLctrumDAO.regSubjFavorDelete", param);
				log.info("찜목록 취소 결과 ==>"+result);
				system_msg = "해당 과정이 찜취소 되었습니다!";
				result = 1;

			//찜목록 등록
			}else if("register".equals(param.getString("p_jobtype"))){

				//30번째 찜목록 삭제
				result = lmsSqlDao.deleteDAO("myLctrumDAO.regSubjFavorLastDelete", param);
				log.info("찜목록 삭제 갯수 ==>"+result);


				if(result > -1){
					lmsSqlDao.insertDAO("myLctrumDAO.regSubjFavorInsert", param);
					system_msg = "해당 과정이 찜등록 되었습니다!";
					result = 1;

				}else{
					system_msg = "최대 찜목록 갯수를 초과하여 더이상 등록할 수 없습니다!";
					log.info("최대 찜목록 갯수를 초과하여 더이상 등록할 수 없습니다!");
					result = -2;
					return;
				}

			}else{
				system_msg = "진행할 작업을 알 수 없습니다.\n다시 시도해주세요!";
				log.info("진행할 작업을 알 수 없습니다.\n다시 시도해주세요!");
				result = -3;
				return;
			}

		}

		model.addAttribute("system_msg", system_msg);
		model.addAttribute("result", result);

	}
	public void myOpenLetureList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		param.put("userId",user.getUserId());
		param.put("grcode", "N000001");
		List<ZValue> resultList = lmsSqlDao.listDAO("openLecture.selectMyOpenLectureList", param);
		model.put("resultList", resultList);
	}

	public void myOpenLetureView(ParameterContext<ZValue> paramCtx) throws Exception {

	}

	public void creduReturnXml(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		String creduURL = param.getString("url");
		String videoURL = "";
		try{
			Document document = parse(creduURL);
			if(document != null){
				XPath xpathSelector = DocumentHelper.createXPath("/ITEM/MP4NM");
				
				List results = xpathSelector.selectNodes(document);
				for(Iterator iter = results.iterator(); iter.hasNext();){
					Element element = (Element)iter.next();
					videoURL = element.getText();
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("result", videoURL);
	}
	
	public Document parse(String url) throws DocumentException {
    	SAXReader reader = new SAXReader();
    	try
    	{
    		return reader.read(new URL(url));
    	}
    	catch(MalformedURLException e)
    	{
    		e.printStackTrace();
    	}
    	return null;
    }
	
	/**
	 * 하위 분류 리스트
	 */
	public void gubunList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(!"".equals(param.getString("p_code"))){
			//분류 목록
			List<ZValue> gubunList = lmsSqlDao.listDAO("openLecture.gubunList", param);
			model.addAttribute("gubunList", gubunList);
			
			if("2".equals(param.getString("p_ordr"))){
				//난이도 목록
				List<ZValue> levelList = lmsSqlDao.listDAO("openLecture.levelList", param);
				model.addAttribute("levelList", levelList);
			}
		}
		
	}
}
