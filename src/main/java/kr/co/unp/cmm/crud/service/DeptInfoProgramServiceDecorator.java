package kr.co.unp.cmm.crud.service;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramServiceDecorator;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;

public class DeptInfoProgramServiceDecorator extends DefaultCmmProgramServiceDecorator<ZValue>  {

	@Resource(name = "SqlDAO")
	ISqlDAO<ZValue> deptDao;

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		super.list(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("deptList", deptDao.listDAO("deptPopDAO.getBbsDeptList", param));

	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forInsert(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("deptList", deptDao.listDAO("deptPopDAO.getBbsDeptList", param));
	}


	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.view(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("deptList", deptDao.listDAO("deptPopDAO.getBbsDeptList", param));
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forUpdate(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("deptList", deptDao.listDAO("deptPopDAO.getBbsDeptList", param));
	}


}
