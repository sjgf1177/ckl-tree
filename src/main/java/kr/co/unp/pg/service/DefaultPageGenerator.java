package kr.co.unp.pg.service;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.pg.dao.PageGeneratorDAO;
import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.NamedMapBeansFactory;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;

public class DefaultPageGenerator extends PageTemplateImpl implements PageGenerator {

	Logger log = Logger.getLogger(this.getClass());

	protected final String REPLACE_COLGROUP_MARK = "<!-- colgroup contents -->";
	protected final String REPLACE_THEAD_MARK = "<!-- thead contents -->";
	protected final String REPLACE_TBODY_MARK = "<!-- tbody contents -->";
	protected final String REPLACE_NAME_MARK = "[fieldName]";
	protected final String REPLACE_TEXT_MARK = "[fieldText]";
	protected final String REPLACE_TYPE_MARK = "[fieldType]";
	protected final String REPLACE_PAGE_CODE_MARK = "[pageCode]";
	protected final String CONFLICT_PROPERTY_MARK = "@{";
	protected final String REPLACE_CONFLICT_PROPERTY_MARK = "${";

	@Resource(name = "namedMapBeansFactory")
	protected NamedMapBeansFactory fatory;

	@Resource(name = "pageGeneratorDAO")
	protected PageGeneratorDAO pageGeneratorDAO;

	@Resource(name="siteMngService")
	private SiteMngService siteMngService;

    @Resource(name = "pageCodeGnrService")
    protected EgovIdGnrService idgenService;

	protected Map<String, String> beanNameMap;


	public Map<String, String> getBeanNameMap() {
		return beanNameMap;
	}

	public void setBeanNameMap(Map<String, String> beanNameMap) {
		this.beanNameMap = beanNameMap;
	}

	public PageTemplate[] getPageTemplates(PageVO vo){
		fatory.setBeanNameMap(beanNameMap);
		Object[] objs = fatory.getBeans(vo.getPageType());
		PageTemplate[] templates = Arrays.copyOf(objs, objs.length, PageTemplate[].class);
		return templates;
	}

	public void getPageAttrList(PageVO vo, ModelMap model) throws Exception {
		model.addAttribute("resultList", pageGeneratorDAO.selectPageAttributeList(vo));
	}

	public void addPageAttribute(PageVO vo, ModelMap model) throws Exception {
		vo.setPageCode(idgenService.getNextStringId());
		pageGeneratorDAO.addPageAttribute(vo);
	}

	public void updatePageAttribute(PageVO vo, ModelMap model) throws Exception {
		pageGeneratorDAO.updatePageAttribute(vo);
	}

	public void deletePageAttribute(PageVO vo, ModelMap model) throws Exception {
		pageGeneratorDAO.deletePageAttribute(vo);
	}

	public void readPageInfo(PageVO vo, ModelMap model) throws Exception {
		PageVO result = pageGeneratorDAO.selectPageAttribute(vo);
		vo.setTableName(TABLE_NAME);
		List<FieldAttributeVO> fieldAttributes = pageGeneratorDAO.selectFieldAttributeList(vo);
		model.addAttribute("result", result);
		model.addAttribute("fieldAttributes", fieldAttributes);

		List<ZValue> siteList = siteMngService.getSiteList();
		model.addAttribute("siteList", siteList);
	}

