package kr.co.unp.cmm.excel.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import jxl.Sheet;
import jxl.Workbook;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.excel.service.IExcelUploadService;

import org.apache.log4j.Logger;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;

public class ExcelUploadService<T> implements IExcelUploadService<T> {

	Logger log = Logger.getLogger(this.getClass());

	private ExcelMapping<T> mapping;
	private ISqlDAO<T> sqlDao;
	private String initQueryId;
	private String insertQueryId;
	private String procQueryId;
	
	@Resource(name="txManager")
	private PlatformTransactionManager platformTransactionManager;
	
	@Override
	public Integer uploadExcel(T param, InputStream is) throws Exception {
		return uploadExcel(param, is, 1, 0);
	}

	@Override
	public Integer uploadExcel(T param, InputStream is, int start, long commitCnt) throws Exception {
		Workbook workbook = Workbook.getWorkbook(is);
		Sheet sheet = workbook.getSheet(0);

        Integer rowsAffected = 0;
        DefaultTransactionDefinition paramTransactionDefinition = new DefaultTransactionDefinition();
        TransactionStatus status = platformTransactionManager.getTransaction(paramTransactionDefinition );
        try {
        	//초기화
        	initJob(param);

            long rowCnt = sheet.getColumn(0).length;
            long cnt = (commitCnt == 0) ? rowCnt : commitCnt;

            log.debug("Runtime.getRuntime().totalMemory() : " + Runtime.getRuntime().totalMemory());
            log.debug("Runtime.getRuntime().freeMemory() : " + Runtime.getRuntime().freeMemory());

            long startTime = System.currentTimeMillis();

            List<T> list = new ArrayList<T>();

            for (int idx = start, i = start; idx < rowCnt; idx = i) {

                log.debug("before Runtime.getRuntime().freeMemory() : " + Runtime.getRuntime().freeMemory());
                ExcelMapping<T> mapping = getMapping();
                for (i = idx; i < rowCnt && i < (cnt + idx); i++) {

                	T t = mapping.mappingColumn(param, sheet, i);
                	log.debug(t);
                	processPerRow(t);
                	list.add(t);
                }

                //배치작업
                rowsAffected = processBatchJob(list);

                log.debug("after Runtime.getRuntime().freeMemory() : " + Runtime.getRuntime().freeMemory());
                log.debug("\n\n\n" + rowsAffected);
            }

            log.debug("batchInsert time is " + (System.currentTimeMillis() - startTime));
            platformTransactionManager.commit(status);
        } catch (Exception e) {
        	e.printStackTrace();
        	platformTransactionManager.rollback(status);
            throw new Exception(e);
        }

        return rowsAffected;

	}

	protected void initJob(T param) throws Exception {
		if( StringUtils.hasText(getInitQueryId()) ) {
			getSqlDao().deleteDAO(getInitQueryId(), param);
		}
	}
	
	protected void processPerRow(T val) throws Exception { 
		if( StringUtils.hasText(getInsertQueryId()) ) {
			getSqlDao().insertDAO(getInsertQueryId(), val);
		}
	}

	protected Integer processBatchJob(List<T> list) throws Exception {
		if( StringUtils.hasText(getProcQueryId()) ) {
			return getSqlDao().batchInsert(getProcQueryId(), list);
		}
		return 0;
	}

	public String getInitQueryId() {
		return initQueryId;
	}

	public void setInitQueryId(String initQueryId) {
		this.initQueryId = initQueryId;
	}

	public String getInsertQueryId() {
		return insertQueryId;
	}

	public void setInsertQueryId(String insertQueryId) {
		this.insertQueryId = insertQueryId;
	}

	public String getProcQueryId() {
		return procQueryId;
	}

	public void setProcQueryId(String procQueryId) {
		this.procQueryId = procQueryId;
	}

	public ISqlDAO<T> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<T> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public ExcelMapping<T> getMapping() {
		return mapping;
	}

	public void setMapping(ExcelMapping<T> mapping) {
		this.mapping = mapping;
	}

}
