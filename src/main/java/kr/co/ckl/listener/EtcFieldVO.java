package kr.co.ckl.listener;

import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;

import org.apache.commons.digester.Digester;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.springframework.util.StringUtils;

public class EtcFieldVO {
	
	private String type = ""; 
	private String name = ""; 
	private String value = ""; 
	private String text = ""; 
	private ArrayList<Value> values = new ArrayList<Value>(); 

	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	public ArrayList<Value> getValues() {
		return values;
	}
	public void setValues(ArrayList<Value> values) {
		this.values = values;
	}
	public void addValue(Value value){
		values.add(value);
	}
	@Override
	public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }

	@SuppressWarnings("unchecked")
	public static ArrayList<EtcFieldVO> parseFieldInfo(String xml){
		if( !StringUtils.hasText(xml) ) return null;
		ArrayList<EtcFieldVO> vodList = new ArrayList<EtcFieldVO>();
		Digester digester = new Digester();
		digester.push(vodList);

		digester.addObjectCreate("fieldInfo/etc", EtcFieldVO.class);
		digester.addBeanPropertySetter("fieldInfo/etc/type", "type");
		digester.addBeanPropertySetter("fieldInfo/etc/name", "name");
		digester.addBeanPropertySetter("fieldInfo/etc/value", "value");
		digester.addSetNext("fieldInfo/etc", "add");

		ArrayList<EtcFieldVO> result = null;
		try {
			Reader r = new StringReader(xml);
			result = (ArrayList<EtcFieldVO>) digester.parse(r);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public static class Value {
		
		private String checkedYn = "N";
		private String value = "";
		
		public String getCheckedYn() {
			return checkedYn;
		}
		public void setCheckedYn(String checkedYn) {
			this.checkedYn = checkedYn;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		@Override
		public String toString() {
	    	return ToStringBuilder.reflectionToString(this);
	    }
	}
}
