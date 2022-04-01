package kr.co.unp.cmm.excel.service.impl;

import jxl.Sheet;

public interface ExcelMapping<T> {

    public T mappingColumn(T param, Sheet sheet, int col) throws Exception;
}
