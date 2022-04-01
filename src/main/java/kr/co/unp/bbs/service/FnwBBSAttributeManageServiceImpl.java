package kr.co.unp.bbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.dao.BBSAttributeManageDAO;
import kr.co.unp.bbs.vo.BoardMasterVO;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.Globals;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("fnwBBSAttributeManageService")
public class FnwBBSAttributeManageServiceImpl extends EgovAbstractServiceImpl implements FnwBBSAttributeManageService, InitializingBean {

    @Resource(name = "BBSAttributeManageDAO")
    private BBSAttributeManageDAO attrbMngDAO;

    @Resource(name = "egovBBSMstrNewIdGnrService")
    private EgovIdGnrService idgenService;		
	
	@Override
	public void afterPropertiesSet() throws Exception {
		if( "N".equals(Globals.TEST_MODE) )
			attrbMngDAO.selectAllBBSMasterInf();
	}

	@Override
    public void deleteBBSMasterInf(BoardMasterVO BoardMasterVO) throws Exception {
    	attrbMngDAO.deleteBBSMasterInf(BoardMasterVO);
    }

	@Override
    public String insertBBSMastetInf(BoardMasterVO BoardMasterVO) throws Exception {
    	String bbsId = idgenService.getNextStringId();
    	BoardMasterVO.setBbsId(bbsId);
    	attrbMngDAO.insertBBSMasterInf(BoardMasterVO);
    	return bbsId;
    }

	@Override
    public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO vo) throws Exception {
    	return attrbMngDAO.selectAllBBSMasteInf(vo);
    }

	@Override
    public BoardMasterVO selectBBSMasterInf(BoardMasterVO searchVO) throws Exception {
    	return attrbMngDAO.selectBBSMasterInf(searchVO);
    }

	@Override
    public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception {
		List<BoardMasterVO> result = attrbMngDAO.selectBBSMasterInfs(searchVO);
		int cnt = attrbMngDAO.selectBBSMasterInfsCnt(searchVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

	@Override
    public List<BoardMasterVO> selectBBSMasterInfList(BoardMasterVO searchVO) throws Exception {
    	return attrbMngDAO.selectBBSMasterInfs(searchVO);
    }

	@Override
    public int selectBBSMasterInfListCnt(BoardMasterVO searchVO) throws Exception {
    	return attrbMngDAO.selectBBSMasterInfsCnt(searchVO);
    }

	@Override
    public void updateBBSMasterInf(BoardMasterVO BoardMasterVO) throws Exception {
    	attrbMngDAO.updateBBSMasterInf(BoardMasterVO);
    }

	@Override
	public BoardMasterVO getBoardMasterVO(String bbsId) throws Exception {
		Map<String, BoardMasterVO> boardMasterInf = attrbMngDAO.selectAllBBSMasterInf();
		return boardMasterInf.get(bbsId);
	}

}
