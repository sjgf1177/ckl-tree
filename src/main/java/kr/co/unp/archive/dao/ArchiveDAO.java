package kr.co.unp.archive.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import kr.co.unp.archive.vo.ArchiveBosVO;
import kr.co.unp.banner.vo.Banner;
import kr.co.unp.util.ZValue;

@Repository("ArchiveDAO")
public class ArchiveDAO extends EgovAbstractDAO {

	 @SuppressWarnings("unchecked")
		public List<ArchiveBosVO> selectList(ArchiveBosVO bean) {
	    	List<ArchiveBosVO> resultMany = null;
	    	try {
	    		resultMany = (List<ArchiveBosVO>) list("archiveDAO.list", bean);
	    	} catch (Exception e) {
	    		e.printStackTrace();
			}
	    	return resultMany;
		}
	    
	    public int selectListTotCnt(Banner bean) {
			return (Integer)getSqlMapClientTemplate().queryForObject("ArchiveDAO.listCnt", bean);
		}	
	
}
