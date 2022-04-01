package kr.co.unp.cmm.view.vo;

import java.util.List;

public class ExcelGenerateVO  {


	private String   excelFileName = "";
	private String[] title = null;
	private List<?> dataList = null;

	/**
	 * 엑셀에 필요한 데이터를 받는다.
	 * @param excelFileName
	 * @param title
	 * @param dataList
	 */
	public ExcelGenerateVO(String excelFileName, String[] title, List<?> dataList) {
		this.excelFileName = excelFileName;
		this.title = title;
		this.dataList = dataList;
	}

	public String getExcelFileName() {
		return excelFileName;
	}

	public String[] getTitle() {
		return title;
	}

	public List<?> getDataList() {
		return dataList;
	}

}
