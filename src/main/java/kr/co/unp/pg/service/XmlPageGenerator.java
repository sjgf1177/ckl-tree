package kr.co.unp.pg.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.jdom.CDATA;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Text;
import org.jdom.input.SAXBuilder;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;
import kr.co.unp.util.StrUtils;

public class XmlPageGenerator extends DefaultPageGenerator implements ApplicationContextAware {

	Logger log = Logger.getLogger(this.getClass());

	protected ApplicationContext context;

	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.context = applicationContext;
	}

	@Override
	public PageTemplate[] getPageTemplates(PageVO vo){
		String[] siteNames = vo.getSiteNames();
		String pageType = vo.getPageType();
		if( ArrayUtils.isEmpty(siteNames) ) {
			siteNames = new String[1];
			siteNames[0] = "bos";
		}
		List<PageTemplate> _templates = new ArrayList<PageTemplate>();
		for(String siteName : siteNames) {
			String[] beanNames = StrUtils.split(beanNameMap.get(pageType), ",");
			for(String name : beanNames) {
				String beanName = siteName + name;
				try {
					PageTemplate template = (PageTemplate)context.getBean(beanName);
					_templates.add(template);
					vo.setTableName(template.getTABLE_NAME());
				} catch (BeansException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		PageTemplate[] templates = (PageTemplate[])_templates.toArray(new PageTemplate[_templates.size()]);
		return templates;
	}

	@Override
	public void createPage(PageVO vo, ModelMap model) throws Exception {
		//String newLine = System.getProperty("line.separator");

		SAXBuilder builder = new SAXBuilder();
		PageTemplate[] templates = getPageTemplates(vo);
		for(PageTemplate template : templates)
		{
			List<FieldAttributeVO> fieldList = template.selectFieldAttributeList(vo);
			Document document = builder.build(template.getTemplatePath());
			Element root = document.getRootElement();
			Iterator it = root.getContent().iterator();
			StringBuffer result = new StringBuffer();
			while(it.hasNext()) {
				Object o = it.next();
				if ( o instanceof CDATA || o instanceof Text ) {
					String txt = ((Text)o).getText();
					if( StringUtils.hasText(txt) )
						result.append(txt);
				}	
				else if( o instanceof Element ) {
					Element e = (Element)o;
					processForEachTag(e, result, fieldList, template.getTemplatePath().toLowerCase().indexOf("list")>-1 ? true : false);
				}
			}

			String outputPath = StrUtils.replace(template.getOutputPath(), REPLACE_PAGE_CODE_MARK, vo.getPageCode());
			File outputFile = new File(outputPath);
			if (outputFile.isFile()){
				outputFile.renameTo(new File(outputPath.replaceAll("\\.jsp", "_" + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date())+"\\.jsp")));
			}
			FileUtils.writeStringToFile(outputFile, result.toString());
			log.debug("<<" + outputPath + " file created!");
		}		
	}

	private void processForEachTag(Element e, StringBuffer result, List<FieldAttributeVO> fieldList, boolean listFlag) {
		String forEachTxt = e.getText();
		if( StringUtils.hasText(forEachTxt) ) {
			for( FieldAttributeVO vo : fieldList ) {
				if (listFlag==false || (listFlag && (vo.getFieldList()!=null && vo.getFieldList().equals("Y")))){
				String _contents = StrUtils.replace(forEachTxt, REPLACE_NAME_MARK, vo.getFieldName());
				_contents = StrUtils.replace(_contents, REPLACE_TEXT_MARK, vo.getFieldText());
				_contents = StrUtils.replace(_contents, REPLACE_TYPE_MARK, vo.getFieldType());
				//System.out.println(_contents);
				result.append(_contents);
				}
			}
		}
		else {
			processIsEqualTag(e, result, fieldList, listFlag);
		}
	}
	
	private void processIsEqualTag(Element parentEle, StringBuffer result, List<FieldAttributeVO> fieldList, boolean listFlag) {
		Map<String, String> valueMap = new HashMap<String, String>();
		Iterator<Element> _it = parentEle.getChildren().iterator();
		while( _it.hasNext() ) {
			Element isEqualEle = _it.next();
			String isEqualTxt = isEqualEle.getText();
			String value = isEqualEle.getAttribute("value").getValue();
			valueMap.put(value, isEqualTxt);
		}
		for(FieldAttributeVO vo : fieldList) {
			if (listFlag==false || (listFlag && (vo.getFieldList()!=null && vo.getFieldList().equals("Y")))){
				String isEqualTxt = valueMap.get(vo.getFieldName());
				if( isEqualTxt == null ) {
					isEqualTxt = valueMap.get("default-" + vo.getFieldType());
					if( isEqualTxt == null ) isEqualTxt = valueMap.get("default");
				}
				String _contents = StrUtils.replace(isEqualTxt, REPLACE_NAME_MARK, vo.getFieldName());
				_contents = StrUtils.replace(_contents, REPLACE_TEXT_MARK, vo.getFieldText());
				_contents = StrUtils.replace(_contents, REPLACE_TYPE_MARK, vo.getFieldType());
				result.append(_contents);
			}
		}
	}

}
