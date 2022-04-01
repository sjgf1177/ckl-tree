package kr.co.unp.cmm.crud.config.xml;

import kr.co.unp.bbs.accessor.ArticleAccessor;
import kr.co.unp.cmm.crud.handler.ListHandler;
import kr.co.unp.cmm.crud.listener.CmmProgramListener;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerContainer;
import kr.co.unp.cmm.crud.paging.IPageInfo;
import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.excel.service.IExcelUploadService;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.util.ZValue;

import org.springframework.beans.factory.config.AbstractFactoryBean;
/**
 * 
 * @author KHD
 *
 */
public class CmmProgramParserCpFactoryBean<T extends DefaultCmmProgramService> extends AbstractFactoryBean<DefaultCmmProgramService> {

	private ISqlDAO<ZValue> sqlDao;

	private FnwFileMngService fileMngService;

	private String listQueryId;
	private String countQueryId;
	private String viewQueryId;
	private String insertQueryId;
	private String updateQueryId;
	private String deleteQueryId;
	private String excelQueryId;

	private IExcelUploadService<ZValue> excelUploadService;
	
	private ListHandler<ZValue> listHandler;

	private IPageInfo pageInfo;
	private PageQuery<ZValue> pageQuery;

	private CmmProgramListener<ZValue>[] listeners;
	
	private CmmProgramListenerContainer<ZValue>[] listenerContainers;

	private DefaultCmmProgramService targetObject;
	
	private ArticleAccessor<ZValue> accessor;

	@Override
	public Class<? extends DefaultCmmProgramService> getObjectType() {
		return DefaultCmmProgramService.class;
	}

	@Override
	protected DefaultCmmProgramService createInstance() {
		DefaultCmmProgramService service = getService();
		setProperties(service);
		if( accessor != null ){
			service.setAccessor(accessor);
		}
		return service;
	}
	
	protected void setProperties(DefaultCmmProgramService service) {
		if( sqlDao != null ){
			service.setSqlDao(sqlDao);
		}
		if( fileMngService != null ){
			service.setFnwFileMngService(fileMngService);
		}
		if( countQueryId != null ){
			service.setCountQueryId(countQueryId);
		}
		if( listQueryId != null ){
			service.setListQueryId(listQueryId);
		}
		if( viewQueryId != null ){
			service.setViewQueryId(viewQueryId);
		}
		if( insertQueryId != null ){
			service.setInsertQueryId(insertQueryId);
		}
		if( updateQueryId != null ){
			service.setUpdateQueryId(updateQueryId);
		}
		if( deleteQueryId != null ){
			service.setDeleteQueryId(deleteQueryId);
		}
		if( excelQueryId != null ){
			service.setExcelQueryId(excelQueryId);
		}
		if( excelUploadService != null ){
			service.setExcelUploadService(excelUploadService);
		}
		if( listHandler != null ){
			service.setListHandler(listHandler);
		}
		if( pageInfo != null ){
			service.setPageInfo(pageInfo);
		}
		if( pageQuery != null ){
			service.setPageQuery(pageQuery);
		}
		if( listenerContainers != null ){
			service.setListenerContainers(listenerContainers);
		}
	}
	
	protected DefaultCmmProgramService getService(){
		DefaultCmmProgramService service = null;
		if (this.targetObject != null) {
			service = (DefaultCmmProgramService)targetObject;
		}
		else {
			service = new DefaultCmmProgramService();
		}
		return service;
	}

	public DefaultCmmProgramService getTargetObject() {
		return targetObject;
	}

	public void setTargetObject(DefaultCmmProgramService targetObject) {
		this.targetObject = targetObject;
	}

	public ISqlDAO<ZValue> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<ZValue> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public FnwFileMngService getFileMngService() {
		return fileMngService;
	}

	public void setFileMngService(FnwFileMngService fileMngService) {
		this.fileMngService = fileMngService;
	}

	public String getListQueryId() {
		return listQueryId;
	}

	public void setListQueryId(String listQueryId) {
		this.listQueryId = listQueryId;
	}

	public String getCountQueryId() {
		return countQueryId;
	}

	public void setCountQueryId(String countQueryId) {
		this.countQueryId = countQueryId;
	}

	public String getViewQueryId() {
		return viewQueryId;
	}

	public void setViewQueryId(String viewQueryId) {
		this.viewQueryId = viewQueryId;
	}

	public String getInsertQueryId() {
		return insertQueryId;
	}

	public void setInsertQueryId(String insertQueryId) {
		this.insertQueryId = insertQueryId;
	}

	public String getUpdateQueryId() {
		return updateQueryId;
	}

	public void setUpdateQueryId(String updateQueryId) {
		this.updateQueryId = updateQueryId;
	}

	public String getDeleteQueryId() {
		return deleteQueryId;
	}

	public void setDeleteQueryId(String deleteQueryId) {
		this.deleteQueryId = deleteQueryId;
	}

	public String getExcelQueryId() {
		return excelQueryId;
	}

	public void setExcelQueryId(String excelQueryId) {
		this.excelQueryId = excelQueryId;
	}

	public IExcelUploadService<ZValue> getExcelUploadService() {
		return excelUploadService;
	}

	public void setExcelUploadService(IExcelUploadService<ZValue> excelUploadService) {
		this.excelUploadService = excelUploadService;
	}

	public ListHandler<ZValue> getListHandler() {
		return listHandler;
	}

	public void setListHandler(ListHandler<ZValue> listHandler) {
		this.listHandler = listHandler;
	}

	public IPageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(IPageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public PageQuery<ZValue> getPageQuery() {
		return pageQuery;
	}

	public void setPageQuery(PageQuery<ZValue> pageQuery) {
		this.pageQuery = pageQuery;
	}

	public CmmProgramListener<ZValue>[] getListeners() {
		return listeners;
	}

	public void setListeners(CmmProgramListener<ZValue>[] listeners) {
		this.listeners = listeners;
	}

	public CmmProgramListenerContainer<ZValue>[] getListenerContainers() {
		return listenerContainers;
	}

	public void setListenerContainers(CmmProgramListenerContainer<ZValue>[] listenerContainers) {
		this.listenerContainers = listenerContainers;
	}

	public ArticleAccessor<ZValue> getAccessor() {
		return accessor;
	}

	public void setAccessor(ArticleAccessor<ZValue> accessor) {
		this.accessor = accessor;
	}
	
}
