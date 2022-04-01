package kr.co.edu.job.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.edu.job.paging.EmpymnCnslListQuery;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;



public class EmpymnCnslListService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public EmpymnCnslListService() {
//		super.setDeleteQueryId("empymnCnslListDAO.deleteEmpymnCnsl");

	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue pageInfo = WebFactory.getParameterInit(request);
		super.setCountQueryId("empymnCnslListDAO.selectEmpymnCnslListCnt");
		super.setListQueryId("empymnCnslListDAO.selectEmpymnCnslList");
		super.list(paramCtx);
		model.addAttribute("pageInfo", pageInfo);
	}

	/*
	 * 취업컨설팅 인서트 서비스
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		super.initCmmnParam(param);

		if(StringUtils.hasText(param.getString("emailId")) && StringUtils.hasText(param.getString("emailAddr"))) {
			String email = param.getString("emailId") + "@" + param.getString("emailAddr");
			param.put("email", email);
		}

		if(StringUtils.hasText(param.getString("telno1")) && StringUtils.hasText(param.getString("telno2"))&& StringUtils.hasText(param.getString("telno3"))) {
			String telno = param.getString("telno1") + "-" + param.getString("telno2") + "-" + param.getString("telno3");
			param.put("telno", telno);
		}

		if(StringUtils.hasText(param.getString("faxnum1")) && StringUtils.hasText(param.getString("faxnum2"))&& StringUtils.hasText(param.getString("faxnum3"))) {
			String faxnum = param.getString("faxnum1") + "-" + param.getString("faxnum2") + "-" + param.getString("faxnum3");
			param.put("faxnum", faxnum);

		}
		paramCtx.setParam(param);
		super.setUpdateQueryId("empymnCnslListDAO.sttusUpdate");
		super.setInsertQueryId("empymnCnslListDAO.empymnCnslInsert");
		super.update(paramCtx);
		super.insert(paramCtx);

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/job/empymnCnslList/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));
	}

	/**
	 * 팝업 서비스
	 * @param paramCtx
	 * @throws Exception
	 */
	public void empymnCnslHistPopup(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param= paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String histSn = param.getString("histSn");
		HttpServletRequest request = paramCtx.getRequest();
		ZValue pageInfo = WebFactory.getParameterInit(request);

		 /* 쿼리 */
		paramCtx.setPageQuery(new EmpymnCnslListQuery());
		/*histSn 값이 없을때 초기*/

		if(StringUtils.hasText(histSn.trim())){
			super.setViewQueryId("empymnCnslListDAO.empymnCnslHistPopup");
			super.view(paramCtx);
		}

		super.setCountQueryId("empymnCnslListDAO.empymnCnslHistPopupListCnt");
		super.setListQueryId("empymnCnslListDAO.empymnCnslHistPopupList");
		super.list(paramCtx);
		/*페이징 처리 */
		model.addAttribute("pageInfo", pageInfo);


	}
	/**
	 * 인재관리 히스토리 삭제
	 */
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param= paramCtx.getParam();

		super.initCmmnParam(param);

		super.setDeleteQueryId("empymnCnslListDAO.deleteEmpymnCnsl");
		super.delete(paramCtx);
		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/job/empymnCnslList/empymnCnslHistPopup.do");
		url.append("?").append("viewType=BODY").append("&").append("cnslSn=").append(param.getString("cnslSn")).append("&").append("pageUnit=5");
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));

	}

	public void downloadExcelEmpymnCnslList(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"회원여부", "이름", "성별", "생년월일", "학교","학과", "상담일", "상태", "최종수정일"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("empymnCnslListDAO.listExcel", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("인재관리_취업컨설팅 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}




}
