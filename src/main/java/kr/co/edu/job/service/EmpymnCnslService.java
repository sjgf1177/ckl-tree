package kr.co.edu.job.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;



public class EmpymnCnslService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public EmpymnCnslService() {

		super.setViewQueryId("empymnCnslDAO.selectEmpymnCnsl");
//		super.setDeleteQueryId("empymnCnslDAO.deleteEmpymnCnsl");
	}

	/**
	 * 취업컨설팅 리스트 정보
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue pageInfo = WebFactory.getParameterInit(request);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		super.setCountQueryId("empymnCnslDAO.selectEmpymnCnslListCnt");
		super.setListQueryId("empymnCnslDAO.selectEmpymnCnslList");
		super.list(paramCtx);
		model.addAttribute("pageInfo", pageInfo);
	}

	/**
	 * 취업컨설팅 리스트 정보
	 */
	public void empymnCnslListMypage(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue pageInfo = WebFactory.getParameterInit(request);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		super.setCountQueryId("empymnCnslDAO.selectEmpymnCnslListCnt");
		super.setListQueryId("empymnCnslDAO.selectEmpymnCnslList");
		if (SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName")) &&  !user.getUserId().equals("anonymousUser") && user.getUserIdx() > 0) {
			param.put("userSn", user.getUserIdx());
			super.list(paramCtx);
			model.addAttribute("pageInfo", pageInfo);
		}
	}


	/*
	 * 취업컨설팅 인서트 서비스
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ParameterContext<ZValue> params = new ParameterContext<ZValue>();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if(StringUtils.hasText(param.getString("emlid")) && StringUtils.hasText(param.getString("emailAddr"))) {
			String email = param.getString("emlid") + "@" + param.getString("emailAddr");
			param.put("email", email);
			paramCtx.setParam(param);
		}

		if(StringUtils.hasText(param.getString("email1")) && StringUtils.hasText(param.getString("email2"))) {
			String email = param.getString("email1") + "@" + param.getString("email2");
			param.put("email", email);
		}

		if(StringUtils.hasText(param.getString("ownhomTelno1")) && StringUtils.hasText(param.getString("ownhomTelno2"))&& StringUtils.hasText(param.getString("ownhomTelno3"))) {
			String ownhomTelno = param.getString("ownhomTelno1") + "-" + param.getString("ownhomTelno2") + "-" + param.getString("ownhomTelno3");
			param.put("ownhomTelno", ownhomTelno);
		}

		if(StringUtils.hasText(param.getString("mbtlnum1")) && StringUtils.hasText(param.getString("mbtlnum2"))&& StringUtils.hasText(param.getString("mbtlnum3"))) {
			String mbtlnum = param.getString("mbtlnum1") + "-" + param.getString("mbtlnum2") + "-" + param.getString("mbtlnum3");
			param.put("mbtlnum", mbtlnum);
		}

		param.put("userSn", user.getUserIdx());
		paramCtx.setParam(param);
		super.initCmmnParam(param);
		super.setInsertQueryId("empymnCnslDAO.empymnCnslInsert");

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = null;

		if(SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			param.put("cnsltNm", user.getUserNm());
			super.insert(paramCtx);
		}else if(SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName"))) {
			super.insert(paramCtx);
			url = new StringBuilder("/edu/job/empymnCnsl/recruit02.do");
			url.append("?").append("menuNo=").append(param.getString("menuNo")).append(StrUtils.replace(pageQueryString, "&amp;", "&"));
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));
		}



	}

	/*
	 * 취업컨설팅 수정 서비스
	 */
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.initCmmnParam(param);
		super.setUpdateQueryId("empymnCnslDAO.updateEmpymnCnsl");
		if(StringUtils.hasText(param.getString("email1")) && StringUtils.hasText(param.getString("email2"))) {
			String email = param.getString("email1") + "@" + param.getString("email2");
			param.put("email", email);
			paramCtx.setParam(param);
		}
		if(StringUtils.hasText(param.getString("emlid")) && StringUtils.hasText(param.getString("emailAddr"))) {
			String email = param.getString("emlid") + "@" + param.getString("emailAddr");
			param.put("email", email);
			paramCtx.setParam(param);
		}

		if(StringUtils.hasText(param.getString("ownhomTelno1")) && StringUtils.hasText(param.getString("ownhomTelno2"))&& StringUtils.hasText(param.getString("ownhomTelno3"))) {
			String ownhomTelno = param.getString("ownhomTelno1") + "-" + param.getString("ownhomTelno2") + "-" + param.getString("ownhomTelno3");
			param.put("ownhomTelno", ownhomTelno);
			paramCtx.setParam(param);
		}

		if(StringUtils.hasText(param.getString("mbtlnum1")) && StringUtils.hasText(param.getString("mbtlnum2"))&& StringUtils.hasText(param.getString("mbtlnum3"))) {
			String mbtlnum = param.getString("mbtlnum1") + "-" + param.getString("mbtlnum2") + "-" + param.getString("mbtlnum3");
			param.put("mbtlnum", mbtlnum);
			paramCtx.setParam(param);
		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = null;
		ParameterContext<ZValue> params = new ParameterContext<ZValue>();

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if(SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			super.update(paramCtx);

		}else if(SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName"))) {
			super.update(paramCtx);
			url = new StringBuilder("/edu/job/empymnCnsl/recruit02.do");
			url.append("?").append("menuNo=").append(param.getString("menuNo")).append(StrUtils.replace(pageQueryString, "&amp;", "&"));
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
		}




	}

	public void downloadExcelEmpymnCnsl(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"회원아이디","아이디", "이름", "성별",  "학교","학과", "상담일", "등록일"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("empymnCnslDAO.listExcel", paramCtx.getParam());
    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);

		ExcelGenerateVO vo = new ExcelGenerateVO("일자리 취업컨설팅 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.initCmmnParam(param);
//		sqlDao.deleteDAO("empymnCnslDAO.deleteEmpymnCnslList", param);
		super.setDeleteQueryId("empymnCnslDAO.deleteEmpymnCnsl");
		StringBuilder url = null;
		String pageQueryString = param.getString("pageQueryString");

		if(SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
		super.delete(paramCtx);

		}else if(SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName"))) {
			super.delete(paramCtx);
			url = new StringBuilder("/edu/job/empymnCnsl/empymnCnslListMypage.do");
			url.append("?").append("menuNo=").append(param.getString("menuNo")).append(StrUtils.replace(pageQueryString, "&amp;", "&"));
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));

		}
	}

	public void cnslInsert(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("empymnCnslDAO.updateEmpymnCnslInsert");
		super.insert(paramCtx);

	}

	/**
	 * 사용자 입력폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void recruit00(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap modelMap = paramCtx.getModel();

	}
	/**
	 * 사용자 입력폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void recruit01(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap modelMap = paramCtx.getModel();
		UsersVO user =  UnpUserDetailsHelper.getAuthenticatedUser();
		modelMap.addObject("userInfo", user);
		super.view(paramCtx);


	}

	/**
	 * 신청 완료폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void recruit02(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap modelMap = paramCtx.getModel();
	}


}
