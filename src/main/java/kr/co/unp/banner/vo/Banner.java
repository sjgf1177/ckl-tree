/**
 *
 *
 * @author 김명구
 * @since 2010. 1. 21.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      	수정자      	수정내용
 *  -------    		--------    --------------------------
 *   2010. 1. 21.  김명구      	최초 생성
 *
 * Copyright (C) 2010 by MOPAS  All right reserved.
 * </pre>
 */


package kr.co.unp.banner.vo;

import kr.co.unp.bbs.vo.SearchVO;


public class Banner extends SearchVO {

	/**
	 *
	 */
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

	private int bnr_cd = 0;
	private String bnr_nm = "";
	private String bnr_url = "http://";
	private String bnr_img_path = "";
	private String dept_id = "";
	private String reg_user_id = "";
	private String last_mod_user_id = "";
	private String publish = "";
	private String dept = "";
	private String dong = "";
	private String bnr_img_org_nm = "";
	private String bnr_img_nm = "";
	private String gubun = "";
	private String use_banner = "";
	private String use_banner_nm = "";
	private String popup = "";
	private String status = "";

	private String start_dt = "";
	private String end_dt = "";
	private String reg_dt = "";
	private String deptNmKor ="";
	private String file1_cn = "";
	private String file2_cn = "";

	public int visible_cnt = 1;

	public int orderly = 0;

	public String getDept_id() {
		return dept_id;
	}
	public void setDept_id(String dept_id) {
		this.dept_id = dept_id;
	}
	public String getReg_user_id() {
		return reg_user_id;
	}
	public void setReg_user_id(String reg_user_id) {
		this.reg_user_id = reg_user_id;
	}
	public String getLast_mod_user_id() {
		return last_mod_user_id;
	}
	public void setLast_mod_user_id(String last_mod_user_id) {
		this.last_mod_user_id = last_mod_user_id;
	}
	public String getUse_banner_nm() {
		return use_banner_nm;
	}
	public void setUse_banner_nm(String use_banner_nm) {
		this.use_banner_nm = use_banner_nm;
	}
	public int getCurrentSize() {
		return currentSize;
	}
	public void setCurrentSize(int currentSize) {
		this.currentSize = currentSize;
	}
	public int getOrderly() {
		return orderly;
	}
	public void setOrderly(int orderly) {
		this.orderly = orderly;
	}
	public String getStart_dt() {
		return start_dt;
	}
	public void setStart_dt(String start_dt) {
		this.start_dt = start_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	public String getUse_banner() {
		return use_banner;
	}
	public void setUse_banner(String use_banner) {
		this.use_banner = use_banner;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getBnr_img_org_nm() {
		return bnr_img_org_nm;
	}
	public void setBnr_img_org_nm(String bnr_img_org_nm) {
		this.bnr_img_org_nm = bnr_img_org_nm;
	}
	public String getBnr_img_nm() {
		return bnr_img_nm;
	}
	public void setBnr_img_nm(String bnr_img_nm) {
		this.bnr_img_nm = bnr_img_nm;
	}
	public int getBnr_cd() {
		return bnr_cd;
	}
	public void setBnr_cd(int bnr_cd) {
		this.bnr_cd = bnr_cd;
	}
	public String getBnr_nm() {
		return bnr_nm;
	}
	public void setBnr_nm(String bnr_nm) {
		this.bnr_nm = bnr_nm;
	}
	public String getBnr_url() {
		return bnr_url;
	}
	public void setBnr_url(String bnr_url) {
		this.bnr_url = bnr_url;
	}
	public String getPublish() {
		return publish;
	}
	public void setPublish(String publish) {
		this.publish = publish;
	}
	public String getBnr_img_path() {
		return bnr_img_path;
	}
	public void setBnr_img_path(String bnr_img_path) {
		this.bnr_img_path = bnr_img_path;
	}

	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public int getVisible_cnt() {
		return visible_cnt;
	}
	public void setVisible_cnt(int visible_cnt) {
		this.visible_cnt = visible_cnt;
	}
	public String getPopup() {
		return popup;
	}
	public void setPopup(String popup) {
		this.popup = popup;
	}
	public String getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
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

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
