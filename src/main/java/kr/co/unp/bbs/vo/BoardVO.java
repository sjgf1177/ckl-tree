package kr.co.unp.bbs.vo;

import java.io.Serializable;
import java.util.Date;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
@XmlRootElement(name="board")
@XmlAccessorType(XmlAccessType.FIELD)
public class BoardVO extends SearchVO implements Serializable {

	public static final String USER_DELETION = "2"; //사용자삭제
	public static final String BOS_DELETION = "1";  //관리자삭제
	public static final String NON_DELETION = "0";  //미삭제

	public static final String PUBLIC = "N"; //공개글
	public static final String SECRET = "Y"; //비공개글

	public static final String NOTICE_NTT_TYPE = "1"; //공지형
	public static final String BASIC_NTT_TYPE = "2"; //일반

	public static final String USE = "Y"; //사용
	public static final String DISUSE = "N"; //사용하지않음

	/**
	 * 게시물 첨부파일 아이디
	 */
	private String atchFileId = "";
	/**
	 * 게시판 아이디
	 */
	private String bbsId = "";
	/**
	 * 최초등록자 아이디
	 */
	private String frstRegisterId = "";
	/**
	 * 최초등록시점
	 */
	private String frstRegisterPnttm = "";

	private String answeringRegisterPnttm = "";

	private String answerRegisterPnttm = "";

	/**
	 * 최종수정자 아이디
	 */
	private String lastUpdusrId = "";
	/**
	 * 최종수정시점
	 */
	private String lastUpdusrPnttm = "";
	/**
	 * 게시시작일
	 */
	private String ntceBgnde = "";
	/**
	 * 게시종료일
	 */
	private String ntceEndde = "";
	/**
	 * 게시자핀번호
	 */
	private String ntcrPinno = "";
	/**
	 * 게시자 아이디
	 */
	@XmlElement
	private String ntcrId = "";
	/**
	 * 게시자명
	 */
	@XmlElement
	private String ntcrNm = "";
	/**
	 * 게시물 내용
	 */
	@XmlElement
	private String nttCn = "";
	/**
	 * 게시물 아이디
	 */
	@XmlElement
	private long nttId = 0L;
	/**
	 * 게시물 번호
	 */
	private long nttNo = 0L;
	/**
	 * 게시물 제목
	 */
	@XmlElement
	private String nttSj = "";
	/**
	 * 부모글번호
	 */
	private long parnts = 0L;
	/**
	 * 패스워드
	 */
	private String password = "";

	/**
	 * 조회수
	 */
	@XmlElement
	private int inqireCo = 0;
	/**
	 * 답장여부
	 */
	private String replyAt = "";
	/**
	 * 답장위치
	 */
	private int replyLc = 0;
	/**
	 * 정렬순서
	 */
	private long sortOrdr = 0L;
	/**
	 * 사용여부
	 */
	private String useAt = "";
	/**
	 * 게시 종료일
	 */
	private String ntceEnddeView = "";
	/**
	 * 게시 시작일
	 */
	private String ntceBgndeView = "";

    /** 비밀글여부 */
    private String secret = "";

	/** 파일 수 */
	private int fileCount = 0;

	private String fileFieldName = "";

	/**
	 * 등록일
	 */
	@XmlElement
	private Date regDate = new Date();

	private Date lastUpdDate = new Date();
	/**
	 * 옵션필드
	 */
	private String option1 = "";
	private String option2 = "";
	private String option3 = "";
	private String option4 = "";
	private String option5 = "";
	private String option6 = "";
	private String option7 = "";
	private String option8 = "";
	private String option9 = "";
	private String option10 = "";
	private String option11 = "";
	private String option12 = "";
	private String option13 = "";
	private String option14 = "";
	private String option15 = "";
	private String option16 = "";
	private String option17 = "";
	private String option18 = "";
	private String option19 = "";
	private String option20 = "";
	private String option21 = "";
	private String option22 = "";
	private String option23 = "";
	private String option24 = "";
	private String option25 = "";
	private String option26 = "";
	private String option27 = "";
	private String option28 = "";
	private String option29 = "";
	private String option30 = "";


	private String viewType = "";
	private String htmlYn = "";
	private String requestUri = "";
	private String newYn = "";
	private String streFileNm = "";
	private String ntcrTel = "";
	private String ntcrTel1 = "";
	private String ntcrTel2 = "";
	private String ntcrTel3 = "";
	private String ntcrMobile = "";
	private String ntcrMobile1 = "";
	private String ntcrMobile2 = "";
	private String ntcrMobile3 = "";
	private String ntcrFax = "";
	private String ntcrEmail = "";
	private String ntcrEmail1 = "";
	private String ntcrEmail2 = "";
	private String ntcrZipcode = "";
	private String ntcrZipcode1 = "";
	private String ntcrZipcode2 = "";
	private String ntcrZipcode3 = "";
	private String ntcrZipcode4 = "";
	private String ntcrZipcode5 = "";
	private String ntcrZipcode6 = "";
	private String ntcrZipcode7 = "";
	private String ntcrZipcode8 = "";
	private String ntcrAddr1 = "";
	private String ntcrAddr2 = "";

