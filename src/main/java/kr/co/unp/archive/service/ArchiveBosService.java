package kr.co.unp.archive.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import kr.co.unp.archive.paging.ArchivePageQuery;
import kr.co.unp.archive.paging.ArchiveProjectPageQuery;
import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

public class ArchiveBosService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "siteMngService")
	protected SiteMngService siteMngService;
	
	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;
	
	@Resource(name = "pageInfo")
	private PageInfo pageInfo;
	
	public ArchiveBosService() {
		
	}
	
	// 과정 화면
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		
		paramCtx.setPageQuery(new ArchivePageQuery());

		ZValue param   = paramCtx.getParam();
		// ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setCountQueryId("archiveBosDAO.selectArchiveListTotCnt");
		super.setListQueryId("archiveBosDAO.list");
		super.list(paramCtx);
	}
	
	// 과정 상세
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String sqlUrl = "";
		String deptAt = param.getString("deptAt");
		
		// 프로젝트 일련번호가 있을경우 프로젝트 상세로 이동.
		if(deptAt.equals("Y")){
			sqlUrl = "archiveBosDAO.projectListDetail";
		}else {
			sqlUrl = "archiveBosDAO.listDetail";
		}
		
		ZValue result = sqlDao.selectDAO(sqlUrl, param);
		
		String atchFileId = result.getString("atchFileId");
		
		// 첨부파일을 가져온다.
		if (StringUtils.hasText(atchFileId)) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			
			List<FileVO> fileList = fnwFileMngService.selectFileInfs(fileVO);
			
			model.addAttribute("fileList"   , fileList);
			model.addAttribute("fileListCnt", fileList.size());
		}
		
    	model.addAttribute("result", result);
	}

	// 과정  등록 화면
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		
		List<ZValue> resultList = sqlDao.listDAO("archiveBosDAO.list", param);
		super.forInsert(paramCtx);
		model.addAttribute("resultList", resultList);
	}

	// 과정 등록 로직
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		param.put("frstRegisterId", user.getUserId());    
		
		super.setInsertQueryId("archiveBosDAO.insert");
		super.insert(paramCtx);
	
	}

	// 과정  수정 화면
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		/*super.setViewQueryId("archiveBosDAO.list");
		super.forUpdate(paramCtx);*/

		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		param.put("frstRegisterId", user.getUserId());   
		param.put("lastUpdusrId", user.getUserId()); 
		
		super.setViewQueryId("archiveBosDAO.list");
		super.forUpdate(paramCtx);
	}

	// 과정 수정 로직
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		param.put("frstRegisterId", user.getUserId());   
		param.put("lastUpdusrId", user.getUserId()); 
		
		super.setUpdateQueryId("archiveBosDAO.update");
		super.update(paramCtx);
		
		String goUrl = "/bos/archive/list.do?&menuNo=" + param.getString("menuNo") + "&" + "&pageIndex=" + param.getString("pageIndex") + "&" + StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		MVUtils.goUrl(goUrl, "정상적으로 등록되었습니다.", model);
		
	}

	// 과정 삭제 
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		
		super.setDeleteQueryId("archiveBos.delete");
		super.delete(paramCtx);

	}

// ************************************************************************************************ // 

	// 프로젝트 리스트 화면
	public void deptList(ParameterContext<ZValue> paramCtx) throws Exception {
		
		paramCtx.setPageQuery(new ArchiveProjectPageQuery());
		
		ZValue param   = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		super.setCountQueryId("archiveBosDAO.projectListCnt");
		super.setListQueryId("archiveBosDAO.projectList");
		super.list(paramCtx);
		
		// 과제 정보를 가져온다.
		List<ZValue> taskList   = sqlDao.listDAO("archiveBosDAO.taskProjectList", param);
		model.addAttribute("taskList", taskList);
		
	}

	// 프로젝트 수정 화면
	public void deptListForUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		param.put("frstRegisterId", user.getUserId());   
		param.put("lastUpdusrId", user.getUserId()); 
		
		super.setViewQueryId("archiveBosDAO.projectList");
		super.forUpdate(paramCtx);
	}
	
	// 프로젝트 수정 로직
	public void deptListUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param   = paramCtx.getParam();
		UsersVO user   = UnpUserDetailsHelper.getAuthenticatedUser();
		ModelMap model = paramCtx.getModel();
		
		param.put("frstRegisterId", user.getUserId());   
		param.put("lastUpdusrId", user.getUserId()); 
		
		super.setUpdateQueryId("archiveBosDAO.projectUpdate");
		super.update(paramCtx);
		
		String goUrl = "/bos/archive/deptList.do?taskSeq=" + param.getString("archiveTaskSeq") + "&menuNo=" + param.getString("menuNo") + "&" + "&pageIndex=" + param.getString("pageIndex") + "&" + StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		MVUtils.goUrl(goUrl, "정상적으로 등록되었습니다.", model);
	}
	
	// 프로젝트 등록 화면
	public void deptListForInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		
		super.initCmmnParam(param);
		super.forInsert(paramCtx);
		
		List<ZValue> resultList = sqlDao.listDAO("archiveBosDAO.projectList", param);
		model.addAttribute("resultList", resultList);
	}

	// 프로젝트 등록 로직 
	public void deptListInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param   = paramCtx.getParam();
		UsersVO user   = UnpUserDetailsHelper.getAuthenticatedUser();
		ModelMap model = paramCtx.getModel();
		
		param.put("frstRegisterId", user.getUserId());    
		
		super.setInsertQueryId("archiveBosDAO.projectInsert");
		super.insert(paramCtx);
		
		String goUrl = "/bos/archive/deptList.do?taskSeq=" + param.getString("archiveTaskSeq") + "&menuNo=" + param.getString("menuNo") + "&" + StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		MVUtils.goUrl(goUrl, "정상적으로 등록되었습니다.", model);
	}

	// 프로젝트 상세
	public void deptListView(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.selectDAO("archiveBosDAO.projectListDetail", param);

		model.addAttribute("result", result);
    	model.addAttribute(PAGE_QUERY_STRING, pageQuery.getPageQueryString(param));
	}
	
	// 프로젝트 삭제 
	public void deptListDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param   = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		super.setDeleteQueryId("archiveBos.projectDelete");
		super.delete(paramCtx);

		String goUrl = "/bos/archive/deptList.do?taskSeq=" + param.getString("archiveTaskSeq") + "&menuNo=" + param.getString("menuNo") + "&" + StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		MVUtils.goUrl(goUrl, "정상적으로 삭제되었습니다.", model);
		
	}

}
