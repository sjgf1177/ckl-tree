package kr.co.unp.member.vo;

import java.io.Serializable;
import java.util.Date;

import kr.co.unp.bbs.vo.SearchVO;

import org.apache.commons.lang.builder.ToStringBuilder;

public class UsersVO extends SearchVO implements Serializable {

	private static final long serialVersionUID = 2876900063125999565L;

	/**
	 * 일련번호
	 */
	private long userIdx = 0l;

	/**
	 * 인증키값
	 */
	private String userKey = "";

	/**
	 * 이름
	 */
	private String userNm = "";

	/**
	 * 인증구분(I:아이핀, H:핸드폰, F:페이스북)
	 */
	private String crtfcSe = "";

	/**
	 * 회원구분(01:일반, 02:SNS)
	 */
	private String mberSe = "";

	/**
	 * 아이디
	 */
	private String userId = "";

	/**
	 * 패스워드
	 */
	private String password = "";

	/**
	 * 패스워드 확인
	 */
	private String password2 = "";

	/**
	 * 이메일
	 */
	private String email = "";
	private String email1 = "";
	private String email2 = "";

	/**
	 * 모바일
	 */
	private String moblphon = "";
	private String moblphon1 = "";
	private String moblphon2 = "";
	private String moblphon3 = "";

	/**
	 * 생년월일
	 */
	private String brthdy = "";
	private String brthdy1 = "";
	private String brthdy2 = "";
	private String brthdy3 = "";

	/**
	 * 성별
	 */
	private String sex = "";

	/**
	 * 프로필 이미지
	 */
	private String atchFileId = "";

	/**
	 * 이메일 수신여부
	 */
	private String emailAt = "";

	/**
	 * SMS 수신여부
	 */
	private String smsAt = "";

	/**
	 * 부서명
	 */
	private String deptNm = "";

	/**
	 * 회원 아이피
	 */
	private String userIp = "";

	/**
	 * 우편번호
	 */
	private String zip = "";
	private String zip1 = "";
	private String zip2 = "";

	/**
	 * 주소
	 */
	private String address = "";
	private String detailAddress = "";

	/**
	 * 전화번호
	 */
	private String telno = "";
	private String telno1 = "";
	private String telno2 = "";
	private String telno3 = "";

	/**
	 * 권한코드
	 */
	private String authorCode = "";

	/**
	 * 회원 상태
	 */
	private String status = "";

	private int loginCount = 0;

	private String loginTime = "";

	private String delState = "";

	private String dupInfo = "";

	private String ciInfo = "";

	private String ntcrPinno = "";

	private String deptId = "";

	private String deptName2 = "";

	private String deptNmKor = "";

	private String deptNmEng = "";

	private String upperDeptId = "";

	private String adminTp = "";

	private String authAt = "";

	private String authSe = "";

	private String pwdChangeAt = "";

	private Date regDate = null;

	private Date lastLoginDt = null;

	private Date pwdChangeDt = null;

	private Date agreDt = null;

	private Date otherDt = null;

	private String agreAt = null;

	private String confirmKey = null;

	private String mentoYn = null;

	private String ssotoken = null;

	private String jobSe = "";

	private String ageSe = "";

	private String resdncSe = "";
	
	private String testbedYn = "";
	private String testbedCompAuth = "";


	public long getUserIdx() {
		return userIdx;
	}

	public void setUserIdx(long userIdx) {
		this.userIdx = userIdx;
	}