	private String imgUrl = "";

	private String url = "";

	private int totCnt = 0;

	/**
	 * 첨부파일명
	 */
	private String fileNm = "";

	private String fileExtsn = "";

	private String nttType = "";

	private long ntcrIdx = 0;

    private String[] bbsIdData;

    private String[] nttIdData;

    /* 그린파킹 담장허물기 조성사례*/

    private String prevImgUrl;

    private String prevOrignlFileNm;

    private String nextImgUrl;

    private String nextOrignlFileNm;


	@XmlElement
    private String menuNo = "";

    private boolean plusCount = false;

    private String type = "";

	private int fileSeq = 0;

	private int commentCnt = 0;

	private int replyCnt = 0;

	private String deptName = "";

    /** 최종 수정자명 */
    private String lastUpdusrNm = "";

    /** 유효여부 */
    private String isExpired = "N";

    private String[] deptCodeData;

    private String queryString = "";

    private int currentSize = 0;

    private String orignlFileNm = "";

    private int fileSn = 0;

    private String section = "";

    private String[] sectionData;

    private String sectionNm = "";

	private String optionNm = "";

    private int ReplyPageIndex = 1;

    private String orgPath = "";

    private String newPath = "";

    private String siteName = "";

    private String ntcrDept = "";

    private int totalRows = 0;

	private String tableNm = "";

	private String deptId = "";

	private String deptNm = "";

    private String dong = "";

    private int lv = 0;

    private long deptNo = 0L;
    private long money = 0L;

	private String ntcrBirthday = "";
	private String ntcrBirthday1 = "";
	private String ntcrBirthday2 = "";
	private String ntcrBirthday3 = "";

	private String ntcrIp = "";

	private String deadline = "";

	private String pageQueryString = "";

	private long cmmntId = 0;

    private String smsYn = "N";

    private String fullMenuLink = "";

    private int prevNttId = 0;

    private int nextNttId = 0;

    private String prevNttSj = "";
    private String nextNttSj = "";

    private String sdate = "";
    private String edate = "";

    private String answerType = "";

	private Date answeringDate = new Date();
	private Date answerDate = new Date();

	private String satisfaction = "";

	private String gubun = "";

	private String area = "";

	private String adminNm = "";

    private int recommend = 0;

    private String tempValue1 = "";

    private String tempValue2 = "";

    private String tempValue3 = "";

    private String tempValue4 = "";

    private String tempValue5 = "";

    private String tempValue6 = "";

    private String tempValue7 = "";

    private String tempValue8 = "";

    private String tempValue9 = "";

    private String tempValue10 = "";

	private String tempValue11 = "";

	private String tempValue12 = "";

    /* 수의시담 관련 VO*/

    private String companyName = "";

    private String owner = "";

    private String companyNumber = "";

    private String ownerMobile = "";

    /* 수의시담 관련 VO 끝*/


 /* 무료법률상담 접수등록인원 검색관련*/

    private String receiptSdate ="";
    private String receiptEdate ="";

    /*구정소식 게시여부*/

    private String gujung;

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

	public String getNtcrFax() {
		return ntcrFax;
	}

	public void setNtcrFax(String ntcrFax) {
		this.ntcrFax = ntcrFax;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Date getLastUpdDate() {
		return lastUpdDate;
	}

	public void setLastUpdDate(Date lastUpdDate) {
		this.lastUpdDate = lastUpdDate;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getSatisfaction() {
		return satisfaction;
	}

	public void setSatisfaction(String satisfaction) {
		this.satisfaction = satisfaction;
	}

	public String getPrevNttSj() {
		return prevNttSj;
	}

	public void setPrevNttSj(String prevNttSj) {
		this.prevNttSj = prevNttSj;
	}

	public String getNextNttSj() {
		return nextNttSj;
	}

	public void setNextNttSj(String nextNttSj) {
		this.nextNttSj = nextNttSj;
	}

	public Date getAnsweringDate() {
		return answeringDate;
	}

	public void setAnsweringDate(Date answeringDate) {
		this.answeringDate = answeringDate;
	}

	public Date getAnswerDate() {
		return answerDate;
	}

	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}

	public String getAnswerType() {
		return answerType;
	}

	public void setAnswerType(String answerType) {
		this.answerType = answerType;
	}

	public String getSdate() {
		return sdate;
	}

	public void setSdate(String sdate) {
		this.sdate = sdate;
	}

	public String getEdate() {
		return edate;
	}

	public void setEdate(String edate) {
		this.edate = edate;
	}

	public int getPrevNttId() {
		return prevNttId;
	}

	public void setPrevNttId(int prevNttId) {
		this.prevNttId = prevNttId;
	}

	public int getNextNttId() {
		return nextNttId;
	}

	public void setNextNttId(int nextNttId) {
		this.nextNttId = nextNttId;
	}

	public String getFileExtsn() {
		return fileExtsn;
	}

	public void setFileExtsn(String fileExtsn) {
		this.fileExtsn = fileExtsn;
	}

	public String getFullMenuLink() {
		return fullMenuLink;
	}

	public void setFullMenuLink(String fullMenuLink) {
		this.fullMenuLink = fullMenuLink;
	}

	public String getSmsYn() {
		return smsYn;
	}

	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}

