package kr.co.unp.bbs.dao;

import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.vo.BoardMasterVO;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("BBSAttributeManageDAO")
public class BBSAttributeManageDAO extends EgovAbstractDAO {

	public static final String BBSATTRIBUTE_CACHE_NAME = "storedBBSAttribute";

	@CacheEvict(value=BBSATTRIBUTE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void deleteBBSMasterInf(BoardMasterVO boardMasterVO)
			throws Exception {
		update("BBSAttributeManageDAO.deleteBBSMasterInf", boardMasterVO);
	}

	@CacheEvict(value=BBSATTRIBUTE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public String insertBBSMasterInf(BoardMasterVO boardMasterVO)
			throws Exception {
		return (String) insert("BBSAttributeManageDAO.insertBBSMasterInf", boardMasterVO);
	}

	public BoardMasterVO selectBBSMasterInf(BoardMasterVO boardMasterVO) throws Exception {
		return (BoardMasterVO) selectByPk("BBSAttributeManageDAO.selectBBSMasterInf", boardMasterVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardMasterVO> selectBBSMasterInfs(BoardMasterVO boardMasterVO)
			throws Exception {
		return (List<BoardMasterVO>)list("BBSAttributeManageDAO.selectBBSMasterInfs", boardMasterVO);
	}

	public int selectBBSMasterInfsCnt(BoardMasterVO boardMasterVO) throws Exception {
		return (Integer) selectByPk("BBSAttributeManageDAO.selectBBSMasterInfsCnt", boardMasterVO);
	}

	@CacheEvict(value=BBSATTRIBUTE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void updateBBSMasterInf(BoardMasterVO boardMasterVO) throws Exception {
		update("BBSAttributeManageDAO.updateBBSMasterInf", boardMasterVO);
	}


	@SuppressWarnings("unchecked")
	public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO boardMasterVO)
			throws Exception {
		return (List<BoardMasterVO>)list("BBSAttributeManageDAO.selectAllBBSMaster", boardMasterVO);
	}

	@SuppressWarnings({ "unchecked", "deprecation" })
	@Cacheable(value=BBSATTRIBUTE_CACHE_NAME)
	public Map<String, BoardMasterVO> selectAllBBSMasterInf() throws Exception {
		return (Map<String, BoardMasterVO>) getSqlMapClientTemplate().queryForMap("BBSAttributeManageDAO.selectAllBBSMasterInf", null, "bbsId");
	}

	@CacheEvict(value=BBSATTRIBUTE_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void deleteBBSMaster(BoardMasterVO vo) throws Exception {
		delete("BBSAttributeManageDAO.deleteBBSMaster", vo);
	}
}
