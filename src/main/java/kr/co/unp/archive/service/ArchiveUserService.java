package kr.co.unp.archive.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.unp.cmm.crud.handler.DefaultListHander;
import kr.co.unp.cmm.crud.paging.DefaultPageQuery;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

public class ArchiveUserService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "siteMngService")
	protected SiteMngService siteMngService;
	
	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;
	
	@Resource(name = "pageInfo")
	private PageInfo pageInfo;
	
	 @Resource(name = "defaultListHander")
    protected DefaultListHander defaultListHander;
	
	public ArchiveUserService() {
		super();
	}
	
	// 주요성과 리스트
	@Override
 	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param     = paramCtx.getParam();
		ModelMap model   = paramCtx.getModel();
		String workField = param.getString("workField");
		// UsersVO user     = UnpUserDetailsHelper.getAuthenticatedUser();
		
		// param.put("userid"   , user.getUserId());
		param.put("workField", workField);
		param.put("pageUnit" , "12"); // 목록 갯수

		initCmmnParam(param);
		
		super.setListQueryId("archiveDAO.mainResultList");
		super.setCountQueryId("archiveDAO.mainResultListCnt");
		
		// paramCtx.setSqlDAO(lmsSqlDao);
		paramCtx.setPageQuery(new DefaultPageQuery());
		super.list(paramCtx);
	}
	 
	 /**
	  * 프로젝트 상세 팝업(ajax)
	  * @param paramCtx
	  * @throws Exception
	  */
	 public void ajaxProjectDetail(ParameterContext<ZValue> paramCtx) throws Exception {
	  ZValue param   = paramCtx.getParam();
	  ModelMap model = paramCtx.getModel();
	  ZValue projectDetail = null;
	  
	  try{
	   // 프로젝트 상세정보
	   projectDetail = sqlDao.selectDAO("archiveDAO.ajaxProjectDetail", param);
	   
	  }catch(Exception e){
	   e.printStackTrace();
	  }
	  model.addAttribute("projectDetail", projectDetail);
	 }
	
	//  리스트
		public void contentsList(ParameterContext<ZValue> paramCtx) throws Exception {
			
			ZValue param     = paramCtx.getParam();
			ModelMap model   = paramCtx.getModel();
			String workField = param.getString("workField");
			// UsersVO user     = UnpUserDetailsHelper.getAuthenticatedUser();
			
			// param.put("userid"   , user.getUserId());
			param.put("workField", workField);
			param.put("pageUnit" , "12"); // 목록 갯수

			initCmmnParam(param);
			
			super.setListQueryId("archiveDAO.list");
			super.setCountQueryId("archiveDAO.listCnt");
			
			// paramCtx.setSqlDAO(lmsSqlDao);
			paramCtx.setPageQuery(new DefaultPageQuery());
			super.list(paramCtx);

		}
		
		
		// 실감상세
		public void contentsDeptList(ParameterContext<ZValue> paramCtx) throws Exception {
			ZValue param = paramCtx.getParam();
			ModelMap model = paramCtx.getModel();
			
			String workField = param.getString("workField");
			param.put("workField", workField);
			
			initCmmnParam(param);
			
			List<ZValue> taskList = sqlDao.listDAO("archiveDAO.taskDetail", param);
			model.addAttribute("taskList",taskList);
			
			super.setListQueryId("archiveDAO.projectList");
			super.setCountQueryId("archiveDAO.projectListCnt");
			
			// paramCtx.setSqlDAO(lmsSqlDao); 
			super.list(paramCtx);
			
			
		}
	
}
