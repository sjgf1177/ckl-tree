package kr.co.unp.bbs.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.service.BoardUser;
import kr.co.unp.bbs.vo.BoardVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.FileVO;

/**
 * 게시물 관리를 위한 데이터 접근 클래스
 * 
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------      --------    ---------------------------
 *   2009.3.19  이삼섭          최초 생성
 * 
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Repository("BBSManageDAO")
public class BBSManageDAO extends BBSManageDAOAdaptor {

	public Log log = LogFactory.getLog(getClass());

	/**
	 * 게시판에 게시물을 등록 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void insertBoardArticle(BoardVO boardVO) throws Exception {
		insert("BBSManageDAO.insertBoardArticle", boardVO);
	}

	/**
	 * 게시판에 답변 게시물을 등록 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public long replyBoardArticle(BoardVO board) throws Exception {
		long nttId = (Long) getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMaxNttId");
		board.setNttId(nttId);

		insert("BBSManageDAO.replyBoardArticle", board);

		// ----------------------------------------------------------
		// 현재 글 이후 게시물에 대한 NTT_NO를 증가 (정렬을 추가하기 위해)
		// ----------------------------------------------------------
		// String parentId = board.getParnts();
		long nttNo = (Long) getSqlMapClientTemplate().queryForObject("BBSManageDAO.getParentNttNo", board);

		board.setNttNo(nttNo);
		update("BBSManageDAO.updateOtherNttNo", board);

		board.setNttNo(nttNo + 1);
		update("BBSManageDAO.updateNttNo", board);

		return nttId;
	}

	/**
	 * 게시물 한 건에 대하여 상세 내용을 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
		return (BoardVO) selectByPk("BBSManageDAO.selectBoardArticle", boardVO);
	}

	/**
	 * 조건에 맞는 게시물 목록을 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectBoardArticleList", boardVO);
	}

	/**
	 * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public int selectBoardArticleListCnt(BoardVO boardVO) throws Exception {
		return (Integer) getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectBoardArticleListCnt", boardVO);
	}

	/**
	 * 게시물 한 건의 내용을 수정 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void updateBoardArticle(BoardVO board) throws Exception {
		update("BBSManageDAO.updateBoardArticle", board);
	}

	/**
	 * 게시물 한 건을 삭제 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void deleteBoardArticle(BoardVO board) throws Exception {
		update("BBSManageDAO.deleteBoardArticle", board);
	}
	
	/**
	 * 삭제된 게시물 한 건을 복구 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void restoreBoardArticle(BoardVO board) throws Exception {
		update("BBSManageDAO.restoreBoardArticle", board);
	}
	
	/**
	 * 게시물 한 건을 영구삭제 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void delPermanentlyBoardArticle(BoardVO board) throws Exception {
		update("BBSManageDAO.delPermanentlyBoardArticle", board);
	}

	/**
	 * 게시물에 대한 조회 건수를 수정 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void updateInqireCo(BoardVO boardVO) throws Exception {
		update("BBSManageDAO.updateInqireCo", boardVO);
	}

	/**
	 * 게시물에 대한 현재 조회 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public int selectMaxInqireCo(BoardVO boardVO) throws Exception {
		return (Integer) getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMaxInqireCo", boardVO);
	}

	/**
	 * 게시판에 대한 목록을 정렬 순서로 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectNoticeListForSort(BoardVO board) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectNoticeListForSort", board);
	}

	/**
	 * 게사판에 대한 정렬 순서를 수정 한다.
	 * 
	 * @param sortList
	 * @throws Exception
	 */
	public void updateSortOrder(List<BoardVO> sortList) throws Exception {
		BoardVO vo;
		Iterator<BoardVO> iter = sortList.iterator();
		while (iter.hasNext()) {
			vo = (BoardVO) iter.next();
			update("BBSManageDAO.updateSortOrder", vo);
		}
	}

	/**
	 * 게시판에 대한 현재 게시물 번호의 최대값을 구한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public long selectNoticeItemForSort(BoardVO board) throws Exception {
		return (Long) getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectNoticeItemForSort", board);
	}

	/**
	 * 게시판에 게시물을 등록 한다.
	 * 
	 * @param board
	 * @throws Exception
	 */
	public void insertBoardUserArticle(BoardUser boardUser) {
		try {
			insert("BBSManageDAO.insertBoardUserArticle", boardUser);
		} catch (Exception ex) {
			if (log.isErrorEnabled()) {
				if (log.isErrorEnabled()) {
					log.error("Insert Fail : ", ex);
				}
			}
		}
	}

	/**
	 * 조건에 맞는 게시물 목록을 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectMyBoardArticleList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectMyBoardArticleList", boardVO);
	}

	/**
	 * 조건에 맞는 게시물 목록에 대한 전체 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public int selectMyBoardArticleListCnt(BoardVO boardVO) throws Exception {
		return (Integer) getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectMyBoardArticleListCnt", boardVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectReplyBoardList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectReplyBoardList", boardVO);
	}

	@SuppressWarnings("deprecation")
	public int selectReplyBoardListCnt(BoardVO boardVO) throws Exception {
		return (Integer) getSqlMapClientTemplate().queryForObject("BBSManageDAO.selectReplyBoardListCnt", boardVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectReplyArticles(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectReplyArticles", boardVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectMainBoardArticleList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectMainBoardArticleList", boardVO);
	}

	public Map<String, BoardVO> selectPrevNexArticle(BoardVO boardVO) throws Exception {
		/*BoardVO prevVO = new BoardVO();
		BoardVO nextVO = new BoardVO();
		List<BoardVO> list = list("BBSManageDAO.selectPrevNexArticle", boardVO);
		for (BoardVO vo : list) {
			if ("PREV".equals(vo.getNttType())) {
				prevVO.setNttId(vo.getNttId());
				prevVO.setNttSj(vo.getNttSj());
			} else if ("NEXT".equals(vo.getNttType())) {
				nextVO.setNttId(vo.getNttId());
				nextVO.setNttSj(vo.getNttSj());
			}
		}

		Map<String, BoardVO> result = new HashMap<String, BoardVO>();
		result.put("PREV", prevVO);
		result.put("NEXT", nextVO);

		return result;*/

		Map<String, BoardVO> result = null;
		BoardVO vo = (BoardVO)selectByPk("BBSManageDAO.selectPrevNexArticle", boardVO);
		if( vo != null ){
			BoardVO prevVO = new BoardVO();
			BoardVO nextVO = new BoardVO();
			prevVO.setNttId(vo.getPrevNttId());
			nextVO.setNttId(vo.getNextNttId());
			result = new HashMap<String, BoardVO>();
			result.put("PREV", prevVO);
			result.put("NEXT", nextVO);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectBoardArticles(BoardVO board) throws Exception {
		return (List<BoardVO>)list("BBSManageDAO.selectBoardArticles", board);
	}

	@SuppressWarnings("unchecked")
	public List<FileVO> selectBoardArticleFiles(FileVO fileVO) throws Exception {
		return (List<FileVO>)list("BBSManageDAO.selectBoardArticleFiles", fileVO);
	}

	public Map<String, List<FileVO>> selectBoardArticleFileMap(FileVO fileVO) throws Exception {
		Map<String, List<FileVO>> resultMap = new HashMap<String, List<FileVO>>();
		List<FileVO> list = selectBoardArticleFiles(fileVO);
		for (FileVO vo : list) {
			List<FileVO> files = resultMap.get(vo.getAtchFileId());
			if (files == null) {
				files = new ArrayList<FileVO>();
				resultMap.put(vo.getAtchFileId(), files);
			}
			files.add(vo);
		}
		return resultMap;
	}

	public void updateUseAt(BoardVO boardVO) throws Exception {
		update("BBSManageDAO.updateUseAt", boardVO);
	}

	public BoardVO selectBestBoardArticle(BoardVO boardVO) throws Exception {
		return (BoardVO) selectByPk("BBSManageDAO.selectBestBoardArticle",boardVO);
	}

	public void recommend(BoardVO boardVO) throws Exception {
		update("BBSManageDAO.recommend", boardVO);
	}

	public void opposit(BoardVO boardVO) throws Exception {
		update("BBSManageDAO.opposit", boardVO);
	}

	public BoardVO selectRcmmndCount(BoardVO boardVO) throws Exception {
		return (BoardVO) selectByPk("BBSManageDAO.selectRcmmndCount", boardVO);
	}

	@Override
	public void deleteReplyBoardArticles(BoardVO boardVO) throws Exception {
		update("BBSManageDAO.deleteReplyBoardArticles", boardVO);
	}

	public BoardVO selectRecentBoardArticle(BoardVO boardVO) throws Exception {
		return (BoardVO) selectByPk("BBSManageDAO.selectRecentBoardArticle", boardVO);
	}
	
	public BoardVO selectReplyAt(BoardVO boardVO) throws Exception{
		return (BoardVO) selectByPk("BBSManageDAO.selectReplyAt", boardVO);
	}
}
