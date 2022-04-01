package kr.co.unp.pg.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.StringReader;
import java.util.List;

import org.apache.commons.digester.BeanPropertySetterRule;
import org.apache.commons.digester.Digester;
import org.apache.commons.digester.ObjectCreateRule;
import org.apache.commons.digester.Rules;
import org.apache.commons.digester.SetNextRule;
import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("pageGeneratorDAO")
public class PageGeneratorDAO extends EgovAbstractDAO {

	public  Log log = LogFactory.getLog(getClass());

	@SuppressWarnings("unchecked")
	public List<FieldAttributeVO> selectAllFieldList(PageVO vo) throws Exception {
		return (List<FieldAttributeVO>)list("pageGeneratorDAO.selectAllFieldList", vo);
	}

	@SuppressWarnings("unchecked")
	public List<PageVO> selectPageAttributeList(PageVO vo) throws Exception {
		return (List<PageVO>)list("pageGeneratorDAO.selectPageAttributeList", vo);
	}

	public void addPageAttribute(PageVO vo) throws Exception {
		insert("pageGeneratorDAO.addPageAttribute", vo);
	}

	public void updatePageAttribute(PageVO vo) throws Exception {
		update("pageGeneratorDAO.updatePageAttribute", vo);
	}

	public void deletePageAttribute(PageVO vo) throws Exception {
		FieldAttributeVO fVo = new FieldAttributeVO();
		fVo.setPageCode(vo.getPageCode());
		delete("pageGeneratorDAO.deleteFieldAttributeCode", fVo);
		delete("pageGeneratorDAO.deletePageAttribute", vo);
	}

	public void addFieldAttribute(FieldAttributeVO vo) throws Exception {
		insert("pageGeneratorDAO.addFieldAttribute", vo);
	}

	public void deleteFieldAttribute(FieldAttributeVO vo) throws Exception {
		delete("pageGeneratorDAO.deleteFieldAttribute", vo);
	}

	public PageVO selectPageAttribute(PageVO vo) throws Exception {
		return (PageVO)selectByPk("pageGeneratorDAO.selectPageAttribute", vo);
	}

	public PageVO selectPageInfo(PageVO vo) throws Exception {
		PageVO pageVO = (PageVO)selectByPk("pageGeneratorDAO.selectPageAttribute", vo);
		List<FieldAttributeVO> fieldAttributes = (List<FieldAttributeVO>)list("pageGeneratorDAO.selectFieldAttributeList", pageVO);
		pageVO.setFieldAttributes(fieldAttributes);
		return pageVO;
	}

	@SuppressWarnings("unchecked")
	public List<FieldAttributeVO> selectFieldAttributeList(PageVO vo) throws Exception {
		return (List<FieldAttributeVO>)list("pageGeneratorDAO.selectFieldAttributeList", vo);
	}

	public static void main(String[] args) throws Exception{
		FileInputStream fis2 = null;
		try {
			fis2 = new FileInputStream(
					new File("C:/Project/workspace/gangnam2012/src/main/java/egovframework/kr/co/fw/pg/xml/test.xml"));
			String xml = IOUtils.toString(fis2);
			System.out.println( xml );

			Digester digester = new Digester();

			digester.setValidating(false);

			Rules rules = digester.getRules();
			rules.add( "page", new ObjectCreateRule("kr.co.unp.pg.vo.PageVO") );
			rules.add( "page/id", new BeanPropertySetterRule("id") );
			rules.add( "page/pageType", new BeanPropertySetterRule("pageType") );
			rules.add( "page/savePath", new BeanPropertySetterRule("savePath") );
			rules.add( "page/fields/field", new ObjectCreateRule("kr.co.unp.pg.vo.FieldVO") );
			rules.add( "page/fields/field", new SetNextRule("addField", "kr.co.unp.pg.vo.FieldVO") );
			rules.add( "page/fields/field/name", new BeanPropertySetterRule("name") );
			rules.add( "page/fields/field/text", new BeanPropertySetterRule("text") );
			rules.add( "page/fields/field/type", new BeanPropertySetterRule("type") );

			PageVO _vo = (PageVO)digester.parse(new StringReader(xml));

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { if (fis2!=null) fis2.close(); } catch (Exception e2) { e2.printStackTrace();}
		}

	}
}
