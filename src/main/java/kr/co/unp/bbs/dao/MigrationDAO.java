package kr.co.unp.bbs.dao;

import kr.co.unp.bbs.vo.BoardVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("migrationDAO")
public class MigrationDAO extends EgovAbstractDAO {

	public Log log = LogFactory.getLog(getClass());

    public void insertBasicBoardArticle(BoardVO board) throws Exception {
    	insert("migrationDAO.insertBasicBoardArticle", board);
    }

    public void insertBoardArticle(BoardVO board) throws Exception {
    	insert("migrationDAO.insertBoardArticle", board);
    }

    public void insertWorldmapArticle(BoardVO board) throws Exception {
    	insert("migrationDAO.insertWorldmap", board);
    }

    public int selectMaxPlusNttId(BoardVO board) throws Exception {
    	return (Integer)selectByPk("migrationDAO.selectMaxPlusNttId", board);
    }
    
    public void deleteBbs(BoardVO board) throws Exception {
    	delete("migrationDAO.deleteBbs", board);
    }

    public void deleteFileDetail(BoardVO board) throws Exception {
    	delete("migrationDAO.deleteFileDetail", board);
    }

    public void deleteFile(BoardVO board) throws Exception {
    	delete("migrationDAO.deleteFile", board);
    }

    public void insertCommentArticle(BoardVO board) throws Exception {
    	insert("migrationDAO.insertCommentArticle", board);
    }

    public void deleteCommnet(BoardVO board) throws Exception {
    	delete("migrationDAO.deleteCommnet", board);
    }

    public void insertBbsRcmmd(BoardVO board) throws Exception {
    	insert("migrationDAO.insertBbsRcmmd", board);
    }

    public void deleteBbsrcmmd(BoardVO board) throws Exception {
    	delete("migrationDAO.deleteBbsrcmmd", board);
    }

}
