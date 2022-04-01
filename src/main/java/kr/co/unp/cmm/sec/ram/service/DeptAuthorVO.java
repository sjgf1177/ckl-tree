package kr.co.unp.cmm.sec.ram.service;

import java.util.List;

/**
 * 부서권한에 대한 Vo 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *
 * </pre>
 */

public class DeptAuthorVO extends DeptAuthor {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 부서권한목록
	 */
	List <DeptAuthorVO> deptAuthorList;
	/**
	 * 부서목록
	 */
	List <DeptAuthorVO> deptList;	
	/**
	 * 부서코드
	 */
	private String deptCode = "";
	/**
	 * 부서 명
	 */
	private String deptNm = "";
	
	private String deptLevel = "";
	
	private String larCd = "";
	private String midCd = "";
	private String smCd = "";
	private String larNm = "";
	private String midNm = "";
	private String smNm = "";
	private String gookName = "";
	private String gwaName = "";
	private String teamName = "";
	private String searchCnd = "";
	private String searchWrd = "";
	
	private int totalRows = 0;
	
	public String getGookName() {
		return gookName;
	}
	public void setGookName(String gookName) {
		this.gookName = gookName;
	}
	public String getGwaName() {
		return gwaName;
	}
	public void setGwaName(String gwaName) {
		this.gwaName = gwaName;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	
	public String getSearchCnd() {
		return searchCnd;
	}
	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}
	public String getSearchWrd() {
		return searchWrd;
	}
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}
	public String getLarNm() {
		return larNm;
	}
	public void setLarNm(String larNm) {
		this.larNm = larNm;
	}
	public String getMidNm() {
		return midNm;
	}
	public void setMidNm(String midNm) {
		this.midNm = midNm;
	}
	public String getSmNm() {
		return smNm;
	}
	public void setSmNm(String smNm) {
		this.smNm = smNm;
	}
	public String getLarCd() {
		return larCd;
	}
	public void setLarCd(String larCd) {
		this.larCd = larCd;
	}
	public String getMidCd() {
		return midCd;
	}
	public void setMidCd(String midCd) {
		this.midCd = midCd;
	}
	public String getSmCd() {
		return smCd;
	}
	public void setSmCd(String smCd) {
		this.smCd = smCd;
	}
	public String getDeptLevel() {
		return deptLevel;
	}
	public void setDeptLevel(String deptLevel) {
		this.deptLevel = deptLevel;
	}
	/**
	 * deptAuthorList attribute 를 리턴한다.
	 * @return List<DeptAuthorVO>
	 */
	public List<DeptAuthorVO> getDeptAuthorList() {
		return deptAuthorList;
	}
	/**
	 * deptAuthorList attribute 값을 설정한다.
	 * @param deptAuthorList List<DeptAuthorVO> 
	 */
	public void setDeptAuthorList(List<DeptAuthorVO> deptAuthorList) {
		this.deptAuthorList = deptAuthorList;
	}
	/**
	 * deptList attribute 를 리턴한다.
	 * @return List<DeptAuthorVO>
	 */
	public List<DeptAuthorVO> getDeptList() {
		return deptList;
	}
	/**
	 * deptList attribute 값을 설정한다.
	 * @param deptList List<DeptAuthorVO> 
	 */
	public void setDeptList(List<DeptAuthorVO> deptList) {
		this.deptList = deptList;
	}
	/**
	 * deptCode attribute 를 리턴한다.
	 * @return String
	 */
	public String getDeptCode() {
		return deptCode;
	}
	/**
	 * deptCode attribute 값을 설정한다.
	 * @param deptCode String 
	 */
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	/**
	 * deptNm attribute 를 리턴한다.
	 * @return String
	 */
	public String getDeptNm() {
		return deptNm;
	}
	/**
	 * deptNm attribute 값을 설정한다.
	 * @param deptNm String 
	 */
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	
}