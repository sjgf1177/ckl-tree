package kr.co.unp.bbs.vo;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 게시판 속성 정보를 관리하기 위한 VO  클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.12  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@SuppressWarnings("serial")
@XmlRootElement(name="boardMaster")
@XmlAccessorType(XmlAccessType.FIELD)
public class BoardMasterVO implements Serializable {

    /** 검색시작일 */
    private String searchBgnDe = "";

    /** 검색조건 */
    private String searchCnd = "";

    /** 검색종료일 */
    private String searchEndDe = "";

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

    private int currentSize = 0;

    /** rowNo */
    private int rowNo = 0;

    /** 최초 등록자명 */
	@XmlElement
    private String frstRegisterNm = "";

    /** 게시판유형 코드명 */
	@XmlElement
    private String bbsTyCodeNm = "";

    /** 게시판속성 코드명 */
	@XmlElement
    private String bbsAttrbCode = "";
	@XmlElement
    private String bbsAttrbCodeNm = "";

    /** 템플릿 명 */
    private String tmplatNm = "";

    /** 최종 수정자명 */
    private String lastUpdusrNm = "";

    /** 권한지정 여부 */
    private String authFlag = "";

    /** 템플릿경로 */
    private String tmplatCours = "";

    /** 개별프로그램 속성코드 */
    private String proBbsAttrbCode = "";

    /** 개별프로그램 사용여부 */
    private String proUseAt = "";

    /** 개별프로그램 답장가능여부 */
    private String proReplyPosblAt = "";

    /** 개별프로그램 파일첨부가능여부 */
    private String proFileAtchPosblAt = "";

    /** 유효게시판 게시 시작일 */
    private String ntceBgnde = "";

    /** 유효게시판 게시 종료일 */
    private String ntceEndde = "";

	@XmlElement
    private String addCon = "";

    private String popupYn = "N";

	@XmlElement
    private String siteId = "";

	@XmlElement
    private String cmmntPosblAt = "";

    private int totalRows = 0;

    private String tableNm = "";

	@XmlElement
    private String preNextPosblAt = "";

    /** 게시판 아이디 */
	@XmlElement
    private String bbsId = "";

    /** 게시판 소개 */
	@XmlElement
    private String bbsIntrcn = "";

    /** 게시판 명 */
	@XmlElement
    private String bbsNm = "";

    /** 게시판 유형코드 */
	@XmlElement
    private String bbsTyCode = "";

    /** 최초등록자 아이디 */
    private String frstRegisterId = "";

    /** 최초등록시점 */
    private String frstRegisterPnttm = "";

    /** 최종수정자 아이디 */
    public String lastUpdusrId = "";

    /** 최종수정시점 */
    private String lastUpdusrPnttm = "";

    /** 첨부가능파일숫자 */
    private int posblAtchFileNumber = 0;

    /** 첨부가능파일사이즈 */
    private String posblAtchFileSize = null;

    /** 답장가능여부 */
	@XmlElement
    private String replyPosblAt = "";

    /** 템플릿 아이디 */
    private String tmplatId = "";

    /** 사용여부 */
    private String useAt = "";

    /** 사용플래그 */
    private String bbsUseFlag = "";

    /** 대상 아이디 */
    private String trgetId = "";

    /** 등록구분코드 */
    private String registSeCode = "";

    /** 유일 아이디 */
    private String uniqId = "";

    //---------------------------------
    // 2009.06.26 : 2단계 기능 추가
    //---------------------------------
    /** 추가 option (댓글-comment, 만족도조사-stsfdg) */
    private String option = "";

    /** 댓글 여부 */
    private String commentAt = "";

    /** 만족도조사 */
    private String stsfdgAt = "";

    private long nttId = 0L;
    
    private int menuNo = 0;
    ////-------------------------------

    public String getBbsNm() {
		return bbsNm;
	}