	public String getUserKey() {
		return userKey;
	}


	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public String getUserNm() {
		return userNm;
	}


	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}


	public String getCrtfcSe() {
		return crtfcSe;
	}


	public void setCrtfcSe(String crtfcSe) {
		this.crtfcSe = crtfcSe;
	}

	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getPassword2() {
		return password2;
	}


	public void setPassword2(String password2) {
		this.password2 = password2;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getEmail1() {
		return email1;
	}


	public void setEmail1(String email1) {
		this.email1 = email1;
	}


	public String getEmail2() {
		return email2;
	}


	public void setEmail2(String email2) {
		this.email2 = email2;
	}


	public String getMoblphon() {
		return moblphon;
	}


	public void setMoblphon(String moblphon) {
		this.moblphon = moblphon;
	}


	public String getMoblphon1() {
		return moblphon1;
	}


	public void setMoblphon1(String moblphon1) {
		this.moblphon1 = moblphon1;
	}


	public String getMoblphon2() {
		return moblphon2;
	}


	public void setMoblphon2(String moblphon2) {
		this.moblphon2 = moblphon2;
	}


	public String getMoblphon3() {
		return moblphon3;
	}


	public void setMoblphon3(String moblphon3) {
		this.moblphon3 = moblphon3;
	}


	public String getBrthdy() {
		return brthdy;
	}


	public void setBrthdy(String brthdy) {
		this.brthdy = brthdy;
	}


	public String getBrthdy1() {
		return brthdy1;
	}


	public void setBrthdy1(String brthdy1) {
		this.brthdy1 = brthdy1;
	}


	public String getBrthdy2() {
		return brthdy2;
	}


	public void setBrthdy2(String brthdy2) {
		this.brthdy2 = brthdy2;
	}


	public String getBrthdy3() {
		return brthdy3;
	}


	public void setBrthdy3(String brthdy3) {
		this.brthdy3 = brthdy3;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public String getAtchFileId() {
		return atchFileId;
	}


	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}


	public String getEmailAt() {
		return emailAt;
	}


	public void setEmailAt(String emailAt) {
		this.emailAt = emailAt;
	}


	public String getSmsAt() {
		return smsAt;
	}


	public void setSmsAt(String smsAt) {
		this.smsAt = smsAt;
	}


	public String getMberSe() {
		return mberSe;
	}


	public void setMberSe(String mberSe) {
		this.mberSe = mberSe;
	}


	public String getDeptNm() {
		return deptNm;
	}


	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}


	public String getUserIp() {
		return userIp;
	}


	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}


	public String getZip() {
		return zip;
	}


	public void setZip(String zip) {
		this.zip = zip;
	}


	public String getZip1() {
		return zip1;
	}


	public void setZip1(String zip1) {
		this.zip1 = zip1;
	}


	public String getZip2() {
		return zip2;
	}


	public void setZip2(String zip2) {
		this.zip2 = zip2;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getDetailAddress() {
		return detailAddress;
	}


	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}


	public String getTelno() {
		return telno;
	}


	public void setTelno(String telno) {
		this.telno = telno;
	}


	public String getTelno1() {
		return telno1;
	}


	public void setTelno1(String telno1) {
		this.telno1 = telno1;
	}


	public String getTelno2() {
		return telno2;
	}


	public void setTelno2(String telno2) {
		this.telno2 = telno2;
	}


	public String getTelno3() {
		return telno3;
	}


	public void setTelno3(String telno3) {
		this.telno3 = telno3;
	}


	public int getLoginCount() {
		return loginCount;
	}


	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}


	public String getLoginTime() {
		return loginTime;
	}


	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}


	public String getDelState() {
		return delState;
	}


	public void setDelState(String delState) {
		this.delState = delState;
	}


	public String getDupInfo() {
		return dupInfo;
	}


	public void setDupInfo(String dupInfo) {
		this.dupInfo = dupInfo;
	}


	public String getCiInfo() {
		return ciInfo;
	}


	public void setCiInfo(String ciInfo) {
		this.ciInfo = ciInfo;
	}


	public String getNtcrPinno() {
		return ntcrPinno;
	}


	public void setNtcrPinno(String ntcrPinno) {
		this.ntcrPinno = ntcrPinno;
	}


	public String getDeptId() {
		return deptId;
	}


	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}


	public String getDeptName2() {
		return deptName2;
	}


	public void setDeptName2(String deptName2) {
		this.deptName2 = deptName2;
	}


	public String getDeptNmKor() {
		return deptNmKor;
	}


	public void setDeptNmKor(String deptNmKor) {
		this.deptNmKor = deptNmKor;
	}


	public String getDeptNmEng() {
		return deptNmEng;
	}


	public void setDeptNmEng(String deptNmEng) {
		this.deptNmEng = deptNmEng;
	}


	public String getUpperDeptId() {
		return upperDeptId;
	}


	public void setUpperDeptId(String upperDeptId) {
		this.upperDeptId = upperDeptId;
	}

	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}


	public String getAuthorCode() {
		return authorCode;
	}


	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getAdminTp() {
		return adminTp;
	}


	public void setAdminTp(String adminTp) {
		this.adminTp = adminTp;
	}


	public String getAuthAt() {
		return authAt;
	}


	public void setAuthAt(String authAt) {
		this.authAt = authAt;
	}


	public String getAuthSe() {
		return authSe;
	}


	public void setAuthSe(String authSe) {
		this.authSe = authSe;
	}


	public Date getLastLoginDt() {
		return lastLoginDt;
	}


	public void setLastLoginDt(Date lastLoginDt) {
		this.lastLoginDt = lastLoginDt;
	}


	public Date getPwdChangeDt() {
		return pwdChangeDt;
	}


	public void setPwdChangeDt(Date pwdChangeDt) {
		this.pwdChangeDt = pwdChangeDt;
	}


	public Date getAgreDt() {
		return agreDt;
	}


	public void setAgreDt(Date agreDt) {
		this.agreDt = agreDt;
	}


	public Date getOtherDt() {
		return otherDt;
	}


	public void setOtherDt(Date otherDt) {
		this.otherDt = otherDt;
	}


	public String getPwdChangeAt() {
		return pwdChangeAt;
	}


	public void setPwdChangeAt(String pwdChangeAt) {
		this.pwdChangeAt = pwdChangeAt;
	}


	public String getAgreAt() {
		return agreAt;
	}


	public void setAgreAt(String agreAt) {
		this.agreAt = agreAt;
	}


	public String getConfirmKey() {
		return confirmKey;
	}

	public void setConfirmKey(String confirmKey) {
		this.confirmKey = confirmKey;
	}


	public String getMentoYn() {
		return mentoYn;
	}

	public void setMentoYn(String mentoYn) {
		this.mentoYn = mentoYn;
	}


	public String getSsotoken() {
		return ssotoken;
	}

	public void setSsotoken(String ssotoken) {
		this.ssotoken = ssotoken;
	}


	public String getResdncSe() {
		return resdncSe;
	}

	public void setResdncSe(String resdncSe) {
		this.resdncSe = resdncSe;
	}

	public String getJobSe() {
		return jobSe;
	}

	public void setJobSe(String jobSe) {
		this.jobSe = jobSe;
	}

	public String getAgeSe() {
		return ageSe;
	}

	public void setAgeSe(String ageSe) {
		this.ageSe = ageSe;
	}
	
	public String getTestbedYn() {
		return testbedYn;
	}
	
	public void setTestbedYn(String testbedYn) {
		this.testbedYn = testbedYn;
	}
	
	public String getTestbedCompAuth() {
		return testbedCompAuth;
	}
	
	public void setTestbedCompAuth(String testbedCompAuth) {
		this.testbedCompAuth = testbedCompAuth;
	}

	@Override
	public String toString()
	{
		return ToStringBuilder.reflectionToString(this);
	}
}
