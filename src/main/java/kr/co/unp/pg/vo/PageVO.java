package kr.co.unp.pg.vo;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

public class PageVO {

	private String[] siteNames = null;
	private String pageCode = "";
	private String pageName = "";
	private String pageDesc = "";
	private String pageType = "";
	private Date creatDt = null;
	private String savePath = "";
	private List<FieldAttributeVO> fieldAttributes = null;	
	private String bbsId = "";
	
	private String fieldId = "";
	private String fieldType = "";
	private String fieldText = "";
	private String fieldList = "";
	private String tableName = "";
	private int menuNo = 0;
	
	public int getMenuNo() {
		return menuNo;
	}

	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}

	public String getBbsId() {
		return bbsId;
	}

	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	public String[] getSiteNames() {
		return siteNames;
	}

	public void setSiteNames(String[] siteNames) {
		this.siteNames = siteNames;
	}

	public String getPageDesc() {
		return pageDesc;
	}

	public void setPageDesc(String pageDesc) {
		this.pageDesc = pageDesc;
	}

	public String getPageCode() {
		return pageCode;
	}

	public void setPageCode(String pageCode) {
		this.pageCode = pageCode;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	public Date getCreatDt() {
		return creatDt;
	}

	public void setCreatDt(Date creatDt) {
		this.creatDt = creatDt;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public List<FieldAttributeVO> getFieldAttributes() {
		return fieldAttributes;
	}

	public void setFieldAttributes(List<FieldAttributeVO> fieldAttributes) {
		this.fieldAttributes = fieldAttributes;
	}

	@Override
	public String toString(){
		return ReflectionToStringBuilder.toString(this);
	}

	public String getFieldId() {
		return fieldId;
	}

	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}

	public String getFieldText() {
		return fieldText;
	}

	public void setFieldText(String fieldText) {
		this.fieldText = fieldText;
	}

	public String getFieldList() {
		return fieldList;
	}

	public void setFieldList(String fieldList) {
		this.fieldList = fieldList;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
}
