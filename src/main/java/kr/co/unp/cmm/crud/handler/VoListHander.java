package kr.co.unp.cmm.crud.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.util.FileMngUtil;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("voListHandler")
public class VoListHander<T extends SearchVO> extends ListHandler<T>{

	@Resource(name = "fnwFileMngService")
	protected FnwFileMngService fnwFileMngService;

	@Resource(name = "fileMngUtil")
	protected FileMngUtil fileUtil;

	@Override
	protected PaginationInfo getPaginationInfo(T param) {
		int pageUnit = param.getPageUnit();
		int pageSize = param.getPageSize();
		int pageIndex = param.getPageIndex();

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);
		return paginationInfo;
	}

	@Override
	protected void setPagingParam(PaginationInfo paginationInfo, T param) throws Exception {
		param.setFirstIndex(paginationInfo.getFirstRecordIndex());
		param.setLastIndex(paginationInfo.getLastRecordIndex());
		param.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		param.setTotCnt(paginationInfo.getTotalRecordCount());
	}

	@Override
	protected String getPageNavigateString(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		int pageUnit = param.getPageUnit();
		int pageSize = param.getPageSize();
		int pageIndex = param.getPageIndex();
		int totCnt = param.getTotCnt();

		HttpServletRequest request = paramCtx.getRequest();
		String link = request.getRequestURI();
		String pageLinkQueryString = paramCtx.getPageQuery().getPageLinkQueryString(param);
		if( pageLinkQueryString != null )
			link += "?" + pageLinkQueryString;
		return paramCtx.getPageInfo().getPageNavString(pageSize, pageUnit, totCnt, pageIndex, link);
	}

	@Override
	public Map<String, List<FileVO>> getFileMap(T param, List<T> resultList) throws Exception{
		Map<String, List<FileVO>> fileMap = null;
    	if( CollectionUtils.isNotEmpty(resultList) ){
        	ArrayList<String> _atchFileIdData = new ArrayList<String>();
        	for( T val : resultList ) {
        		if( StringUtils.hasText(val.getAtchFileId())) _atchFileIdData.add(val.getAtchFileId());
        	}
        	if( CollectionUtils.isNotEmpty(_atchFileIdData) ) {
        		String[] atchFileIdData = _atchFileIdData.toArray(new String[]{""});
        		FileVO fvo = new FileVO();
        		fvo.setTableNm(param.getTableNm());
        		fvo.setAtchFileIdData(atchFileIdData);
        		fileMap = fnwFileMngService.selectArticleFileMap(fvo);
        	}
    	}

    	return fileMap;
	}

	@Override
	public Map<String, List<FileVO>> getFileMap(T param, List<T> resultList, String fileIdNm) throws Exception {
		return null;
	}

}
