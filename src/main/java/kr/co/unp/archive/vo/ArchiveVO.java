package kr.co.unp.archive.vo;

import java.util.Date;

import kr.co.unp.bbs.vo.SearchVO;

public class ArchiveVO extends SearchVO{

	private static final long serialVersionUID = -1522696123591606320L;
	public static int PORTAL_DISPLAY_CNT = 4;
	public static int HEALTH_DISPLAY_CNT = 6;
	public static int COUNCIL_DISPLAY_CNT = 3;
	public static int DONG_DISPLAY_CNT = 100000;
	public static int DEPT_DISPLAY_CNT = 3;

	public static int ENGLISH_DISPLAY_CNT = 8;
	public static int CHINA_DISPLAY_CNT = 8;
	public static int JAPAN_DISPLAY_CNT = 8;
	private int currentSize = 0;
	  /** 검색시작일 */
    private String sdate = "";

    /** 검색조건 */
    private String searchCnd = "";

    /** 검색종료일 */
    private String edate = "";

    /** 검색단어 */
    private String searchWrd = "";

    /** 정렬순서(DESC,ASC) */
    private String sortOrdr = "";

    /** 검색사용여부 */
    private String searchUseYn = "";

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;

    /** rowNo */
    private int rowNo = 0;
    
    /** 현재페이지 */
    private int projectPageIndex = 1;

    /** 페이지갯수 */
    private int projectPageUnit = 10;

    /** 페이지사이즈 */
    private int projectPageSize = 10;

    /** firstIndex */
    private int projectFirstIndex = 1;

    /** lastIndex */
    private int projectLastIndex = 1;

    /** recordCountPerPage */
    private int projectRecordCountPerPage = 10;

    /** rowNo */
    private int projectRowNo = 0;
    
    //=======================================================================
    /** 현재페이지 */
    private int userPageIndex = 1;

    /** 페이지갯수 */
    private int userPageUnit = 10;

    /** 페이지사이즈 */
    private int userPageSize = 10;

    /** firstIndex */
    private int userFirstIndex = 1;

    /** lastIndex */
    private int userLastIndex = 1;

    /** recordCountPerPage */
    private int userRecordCountPerPage = 10;

    /** rowNo */
    private int userRowNo = 0;
    
	// 과제 
	private String taskSeq ="";
	private String archiveTaskSeq = "";
	private String year = "";
	private String workField = "";
	private String organNm ="";
	private String taskNm ="";
	private String archiveField1 = "";
	private String archiveField2 = "";
	private String archiveField3 = "";
	private String archiveFieldEtc1 = "";
	private String archiveFieldEtc2 = "";
	private String archiveFieldEtc3 = "";
	private String archiveFieldFullName ="";
	private String taskSummary = "";
	private String atchFileId = "";
	private String useAt = "";
	private String userNm = "";
	private String frstRegisterId = "";
	private Date firstDate = new Date();
	private String firstUpdateId = "";
	private Date firstUpdateDate = new Date();
	private String file1_cn = "";
	private String file2_cn = "";
	private String projectCnt ="";
	public int visible_cnt = 1;
	public int orderly = 0;
	
	// 프로젝트 
	private String archiveProjectSeq = "";
	private String expert = "";
	private String students = "";
	private String projectSummary = "";
	private String projectNm = "";
	private String resultVideo = "http://";
	private String resultURL = "http://";
	private String mainResultAt = "";
	private String projectUseAt = "";
	private String openAt = "";
	private String resultImg = "";
	private String resultEtcFile = "";
	private String userNm1 = "";
	private String projectFrstRegisterId = "";
	private Date projectFirstDate = new Date();
	private String projectFirstUpdateId = "";
	private Date projectFirstUpdateDate = new Date();

