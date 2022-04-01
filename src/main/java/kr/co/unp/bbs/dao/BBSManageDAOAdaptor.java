package kr.co.unp.bbs.dao;

import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.service.BoardUser;
import kr.co.unp.bbs.vo.BoardVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.com.cmm.service.FileVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

public class BBSManageDAOAdaptor extends EgovAbstractDAO implements IBBSManageDAO {

	public Log log = LogFactory.getLog(getClass());

	@Override
	public void insertBoardArticle(BoardVO board) throws Exception {
		
	}

	@Override
	public long replyBoardArticle(BoardVO board) throws Exception {
		
		return 0;
	}

	@Override
	public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
		
		return null;
	}

	@Override
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO)
			throws Exception {
		
		return null;
	}

	@Override
	public int selectBoardArticleListCnt(BoardVO boardVO) throws Exception {
		
		return 0;
	}

	@Override
	public void updateBoardArticle(BoardVO board) throws Exception {
		
		
	}

	@Override
	public void deleteBoardArticle(BoardVO board) throws Exception {
		
		
	}
	
	@Override
	public void restoreBoardArticle(BoardVO board) throws Exception {
		
		
	}
	
	@Override
	public void delPermanentlyBoardArticle(BoardVO board) throws Exception {
		
		
	}

	@Override
	public void updateInqireCo(BoardVO boardVO) throws Exception {
		
		
	}

	@Override
	public int selectMaxInqireCo(BoardVO boardVO) throws Exception {
		
		return 0;
	}

	@Override
	public List<BoardVO> selectNoticeListForSort(BoardVO board)
			throws Exception {
		
		return null;
	}

	@Override
	public void updateSortOrder(List<BoardVO> sortList) throws Exception {
		
		
	}

	@Override
	public long selectNoticeItemForSort(BoardVO board) throws Exception {
		
		return 0;
	}

	@Override
	public void insertBoardUserArticle(BoardUser boardUser) {
		
		
	}

	@Override
	public List<BoardVO> selectMyBoardArticleList(BoardVO boardVO)
			throws Exception {
		
		return null;
	}

	@Override
	public int selectMyBoardArticleListCnt(BoardVO boardVO) throws Exception {
		
		return 0;
	}

	@Override
	public List<BoardVO> selectReplyBoardList(BoardVO boardVO) throws Exception {
		
		return null;
	}

	@Override
	public int selectReplyBoardListCnt(BoardVO boardVO) throws Exception {
		
		return 0;
	}

	@Override
	public List<BoardVO> selectMainBoardArticleList(BoardVO boardVO) throws Exception {
		
		return null;
	}

	@Override
	public Map<String, BoardVO> selectPrevNexArticle(BoardVO boardVO)
			throws Exception {
		
		return null;
	}

	@Override
	public List<BoardVO> selectBoardArticles(BoardVO board) throws Exception {
		
		return null;
	}

	@Override
	public List<FileVO> selectBoardArticleFiles(FileVO fileVO) throws Exception {
		
		return null;
	}

	@Override
	public Map<String, List<FileVO>> selectBoardArticleFileMap(FileVO fileVO)
			throws Exception {
		
		return null;
	}

	@Override
	public void updateUseAt(BoardVO boardVO) throws Exception {
		
		
	}

	@Override
	public BoardVO selectBestBoardArticle(BoardVO boardVO) throws Exception {
		
		return null;
	}

	@Override
	public void recommend(BoardVO boardVO) throws Exception {
		
		
	}

	@Override
	public void opposit(BoardVO boardVO) throws Exception {
		
		
	}

	@Override
	public BoardVO selectRcmmndCount(BoardVO boardVO) throws Exception {
		
		return null;
	}

	@Override
	public void deleteReplyBoardArticles(BoardVO boardVO) throws Exception {
		
	}

	@Override
	public List<BoardVO> selectReplyArticles(BoardVO boardVO) throws Exception {
		return null;
	}

	@Override
	public BoardVO selectReplyAt(BoardVO boardVO) throws Exception{
		return null;
	}

	@Override
	public void receipt(BoardVO boardVO) throws Exception {		
	}

	@Override
	public void assignPublicOffice(BoardVO boardVO) throws Exception {
	}

	@Override
	public void assignDept(BoardVO boardVO) throws Exception {
	}

	@Override
	public void updateStatus(BoardVO boardVO) throws Exception {
	}

	@Override
	public void updateAnswer(BoardVO boardVO)  throws Exception{
	}

	@Override
	public void insertTransHistory(BoardVO boardVO)  throws Exception{
	}

	@Override
	public List<BoardVO> selectTransHistoryList(BoardVO board) throws Exception {
		return null;
	}

	@Override
	public void deleteTransHistory(BoardVO board) throws Exception {
	}

	@Override
	public List<BoardVO> selectCntByReplyAt(BoardVO board) throws Exception {
		return null;
	}
}
