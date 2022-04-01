package kr.co.unp.bbs.dao;

import java.util.List;

import kr.co.unp.util.ZValue;

public interface ICommentDAO {

	public ZValue selectComment(ZValue zvl) throws Exception;

	public List<ZValue> selectCommentList(ZValue zvl) throws Exception;

	public List<ZValue> selectComments(ZValue zvl) throws Exception;

	public int selectCommentListCnt(ZValue zvl) throws Exception;

	public List<ZValue> selectCommentOpinionListCnt(ZValue zvl) throws Exception;
	
	public boolean insertCommentArticle(ZValue zvl);

	public void deleteCommentArticle(ZValue zvl) throws Exception;

	public int updateCommentState(ZValue zvl) throws Exception;

}
