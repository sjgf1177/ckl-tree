package kr.co.edu.hkFcltyResve.service;


import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class SchdulService  extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());


	public SchdulService() {
		super.setCountQueryId("HkFcltyResveDAO.listSchdulCnt");
		super.setListQueryId("HkFcltyResveDAO.listSchdul");
		super.setViewQueryId("HkFcltyResveDAO.viewSchdul");
		super.setInsertQueryId("HkFcltyResveDAO.insertSchdul");
		super.setUpdateQueryId("HkFcltyResveDAO.updateSchdul");
		super.setDeleteQueryId("HkFcltyResveDAO.deleteSchdul");
	}

	/**
	 * 일정관리 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.list(paramCtx);

		model = paramCtx.getModel();
		param = paramCtx.getParam();
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		int cnt = sqlDao.selectCount("HkFcltyResveDAO.schdulChkCnt", param);
		if (cnt > 0) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, "validate");
			return;
		}
		super.insert(paramCtx);
	}

}