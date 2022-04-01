package kr.co.edu.hkEtcResve.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.edu.hkEtcResve.paging.EqpmnPageQuery;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;


public class EqpmnService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	public EqpmnService(){

	}

	/**
	 * 장비관리상세 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void viewPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new EqpmnPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkEtcResveDAO.viewEqpmn");
		super.view(paramCtx);
	}



	/**
	 * 장비관리 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new EqpmnPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		if ("edu".equals(param.getString("siteName")) || "edueng".equals(param.getString("siteName"))) param.put("pageUnit", 9);

		super.setCountQueryId("HkEtcResveDAO.listEqpmnCnt");
		super.setListQueryId("HkEtcResveDAO.listEqpmn");
		super.list(paramCtx);

		model = paramCtx.getModel();
		param = paramCtx.getParam();
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);
	}


	/**
	 * 장비관리 상세
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new EqpmnPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkEtcResveDAO.viewEqpmn");
		super.view(paramCtx);
	}


	/**
	 * 장비관리 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new EqpmnPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		super.forInsert(paramCtx);
	}


	/**
	 * 장비관리 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
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

		super.setInsertQueryId("HkEtcResveDAO.insertEqpmn");
		super.insert(paramCtx);

		param.put("eqpmnSn", paramCtx.getPkValue());


		List<ZValue> detailEqpmnList = super.getJsonConvertZValueList(param.getString("detailEqpmnsStr"));

		if (detailEqpmnList != null) {
			int num = 0;
			for (ZValue item : detailEqpmnList) {
				param.put("eqpmnDetailSn", ++num);
				param.put("eqpmnDetailNm", item.getString("eqpmnDetailNm"));
				param.put("useAt", item.getString("detailUseAt"));
				param.put("rm", item.getString("rm"));
				sqlDao.insertDAO("HkEtcResveDAO.insertEqpmnDetail", param);
			}
		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/hkEtcResve/eqpmn/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

	}


	/**
	 * 장비관리 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new EqpmnPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkEtcResveDAO.viewEqpmn");
		super.forUpdate(paramCtx);

		List<ZValue> eqpmnDteailList = sqlDao.listDAO("HkEtcResveDAO.listEqpmnDetail", param);
		model.addAttribute("detailList", eqpmnDteailList);
	}


	/**
	 * 장비관리 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
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

		super.setUpdateQueryId("HkEtcResveDAO.updateEqpmn");
		super.update(paramCtx);

		List<ZValue> detailEqpmnList = super.getJsonConvertZValueList(param.getString("detailEqpmnsStr"));

		//sqlDao.updateDAO("HkEtcResveDAO.deleteEqpmnDetailByEqpmnSn", param);
		if (detailEqpmnList != null) {
			int num = 0;
			for (ZValue item : detailEqpmnList) {
				if (!"".equals(item.getString("eqpmnDetailSn",""))) {
					param.put("eqpmnDetailSn", item.getString("eqpmnDetailSn"));
					param.put("eqpmnDetailNm", item.getString("eqpmnDetailNm"));
					param.put("useAt", item.getString("detailUseAt"));
					param.put("rm", item.getString("rm"));
					sqlDao.insertDAO("HkEtcResveDAO.updateEqpmnDetail", param);
				}
				else {
					param.put("eqpmnDetailSn", ++num);
					param.put("eqpmnDetailNm", item.getString("eqpmnDetailNm"));
					param.put("useAt", item.getString("detailUseAt"));
					param.put("rm", item.getString("rm"));
					sqlDao.insertDAO("HkEtcResveDAO.insertEqpmnDetail", param);
				}
			}
		}

		String delEqpmnDetailSnListStr = param.getString("delEqpmnDetailSnListStr","");
		if (!"".equals(param.getString("delEqpmnDetailSnListStr",""))) {
			String[] delEqpmnDetailSnArr = delEqpmnDetailSnListStr.split(",");
			for (String detailSn : delEqpmnDetailSnArr) {
				param.put("eqpmnDetailSn", detailSn);
				sqlDao.updateDAO("HkEtcResveDAO.deleteEqpmnDetail", param);
			}
		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/hkEtcResve/eqpmn/view.do");
		url.append("?eqpmnSn=").append(param.getString("eqpmnSn")).append("&").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
	}


	/**
	 * 장비관리 삭제처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setDeleteQueryId("HkEtcResveDAO.deleteEqpmn");
		super.delete(paramCtx);

		String pageQueryString = pageQuery.getPageQueryString(param);
		StringBuilder url = new StringBuilder("/bos/hkEtcResve/eqpmn/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));
	}

}
