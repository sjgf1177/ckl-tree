package kr.co.unp.pg.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.pg.dao.PageGeneratorDAO;
import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;

public class PageTemplateImpl implements PageTemplate {

	protected String templatePath;
	protected String outputPath;
	protected String tbodyContents;
	protected String theadContents;
	protected Map<String, String> fieldContents;
	
	protected final String TABLE_NAME = "comtnbbs";

	@Resource(name = "pageGeneratorDAO")
	protected PageGeneratorDAO pageGeneratorDAO;
		
	public String getOutputPath() {
		return outputPath;
	}

	public void setOutputPath(String outputPath) {
		this.outputPath = outputPath;
	}

	public void setTemplatePath(String templatePath){
		this.templatePath = templatePath;
	}

	public void setTbodyContents(String tbodyContents){
		this.tbodyContents = tbodyContents;
	}

	public void setTheadContents(String theadContents){
		this.theadContents = theadContents;
	}
	
	public String getTemplatePath() {
		return this.templatePath;
	}

	public String getTheadContents() {
		return this.theadContents;
	}

	public String getTbodyContents() {
		return this.tbodyContents;
	}

	public PageVO getPageInfo(PageVO vo) throws Exception{
		return pageGeneratorDAO.selectPageInfo(vo);
	}
	
	public String getTABLE_NAME() {
		return TABLE_NAME;
	}

	public Map<String, String> getFieldContents() {
		return fieldContents;
	}

	public void setFieldContents(Map<String, String> fieldContents) {
		this.fieldContents = fieldContents;
	}

	public List<FieldAttributeVO> selectFieldAttributeList(PageVO vo) throws Exception {
		return pageGeneratorDAO.selectFieldAttributeList(vo);
	}

	public List<FieldAttributeVO> selectAllFieldList(PageVO vo) throws Exception {
		return pageGeneratorDAO.selectAllFieldList(vo);
	}
	
}
