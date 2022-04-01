
package kr.co.edu.bbs.service;

import java.util.List;

import kr.co.unp.bbs.service.OptionalBBSManageService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class B0000044BBSManageService  extends OptionalBBSManageService  {
	Logger log = Logger.getLogger(this.getClass());

	public B0000044BBSManageService() {
		super();
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		model.addAttribute("psitnCodeList", psitnCodeList);
		super.forInsert(paramCtx);
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		model.addAttribute("psitnCodeList", psitnCodeList);
		super.list(paramCtx);
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		model.addAttribute("psitnCodeList", psitnCodeList);
		super.view(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		model.addAttribute("psitnCodeList", psitnCodeList);
		super.forUpdate(paramCtx);
	}



}
