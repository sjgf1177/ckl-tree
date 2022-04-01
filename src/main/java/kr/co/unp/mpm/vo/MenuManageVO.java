package kr.co.unp.mpm.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 메뉴목록관리 처리를 위한 VO 클래스르를 정의한다
 *
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */

public class MenuManageVO implements Serializable {

	private static final long serialVersionUID = 402029306912962535L;
	/** 메뉴정보 */
	/** 메뉴번호 */
	private int menuNo;

	private int preMenuNo;

	private int nextMenuNo;

	private int cMenuNo;
	/** 메뉴순서 */
	private int menuOrdr;
	/** 메뉴명 */
	private String menuNm = "";
	/** 상위메뉴번호 */
	private int upperMenuId;

	private int upperMenuNo;
	/** 메뉴설명 */
	private String menuDc = "";
	/** 관련이미지경로 */
	private String relateImagePath = "";
	/** 관련이미지명 */
	private String relateImageNm = "";
	/** 프로그램파일명 */
	private String progrmFileNm = "";

	private String siteId = "1";

	private String menuLink = "";

	private String preMenuLink = "";

	private String nextMenuLink = "";

	private String menuPopupYn = "N";

	private String deptId = "";

	private String userId = "";

	private String userName = "";

	private String path = "";

	private String fullPath = "";

	private String fullMenuLink = "";

	private String contentsPath = "";

	private String useYn = "N";

	/** 사이트맵 */
	/** 생성자ID **/
	private String creatPersonId = "";

	/** 권한정보설정 */
	/** 권한코드 */
	private String authorCode = "";

	/** 기타VO변수 */
	private String tempValue = "";
	private int tempInt;

	/** Login 메뉴관련 VO변수 */
	/** tmp_Id */
	private String tmp_Id;
	/** tmp_Password */
	private String tmp_Password;
	/** tmp_Name */
	private String tmp_Name;
	/** tmp_UserSe */
	private String tmp_UserSe;
	/** tmp_Email */
	private String tmp_Email;
	/** tmp_OrgnztId */
	private String tmp_OrgnztId;
	/** tmp_UniqId */
	private String tmp_UniqId;
	/** tmp_Cmd */
	private String tmp_Cmd;

	private int chkYeoBu;

	private int roleAdminChkYeoBu;

	private Date modifyDay = new Date();

	private String tel = "";

	private String lastTel = "";

	private String fax = "";

	private String deptName = "";

	private String teamName = "";


	private String addCss = ""; //호환성 때문에 css를 메뉴에서 등록 가능하도록 추가
	private String addJs = ""; //호환성 때문에 js를 메뉴에서 등록 가능하도록 추가
	private String gcon_pcode = "";
	private String gcon_uid = "";
	private String gcon_subject = "";
	private String preCon = "";
	private String nxtCon = "";
	private String chkConModi = "";
	private int cvNo = 0;
	private String cvCon = "";

	private String position = "";

	private String deptCode = "";

	private String gconPcode = "";

	private String leafNodeYn = "N";

	private int depth = 0;

	private String siteName = "";

	private String bbsId = "";

	private String pic = "";

	private String adnm = "";

	private String kogl = "";

	private int topMenuNo = 0;

	private String menuNoPath = "";

	private String layoutSe = "";

	public int getcMenuNo() {
		return cMenuNo;
	}

	public void setcMenuNo(int cMenuNo) {
		this.cMenuNo = cMenuNo;
	}

	public String getMenuNoPath() {
		return menuNoPath;
	}

	public void setMenuNoPath(String menuNoPath) {
		this.menuNoPath = menuNoPath;
	}

	public int getRoleAdminChkYeoBu() {
		return roleAdminChkYeoBu;
	}

	public void setRoleAdminChkYeoBu(int roleAdminChkYeoBu) {
		this.roleAdminChkYeoBu = roleAdminChkYeoBu;
	}

