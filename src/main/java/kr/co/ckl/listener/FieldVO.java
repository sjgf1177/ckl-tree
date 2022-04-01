package kr.co.ckl.listener;

import java.io.Reader;
import java.io.Serializable;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import kr.co.ckl.listener.EtcFieldVO.Value;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.digester.Digester;
import org.apache.commons.lang.builder.ToStringBuilder;

public class FieldVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1758567882892930439L;
	private ArrayList<EtcFieldVO> etcData = new ArrayList<EtcFieldVO>();

	public String toXml(){
		StringBuilder xml = new StringBuilder();
		xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		xml.append("<fieldInfo>");
		ArrayList<EtcFieldVO> etcData = getEtcData();
		if( CollectionUtils.isNotEmpty(etcData) ){
			xml.append("<etc>");
			for(EtcFieldVO etcVO : etcData){
				xml.append("<type>").append(etcVO.getType()).append("</type>");
				xml.append("<name>").append(etcVO.getName()).append("</name>");
				xml.append("<text>").append(etcVO.getText()).append("</text>");
				ArrayList<Value> values = etcVO.getValues();
				if( CollectionUtils.isNotEmpty(values) ){
					xml.append("<values>");
					for(Value value : values){
						xml.append("<value checkedYn='").append(value.getCheckedYn()).append("'>").append(value.getValue()).append("</value>");
					}
					xml.append("</values>");
				}
			}
			xml.append("</etc>");
		}
		xml.append("</fieldInfo>");
		return xml.toString();
	}

	public static String toXml(ZValue param){
		StringBuilder xml = new StringBuilder();
		xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		xml.append("<fieldInfo>");
		List<String> names = param.getList("name");
		List<String> types = param.getList("type");
		List<String> texts = param.getList("text");
		if( CollectionUtils.isNotEmpty(types) )
		{
			for(int i=0; i<names.size(); i++){
				xml.append("<etc>");
				xml.append("<type>").append(types.get(i)).append("</type>");
				xml.append("<name>").append(names.get(i)).append("</name>");
				xml.append("<text>").append(texts.get(i)).append("</text>");
				List<String> values = param.getList("value_"+names.get(i));
				List<String> checkedYns = param.getList("checkedYn_"+names.get(i));
				if( CollectionUtils.isNotEmpty(values) ){
					xml.append("<values>");
					for(int j=0; j<values.size(); j++){
						xml.append("<value checkedYn='").append(checkedYns.get(j)).append("'>").append(values.get(j)).append("</value>");
					}
					xml.append("</values>");
				}
				xml.append("</etc>");
			}
		}
		xml.append("</fieldInfo>");
		return xml.toString();
	}

	public static FieldVO parseFieldInfo(String xml){
		Digester digester = new Digester();
		
		digester.addObjectCreate("fieldInfo", FieldVO.class); 

		digester.addObjectCreate("fieldInfo/etc", EtcFieldVO.class); 
		digester.addBeanPropertySetter("fieldInfo/etc/type", "type");
		digester.addBeanPropertySetter("fieldInfo/etc/name", "name");
		digester.addBeanPropertySetter("fieldInfo/etc/text", "text");

		digester.addObjectCreate("fieldInfo/etc/values/value", Value.class); 
		digester.addBeanPropertySetter("fieldInfo/etc/values/value", "value");
		digester.addSetProperties("fieldInfo/etc/values/value", "checkedYn", "checkedYn");
		digester.addSetNext("fieldInfo/etc/values/value", "addValue");

		digester.addSetNext("fieldInfo/etc", "addEtc");
		
		FieldVO vo = null;
		try {
			Reader r = new StringReader(xml);
			vo = (FieldVO) digester.parse(r);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return vo;
	}
	
	public ArrayList<EtcFieldVO> getEtcData() {
		return etcData;
	}

	public void setEtcData(ArrayList<EtcFieldVO> etcData) {
		this.etcData = etcData;
	}

	public void addEtc(EtcFieldVO etc){
		etcData.add(etc);
	}

	public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
}