	public int getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}

	public long getNttId() {
		return nttId;
	}

	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	public String getBbsId() {
		return bbsId;
	}

	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}
	public String getBbsIntrcn() {
		return bbsIntrcn;
	}

	public void setBbsIntrcn(String bbsIntrcn) {
		this.bbsIntrcn = bbsIntrcn;
	}

	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	public String getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	public void setFrstRegisterPnttm(String frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	public String getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	public int getPosblAtchFileNumber() {
		return posblAtchFileNumber;
	}

	public void setPosblAtchFileNumber(int posblAtchFileNumber) {
		this.posblAtchFileNumber = posblAtchFileNumber;
	}

	public String getPosblAtchFileSize() {
		return posblAtchFileSize;
	}

	public void setPosblAtchFileSize(String posblAtchFileSize) {
		this.posblAtchFileSize = posblAtchFileSize;
	}

	public String getTmplatId() {
		return tmplatId;
	}

	public void setTmplatId(String tmplatId) {
		this.tmplatId = tmplatId;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getBbsUseFlag() {
		return bbsUseFlag;
	}

	public void setBbsUseFlag(String bbsUseFlag) {
		this.bbsUseFlag = bbsUseFlag;
	}

	public String getTrgetId() {
		return trgetId;
	}

	public void setTrgetId(String trgetId) {
		this.trgetId = trgetId;
	}

	public String getRegistSeCode() {
		return registSeCode;
	}

	public void setRegistSeCode(String registSeCode) {
		this.registSeCode = registSeCode;
	}

	public String getUniqId() {
		return uniqId;
	}

	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public String getCommentAt() {
		return commentAt;
	}

	public void setCommentAt(String commentAt) {
		this.commentAt = commentAt;
	}

	public String getStsfdgAt() {
		return stsfdgAt;
	}

	public void setStsfdgAt(String stsfdgAt) {
		this.stsfdgAt = stsfdgAt;
	}

	public void setBbsNm(String bbsNm) {
		this.bbsNm = bbsNm;
	}

	public String getPreNextPosblAt() {
		return preNextPosblAt;
	}

	public void setPreNextPosblAt(String preNextPosblAt) {
		this.preNextPosblAt = preNextPosblAt;
	}

	/** 파일첨부가능여부 */
    private String fileAtchPosblAt = "";

	public String getFileAtchPosblAt() {
		return fileAtchPosblAt;
	}

	public void setFileAtchPosblAt(String fileAtchPosblAt) {
		this.fileAtchPosblAt = fileAtchPosblAt;
	}

	public String getReplyPosblAt() {
		return replyPosblAt;
	}

	public void setReplyPosblAt(String replyPosblAt) {
		this.replyPosblAt = replyPosblAt;
	}

	public String getBbsTyCode() {
		return bbsTyCode;
	}

	public void setBbsTyCode(String bbsTyCode) {
		this.bbsTyCode = bbsTyCode;
	}

	public String getTableNm() {
		return tableNm;
	}

	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}

	public String getBbsAttrbCode() {
		return bbsAttrbCode;
	}

	public void setBbsAttrbCode(String bbsAttrbCode) {
		this.bbsAttrbCode = bbsAttrbCode;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public String getCmmntPosblAt() {
		return cmmntPosblAt;
	}

	public void setCmmntPosblAt(String cmmntPosblAt) {
		this.cmmntPosblAt = cmmntPosblAt;
	}

    public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getPopupYn() {
		return popupYn;
	}

	public void setPopupYn(String popupYn) {
		this.popupYn = popupYn;
	}

	public String getAddCon() {
		return addCon;
	}

	public void setAddCon(String addCon) {
		this.addCon = addCon;
	}

	public int getCurrentSize() {
		return currentSize;
	}

	public void setCurrentSize(int currentSize) {
		this.currentSize = currentSize;
	}

	/**
     * searchBgnDe attribute를 리턴한다.
     *
     * @return the searchBgnDe
     */
    public String getSearchBgnDe() {
	return searchBgnDe;
    }

    /**
     * searchBgnDe attribute 값을 설정한다.
     *
     * @param searchBgnDe
     *            the searchBgnDe to set
     */
    public void setSearchBgnDe(String searchBgnDe) {
	this.searchBgnDe = searchBgnDe;
    }

    /**
     * searchCnd attribute를 리턴한다.
     *
     * @return the searchCnd
     */
    public String getSearchCnd() {
	return searchCnd;
    }

    /**
     * searchCnd attribute 값을 설정한다.
     *
     * @param searchCnd
     *            the searchCnd to set
     */
    public void setSearchCnd(String searchCnd) {
	this.searchCnd = searchCnd;
    }

    /**
     * searchEndDe attribute를 리턴한다.
     *
     * @return the searchEndDe
     */
    public String getSearchEndDe() {
	return searchEndDe;
    }

    /**
     * searchEndDe attribute 값을 설정한다.
     *
     * @param searchEndDe
     *            the searchEndDe to set
     */
    public void setSearchEndDe(String searchEndDe) {
	this.searchEndDe = searchEndDe;
    }

    /**
     * searchWrd attribute를 리턴한다.
     *
     * @return the searchWrd
     */
    public String getSearchWrd() {
	return searchWrd;
    }

    /**
     * searchWrd attribute 값을 설정한다.
     *
     * @param searchWrd
     *            the searchWrd to set
     */
    public void setSearchWrd(String searchWrd) {
	this.searchWrd = searchWrd;
    }

    /**
     * sortOrdr attribute를 리턴한다.
     *
     * @return the sortOrdr
     */
    public String getSortOrdr() {
	return sortOrdr;
    }

    /**
     * sortOrdr attribute 값을 설정한다.
     *
     * @param sortOrdr
     *            the sortOrdr to set
     */
    public void setSortOrdr(String sortOrdr) {
	this.sortOrdr = sortOrdr;
    }

    /**
     * searchUseYn attribute를 리턴한다.
     *
     * @return the searchUseYn
     */
    public String getSearchUseYn() {
	return searchUseYn;
    }

    /**
     * searchUseYn attribute 값을 설정한다.
     *
     * @param searchUseYn
     *            the searchUseYn to set
     */
    public void setSearchUseYn(String searchUseYn) {
	this.searchUseYn = searchUseYn;
    }

    /**
     * pageIndex attribute를 리턴한다.
     *
     * @return the pageIndex
     */
    public int getPageIndex() {
	return pageIndex;
    }

    /**
     * pageIndex attribute 값을 설정한다.
     *
     * @param pageIndex
     *            the pageIndex to set
     */
    public void setPageIndex(int pageIndex) {
	this.pageIndex = pageIndex;
    }

    /**
     * pageUnit attribute를 리턴한다.
     *
     * @return the pageUnit
     */
    public int getPageUnit() {
	return pageUnit;
    }

    /**
     * pageUnit attribute 값을 설정한다.
     *
     * @param pageUnit
     *            the pageUnit to set
     */
    public void setPageUnit(int pageUnit) {
	this.pageUnit = pageUnit;
    }

    /**
     * pageSize attribute를 리턴한다.
     *
     * @return the pageSize
     */
    public int getPageSize() {
	return pageSize;
    }

    /**
     * pageSize attribute 값을 설정한다.
     *
     * @param pageSize
     *            the pageSize to set
     */
    public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
    }

    /**
     * firstIndex attribute를 리턴한다.
     *
     * @return the firstIndex
     */
    public int getFirstIndex() {
	return firstIndex;
    }

    /**
     * firstIndex attribute 값을 설정한다.
     *
     * @param firstIndex
     *            the firstIndex to set
     */
    public void setFirstIndex(int firstIndex) {
	this.firstIndex = firstIndex;
    }

    /**
     * lastIndex attribute를 리턴한다.
     *
     * @return the lastIndex
     */
    public int getLastIndex() {
	return lastIndex;
    }

    /**
     * lastIndex attribute 값을 설정한다.
     *
     * @param lastIndex
     *            the lastIndex to set
     */
    public void setLastIndex(int lastIndex) {
	this.lastIndex = lastIndex;
    }

    /**
     * recordCountPerPage attribute를 리턴한다.
     *
     * @return the recordCountPerPage
     */
    public int getRecordCountPerPage() {
	return recordCountPerPage;
    }

    /**
     * recordCountPerPage attribute 값을 설정한다.
     *
     * @param recordCountPerPage
     *            the recordCountPerPage to set
     */
    public void setRecordCountPerPage(int recordCountPerPage) {
	this.recordCountPerPage = recordCountPerPage;
    }

    /**
     * rowNo attribute를 리턴한다.
     *
     * @return the rowNo
     */
    public int getRowNo() {
	return rowNo;
    }

    /**
     * rowNo attribute 값을 설정한다.
     *
     * @param rowNo
     *            the rowNo to set
     */
    public void setRowNo(int rowNo) {
	this.rowNo = rowNo;
    }

    /**
     * frstRegisterNm attribute를 리턴한다.
     *
     * @return the frstRegisterNm
     */
    public String getFrstRegisterNm() {
	return frstRegisterNm;
    }

    /**
     * frstRegisterNm attribute 값을 설정한다.
     *
     * @param frstRegisterNm
     *            the frstRegisterNm to set
     */
    public void setFrstRegisterNm(String frstRegisterNm) {
	this.frstRegisterNm = frstRegisterNm;
    }

    /**
     * bbsTyCodeNm attribute를 리턴한다.
     *
     * @return the bbsTyCodeNm
     */
    public String getBbsTyCodeNm() {
	return bbsTyCodeNm;
    }

    /**
     * bbsTyCodeNm attribute 값을 설정한다.
     *
     * @param bbsTyCodeNm
     *            the bbsTyCodeNm to set
     */
    public void setBbsTyCodeNm(String bbsTyCodeNm) {
	this.bbsTyCodeNm = bbsTyCodeNm;
    }

    /**
     * bbsAttrbCodeNm attribute를 리턴한다.
     *
     * @return the bbsAttrbCodeNm
     */
    public String getBbsAttrbCodeNm() {
	return bbsAttrbCodeNm;
    }

    /**
     * bbsAttrbCodeNm attribute 값을 설정한다.
     *
     * @param bbsAttrbCodeNm
     *            the bbsAttrbCodeNm to set
     */
    public void setBbsAttrbCodeNm(String bbsAttrbCodeNm) {
	this.bbsAttrbCodeNm = bbsAttrbCodeNm;
    }

    /**
     * tmplatNm attribute를 리턴한다.
     *
     * @return the tmplatNm
     */
    public String getTmplatNm() {
	return tmplatNm;
    }

    /**
     * tmplatNm attribute 값을 설정한다.
     *
     * @param tmplatNm
     *            the tmplatNm to set
     */
    public void setTmplatNm(String tmplatNm) {
	this.tmplatNm = tmplatNm;
    }

    /**
     * lastUpdusrNm attribute를 리턴한다.
     *
     * @return the lastUpdusrNm
     */
    public String getLastUpdusrNm() {
	return lastUpdusrNm;
    }

    /**
     * lastUpdusrNm attribute 값을 설정한다.
     *
     * @param lastUpdusrNm
     *            the lastUpdusrNm to set
     */
    public void setLastUpdusrNm(String lastUpdusrNm) {
	this.lastUpdusrNm = lastUpdusrNm;
    }

    /**
     * authFlag attribute를 리턴한다.
     *
     * @return the authFlag
     */
    public String getAuthFlag() {
	return authFlag;
    }

    /**
     * authFlag attribute 값을 설정한다.
     *
     * @param authFlag
     *            the authFlag to set
     */
    public void setAuthFlag(String authFlag) {
	this.authFlag = authFlag;
    }

    /**
     * tmplatCours attribute를 리턴한다.
     *
     * @return the tmplatCours
     */
    public String getTmplatCours() {
	return tmplatCours;
    }

    /**
     * tmplatCours attribute 값을 설정한다.
     *
     * @param tmplatCours
     *            the tmplatCours to set
     */
    public void setTmplatCours(String tmplatCours) {
	this.tmplatCours = tmplatCours;
    }

    /**
     * proBbsAttrbCode attribute를 리턴한다.
     *
     * @return the proBbsAttrbCode
     */
    public String getProBbsAttrbCode() {
	return proBbsAttrbCode;
    }

    /**
     * proBbsAttrbCode attribute 값을 설정한다.
     *
     * @param proBbsAttrbCode
     *            the proBbsAttrbCode to set
     */
    public void setProBbsAttrbCode(String proBbsAttrbCode) {
	this.proBbsAttrbCode = proBbsAttrbCode;
    }

    /**
     * proUseAt attribute를 리턴한다.
     *
     * @return the proUseAt
     */
    public String getProUseAt() {
	return proUseAt;
    }

    /**
     * proUseAt attribute 값을 설정한다.
     *
     * @param proUseAt
     *            the proUseAt to set
     */
    public void setProUseAt(String proUseAt) {
	this.proUseAt = proUseAt;
    }

    /**
     * proReplyPosblAt attribute를 리턴한다.
     *
     * @return the proReplyPosblAt
     */
    public String getProReplyPosblAt() {
	return proReplyPosblAt;
    }

    /**
     * proReplyPosblAt attribute 값을 설정한다.
     *
     * @param proReplyPosblAt
     *            the proReplyPosblAt to set
     */
    public void setProReplyPosblAt(String proReplyPosblAt) {
	this.proReplyPosblAt = proReplyPosblAt;
    }

    /**
     * proFileAtchPosblAt attribute를 리턴한다.
     *
     * @return the proFileAtchPosblAt
     */
    public String getProFileAtchPosblAt() {
	return proFileAtchPosblAt;
    }

    /**
     * proFileAtchPosblAt attribute 값을 설정한다.
     *
     * @param proFileAtchPosblAt
     *            the proFileAtchPosblAt to set
     */
    public void setProFileAtchPosblAt(String proFileAtchPosblAt) {
	this.proFileAtchPosblAt = proFileAtchPosblAt;
    }

    /**
     * ntceBgnde attribute를 리턴한다.
     *
     * @return the ntceBgnde
     */
    public String getNtceBgnde() {
	return ntceBgnde;
    }

    /**
     * ntceBgnde attribute 값을 설정한다.
     *
     * @param ntceBgnde
     *            the ntceBgnde to set
     */
    public void setNtceBgnde(String ntceBgnde) {
	this.ntceBgnde = ntceBgnde;
    }

    /**
     * ntceEndde attribute를 리턴한다.
     *
     * @return the ntceEndde
     */
    public String getNtceEndde() {
	return ntceEndde;
    }

    /**
     * ntceEndde attribute 값을 설정한다.
     *
     * @param ntceEndde
     *            the ntceEndde to set
     */
    public void setNtceEndde(String ntceEndde) {
	this.ntceEndde = ntceEndde;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
}
