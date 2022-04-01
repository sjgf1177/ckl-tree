package kr.co.unp.banner.vo;

public class BannerPagingInfo {


    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 10;
    

    private String searchCondition = "";
    private String searchKeyword = "";

    private String searchVal1 = "";
    private String searchVal2 = "";
    private String searchVal3 = "";
    private String searchVal4 = "";
    private String searchVal5 = "";
    
    
	/**
	 * @return the pageIndex
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * @param pageIndex the pageIndex to set
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * @return the pageUnit
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * @param pageUnit the pageUnit to set
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return the firstIndex
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * @param firstIndex the firstIndex to set
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * @return the lastIndex
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * @param lastIndex the lastIndex to set
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * @return the recordCountPerPage
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * @param recordCountPerPage the recordCountPerPage to set
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	/**
	 * @return the searchCondition
	 */
	public String getSearchCondition() {
		return searchCondition;
	}

	/**
	 * @param searchCondition the searchCondition to set
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	/**
	 * @return the searchKeyword
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * @param searchKeyword the searchKeyword to set
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * @return the searchVal1
	 */
	public String getSearchVal1() {
		return searchVal1;
	}

	/**
	 * @param searchVal1 the searchVal1 to set
	 */
	public void setSearchVal1(String searchVal1) {
		this.searchVal1 = searchVal1;
	}

	/**
	 * @return the searchVal2
	 */
	public String getSearchVal2() {
		return searchVal2;
	}

	/**
	 * @param searchVal2 the searchVal2 to set
	 */
	public void setSearchVal2(String searchVal2) {
		this.searchVal2 = searchVal2;
	}

	/**
	 * @return the searchVal3
	 */
	public String getSearchVal3() {
		return searchVal3;
	}

	/**
	 * @param searchVal3 the searchVal3 to set
	 */
	public void setSearchVal3(String searchVal3) {
		this.searchVal3 = searchVal3;
	}

	/**
	 * @return the searchVal4
	 */
	public String getSearchVal4() {
		return searchVal4;
	}

	/**
	 * @param searchVal4 the searchVal4 to set
	 */
	public void setSearchVal4(String searchVal4) {
		this.searchVal4 = searchVal4;
	}

	/**
	 * @return the searchVal5
	 */
	public String getSearchVal5() {
		return searchVal5;
	}

	/**
	 * @param searchVal5 the searchVal5 to set
	 */
	public void setSearchVal5(String searchVal5) {
		this.searchVal5 = searchVal5;
	}
	
}
