package kr.co.unp.cmm.crud.service;

import kr.co.unp.cmm.crud.listener.CmmProgramListenerContainer;


public interface CmmProgramService<T> {

	public static final String SITE_NAME = "siteName";
	public static final String PROGRAM_ID = "programId";
	public static final String ATCH_FILE_ID = "atchFileId";
	public static final String RESULT_LIST = "resultList";
	public static final String RESULT = "result";
	public static final String PAGE_LINK = "pageLink";
	public static final String PAGE_QUERY_STRING = "pageQueryString";
	public static final String CACHE_KEY = "cacheKey";

	public void list(ParameterContext<T> paramCtx) throws Exception;

	public void view(ParameterContext<T> paramCtx) throws Exception;

	public void forInsert(ParameterContext<T> paramCtx) throws Exception;

	public void insert(ParameterContext<T> paramCtx) throws Exception;

	public void forUpdate(ParameterContext<T> paramCtx) throws Exception;

	public void update(ParameterContext<T> paramCtx) throws Exception;

	public void delete(ParameterContext<T> paramCtx) throws Exception;

	public void downloadExcel(ParameterContext<T> paramCtx) throws Exception;

	public void uploadExcel(ParameterContext<T> paramCtx) throws Exception;

	public CmmProgramListenerContainer<T> getListenerContainer();

}
