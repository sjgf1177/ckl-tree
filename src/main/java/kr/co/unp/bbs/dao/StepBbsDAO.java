package kr.co.unp.bbs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import egovframework.com.cmm.service.FileVO;
import kr.co.unp.bbs.vo.BoardVO;

@Repository("stepBbsDAO")
public class StepBbsDAO extends BBSManageDAOAdaptor {
	
	public Log log = LogFactory.getLog(getClass());	

	@Override
	@Resource(name="egov.sqlMapClient")
	public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSuperSqlMapClient(sqlMapClient);
    }

	@Override
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectBoardArticleList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("stepBbsDAO.selectBoardArticleList", boardVO);
	}

	@Override
	public Map<String, BoardVO> selectPrevNexArticle(BoardVO boardVO) throws Exception {
		/*BoardVO prevVO = new BoardVO();
		BoardVO nextVO = new BoardVO();
		List<BoardVO> list = list("stepBbsDAO.selectPrevNexArticle", boardVO);
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
		BoardVO vo = (BoardVO)selectByPk("stepBbsDAO.selectPrevNexArticle", boardVO);
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

	@Override
	public void insertBoardArticle(BoardVO boardVO) throws Exception {
		insert("stepBbsDAO.insertBoardArticle", boardVO);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<FileVO> selectBoardArticleFiles(FileVO fileVO) throws Exception {
		return (List<FileVO>)list("stepBbsDAO.selectBoardArticleFiles", fileVO);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectBoardArticles(BoardVO board) throws Exception {
		return (List<BoardVO>)list("stepBbsDAO.selectBoardArticles", board);
	}

	@Override
	public BoardVO selectBoardArticle(BoardVO boardVO) throws Exception {
		return (BoardVO) selectByPk("stepBbsDAO.selectBoardArticle", boardVO);
	}

	@Override
	public void updateBoardArticle(BoardVO board) throws Exception {
		update("stepBbsDAO.updateBoardArticle", board);
	}

	@Override
	public void deleteBoardArticle(BoardVO board) throws Exception {
		update("stepBbsDAO.deleteBoardArticle", board);
	}

	@Override
	public void restoreBoardArticle(BoardVO board) throws Exception {
		update("stepBbsDAO.restoreBoardArticle", board);
	}

	@Override
	public void delPermanentlyBoardArticle(BoardVO board) throws Exception {
		update("stepBbsDAO.delPermanentlyBoardArticle", board);
	}

	@Override
	public void updateInqireCo(BoardVO boardVO) throws Exception {
		update("stepBbsDAO.updateInqireCo", boardVO);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<BoardVO> selectMainBoardArticleList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("stepBbsDAO.selectMainBoardArticleList", boardVO);
	}

	/**
	 * 게시물에 대한 현재 조회 건수를 조회 한다.
	 * 
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int selectMaxInqireCo(BoardVO boardVO) throws Exception {
		return (Integer) selectByPk("stepBbsDAO.selectMaxInqireCo", boardVO);
	}

}
