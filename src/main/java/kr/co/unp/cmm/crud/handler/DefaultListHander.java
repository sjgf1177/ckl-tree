package kr.co.unp.cmm.crud.handler;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.util.FileMngUtil;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Service("defaultListHander")
public class DefaultListHander extends ListHandler<ZValue> {

	@Resource(name = "fnwFileMngService")
	protected FnwFileMngService fnwFileMngService;

	@Resource(name = "fileMngUtil")
	protected FileMngUtil fileUtil;

	@Override
	protected PaginationInfo getPaginationInfo(ZValue param) {
		setPageSize(param);
		int pageUnit = param.getInt("pageUnit", 10);
		int pageSize = param.getInt("pageSize", 10);
		int pageIndex = param.getInt("pageIndex", 1);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);
		return paginationInfo;
	}

	@Override
	protected void setPagingParam(PaginationInfo paginationInfo, ZValue param) throws Exception {
		int pageIndex = param.getInt("pageIndex", 1);
		param.put("pageIndex", pageIndex);
		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());
		param.put("totCnt", paginationInfo.getTotalRecordCount());
	}

	@Override
	protected String getPageNavigateString(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		setPageSize(param);
		int pageUnit = param.getInt("pageUnit", 10);
		int pageSize = param.getInt("pageSize", 10);
		int pageIndex = param.getInt("pageIndex", 1);
		int totCnt = param.getInt("totCnt");

		HttpServletRequest request = paramCtx.getRequest();
		String link = param.getString(CmmProgramService.PAGE_LINK);
		if( !StringUtils.hasText(link) ){
			link = request.getRequestURI();
			String pageLinkQueryString = paramCtx.getPageQuery().getPageLinkQueryString(param);
			if( pageLinkQueryString != null )
				link += "?" + pageLinkQueryString;
		}
		return paramCtx.getPageInfo().getPageNavString(pageSize, pageUnit, totCnt, pageIndex, link);
	}

	private void setPageSize(ZValue param) {

	}

	@Override
	public Map<String, List<FileVO>> getFileMap(ZValue zvl, List<ZValue> resultList) throws Exception{
		return getFileMap(zvl, resultList, "atchFileId");
	}

	public Map<String, List<FileVO>> getFileMap(ZValue zvl, List<ZValue> resultList, String fileIdNm) throws Exception{
		Map<String, List<FileVO>> fileMap = Collections.emptyMap();
    	if( CollectionUtils.isNotEmpty(resultList) ){
        	ArrayList<String> _atchFileIdData = new ArrayList<String>();
        	for( ZValue val : resultList ) {
        		if( StringUtils.hasText(val.getString(fileIdNm))) _atchFileIdData.add(val.getString(fileIdNm));
        	}
        	if( CollectionUtils.isNotEmpty(_atchFileIdData) ) {
        		String[] atchFileIdData = _atchFileIdData.toArray(new String[]{""});
        		FileVO fvo = new FileVO();
        		fvo.setAtchFileIdData(atchFileIdData);
        		fileMap = fnwFileMngService.selectArticleFileMap(fvo);
        	}
    	}

    	return fileMap;
	}
}
