package kr.co.unp.archive.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kr.co.unp.archive.vo.ArchiveBosVO;
import kr.co.unp.banner.vo.Banner;

@Repository("ArchiveBosDAO")
public class ArchiveBosDAO extends EgovAbstractDAO{

    @SuppressWarnings("unchecked")
	public List<ArchiveBosVO> selectList(ArchiveBosVO bean) {
    	List<ArchiveBosVO> resultMany = null;
    	try {
    		resultMany = (List<ArchiveBosVO>) list("archiveBosDAO.list", bean);
    	} catch (Exception e) {
    		e.printStackTrace();
		}
    	return resultMany;
	}
    
    public int selectListTotCnt(Banner bean) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ArchiveBosDAO.selectArchiveListTotCnt", bean);
	}
    
    @SuppressWarnings("unchecked")
  	public List<Banner> deptList(Banner param) {
      	List<Banner> resultMany = null;
      	try {
      		resultMany = (List<Banner>) list("archiveBosDAO.projectList", param);
      	} catch (Exception e) {
      		e.printStackTrace();
  		}
      	return resultMany;
  	}
}
