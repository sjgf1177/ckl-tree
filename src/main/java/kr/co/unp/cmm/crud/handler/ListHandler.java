package kr.co.unp.cmm.crud.handler;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;

import org.springframework.ui.ModelMap;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public abstract class ListHandler<T> implements Handler<T> {

	@Resource(name = "SqlDAO")
	protected ISqlDAO<T> sqlDao;

	@Override
	public boolean invoke(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		int totCnt = getListCount(paramCtx);
		model.addAttribute("resultCnt", totCnt);

		PaginationInfo paginationInfo = getPaginationInfo(param);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		setPagingParam(paginationInfo, param);

		List<T> resultList = getResultList(paramCtx);
		model.addAttribute("resultList", resultList);

    	Map<String, List<FileVO>> fileMap = getFileMap(param, resultList);
		model.addAttribute("fileMap", fileMap);

		String pageNav = getPageNavigateString(paramCtx);
		model.addAttribute("pageNav", pageNav);

		model.addAttribute("pageQueryString", paramCtx.getPageQuery().getPageQueryString(param));

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
    	model.addAttribute("user", user);

    	return CONTINUE;
	}

	public abstract Map<String, List<FileVO>> getFileMap(T param, List<T> resultList) throws Exception;

	public abstract Map<String, List<FileVO>> getFileMap(T param, List<T> resultList, String fileIdNm) throws Exception;

	protected abstract PaginationInfo getPaginationInfo(T param);

	protected abstract void setPagingParam(PaginationInfo paginationInfo, T param) throws Exception;

	protected List<T> getResultList(ParameterContext<T> paramCtx) throws Exception{
		return sqlDao.listDAO(paramCtx.getQueryIdVO().getListQueryId(), paramCtx.getParam());
	}

	protected int getListCount(ParameterContext<T> paramCtx) throws Exception{
		return sqlDao.selectCount(paramCtx.getQueryIdVO().getCountQueryId(), paramCtx.getParam());
	}

	protected abstract String getPageNavigateString(ParameterContext<T> paramCtx) throws Exception;

	public ISqlDAO<T> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<T> sqlDao) {
		this.sqlDao = sqlDao;
	}

}
