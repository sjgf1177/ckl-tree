package kr.co.unp.cmm.file.service;

import java.util.Iterator;
import java.util.List;

import kr.co.unp.bbs.vo.FileVO;

import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("fnwFileManageDAO")
public class FnwFileManageDAO extends EgovAbstractDAO {

    //private static final Logger LOG = Logger.getLogger(this.getClass());

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fileList
     * @return
     * @throws Exception
     */
    public String insertFileInfs(List<FileVO> fileList) throws Exception {
    	if( CollectionUtils.isEmpty(fileList) ) return null;
		FileVO vo = fileList.get(0);
		String atchFileId = vo.getAtchFileId();
		
		insert("fileDAO.insertFileMaster", vo);
	
		Iterator<FileVO> iter = fileList.iterator();
		while (iter.hasNext()) {
		    vo = (FileVO)iter.next();
		    
		    insert("fileDAO.insertFileDetail", vo);
		}
		
		return atchFileId;
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInf(FileVO vo) throws Exception {
		insert("fileDAO.insertFileMaster", vo);
		insert("fileDAO.insertFileDetail", vo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fileList
     * @throws Exception
     */
    public void updateFileInfs(List<FileVO> fileList) throws Exception {
		FileVO vo;
		Iterator<FileVO> iter = fileList.iterator();
		while (iter.hasNext()) {
		    vo = (FileVO)iter.next();
		    
		    insert("fileDAO.insertFileDetail", vo);
		}
    }

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @param fileList
     * @throws Exception
     */
    public void deleteFileInfs(List<FileVO> fileList) throws Exception {
		Iterator<FileVO> iter = fileList.iterator();
		FileVO vo;
		while (iter.hasNext()) {
		    vo = (FileVO)iter.next();
		    
		    delete("fileDAO.deleteFileDetail", vo);
		}
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteFileInf(FileVO fvo) throws Exception {
    	delete("fileDAO.deleteFileDetail", fvo);
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileInfs(FileVO vo) throws Exception {
    	return (List<FileVO>)list("fileDAO.selectFileList", vo);
    }
    
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileListByAtchFileIdData(FileVO vo) throws Exception {
    	return (List<FileVO>)list("fileDAO.selectFileListByAtchFileIdData", vo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(FileVO fvo) throws Exception {
    	return (Integer)selectByPk("fileDAO.getMaxFileSN", fvo);
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception {
    	return (FileVO)selectByPk("fileDAO.selectFileInf", fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception {
    	update("fileDAO.deleteCOMTNFILE", fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectFileListByFileNm(FileVO fvo) throws Exception {
    	return (List<FileVO>)list("fileDAO.selectFileListByFileNm", fvo);
    }

    /**
     * 파일명 검색에 대한 목록 전체 건수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int selectFileListCntByFileNm(FileVO fvo) throws Exception {
    	return (Integer)selectByPk("fileDAO.selectFileListCntByFileNm", fvo);
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception {
    	return (List<FileVO>)list("fileDAO.selectImageFileList", vo);
    }

    @SuppressWarnings("unchecked")
    public List<FileVO> selectBoardArticleFiles(FileVO fvo) throws Exception {
	return (List<FileVO>)list("fileDAO.selectBoardArticleFiles", fvo);
    }
    
    @SuppressWarnings("unchecked")
    public List<FileVO> selectTeacherBoardArticleFiles(FileVO fvo) throws Exception {
	return (List<FileVO>)list("fileDAO.selectTeacherBoardArticleFiles", fvo);
    }

}
