package kr.co.edu.onlineEdu.service;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;


public class OccpService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public OccpService() {
		super();

	}


	/**
	 * 직업별 목록
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("upperclscd", "1000");	//분류별 목록을 불러오기 위한 코드 값 등록
		param.put("grcode", "N000001");		//교육그룹코드 등록

		param.put("pGubun1", param.getString("pGubun1", param.getString("gubun", "A")));
		param.put("pGubun2", param.getString("pGubun2", param.getString("option1", "A")));
		param.put("pGubun3", param.getString("pGubun3", param.getString("option5", "A")));
		initCmmnParam(param);

		//직업별 탭 목록
		List<ZValue> occpTabList = lmsSqlDao.listDAO("occpListDAO.occpTabList", param);
		model.addAttribute("occpTabList",occpTabList);

		//직업별 탭 하위 목록
		List<ZValue> occpSubTabList = lmsSqlDao.listDAO("occpListDAO.occpSubTabList", param);
		model.addAttribute("occpSubTabList",occpSubTabList);

		//과정 목록
		super.setCountQueryId("occpListDAO.occpSubjListCnt");
		super.setListQueryId("occpListDAO.occpSubjList");

		paramCtx.setSqlDAO(lmsSqlDao);
		super.list(paramCtx);


	}


	/**
	 * 과정 상세 화면
	 */
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");	//교육그룹코드 등록

		String year = "";
		String subjseq = "";


		if("".equals(param.getString("p_year")) || "".equals(param.getString("p_subjseq"))){
			ZValue getAdvanceInfo = lmsSqlDao.selectDAO("occpListDAO.getSubjectAdvanceInfo", param);

			year = getAdvanceInfo.getString("year");
			subjseq = getAdvanceInfo.getString("subjseq");

			param.put("p_year", year);
			param.put("p_subjseq", subjseq);
		}

		//과정 상세정보
		ZValue view = lmsSqlDao.selectDAO("occpListDAO.view", param);
		model.addAttribute("view", view);

		//차시 목록
		List<ZValue> lessonList = lmsSqlDao.listDAO("occpListDAO.lessonList", param);
		model.addAttribute("lessonList",lessonList);


		String subjMuserid = "";
		subjMuserid = view.getString("tutorid");
		param.put("subjmuserid", subjMuserid);

		ZValue tutorInfo = lmsSqlDao.selectDAO("occpListDAO.getTutorInfo", param);
		model.addAttribute("tutorInfo", tutorInfo);


		//연관과정 정보: 연관 과정이란 수강 신청을 해 놓은 과정을 의미함
		ZValue getSearchNM = lmsSqlDao.selectDAO("occpListDAO.getSearchNM", param);
		String []searchNm = null;
		searchNm = getSearchNM.getString("searchNm").split(",");

		List<String> obj = Arrays.asList(searchNm);
		param.put("searchNm", obj);

		String[] searchNmArr = null;
		int rnkLimit = 0;
		searchNmArr = searchNm;
		rnkLimit = (searchNm.length < 3)?searchNmArr.length-1:2;
		param.put("rnkLimit", rnkLimit);


		//연관과정 목록
		List<ZValue> nextProposeSubjList = lmsSqlDao.listDAO("occpListDAO.nextProposeSubjList", param);
		model.addAttribute("nextProposeSubjList",nextProposeSubjList);

	}

	/**
	 * 직업별 탭 목록(통합검색시 사용)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void occpTabList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> occpTabList = lmsSqlDao.listDAO("occpListDAO.occpTabList", param);
		model.addAttribute("tabList", occpTabList);
	}




















}
