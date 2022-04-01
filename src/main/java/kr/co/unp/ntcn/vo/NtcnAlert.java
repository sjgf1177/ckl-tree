package kr.co.unp.ntcn.vo;

import java.util.Date;

import kr.co.unp.bbs.vo.SearchVO;



public class NtcnAlert extends SearchVO {
	private static final long serialVersionUID = 4375853156043734024L;

	public static final String ALERT_TYPE = "01";
	public static final String MAIN_IMG_TYPE = "02";
	public static final String TOP_BANNER_TYPE = "03";
	public static final String BOTTOM_BANNER_TYPE = "04";
	private int alert_cd = 0;
	private String alert_nm = "";
	private String alert_url = "http://";
	private String popup = "Y";
	private String alert_img_path = "";
	private String publish = "";
	private String pub_sdate = null;
	private String pub_edate = null;
	private int priority = 0;
	private String category = "";
	private String category_nm = "";

	private String img_org_nm = "";
	private String img_nm = "";
	private String status = "";
	private int currentSize = 0;
	private String type = ALERT_TYPE;

	private String map_yn = "";

	private String dept_id = "";
	private Date reg_dt = null;
	private String reg_user_id = "";
	private Date last_mod_dt = null;
	private String last_mod_user_id = "";
	private String is_del = "N";
	private String deptNmKor ="";
	private String file1_cn = "";
	private String file2_cn = "";


	// SSOX_USER 테이블

	private String reg_user_name = "";		// 최초 등록자 이름
	private String last_mod_user_name = "";	// 마지막 수정자 이름
	private String dept_name = "";


	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public Date getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Date reg_dt) {
		this.reg_dt = reg_dt;
	}
	public String getReg_user_id() {
		return reg_user_id;
	}
	public void setReg_user_id(String reg_user_id) {
		this.reg_user_id = reg_user_id;
	}
	public Date getLast_mod_dt() {
		return last_mod_dt;
	}
	public void setLast_mod_dt(Date last_mod_dt) {
		this.last_mod_dt = last_mod_dt;
	}
	public String getLast_mod_user_id() {
		return last_mod_user_id;
	}
	public void setLast_mod_user_id(String last_mod_user_id) {
		this.last_mod_user_id = last_mod_user_id;
	}
	public String getIs_del() {
		return is_del;
	}
	public void setIs_del(String is_del) {
		this.is_del = is_del;
	}
	public String getReg_user_name() {
		return reg_user_name;
	}
	public void setReg_user_name(String reg_user_name) {
		this.reg_user_name = reg_user_name;
	}
	public String getLast_mod_user_name() {
		return last_mod_user_name;
	}
	public void setLast_mod_user_name(String last_mod_user_name) {
		this.last_mod_user_name = last_mod_user_name;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getCurrentSize() {
		return currentSize;
	}
	public void setCurrentSize(int currentSize) {
		this.currentSize = currentSize;
	}
	public String getCategory_nm() {
		return category_nm;
	}
	public void setCategory_nm(String category_nm) {
		this.category_nm = category_nm;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getImg_org_nm() {
		return img_org_nm;
	}
	public void setImg_org_nm(String img_org_nm) {
		this.img_org_nm = img_org_nm;
	}
	public String getImg_nm() {
		return img_nm;
	}
	public void setImg_nm(String img_nm) {
		this.img_nm = img_nm;
	}
	public int getAlert_cd() {
		return alert_cd;
	}
	public void setAlert_cd(int alert_cd) {
		this.alert_cd = alert_cd;
	}
	public String getAlert_nm() {
		return alert_nm;
	}
	public void setAlert_nm(String alert_nm) {
		this.alert_nm = alert_nm;
	}
	public String getAlert_url() {
		return alert_url;
	}
	public void setAlert_url(String alert_url) {
		this.alert_url = alert_url;
	}
	public String getPopup() {
		return popup;
	}
	public void setPopup(String popup) {
		this.popup = popup;
	}
	public String getAlert_img_path() {
		return alert_img_path;
	}
	public void setAlert_img_path(String alert_img_path) {
		this.alert_img_path = alert_img_path;
	}
	public String getPublish() {
		return publish;
	}
	public void setPublish(String publish) {
		this.publish = publish;
	}
	public String getPub_sdate() {
		return pub_sdate;
	}
	public void setPub_sdate(String pub_sdate) {
		this.pub_sdate = pub_sdate;
	}
	public String getPub_edate() {
		return pub_edate;
	}
	public void setPub_edate(String pub_edate) {
		this.pub_edate = pub_edate;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getMap_yn() {
		return map_yn;
	}
	public void setMap_yn(String map_yn) {
		this.map_yn = map_yn;
	}
	public String getDeptNmKor() {
		return deptNmKor;
	}
	public void setDeptNmKor(String deptNmKor) {
		this.deptNmKor = deptNmKor;
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

}