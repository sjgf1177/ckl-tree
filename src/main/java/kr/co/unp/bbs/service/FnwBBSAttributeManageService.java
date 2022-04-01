package kr.co.unp.bbs.service;

import java.util.List;

import java.util.Map;

import kr.co.unp.bbs.vo.BoardMasterVO;

public interface FnwBBSAttributeManageService {
	
    public void deleteBBSMasterInf(BoardMasterVO boardMaster) throws Exception;

    /**
     * 신규 게시판 속성정보를 생성한다.
     * 
     * @param BoardMaster
     */
    public String insertBBSMastetInf(BoardMasterVO boardMaster) throws Exception;

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @param BoardMasterVO
     */
    public BoardMasterVO selectBBSMasterInf(BoardMasterVO searchVO) throws Exception;

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param BoardMasterVO
     */
    public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception;

    public List<BoardMasterVO> selectBBSMasterInfList(BoardMasterVO searchVO) throws Exception;

    public int selectBBSMasterInfListCnt(BoardMasterVO searchVO) throws Exception;
    
    /**
     * 게시판 속성정보를 수정한다.
     * 
     * @param BoardMaster
     */
    public void updateBBSMasterInf(BoardMasterVO boardMaster) throws Exception;


    /**
     * 유효한 게시판 마스터 정보를 호출한다.
     * 
     * @param searchVO
     * @return
     * @throws Exception
     */
    public List<BoardMasterVO> selectAllBBSMasteInf(BoardMasterVO vo) throws Exception;

    public BoardMasterVO getBoardMasterVO(String bbsId) throws Exception;
}