	public String getTaskSeq() {
		return taskSeq;
	}
	public void setTaskSeq(String taskSeq) {
		this.taskSeq = taskSeq;
	}
	public String getArchiveTaskSeq() {
		return archiveTaskSeq;
	}
	public void setArchiveTaskSeq(String archiveTaskSeq) {
		this.archiveTaskSeq = archiveTaskSeq;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getWorkField() {
		return workField;
	}
	public void setWorkField(String workField) {
		this.workField = workField;
	}
	public String getOrganNm() {
		return organNm;
	}
	public void setOrganNm(String organNm) {
		this.organNm = organNm;
	}
	public String getTaskNm() {
		return taskNm;
	}
	public void setTaskNm(String taskNm) {
		this.taskNm = taskNm;
	}
	public String getArchiveField1() {
		return archiveField1;
	}
	public void setArchiveField1(String archiveField1) {
		this.archiveField1 = archiveField1;
	}
	public String getArchiveField2() {
		return archiveField2;
	}
	public void setArchiveField2(String archiveField2) {
		this.archiveField2 = archiveField2;
	}
	public String getArchiveField3() {
		return archiveField3;
	}
	public void setArchiveField3(String archiveField3) {
		this.archiveField3 = archiveField3;
	}
	public String getArchiveFieldEtc1() {
		return archiveFieldEtc1;
	}
	public void setArchiveFieldEtc1(String archiveFieldEtc1) {
		this.archiveFieldEtc1 = archiveFieldEtc1;
	}
	public String getArchiveFieldEtc2() {
		return archiveFieldEtc2;
	}
	public void setArchiveFieldEtc2(String archiveFieldEtc2) {
		this.archiveFieldEtc2 = archiveFieldEtc2;
	}
	public String getArchiveFieldEtc3() {
		return archiveFieldEtc3;
	}
	public void setArchiveFieldEtc3(String archiveFieldEtc3) {
		this.archiveFieldEtc3 = archiveFieldEtc3;
	}
	public String getTaskSummary() {
		return taskSummary;
	}
	public void setTaskSummary(String taskSummary) {
		this.taskSummary = taskSummary;
	}
	public String getAtchFileId() {
		return atchFileId;
	}
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getFrstRegisterId() {
		return frstRegisterId;
	}
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}
	public Date getFirstDate() {
		return firstDate;
	}
	public void setFirstDate(Date firstDate) {
		this.firstDate = firstDate;
	}
	public String getFirstUpdateId() {
		return firstUpdateId;
	}
	public void setFirstUpdateId(String firstUpdateId) {
		this.firstUpdateId = firstUpdateId;
	}
	public Date getFirstUpdateDate() {
		return firstUpdateDate;
	}
	public void setFirstUpdateDate(Date firstUpdateDate) {
		this.firstUpdateDate = firstUpdateDate;
	}
	public String getFile1_cn() {
		return file1_cn;
	}
	public void setFile1_cn(String file1_cn) {
		this.file1_cn = file1_cn;
	}
	public String getFile2_cn() {
		return file2_cn;
	}
	public void setFile2_cn(String file2_cn) {
		this.file2_cn = file2_cn;
	}
	public String getProjectCnt() {
		return projectCnt;
	}
	public void setProjectCnt(String projectCnt) {
		this.projectCnt = projectCnt;
	}
	public int getVisible_cnt() {
		return visible_cnt;
	}
	public void setVisible_cnt(int visible_cnt) {
		this.visible_cnt = visible_cnt;
	}
	public int getOrderly() {
		return orderly;
	}
	public void setOrderly(int orderly) {
		this.orderly = orderly;
	}
	public String getArchiveProjectSeq() {
		return archiveProjectSeq;
	}
	public void setArchiveProjectSeq(String archiveProjectSeq) {
		this.archiveProjectSeq = archiveProjectSeq;
	}
	public String getExpert() {
		return expert;
	}
	public void setExpert(String expert) {
		this.expert = expert;
	}
	public String getStudents() {
		return students;
	}
	public void setStudents(String students) {
		this.students = students;
	}
	public String getProjectSummary() {
		return projectSummary;
	}
	public void setProjectSummary(String projectSummary) {
		this.projectSummary = projectSummary;
	}
	public String getProjectNm() {
		return projectNm;
	}
	public void setProjectNm(String projectNm) {
		this.projectNm = projectNm;
	}
	public String getResultVideo() {
		return resultVideo;
	}
	public void setResultVideo(String resultVideo) {
		this.resultVideo = resultVideo;
	}
	public String getResultURL() {
		return resultURL;
	}
	public void setResultURL(String resultURL) {
		this.resultURL = resultURL;
	}
	public String getMainResultAt() {
		return mainResultAt;
	}
	public void setMainResultAt(String mainResultAt) {
		this.mainResultAt = mainResultAt;
	}
	public String getProjectUseAt() {
		return projectUseAt;
	}
	public void setProjectUseAt(String projectUseAt) {
		this.projectUseAt = projectUseAt;
	}
	public String getOpenAt() {
		return openAt;
	}
	public void setOpenAt(String openAt) {
		this.openAt = openAt;
	}
	public String getResultImg() {
		return resultImg;
	}
	public void setResultImg(String resultImg) {
		this.resultImg = resultImg;
	}
	public String getResultEtcFile() {
		return resultEtcFile;
	}
	public void setResultEtcFile(String resultEtcFile) {
		this.resultEtcFile = resultEtcFile;
	}
	public String getUserNm1() {
		return userNm1;
	}
	public void setUserNm1(String userNm1) {
		this.userNm1 = userNm1;
	}
	public String getProjectFrstRegisterId() {
		return projectFrstRegisterId;
	}
	public void setProjectFrstRegisterId(String projectFrstRegisterId) {
		this.projectFrstRegisterId = projectFrstRegisterId;
	}
	public Date getProjectFirstDate() {
		return projectFirstDate;
	}
	public void setProjectFirstDate(Date projectFirstDate) {
		this.projectFirstDate = projectFirstDate;
	}
	public String getProjectFirstUpdateId() {
		return projectFirstUpdateId;
	}
	public void setProjectFirstUpdateId(String projectFirstUpdateId) {
		this.projectFirstUpdateId = projectFirstUpdateId;
	}
	public Date getProjectFirstUpdateDate() {
		return projectFirstUpdateDate;
	}
	public void setProjectFirstUpdateDate(Date projectFirstUpdateDate) {
		this.projectFirstUpdateDate = projectFirstUpdateDate;
	}
	public static int getPORTAL_DISPLAY_CNT() {
		return PORTAL_DISPLAY_CNT;
	}
	public static void setPORTAL_DISPLAY_CNT(int pORTAL_DISPLAY_CNT) {
		PORTAL_DISPLAY_CNT = pORTAL_DISPLAY_CNT;
	}
	public static int getHEALTH_DISPLAY_CNT() {
		return HEALTH_DISPLAY_CNT;
	}
	public static void setHEALTH_DISPLAY_CNT(int hEALTH_DISPLAY_CNT) {
		HEALTH_DISPLAY_CNT = hEALTH_DISPLAY_CNT;
	}
	public static int getCOUNCIL_DISPLAY_CNT() {
		return COUNCIL_DISPLAY_CNT;
	}
	public static void setCOUNCIL_DISPLAY_CNT(int cOUNCIL_DISPLAY_CNT) {
		COUNCIL_DISPLAY_CNT = cOUNCIL_DISPLAY_CNT;
	}
	public static int getDONG_DISPLAY_CNT() {
		return DONG_DISPLAY_CNT;
	}
	public static void setDONG_DISPLAY_CNT(int dONG_DISPLAY_CNT) {
		DONG_DISPLAY_CNT = dONG_DISPLAY_CNT;
	}
	public static int getDEPT_DISPLAY_CNT() {
		return DEPT_DISPLAY_CNT;
	}
	public static void setDEPT_DISPLAY_CNT(int dEPT_DISPLAY_CNT) {
		DEPT_DISPLAY_CNT = dEPT_DISPLAY_CNT;
	}
	public static int getENGLISH_DISPLAY_CNT() {
		return ENGLISH_DISPLAY_CNT;
	}
	public static void setENGLISH_DISPLAY_CNT(int eNGLISH_DISPLAY_CNT) {
		ENGLISH_DISPLAY_CNT = eNGLISH_DISPLAY_CNT;
	}
	public static int getCHINA_DISPLAY_CNT() {
		return CHINA_DISPLAY_CNT;
	}
	public static void setCHINA_DISPLAY_CNT(int cHINA_DISPLAY_CNT) {
		CHINA_DISPLAY_CNT = cHINA_DISPLAY_CNT;
	}
	public static int getJAPAN_DISPLAY_CNT() {
		return JAPAN_DISPLAY_CNT;
	}
	public static void setJAPAN_DISPLAY_CNT(int jAPAN_DISPLAY_CNT) {
		JAPAN_DISPLAY_CNT = jAPAN_DISPLAY_CNT;
	}
	public int getCurrentSize() {
		return currentSize;
	}
	public void setCurrentSize(int currentSize) {
		this.currentSize = currentSize;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getSearchCnd() {
		return searchCnd;
	}
	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public String getSearchWrd() {
		return searchWrd;
	}
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}
	public String getSortOrdr() {
		return sortOrdr;
	}
	public void setSortOrdr(String sortOrdr) {
		this.sortOrdr = sortOrdr;
	}
	public String getSearchUseYn() {
		return searchUseYn;
	}
	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public int getRowNo() {
		return rowNo;
	}
	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}
	public int getProjectPageIndex() {
		return projectPageIndex;
	}
	public void setProjectPageIndex(int projectPageIndex) {
		this.projectPageIndex = projectPageIndex;
	}
	public int getProjectPageUnit() {
		return projectPageUnit;
	}
	public void setProjectPageUnit(int projectPageUnit) {
		this.projectPageUnit = projectPageUnit;
	}
	public int getProjectPageSize() {
		return projectPageSize;
	}
	public void setProjectPageSize(int projectPageSize) {
		this.projectPageSize = projectPageSize;
	}
	public int getProjectFirstIndex() {
		return projectFirstIndex;
	}
	public void setProjectFirstIndex(int projectFirstIndex) {
		this.projectFirstIndex = projectFirstIndex;
	}
	public int getProjectLastIndex() {
		return projectLastIndex;
	}
	public void setProjectLastIndex(int projectLastIndex) {
		this.projectLastIndex = projectLastIndex;
	}
	public int getProjectRecordCountPerPage() {
		return projectRecordCountPerPage;
	}
	public void setProjectRecordCountPerPage(int projectRecordCountPerPage) {
		this.projectRecordCountPerPage = projectRecordCountPerPage;
	}
	public int getProjectRowNo() {
		return projectRowNo;
	}
	public void setProjectRowNo(int projectRowNo) {
		this.projectRowNo = projectRowNo;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public int getUserPageIndex() {
		return userPageIndex;
	}
	public void setUserPageIndex(int userPageIndex) {
		this.userPageIndex = userPageIndex;
	}
	public int getUserPageUnit() {
		return userPageUnit;
	}
	public void setUserPageUnit(int userPageUnit) {
		this.userPageUnit = userPageUnit;
	}
	public int getUserPageSize() {
		return userPageSize;
	}
	public void setUserPageSize(int userPageSize) {
		this.userPageSize = userPageSize;
	}
	public int getUserFirstIndex() {
		return userFirstIndex;
	}
	public void setUserFirstIndex(int userFirstIndex) {
		this.userFirstIndex = userFirstIndex;
	}
	public int getUserLastIndex() {
		return userLastIndex;
	}
	public void setUserLastIndex(int userLastIndex) {
		this.userLastIndex = userLastIndex;
	}
	public int getUserRecordCountPerPage() {
		return userRecordCountPerPage;
	}
	public void setUserRecordCountPerPage(int userRecordCountPerPage) {
		this.userRecordCountPerPage = userRecordCountPerPage;
	}
	public int getUserRowNo() {
		return userRowNo;
	}
	public void setUserRowNo(int userRowNo) {
		this.userRowNo = userRowNo;
	}
	public String getArchiveFieldFullName() {
		return archiveFieldFullName;
	}
	public void setArchiveFieldFullName(String archiveFieldFullName) {
		this.archiveFieldFullName = archiveFieldFullName;
	}
		
		
}
