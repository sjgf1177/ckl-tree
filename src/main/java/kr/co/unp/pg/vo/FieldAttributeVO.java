package kr.co.unp.pg.vo;

import org.apache.commons.lang.builder.ToStringBuilder;

import kr.co.unp.util.StrUtils;

public class FieldAttributeVO {

	public static final String TEXT_TYPE = "text";
	public static final String SELECT_TYPE = "select";
	public static final String RADIO_TYPE = "radio";
	public static final String CHECKBOX_TYPE = "checkbox";
	public static final String EMPTY_TYPE = "empty";
		
	private int fieldId = 0;
	private String pageCode = "";
	private String fieldName = "";
	private String fieldType = "";
	private String fieldText = "";
	private String fieldList = "";
	private String pageType = "";
	private int fieldOrdr = 0;
	private String checkedYn = "N";
	
	public int getFieldOrdr() {
		return fieldOrdr;
	}
	public void setFieldOrdr(int fieldOrdr) {
		this.fieldOrdr = fieldOrdr;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	public int getFieldId() {
		return fieldId;
	}
	public void setFieldId(int fieldId) {
		this.fieldId = fieldId;
	}
	public String getPageCode() {
		return pageCode;
	}
	public void setPageCode(String pageCode) {
		this.pageCode = pageCode;
	}
	public String getFieldName() {
		return StrUtils.convert2CamelCase(fieldName);
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
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
	public String getCheckedYn() {
		return checkedYn;
	}
	public void setCheckedYn(String checkedYn) {
		this.checkedYn = checkedYn;
	}
	public String getFieldList() {
		return fieldList;
	}
	public void setFieldList(String fieldList) {
		this.fieldList = fieldList;
	}
	
	@Override
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}
}