	public long getCmmntId() {
		return cmmntId;
	}

	public void setCmmntId(long cmmntId) {
		this.cmmntId = cmmntId;
	}

	public String getPageQueryString() {
		return pageQueryString;
	}

	public void setPageQueryString(String pageQueryString) {
		this.pageQueryString = pageQueryString;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	public String getNtcrBirthday() {
		return ntcrBirthday;
	}

	public void setNtcrBirthday(String ntcrBirthday) {
		this.ntcrBirthday = ntcrBirthday;
	}

	public String getNtcrBirthday1() {
		return ntcrBirthday1;
	}

	public void setNtcrBirthday1(String ntcrBirthday1) {
		this.ntcrBirthday1 = ntcrBirthday1;
	}

	public String getNtcrBirthday2() {
		return ntcrBirthday2;
	}

	public void setNtcrBirthday2(String ntcrBirthday2) {
		this.ntcrBirthday2 = ntcrBirthday2;
	}

	public String getNtcrBirthday3() {
		return ntcrBirthday3;
	}

	public void setNtcrBirthday3(String ntcrBirthday3) {
		this.ntcrBirthday3 = ntcrBirthday3;
	}

	public String getNtcrIp() {
		return ntcrIp;
	}

	public void setNtcrIp(String ntcrIp) {
		this.ntcrIp = ntcrIp;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getTableNm() {
		return tableNm;
	}

	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public String getNtcrDept() {
		return ntcrDept;
	}

	public void setNtcrDept(String ntcrDept) {
		this.ntcrDept = ntcrDept;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public int getTotCnt() {
		return totCnt;
	}

	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}


	private String siteId = "";

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getNtcrTel1() {
		return ntcrTel1;
	}

	public void setNtcrTel1(String ntcrTel1) {
		this.ntcrTel1 = ntcrTel1;
	}

	public String getNtcrTel2() {
		return ntcrTel2;
	}

	public void setNtcrTel2(String ntcrTel2) {
		this.ntcrTel2 = ntcrTel2;
	}

	public String getNtcrTel3() {
		return ntcrTel3;
	}

	public void setNtcrTel3(String ntcrTel3) {
		this.ntcrTel3 = ntcrTel3;
	}

	public String getNtcrMobile1() {
		return ntcrMobile1;
	}

	public void setNtcrMobile1(String ntcrMobile1) {
		this.ntcrMobile1 = ntcrMobile1;
	}

	public String getNtcrMobile2() {
		return ntcrMobile2;
	}

	public void setNtcrMobile2(String ntcrMobile2) {
		this.ntcrMobile2 = ntcrMobile2;
	}

	public String getNtcrMobile3() {
		return ntcrMobile3;
	}

	public void setNtcrMobile3(String ntcrMobile3) {
		this.ntcrMobile3 = ntcrMobile3;
	}

	public String getNtcrEmail1() {
		return ntcrEmail1;
	}

	public void setNtcrEmail1(String ntcrEmail1) {
		this.ntcrEmail1 = ntcrEmail1;
	}

	public String getNtcrEmail2() {
		return ntcrEmail2;
	}

	public void setNtcrEmail2(String ntcrEmail2) {
		this.ntcrEmail2 = ntcrEmail2;
	}

	public String getNtcrZipcode1() {
		return ntcrZipcode1;
	}

	public void setNtcrZipcode1(String ntcrZipcode1) {
		this.ntcrZipcode1 = ntcrZipcode1;
	}

	public String getNtcrZipcode2() {
		return ntcrZipcode2;
	}

	public void setNtcrZipcode2(String ntcrZipcode2) {
		this.ntcrZipcode2 = ntcrZipcode2;
	}

	public String getNtcrZipcode3() {
		return ntcrZipcode3;
	}

	public void setNtcrZipcode3(String ntcrZipcode3) {
		this.ntcrZipcode3 = ntcrZipcode3;
	}

	public String getNtcrZipcode4() {
		return ntcrZipcode4;
	}

	public void setNtcrZipcode4(String ntcrZipcode4) {
		this.ntcrZipcode4 = ntcrZipcode4;
	}

	public String getNtcrZipcode5() {
		return ntcrZipcode5;
	}

	public void setNtcrZipcode5(String ntcrZipcode5) {
		this.ntcrZipcode5 = ntcrZipcode5;
	}

	public String getNtcrZipcode6() {
		return ntcrZipcode6;
	}

	public void setNtcrZipcode6(String ntcrZipcode6) {
		this.ntcrZipcode6 = ntcrZipcode6;
	}

	public String getNtcrZipcode7() {
		return ntcrZipcode7;
	}

	public void setNtcrZipcode7(String ntcrZipcode7) {
		this.ntcrZipcode7 = ntcrZipcode7;
	}

	public String getNtcrZipcode8() {
		return ntcrZipcode8;
	}

	public void setNtcrZipcode8(String ntcrZipcode8) {
		this.ntcrZipcode8 = ntcrZipcode8;
	}

	public String getNtcrTel() {
		return ntcrTel;
	}

	public void setNtcrTel(String ntcrTel) {
		this.ntcrTel = ntcrTel;
	}

	public String getNtcrMobile() {
		return ntcrMobile;
	}

	public void setNtcrMobile(String ntcrMobile) {
		this.ntcrMobile = ntcrMobile;
	}

	public String getNtcrEmail() {
		return ntcrEmail;
	}

	public void setNtcrEmail(String ntcrEmail) {
		this.ntcrEmail = ntcrEmail;
	}

	public String getNtcrZipcode() {
		return ntcrZipcode;
	}

	public void setNtcrZipcode(String ntcrZipcode) {
		this.ntcrZipcode = ntcrZipcode;
	}

	public String getNtcrAddr1() {
		return ntcrAddr1;
	}

	public void setNtcrAddr1(String ntcrAddr1) {
		this.ntcrAddr1 = ntcrAddr1;
	}

	public String getNtcrAddr2() {
		return ntcrAddr2;
	}

	public void setNtcrAddr2(String ntcrAddr2) {
		this.ntcrAddr2 = ntcrAddr2;
	}

	public static String getUserDeletion() {
		return USER_DELETION;
	}

	public static String getBosDeletion() {
		return BOS_DELETION;
	}

	public static String getNonDeletion() {
		return NON_DELETION;
	}

	public String getStreFileNm() {
		return streFileNm;
	}

	public void setStreFileNm(String streFileNm) {
		this.streFileNm = streFileNm;
	}

	public String getNewYn() {
		return newYn;
	}

	public void setNewYn(String newYn) {
		this.newYn = newYn;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public String getHtmlYn() {
		return htmlYn;
	}

	public void setHtmlYn(String htmlYn) {
		this.htmlYn = htmlYn;
	}

	public String getNtcrPinno() {
		return ntcrPinno;
	}

	public void setNtcrPinno(String ntcrPinno) {
		this.ntcrPinno = ntcrPinno;
	}

	public String getViewType() {
		return viewType;
	}

	public void setViewType(String viewType) {
		this.viewType = viewType;
	}


    public String getOrgPath() {
		return orgPath;
	}

	public void setOrgPath(String orgPath) {
		this.orgPath = orgPath;
	}

	public String getNewPath() {
		return newPath;
	}

	public void setNewPath(String newPath) {
		this.newPath = newPath;
	}

	public String[] getectionData() {
		return sectionData;
	}

	public void setSectionnData(String[] sectionData) {
		this.sectionData = sectionData;
	}

	public int getReplyPageIndex() {
		return ReplyPageIndex;
	}

	public void setReplyPageIndex(int replyPageIndex) {
		ReplyPageIndex = replyPageIndex;
	}

	public String getSectionNm() {
		return sectionNm;
	}

	public void setSectionNm(String sectionNm) {
		this.sectionNm = sectionNm;
	}

    public String getOptionNm() {
		return optionNm;
	}

	public void setOptionNm(String optionNm) {
		this.optionNm = optionNm;
	}

	public String[] getNttIdData() {
		return nttIdData;
	}

	public void setNttIdData(String[] nttIdData) {
		this.nttIdData = nttIdData;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getOrignlFileNm() {
		return orignlFileNm;
	}

	public void setOrignlFileNm(String orignlFileNm) {
		this.orignlFileNm = orignlFileNm;
	}

	public int getFileSn() {
		return fileSn;
	}

	public void setFileSn(int fileSn) {
		this.fileSn = fileSn;
	}

	public int getCurrentSize() {
		return currentSize;
	}

	public void setCurrentSize(int currentSize) {
		this.currentSize = currentSize;
	}

	public String getQueryString() {
		return queryString;
	}

	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}

	public String[] getDeptCodeData() {
		return deptCodeData;
	}

	public void setDeptCodeData(String[] deptCodeData) {
		this.deptCodeData = deptCodeData;
	}

	public String getLastUpdusrNm() {
		return lastUpdusrNm;
	}

	public void setLastUpdusrNm(String lastUpdusrNm) {
		this.lastUpdusrNm = lastUpdusrNm;
	}

	public String getIsExpired() {
		return isExpired;
	}

	public void setIsExpired(String isExpired) {
		this.isExpired = isExpired;
	}

	public int getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public int getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isPlusCount() {
		return plusCount;
	}

	public void setPlusCount(boolean plusCount) {
		this.plusCount = plusCount;
	}

	public String getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}

	public String[] getBbsIdData() {
		return bbsIdData;
	}

	public void setBbsIdData(String[] bbsIdData) {
		this.bbsIdData = bbsIdData;
	}

	public long getNtcrIdx() {
		return ntcrIdx;
	}

	public void setNtcrIdx(long ntcrIdx) {
		this.ntcrIdx = ntcrIdx;
	}

	public String getNttType() {
		return nttType;
	}

	public void setNttType(String nttType) {
		this.nttType = nttType;
	}

	/**
	 * atchFileId attribute를 리턴한다.
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
		return atchFileId;
	}

	/**
	 * atchFileId attribute 값을 설정한다.
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	/**
	 * bbsId attribute를 리턴한다.
	 * @return the bbsId
	 */
	public String getBbsId() {
		return bbsId;
	}

	/**
	 * bbsId attribute 값을 설정한다.
	 * @param bbsId the bbsId to set
	 */
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	/**
	 * frstRegisterId attribute를 리턴한다.
	 * @return the frstRegisterId
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId the frstRegisterId to set
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * lastUpdusrId attribute를 리턴한다.
	 * @return the lastUpdusrId
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId the lastUpdusrId to set
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	/**
	 * lastUpdusrPnttm attribute를 리턴한다.
	 * @return the lastUpdusrPnttm
	 */
	public String getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	/**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm the lastUpdusrPnttm to set
	 */
	public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	/**
	 * ntceBgnde attribute를 리턴한다.
	 * @return the ntceBgnde
	 */
	public String getNtceBgnde() {
		return ntceBgnde;
	}

	/**
	 * ntceBgnde attribute 값을 설정한다.
	 * @param ntceBgnde the ntceBgnde to set
	 */
	public void setNtceBgnde(String ntceBgnde) {
		this.ntceBgnde = ntceBgnde;
	}

	/**
	 * ntceEndde attribute를 리턴한다.
	 * @return the ntceEndde
	 */
	public String getNtceEndde() {
		return ntceEndde;
	}

	/**
	 * ntceEndde attribute 값을 설정한다.
	 * @param ntceEndde the ntceEndde to set
	 */
	public void setNtceEndde(String ntceEndde) {
		this.ntceEndde = ntceEndde;
	}

	/**
	 * ntcrId attribute를 리턴한다.
	 * @return the ntcrId
	 */
	public String getNtcrId() {
		return ntcrId;
	}

	/**
	 * ntcrId attribute 값을 설정한다.
	 * @param ntcrId the ntcrId to set
	 */
	public void setNtcrId(String ntcrId) {
		this.ntcrId = ntcrId;
	}

	/**
	 * ntcrNm attribute를 리턴한다.
	 * @return the ntcrNm
	 */
	public String getNtcrNm() {
		return ntcrNm;
	}

	/**
	 * ntcrNm attribute 값을 설정한다.
	 * @param ntcrNm the ntcrNm to set
	 */
	public void setNtcrNm(String ntcrNm) {
		this.ntcrNm = ntcrNm;
	}

	/**
	 * nttCn attribute를 리턴한다.
	 * @return the nttCn
	 */
	public String getNttCn() {
		return nttCn;
	}

	/**
	 * nttCn attribute 값을 설정한다.
	 * @param nttCn the nttCn to set
	 */
	public void setNttCn(String nttCn) {
		this.nttCn = nttCn;
	}

	/**
	 * nttId attribute를 리턴한다.
	 * @return the nttId
	 */
	public long getNttId() {
		return nttId;
	}

	/**
	 * nttId attribute 값을 설정한다.
	 * @param nttId the nttId to set
	 */
	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	/**
	 * nttNo attribute를 리턴한다.
	 * @return the nttNo
	 */
	public long getNttNo() {
		return nttNo;
	}

	/**
	 * nttNo attribute 값을 설정한다.
	 * @param nttNo the nttNo to set
	 */
	public void setNttNo(long nttNo) {
		this.nttNo = nttNo;
	}

	/**
	 * nttSj attribute를 리턴한다.
	 * @return the nttSj
	 */
	public String getNttSj() {
		return nttSj;
	}

	/**
	 * nttSj attribute 값을 설정한다.
	 * @param nttSj the nttSj to set
	 */
	public void setNttSj(String nttSj) {
		this.nttSj = nttSj;
	}

	/**
	 * parnts attribute를 리턴한다.
	 * @return the parnts
	 */
	public long getParnts() {
		return parnts;
	}

	/**
	 * parnts attribute 값을 설정한다.
	 * @param parnts the parnts to set
	 */
	public void setParnts(long parnts) {
		this.parnts = parnts;
	}

	/**
	 * password attribute를 리턴한다.
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * password attribute 값을 설정한다.
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * inqireCo attribute를 리턴한다.
	 * @return the inqireCo
	 */
	public int getInqireCo() {
		return inqireCo;
	}

	/**
	 * inqireCo attribute 값을 설정한다.
	 * @param inqireCo the inqireCo to set
	 */
	public void setInqireCo(int inqireCo) {
		this.inqireCo = inqireCo;
	}

	/**
	 * replyAt attribute를 리턴한다.
	 * @return the replyAt
	 */
	public String getReplyAt() {
		return replyAt;
	}

	/**
	 * replyAt attribute 값을 설정한다.
	 * @param replyAt the replyAt to set
	 */
	public void setReplyAt(String replyAt) {
		this.replyAt = replyAt;
	}

	/**
	 * replyLc attribute를 리턴한다.
	 * @return the replyLc
	 */
	public int getReplyLc() {
		return replyLc;
	}

	/**
	 * replyLc attribute 값을 설정한다.
	 * @param replyLc the replyLc to set
	 */
	public void setReplyLc(int replyLc) {
		this.replyLc = replyLc;
	}

	/**
	 * sortOrdr attribute를 리턴한다.
	 * @return the sortOrdr
	 */
	public long getSortOrdr() {
		return sortOrdr;
	}

	/**
	 * sortOrdr attribute 값을 설정한다.
	 * @param sortOrdr the sortOrdr to set
	 */
	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	/**
	 * useAt attribute를 리턴한다.
	 * @return the useAt
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt the useAt to set
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * ntceEnddeView attribute를 리턴한다.
	 * @return the ntceEnddeView
	 */
	public String getNtceEnddeView() {
		return ntceEnddeView;
	}

	/**
	 * ntceEnddeView attribute 값을 설정한다.
	 * @param ntceEnddeView the ntceEnddeView to set
	 */
	public void setNtceEnddeView(String ntceEnddeView) {
		this.ntceEnddeView = ntceEnddeView;
	}

	/**
	 * ntceBgndeView attribute를 리턴한다.
	 * @return the ntceBgndeView
	 */
	public String getNtceBgndeView() {
		return ntceBgndeView;
	}

	/**
	 * ntceBgndeView attribute 값을 설정한다.
	 * @param ntceBgndeView the ntceBgndeView to set
	 */
	public void setNtceBgndeView(String ntceBgndeView) {
		this.ntceBgndeView = ntceBgndeView;
	}

    /**
     * secret attribute를 리턴한다.
     *
     * @return the secret
     */
    public String getSecret() {
	return secret;
    }

    /**
     * secret attribute 값을 설정한다.
     *
     * @param secret
     *            the secret to set
     */
    public void setSecret(String secret) {
	this.secret = secret;
    }

    /**
     * fileCount attribute를 리턴한다.
     *
     * @return the fileCount
     */
	public int getFileCount() {
		return fileCount;
	}

    /**
     * fileCount attribute 값을 설정한다.
     *
     * @param fileCount
     *            the fileCount to set
     */
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	/**
	 * fileFieldName attribute를 리턴한다.
	 *
	 * @return the fileFieldName
	 */
	public void setFileFieldName(String fileFieldName) {
		this.fileFieldName = fileFieldName;
	}

	/**
	 * fileFieldName attribute 값을 설정한다.
	 *
	 * @param fileFieldName
	 *            the fileFieldName to set
	 */
	public String getFileFieldName() {
		return fileFieldName;
	}

	/**
	 * regDate attribute를 리턴한다.
	 * @return the regDate
	 */
	public Date getRegDate() {
		return regDate;
	}

	/**
	 * regDate attribute 값을 설정한다.
	 * @param regDate the regDate to set
	 */
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	/**
	 * regDate attribute를 리턴한다.
	 * @return the regDate
	 */
	public String getOption1() {
		return option1;
	}

	/**
	 * option1 attribute 값을 설정한다.
	 * @param option1 the option1 to set
	 */
	public void setOption1(String option1) {
		this.option1 = option1;
	}

	/**
	 * option1 attribute를 리턴한다.
	 * @return the option1
	 */
	public String getOption2() {
		return option2;
	}

	/**
	 * option2 attribute 값을 설정한다.
	 * @param option2 the option2 to set
	 */
	public void setOption2(String option2) {
		this.option2 = option2;
	}

	/**
	 * option2 attribute를 리턴한다.
	 * @return the option2
	 */
	public String getOption3() {
		return option3;
	}

	/**
	 * option3 attribute 값을 설정한다.
	 * @param option3 the option3 to set
	 */
	public void setOption3(String option3) {
		this.option3 = option3;
	}

	/**
	 * option3 attribute를 리턴한다.
	 * @return the option3
	 */
	public String getOption4() {
		return option4;
	}

	/**
	 * option4 attribute 값을 설정한다.
	 * @param option4 the option4 to set
	 */
	public void setOption4(String option4) {
		this.option4 = option4;
	}

	/**
	 * option5 attribute를 리턴한다.
	 * @return the option5
	 */
	public String getOption5() {
		return option5;
	}

	/**
	 * option5 attribute 값을 설정한다.
	 * @param option5 the option5 to set
	 */
	public void setOption5(String option5) {
		this.option5 = option5;
	}

	/**
	 * option6 attribute를 리턴한다.
	 * @return the option6
	 */
	public String getOption6() {
		return option6;
	}

	/**
	 * option6 attribute 값을 설정한다.
	 * @param option6 the option6 to set
	 */
	public void setOption6(String option6) {
		this.option6 = option6;
	}

	/**
	 * option7 attribute를 리턴한다.
	 * @return the option7
	 */
	public String getOption7() {
		return option7;
	}

	/**
	 * option7 attribute 값을 설정한다.
	 * @param option7 the option7 to set
	 */
	public void setOption7(String option7) {
		this.option7 = option7;
	}

	/**
	 * option8 attribute를 리턴한다.
	 * @return the option8
	 */
	public String getOption8() {
		return option8;
	}

	/**
	 * option8 attribute 값을 설정한다.
	 * @param option8 the option8 to set
	 */
	public void setOption8(String option8) {
		this.option8 = option8;
	}

	/**
	 * option9 attribute를 리턴한다.
	 * @return the option9
	 */
	public String getOption9() {
		return option9;
	}

	/**
	 * option9 attribute 값을 설정한다.
	 * @param option9 the option9 to set
	 */
	public void setOption9(String option9) {
		this.option9 = option9;
	}

	/**
	 * option10 attribute를 리턴한다.
	 * @return the option10
	 */
	public String getOption10() {
		return option10;
	}

	/**
	 * option10 attribute 값을 설정한다.
	 * @param option10 the option10 to set
	 */
	public void setOption10(String option10) {
		this.option10 = option10;
	}

	public String getOption11() {
		return option11;
	}

	public void setOption11(String option11) {
		this.option11 = option11;
	}

	public String getOption12() {
		return option12;
	}

	public void setOption12(String option12) {
		this.option12 = option12;
	}

	public String getOption13() {
		return option13;
	}

	public void setOption13(String option13) {
		this.option13 = option13;
	}

	public String getOption14() {
		return option14;
	}

	public void setOption14(String option14) {
		this.option14 = option14;
	}

	public String getOption15() {
		return option15;
	}

	public void setOption15(String option15) {
		this.option15 = option15;
	}

	public String getOption16() {
		return option16;
	}

	public void setOption16(String option16) {
		this.option16 = option16;
	}

	public String getOption17() {
		return option17;
	}

	public void setOption17(String option17) {
		this.option17 = option17;
	}

	public String getOption18() {
		return option18;
	}

	public void setOption18(String option18) {
		this.option18 = option18;
	}

	public String getOption19() {
		return option19;
	}

	public void setOption19(String option19) {
		this.option19 = option19;
	}

	public String getOption20() {
		return option20;
	}

	public void setOption20(String option20) {
		this.option20 = option20;
	}

	public String getOption21() {
		return option21;
	}

	public void setOption21(String option21) {
		this.option21 = option21;
	}

	public String getOption22() {
		return option22;
	}

	public void setOption22(String option22) {
		this.option22 = option22;
	}

	public String getOption23() {
		return option23;
	}

	public void setOption23(String option23) {
		this.option23 = option23;
	}

	public String getOption24() {
		return option24;
	}

	public void setOption24(String option24) {
		this.option24 = option24;
	}

	public String getOption25() {
		return option25;
	}

	public void setOption25(String option25) {
		this.option25 = option25;
	}

	public String getOption26() {
		return option26;
	}

	public void setOption26(String option26) {
		this.option26 = option26;
	}

	public String getOption27() {
		return option27;
	}

	public void setOption27(String option27) {
		this.option27 = option27;
	}

	public String getOption28() {
		return option28;
	}

	public void setOption28(String option28) {
		this.option28 = option28;
	}

	public String getOption29() {
		return option29;
	}

	public void setOption29(String option29) {
		this.option29 = option29;
	}

	public String getOption30() {
		return option30;
	}

	public void setOption30(String option30) {
		this.option30 = option30;
	}

	/**
	 * fileNm attribute를 리턴한다.
	 * @return the fileNm
	 */
	public String getFileNm() {
		return fileNm;
	}

	/**
	 * fileNm attribute 값을 설정한다.
	 * @param fileNm the fileNm to set
	 */
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

    public String getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	public void setFrstRegisterPnttm(String frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	public String getAnsweringRegisterPnttm() {
		return answeringRegisterPnttm;
	}

	public void setAnsweringRegisterPnttm(String answeringRegisterPnttm) {
		this.answeringRegisterPnttm = answeringRegisterPnttm;
	}

	public String getAnswerRegisterPnttm() {
		return answerRegisterPnttm;
	}

	public void setAnswerRegisterPnttm(String answerRegisterPnttm) {
		this.answerRegisterPnttm = answerRegisterPnttm;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

    String newPassword = "";

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getTempValue1() {
		return tempValue1;
	}

	public void setTempValue1(String tempValue1) {
		this.tempValue1 = tempValue1;
	}

	public String getTempValue2() {
		return tempValue2;
	}

	public void setTempValue2(String tempValue2) {
		this.tempValue2 = tempValue2;
	}

	public String getTempValue3() {
		return tempValue3;
	}

	public void setTempValue3(String tempValue3) {
		this.tempValue3 = tempValue3;
	}

	public String getTempValue4() {
		return tempValue4;
	}

	public void setTempValue4(String tempValue4) {
		this.tempValue4 = tempValue4;
	}

	public String getTempValue5() {
		return tempValue5;
	}

	public void setTempValue5(String tempValue5) {
		this.tempValue5 = tempValue5;
	}

	public String getTempValue6() {
		return tempValue6;
	}

	public void setTempValue6(String tempValue6) {
		this.tempValue6 = tempValue6;
	}

	public String getTempValue7() {
		return tempValue7;
	}

	public void setTempValue7(String tempValue7) {
		this.tempValue7 = tempValue7;
	}

	public String getTempValue8() {
		return tempValue8;
	}

	public void setTempValue8(String tempValue8) {
		this.tempValue8 = tempValue8;
	}

	public String getTempValue9() {
		return tempValue9;
	}

	public void setTempValue9(String tempValue9) {
		this.tempValue9 = tempValue9;
	}

	public String getTempValue10() {
		return tempValue10;
	}

	public void setTempValue10(String tempValue10) {
		this.tempValue10 = tempValue10;
	}

	public String getTempValue11() {
		return tempValue11;
	}

	public void setTempValue11(String tempValue11) {
		this.tempValue11 = tempValue11;
	}

	public String getTempValue12() {
		return tempValue12;
	}

	public void setTempValue12(String tempValue12) {
		this.tempValue12 = tempValue12;
	}


	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getCompanyNumber() {
		return companyNumber;
	}

	public void setCompanyNumber(String companyNumber) {
		this.companyNumber = companyNumber;
	}

	public String getOwnerMobile() {
		return ownerMobile;
	}

	public void setOwnerMobile(String ownerMobile) {
		this.ownerMobile = ownerMobile;
	}

	public String getPrevImgUrl() {
		return prevImgUrl;
	}

	public void setPrevImgUrl(String prevImgUrl) {
		this.prevImgUrl = prevImgUrl;
	}

	public String getPrevOrignlFileNm() {
		return prevOrignlFileNm;
	}

	public void setPrevOrignlFileNm(String prevOrignlFileNm) {
		this.prevOrignlFileNm = prevOrignlFileNm;
	}

	public String getNextImgUrl() {
		return nextImgUrl;
	}

	public void setNextImgUrl(String nextImgUrl) {
		this.nextImgUrl = nextImgUrl;
	}

	public String getNextOrignlFileNm() {
		return nextOrignlFileNm;
	}

	public void setNextOrignlFileNm(String nextOrignlFileNm) {
		this.nextOrignlFileNm = nextOrignlFileNm;
	}

	public String getReceiptSdate() {
		return receiptSdate;
	}

	public void setReceiptSdate(String receiptSdate) {
		this.receiptSdate = receiptSdate;
	}

	public String getReceiptEdate() {
		return receiptEdate;
	}

	public void setReceiptEdate(String receiptEdate) {
		this.receiptEdate = receiptEdate;
	}

	public String getAdminNm() {
		return adminNm;
	}

	public void setAdminNm(String adminNm) {
		this.adminNm = adminNm;
	}

	public String getGujung() {
		return gujung;
	}

	public void setGujung(String gujung) {
		this.gujung = gujung;
	}

	public int getLv() {
		return lv;
	}

	public void setLv(int lv) {
		this.lv = lv;
	}

	public long getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(long deptNo) {
		this.deptNo = deptNo;
	}

	public long getMoney() {
		return money;
	}

	public void setMoney(long money) {
		this.money = money;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}


}
