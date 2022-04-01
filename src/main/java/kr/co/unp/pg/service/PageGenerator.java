package kr.co.unp.pg.service;

import org.springframework.ui.ModelMap;

import kr.co.unp.pg.vo.PageVO;
import kr.co.unp.util.ZValue;

public interface PageGenerator {
	
	public void getPageAttrList(PageVO vo, ModelMap model) throws Exception;
	
	public void addPageAttribute(PageVO vo, ModelMap model) throws Exception;

	public void updatePageAttribute(PageVO vo, ModelMap model) throws Exception;

	public void deletePageAttribute(PageVO vo, ModelMap model) throws Exception;
	
	public void readPageInfo(PageVO vo, ModelMap model) throws Exception;
	
	public void createPage(PageVO vo, ModelMap model) throws Exception;

	public void selectAllFieldList(PageVO vo, ModelMap model) throws Exception;

	public void addFieldAttribute(ZValue zvl, ModelMap model) throws Exception;
	
	public void updateFieldAttributeOrdr(ZValue zvl, ModelMap model) throws Exception;
}