	public String getKogl() {
		return kogl;
	}

	public void setKogl(String kogl) {
		this.kogl = kogl;
	}

	public String getAdnm() {
		return adnm;
	}

	public void setAdnm(String adnm) {
		this.adnm = adnm;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getBbsId() {
		return bbsId;
	}

	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getLeafNodeYn() {
		return leafNodeYn;
	}

	public void setLeafNodeYn(String leafNodeYn) {
		this.leafNodeYn = leafNodeYn;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getGconPcode() {
		return gconPcode;
	}

	public void setGconPcode(String gconPcode) {
		this.gconPcode = gconPcode;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public int getUpperMenuNo() {
		return upperMenuNo;
	}

	public void setUpperMenuNo(int upperMenuNo) {
		this.upperMenuNo = upperMenuNo;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getAddCss() {
		return addCss;
	}

	public void setAddCss(String addCss) {
		this.addCss = addCss;
	}

	public String getAddJs() {
		return addJs;
	}

	public void setAddJs(String addJs) {
		this.addJs = addJs;
	}

	public String getLastTel() {
		return lastTel;
	}

	public void setLastTel(String lastTel) {
		this.lastTel = lastTel;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContentsPath() {
		return contentsPath;
	}

	public void setContentsPath(String contentsPath) {
		this.contentsPath = contentsPath;
	}

	public int getChkYeoBu() {
		return chkYeoBu;
	}

	public void setChkYeoBu(int chkYeoBu) {
		this.chkYeoBu = chkYeoBu;
	}

	public String getFullPath() {
		return fullPath;
	}

	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}

	/**
	 * menuNo attribute를 리턴한다.
	 *
	 * @return int
	 */
	public int getMenuNo() {
		return menuNo;
	}

	/**
	 * menuNo attribute 값을 설정한다.
	 *
	 * @param menuNo
	 *            int
	 */
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}

	/**
	 * menuOrdr attribute를 리턴한다.
	 *
	 * @return int
	 */
	public int getMenuOrdr() {
		return menuOrdr;
	}

	/**
	 * menuOrdr attribute 값을 설정한다.
	 *
	 * @param menuOrdr
	 *            int
	 */
	public void setMenuOrdr(int menuOrdr) {
		this.menuOrdr = menuOrdr;
	}

	/**
	 * menuNm attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getMenuNm() {
		return menuNm;
	}

	/**
	 * menuNm attribute 값을 설정한다.
	 *
	 * @param menuNm
	 *            String
	 */
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}

	/**
	 * upperMenuId attribute를 리턴한다.
	 *
	 * @return int
	 */
	public int getUpperMenuId() {
		return upperMenuId;
	}

	/**
	 * upperMenuId attribute 값을 설정한다.
	 *
	 * @param upperMenuId
	 *            int
	 */
	public void setUpperMenuId(int upperMenuId) {
		this.upperMenuId = upperMenuId;
	}

	/**
	 * menuDc attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getMenuDc() {
		return menuDc;
	}

	/**
	 * menuDc attribute 값을 설정한다.
	 *
	 * @param menuDc
	 *            String
	 */
	public void setMenuDc(String menuDc) {
		this.menuDc = menuDc;
	}

	/**
	 * relateImagePath attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getRelateImagePath() {
		return relateImagePath;
	}

	/**
	 * relateImagePath attribute 값을 설정한다.
	 *
	 * @param relateImagePath
	 *            String
	 */
	public void setRelateImagePath(String relateImagePath) {
		this.relateImagePath = relateImagePath;
	}

	/**
	 * relateImageNm attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getRelateImageNm() {
		return relateImageNm;
	}

	/**
	 * relateImageNm attribute 값을 설정한다.
	 *
	 * @param relateImageNm
	 *            String
	 */
	public void setRelateImageNm(String relateImageNm) {
		this.relateImageNm = relateImageNm;
	}

	/**
	 * progrmFileNm attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getProgrmFileNm() {
		return progrmFileNm;
	}

	/**
	 * progrmFileNm attribute 값을 설정한다.
	 *
	 * @param progrmFileNm
	 *            String
	 */
	public void setProgrmFileNm(String progrmFileNm) {
		this.progrmFileNm = progrmFileNm;
	}

	/**
	 * creatPersonId attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getCreatPersonId() {
		return creatPersonId;
	}

	/**
	 * creatPersonId attribute 값을 설정한다.
	 *
	 * @param creatPersonId
	 *            String
	 */
	public void setCreatPersonId(String creatPersonId) {
		this.creatPersonId = creatPersonId;
	}

	/**
	 * authorCode attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getAuthorCode() {
		return authorCode;
	}

	/**
	 * authorCode attribute 값을 설정한다.
	 *
	 * @param authorCode
	 *            String
	 */
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	/**
	 * tmp_Id attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_Id() {
		return tmp_Id;
	}

	/**
	 * tmp_Id attribute 값을 설정한다.
	 *
	 * @param tmp_Id
	 *            String
	 */
	public void setTmp_Id(String tmp_Id) {
		this.tmp_Id = tmp_Id;
	}

	/**
	 * tmp_Password attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_Password() {
		return tmp_Password;
	}

	/**
	 * tmp_Password attribute 값을 설정한다.
	 *
	 * @param tmp_Password
	 *            String
	 */
	public void setTmp_Password(String tmp_Password) {
		this.tmp_Password = tmp_Password;
	}

	/**
	 * tmp_Name attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_Name() {
		return tmp_Name;
	}

	/**
	 * tmp_Name attribute 값을 설정한다.
	 *
	 * @param tmp_Name
	 *            String
	 */
	public void setTmp_Name(String tmp_Name) {
		this.tmp_Name = tmp_Name;
	}

	/**
	 * tmp_UserSe attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_UserSe() {
		return tmp_UserSe;
	}

	/**
	 * tmp_UserSe attribute 값을 설정한다.
	 *
	 * @param tmp_UserSe
	 *            String
	 */
	public void setTmp_UserSe(String tmp_UserSe) {
		this.tmp_UserSe = tmp_UserSe;
	}

	/**
	 * tmp_Email attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_Email() {
		return tmp_Email;
	}

	/**
	 * tmp_Email attribute 값을 설정한다.
	 *
	 * @param tmp_Email
	 *            String
	 */
	public void setTmp_Email(String tmp_Email) {
		this.tmp_Email = tmp_Email;
	}

	/**
	 * tmp_OrgnztId attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_OrgnztId() {
		return tmp_OrgnztId;
	}

	/**
	 * tmp_OrgnztId attribute 값을 설정한다.
	 *
	 * @param tmp_OrgnztId
	 *            String
	 */
	public void setTmp_OrgnztId(String tmp_OrgnztId) {
		this.tmp_OrgnztId = tmp_OrgnztId;
	}

	/**
	 * tmp_UniqId attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_UniqId() {
		return tmp_UniqId;
	}

	/**
	 * tmp_UniqId attribute 값을 설정한다.
	 *
	 * @param tmp_UniqId
	 *            String
	 */
	public void setTmp_UniqId(String tmp_UniqId) {
		this.tmp_UniqId = tmp_UniqId;
	}

	/**
	 * tmp_Cmd attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTmp_Cmd() {
		return tmp_Cmd;
	}

	/**
	 * tmp_Cmd attribute 값을 설정한다.
	 *
	 * @param tmp_Cmd
	 *            String
	 */
	public void setTmp_Cmd(String tmp_Cmd) {
		this.tmp_Cmd = tmp_Cmd;
	}

	/**
	 * tempValue attribute를 리턴한다.
	 *
	 * @return String
	 */
	public String getTempValue() {
		return tempValue;
	}

	/**
	 * tempValue attribute 값을 설정한다.
	 *
	 * @param tempValue
	 *            String
	 */
	public void setTempValue(String tempValue) {
		this.tempValue = tempValue;
	}

	/**
	 * tempInt attribute를 리턴한다.
	 *
	 * @return int
	 */
	public int getTempInt() {
		return tempInt;
	}

	/**
	 * tempInt attribute 값을 설정한다.
	 *
	 * @param tempInt
	 *            int
	 */
	public void setTempInt(int tempInt) {
		this.tempInt = tempInt;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getMenuLink() {
		return menuLink;
	}

	public void setMenuLink(String menuLink) {
		this.menuLink = menuLink;
	}

	public String getMenuPopupYn() {
		return menuPopupYn;
	}

	public void setMenuPopupYn(String menuPopupYn) {
		this.menuPopupYn = menuPopupYn;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getFullMenuLink() {
		return fullMenuLink;
	}

	public void setFullMenuLink(String fullMenuLink) {
		this.fullMenuLink = fullMenuLink;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public Date getModifyDay() {
		return modifyDay;
	}

	public void setModifyDay(Date modifyDay) {
		this.modifyDay = modifyDay;
	}

	public String getGcon_pcode() {
		return gcon_pcode;
	}

	public void setGcon_pcode(String gconPcode) {
		gcon_pcode = gconPcode;
	}

	public String getGcon_uid() {
		return gcon_uid;
	}

	public void setGcon_uid(String gconUid) {
		gcon_uid = gconUid;
	}

	public String getGcon_subject() {
		return gcon_subject;
	}

	public void setGcon_subject(String gconSubject) {
		gcon_subject = gconSubject;
	}

	public String getPreCon() {
		return preCon;
	}

	public void setPreCon(String preCon) {
		this.preCon = preCon;
	}

	public String getNxtCon() {
		return nxtCon;
	}

	public void setNxtCon(String nxtCon) {
		this.nxtCon = nxtCon;
	}

	public String getChkConModi() {
		return chkConModi;
	}

	public void setChkConModi(String chkConModi) {
		this.chkConModi = chkConModi;
	}

	public int getCvNo() {
		return cvNo;
	}

	public void setCvNo(int cvNo) {
		this.cvNo = cvNo;
	}

	public String getCvCon() {
		return cvCon;
	}

	public void setCvCon(String cvCon) {
		this.cvCon = cvCon;
	}

	public int getTopMenuNo() {
		return topMenuNo;
	}

	public void setTopMenuNo(int topMenuNo) {
		this.topMenuNo = topMenuNo;
	}


	public String getLayoutSe() {
		return layoutSe;
	}

	public void setLayoutSe(String layoutSe) {
		this.layoutSe = layoutSe;
	}


	public int getPreMenuNo() {
		return preMenuNo;
	}

	public void setPreMenuNo(int preMenuNo) {
		this.preMenuNo = preMenuNo;
	}

	public int getNextMenuNo() {
		return nextMenuNo;
	}

	public void setNextMenuNo(int nextMenuNo) {
		this.nextMenuNo = nextMenuNo;
	}


	public String getPreMenuLink() {
		return preMenuLink;
	}

	public void setPreMenuLink(String preMenuLink) {
		this.preMenuLink = preMenuLink;
	}

	public String getNextMenuLink() {
		return nextMenuLink;
	}

	public void setNextMenuLink(String nextMenuLink) {
		this.nextMenuLink = nextMenuLink;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("[menuNo," + menuNo + "]");
		sb.append("[menuNm," + menuNm + "]");
		sb.append("[menuLink," + menuLink + "]");
		sb.append("[fullMenuLink," + fullMenuLink + "]");
		sb.append("[path," + path + "]");
		sb.append("[menuNoPath," + menuNoPath + "]");
		sb.append("[leafNodeYn," + leafNodeYn + "]");
		return sb.toString();
	}

}