	public void createPage(PageVO vo, ModelMap model) throws Exception {
		//String newLine = System.getProperty("line.separator");

		PageTemplate[] templates = getPageTemplates(vo);
		for(PageTemplate template : templates)
		{
			Map<String, String> fieldContents = template.getFieldContents();
			String templatePath = template.getTemplatePath();
			File templateFile = new File(templatePath.replaceAll("\\p{Space}", ""));
			String templateContents = FileUtils.readFileToString(templateFile);

			StringBuffer addedColgroupContents = new StringBuffer();
			StringBuffer addedTheadContents = new StringBuffer();
			StringBuffer addedTbodyContents = new StringBuffer();
			String theadContents = template.getTheadContents();
			List<FieldAttributeVO> fieldList = template.selectFieldAttributeList(vo);
			for( FieldAttributeVO fieldVO : fieldList ){
				if( "nttSj".equals(fieldVO.getFieldName()) )
					addedColgroupContents.append("\t\t\t\t<col width=\"*\" />\n");
				else
					addedColgroupContents.append("\t\t\t\t<col width=\"10\" />\n");
				String _theadContents = StrUtils.replace(theadContents, REPLACE_NAME_MARK, fieldVO.getFieldName());
				_theadContents = StrUtils.replace(_theadContents, REPLACE_TEXT_MARK, fieldVO.getFieldText());
				addedTheadContents.append(_theadContents);
				//addedTheadContents.append(newLine);

				String contents = fieldContents.get(fieldVO.getFieldName());
				if( contents == null )
				{
					if( FieldAttributeVO.TEXT_TYPE.equals(fieldVO.getFieldType()) ) contents = fieldContents.get("default");
					else if( FieldAttributeVO.SELECT_TYPE.equals(fieldVO.getFieldType()) ) contents = fieldContents.get("defaultSelect");
					else if( FieldAttributeVO.RADIO_TYPE.equals(fieldVO.getFieldType())
							|| FieldAttributeVO.CHECKBOX_TYPE.equals(fieldVO.getFieldType()) ) contents = fieldContents.get("defaultCheck");
					if( contents == null ) contents = fieldContents.get("default");

				}
				String _contents = StrUtils.replace(contents, REPLACE_NAME_MARK, fieldVO.getFieldName());
				_contents = StrUtils.replace(_contents, REPLACE_TEXT_MARK, fieldVO.getFieldText());
				_contents = StrUtils.replace(_contents, REPLACE_TYPE_MARK, fieldVO.getFieldType());
				addedTbodyContents.append(_contents);
				//addedTbodyContents.append(newLine);
			}

			templateContents = StrUtils.replace(templateContents, REPLACE_COLGROUP_MARK, addedColgroupContents.toString());
			templateContents = StrUtils.replace(templateContents, REPLACE_THEAD_MARK, addedTheadContents.toString());
			templateContents = StrUtils.replace(templateContents, REPLACE_TBODY_MARK, addedTbodyContents.toString());
			templateContents = StrUtils.replace(templateContents, CONFLICT_PROPERTY_MARK, REPLACE_CONFLICT_PROPERTY_MARK);

			String outputPath = StrUtils.replace(template.getOutputPath(), REPLACE_PAGE_CODE_MARK, vo.getPageCode());
			File outputFile = new File(outputPath);
			FileUtils.writeStringToFile(outputFile, templateContents);
		}
	}

	public void selectAllFieldList(PageVO vo, ModelMap model) throws Exception {
		PageTemplate[] templates = getPageTemplates(vo);
		Assert.notEmpty(templates);

		PageTemplate template = templates[0];
		model.addAttribute("fieldAttributes", template.selectAllFieldList(vo));
	}

	public void addFieldAttribute(ZValue zvl, ModelMap model) throws Exception {
		String pageCode = zvl.getString("pageCode");
		String pageType = zvl.getString("pageType");
		FieldAttributeVO vo = new FieldAttributeVO();
		vo.setPageCode(pageCode);
		vo.setPageType(pageType);
		pageGeneratorDAO.deleteFieldAttribute(vo);

		int fieldOrdr = 0;
		List<String> indexes = zvl.getList("fieldAttributeIdx");
		for(String index : indexes)
		{
			String fieldName = zvl.getString("fieldName_" + index);
			String fieldText = zvl.getString("fieldText_" + index);
			String fieldType = zvl.getString("fieldType_" + index);
			String fieldList = zvl.getString("fieldList_" + index);
			vo.setFieldName(fieldName);
			vo.setFieldText(fieldText);
			vo.setFieldType(fieldType);
			vo.setFieldOrdr(fieldOrdr++);
			vo.setFieldList(fieldList);
			pageGeneratorDAO.addFieldAttribute(vo);
		}
	}

	public void updateFieldAttributeOrdr(ZValue zvl, ModelMap model) throws Exception {
		String pageCode = zvl.getString("pageCode");
		String pageType = zvl.getString("pageType");
		FieldAttributeVO vo = new FieldAttributeVO();
		vo.setPageCode(pageCode);
		vo.setPageType(pageType);
		pageGeneratorDAO.deleteFieldAttribute(vo);

		List<String> fieldNameList = zvl.getList("fieldName");
		List<String> fieldTextList = zvl.getList("fieldText");
		List<String> fieldTypeList = zvl.getList("fieldType");
		List<String> fieldListList = zvl.getList("fieldList");
		for(int i=0; i<fieldNameList.size(); i++)
		{
			vo.setFieldName(fieldNameList.get(i));
			vo.setFieldText(fieldTextList.get(i));
			vo.setFieldType(fieldTypeList.get(i));
			vo.setFieldList(fieldListList.get(i));
			vo.setFieldOrdr(i);
			pageGeneratorDAO.addFieldAttribute(vo);
		}
	}
}
