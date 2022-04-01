package kr.co.unp.pg.service;

import java.util.List;
import java.util.Map;

import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;

public interface PageTemplate {
	
	public String getTemplatePath();

	public String getOutputPath();
	
	public String getTheadContents();
	
	public String getTbodyContents();
	
	public PageVO getPageInfo(PageVO vo) throws Exception;
	
	public Map<String, String> getFieldContents() throws Exception;
	
	public List<FieldAttributeVO> selectFieldAttributeList(PageVO vo) throws Exception;
	
	public List<FieldAttributeVO> selectAllFieldList(PageVO vo) throws Exception;
	
	public String getTABLE_NAME();
}
