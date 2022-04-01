package kr.co.unp.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name  : BoardUser.java
 * @Description : 첨부파일에 대한 데이터 처리 모델
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.03.06       이삼섭                  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 *  Copyright (C) 2008 by MOPAS  All right reserved.
 */
@SuppressWarnings("serial")
public class BoardUser implements Serializable {

	private int seq;
	private	String [] groupNo;
	private String atchFileId;
	private String fileSn;
	private String name;
	private String cellPhone;
	private String mailAddress;
	private String type;
	private String rdate;

	/** set **/
	
	public void setSeq(int seq) {
		this.seq = seq;
	}


	public void setGroupNo(String[] groupNo) {
		this.groupNo = groupNo;
	}


	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}


	public void setFileSn(String fileSn) {
		this.fileSn = fileSn;
	}


	public void setName(String name) {
		this.name = name;
	}


	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}


	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}


	public void setType(String type) {
		this.type = type;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	
	/** get **/
	
	public int getSeq() {
		return seq;
	}


	public String[] getGroupNo() {
		return groupNo;
	}


	public String getAtchFileId() {
		return atchFileId;
	}


	public String getFileSn() {
		return fileSn;
	}


	public String getName() {
		return name;
	}


	public String getCellPhone() {
		return cellPhone;
	}


	public String getMailAddress() {
		return mailAddress;
	}


	public String getType() {
		return type;
	}

	public String getRdate() {
		return rdate;
	}


	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
