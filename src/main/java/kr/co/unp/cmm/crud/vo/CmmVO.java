package kr.co.unp.cmm.crud.vo;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import kr.co.unp.bbs.vo.SearchVO;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
@XmlRootElement(name="cmm")  
@XmlAccessorType(XmlAccessType.FIELD)
public class CmmVO extends SearchVO implements Serializable {

	private String programId = "";
	private String userIp = "";
	private String siteName = "";
	private String pageQueryString ="";
	private String menuNo = "";
	public String getProgramId() {
		return programId;
	}

	public void setProgramId(String programId) {
		this.programId = programId;
	}

	public String getUserIp() {
		return userIp;
	}

	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

	
	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

	public String getPageQueryString() {
		return pageQueryString;
	}

	public void setPageQueryString(String pageQueryString) {
		this.pageQueryString = pageQueryString;
	}

	public String getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}

}
