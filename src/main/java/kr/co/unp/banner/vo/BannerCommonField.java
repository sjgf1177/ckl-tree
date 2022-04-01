package kr.co.unp.banner.vo;

import java.util.Date;

public class BannerCommonField extends BannerPagingInfo {

	private String dept_id = "";
	private Date reg_dt = null;
	private String reg_user_id = "";
	private Date last_mod_dt = null;
	private String last_mod_user_id = "";
	private String is_del = "";
	
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
	
}
