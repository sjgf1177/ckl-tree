package kr.co.unp.bbs.dao;

import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.service.BoardUser;
import kr.co.unp.bbs.vo.BoardVO;
import egovframework.com.cmm.service.FileVO;

public interface IBBSManageDAO {


	/**
	 * 게시판에 게시물을 등록 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void insertBoardArticle(BoardVO board) throws Exception;

	/**
	 * 게시판에 답변 게시물을 등록 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public long replyBoardArticle(BoardVO board) throws Exception;

	/**
	 * 게시물 한 건에 대하여 상세 내용을 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception;

	/**
	 * 조건에 맞는 게시물 목록을 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception;

	/**
	 * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int selectBoardArticleListCnt(BoardVO boardVO) throws Exception;

	/**
	 * 게시물 한 건의 내용을 수정 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void updateBoardArticle(BoardVO boardVO) throws Exception;

	/**
	 * 게시물 한 건을 삭제 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void deleteBoardArticle(BoardVO boardVO) throws Exception;

	/**
	 * 게시물 한 건을 삭제 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void deleteReplyBoardArticles(BoardVO boardVO) throws Exception;

	/**
	 * 삭제된 게시물 한 건을 복구 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void restoreBoardArticle(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시물 한 건을 영구삭제 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void delPermanentlyBoardArticle(BoardVO boardVO) throws Exception;
	
	/**
	 * 게시물에 대한 조회 건수를 수정 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void updateInqireCo(BoardVO boardVO) throws Exception;

	/**
	 * 게시물에 대한 현재 조회 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int selectMaxInqireCo(BoardVO boardVO) throws Exception;

	/**
	 * 게시판에 대한 목록을 정렬 순서로 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public List<BoardVO> selectNoticeListForSort(BoardVO boardVO) throws Exception;

	/**
	 * 게사판에 대한 정렬 순서를 수정 한다.
	 * 
	 * @param sortList
	 * @throws Exception
	 */
	public void updateSortOrder(List<BoardVO> sortList) throws Exception;

	/**
	 * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public long selectNoticeItemForSort(BoardVO boardVO) throws Exception;

	/**
	 * 게시판에 게시물을 등록 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void insertBoardUserArticle(BoardUser boardUser);

	/**
	 * 조건에 맞는 게시물 목록을 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public List<BoardVO> selectMyBoardArticleList(BoardVO boardVO) throws Exception;

	/**
	 * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int selectMyBoardArticleListCnt(BoardVO boardVO) throws Exception;

	public List<BoardVO> selectReplyBoardList(BoardVO boardVO) throws Exception;

	public int selectReplyBoardListCnt(BoardVO boardVO) throws Exception;

	public List<BoardVO> selectReplyArticles(BoardVO boardVO) throws Exception;
	
	public List<BoardVO> selectMainBoardArticleList(BoardVO boardVO) throws Exception;

	public Map<String, BoardVO> selectPrevNexArticle(BoardVO boardVO) throws Exception;

	public List<BoardVO> selectBoardArticles(BoardVO board) throws Exception;

	public List<FileVO> selectBoardArticleFiles(FileVO fileVO) throws Exception;

	public Map<String, List<FileVO>> selectBoardArticleFileMap(FileVO fileVO) throws Exception;

	public void updateUseAt(BoardVO boardVO) throws Exception;

	public BoardVO selectBestBoardArticle(BoardVO boardVO) throws Exception;

	public void recommend(BoardVO boardVO) throws Exception;

	public void opposit(BoardVO boardVO) throws Exception;

	public BoardVO selectRcmmndCount(BoardVO boardVO) throws Exception;

	public BoardVO selectReplyAt(BoardVO boardVO) throws Exception;

	public void receipt(BoardVO boardVO) throws Exception;

	public void assignPublicOffice(BoardVO boardVO) throws Exception;

	public void assignDept(BoardVO boardVO) throws Exception;

	public void updateStatus(BoardVO boardVO) throws Exception;

	public void updateAnswer(BoardVO boardVO)  throws Exception;

	public void insertTransHistory(BoardVO boardVO)  throws Exception;

	public List<BoardVO> selectTransHistoryList(BoardVO board) throws Exception;

	public void deleteTransHistory(BoardVO board) throws Exception;

	public List<BoardVO> selectCntByReplyAt(BoardVO board) throws Exception;
}
