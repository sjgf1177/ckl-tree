package kr.co.unp.bbs.dao;

import java.util.List;

import kr.co.unp.bbs.vo.BoardVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("CommentDAO")
public class CommentDAO extends EgovAbstractDAO {

	public Log log = LogFactory.getLog(getClass());

	public BoardVO selectComment(BoardVO boardVO) throws Exception {
		return (BoardVO) selectByPk("CommentDAO.selectComment", boardVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectCommentList(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("CommentDAO.selectCommentList", boardVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectComments(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("CommentDAO.selectComments", boardVO);
	}

	public int selectCommentListCnt(BoardVO boardVO) throws Exception {
		return (Integer) selectByPk("CommentDAO.selectCommentListCnt", boardVO);
	}

	@SuppressWarnings("unchecked")
	public List<BoardVO> selectCommentOpinionListCnt(BoardVO boardVO) throws Exception {
		return (List<BoardVO>)list("CommentDAO.selectCommentOpinionCnt", boardVO);
	}
	
	public boolean insertCommentArticle(BoardVO boardVO) {

		try {
			return insert("CommentDAO.insertCommentArticle", boardVO) != null;
		} catch (Exception ex) {
			if (log.isErrorEnabled()) {
				if (log.isErrorEnabled()) {
					log.error("Insert Fail : ", ex);
				}
			}
		}
		return false;

	}

	public void deleteCommentArticle(BoardVO boardVO) throws Exception {
		delete("CommentDAO.deleteCommentArticle", boardVO);
	}

	public int updateCommentState(BoardVO boardVO) throws Exception {
		return update("CommentDAO.updateCommentState", boardVO);
	}

}
