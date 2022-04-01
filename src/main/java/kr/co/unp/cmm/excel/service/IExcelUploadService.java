package kr.co.unp.cmm.excel.service;

import java.io.InputStream;

import egovframework.rte.fdl.cmmn.exception.BaseException;

public interface IExcelUploadService<T> {

	public Integer uploadExcel(T t, InputStream is) throws BaseException, Exception;

	public Integer uploadExcel(T t, InputStream is, int start, long commitCnt) throws BaseException, Exception;
}
