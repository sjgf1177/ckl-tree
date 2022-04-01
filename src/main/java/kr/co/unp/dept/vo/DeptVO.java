package kr.co.unp.dept.vo;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import kr.co.unp.bbs.vo.SearchVO;


@SuppressWarnings("serial")
@XmlRootElement(name="dept")  
@XmlAccessorType(XmlAccessType.FIELD)
public class DeptVO extends SearchVO implements Serializable {
	
	private String deptName = "";
	private String deptId = "";
	private String positionId = "";
	private String deptRank = "";
	private String upperDeptId = "";
	private int	deptDepth = 0;
	private String regDate = "";
	private String deptInfo = "";
	private String useYn = "";
	private String linkYn = "N";
	private int insertUpperDeptId = 0;
	
	public String getLinkYn() {
		return linkYn;
	}
	public void setLinkYn(String linkYn) {
		this.linkYn = linkYn;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptRank() {
		return deptRank;
	}
	public void setDeptRank(String deptRank) {
		this.deptRank = deptRank;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPositionId() {
		return positionId;
	}
	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}
	public String getUpperDeptId() {
		return upperDeptId;
	}
	public void setUpperDeptId(String upperDeptId) {
		this.upperDeptId = upperDeptId;
	}
	public int getDeptDepth() {
		return deptDepth;
	}
	public void setDeptDepth(int deptDepth) {
		this.deptDepth = deptDepth;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getDeptInfo() {
		return deptInfo;
	}
	public void setDeptInfo(String deptInfo) {
		this.deptInfo = deptInfo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public int getInsertUpperDeptId() {
		return insertUpperDeptId;
	}
	public void setInsert_upperDeptId(int insertUpperDeptId) {
		this.insertUpperDeptId = insertUpperDeptId;
	}
	
}
