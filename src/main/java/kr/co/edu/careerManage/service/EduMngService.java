package kr.co.edu.careerManage.service;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.edu.careerManage.paging.EduMngPageQuery;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;

import kr.co.unp.util.ZValue;

public class EduMngService extends DefaultCmmProgramService{
	Logger log = Logger.getLogger(this.getClass());
	
	public EduMngService (){
		
	}
	
	/**
	 * 사업관리 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new EduMngPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		if ("edu".equals(param.getString("siteName")) || "edueng".equals(param.getString("siteName"))) param.put("pageUnit", 9);

		super.setCountQueryId("CareerManageDAO.listEduMngCnt");
		super.setListQueryId("CareerManageDAO.listEduMng");
		super.list(paramCtx);
		
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);
	}
	
	
	/**
	 * 사업관리 상세보기
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ajaxEduDetail(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		
		super.setViewQueryId("CareerManageDAO.viewEduMng");
		super.view(paramCtx);
	}
	
	/**
	 * 사업코드 중복확인
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ajaxEduCodeDupl(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		
		super.setCountQueryId("CareerManageDAO.listEduMngCnt");
		super.setListQueryId("CareerManageDAO.listEduMng");
		super.list(paramCtx);
	}
	
	/**
	 * 사업관리 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		
		super.setInsertQueryId("CareerManageDAO.insertEduMng");
		super.insert(paramCtx);
	}
	
	
	/**
	 * 사업관리 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		
		super.setUpdateQueryId("CareerManageDAO.updateEduMng");
		super.update(paramCtx);
	}
	
	/**
	 * 사업관리 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ajaxEduDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		
		super.setUpdateQueryId("CareerManageDAO.deleteEduMng");
		super.update(paramCtx);
	}

}
