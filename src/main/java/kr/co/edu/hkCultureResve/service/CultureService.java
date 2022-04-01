package kr.co.edu.hkCultureResve.service;


import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.edu.hkFcltyResve.paging.EqpmnPageQuery;
import kr.co.edu.hkCultureResve.paging.CulturePageQuery;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

public class CultureService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());


	public CultureService(){

	}

	/**
	 * 시설관리상세 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void viewPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new EqpmnPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkCultureResveDAO.viewFclty");
		super.view(paramCtx);
	}

	/**
	 * 시설관리 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		
		paramCtx.setPageQuery(new CulturePageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		if ("edu".equals(param.getString("siteName")) || "edueng".equals(param.getString("siteName"))) param.put("pageUnit", 9);

		super.setCountQueryId("HkCultureResveDAO.listFcltyCnt");
		super.setListQueryId("HkCultureResveDAO.listFclty");
		super.list(paramCtx);

		model = paramCtx.getModel();
		param = paramCtx.getParam();
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);
	}


	/**
	 * 시설관리 상세
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new CulturePageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkCultureResveDAO.viewFclty");
		super.view(paramCtx);

		List<ZValue> eqpmnList = sqlDao.listDAO("HkCultureResveDAO.listEqpmnByFclty", param);
		model.addAttribute("eqpmnList",eqpmnList);
	}


	/**
	 * 시설관리 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new CulturePageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		super.forInsert(paramCtx);
	}


	/**
	 * 시설관리 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		String[] eqpmnSns = null;
		String eqpmnSnsStr = param.getString("eqpmnSns");
		if (eqpmnSnsStr != null && !"".equals(eqpmnSnsStr)) {
			eqpmnSns = eqpmnSnsStr.split(",");
		}

		super.setInsertQueryId("HkCultureResveDAO.insertFclty");
		super.insert(paramCtx);

		param.put("fcltySn", paramCtx.getPkValue());

		if (eqpmnSns != null) {
			for (String eqpmnSn : eqpmnSns) {
				param.put("eqpmnSn", eqpmnSn);
				sqlDao.insertDAO("HkCultureResveDAO.insertFcltyEqpmn", param);
			}
		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/hkCultureResve/fclty/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

	}


	/**
	 * 시설관리 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new CulturePageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkCultureResveDAO.fcltyView");
		super.forUpdate(paramCtx);
	}


	/**
	 * 시설관리 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		String[] eqpmnSns = null;
		String eqpmnSnsStr = param.getString("eqpmnSns");
		if (eqpmnSnsStr != null && !"".equals(eqpmnSnsStr)) {
			eqpmnSns = eqpmnSnsStr.split(",");
		}

		super.setUpdateQueryId("HkCultureResveDAO.updateFclty");
		super.update(paramCtx);

		if ("N".equals(param.getString("eqpmnUseAt"))) {
			sqlDao.deleteDAO("HkCultureResveDAO.deleteFcltyEqpmnByFcltySn", param);
		}
		else {
			if (eqpmnSns != null) {
				sqlDao.deleteDAO("HkCultureResveDAO.deleteFcltyEqpmnByFcltySn", param);
				for (String eqpmnSn : eqpmnSns) {
					param.put("eqpmnSn", eqpmnSn);
					sqlDao.insertDAO("HkCultureResveDAO.insertFcltyEqpmn", param);
				}
			}
		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/hkCultureResve/fclty/view.do");
		url.append("?fcltySn=").append(param.getString("fcltySn")).append("&").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
	}


	/**
	 * 시설관리 삭제처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setDeleteQueryId("HkCultureResveDAO.deleteFclty");
		super.delete(paramCtx);

		String pageQueryString = pageQuery.getPageQueryString(param);
		StringBuilder url = new StringBuilder("/bos/hkCultureResve/fclty/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));
	}


	/**
	 * 선택장비찾기 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void eqpmnPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listEqpmnPopup", param);
		model.addAttribute("eqpmnList",list);
	}

	/**
	 * 시설목록 (레이아웃)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listForLayout(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn",user.getUserIdx());
		List<ZValue> codeList = super.codeList("COM059","01");
		model.addAttribute("codeList",codeList);
		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listFcltyForLayout", param);
		model.addAttribute("fcltyList",list);
	}

}
