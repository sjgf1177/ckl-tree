package egovframework.com.cmm.service;

import java.util.List;

import kr.co.unp.util.ZValue;

public interface IFileManageDAO {

    public String insertFileInfs(List fileList) throws Exception;

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param vo
     * @throws Exception
     */
    public void insertFileInf(FileVO vo) throws Exception;

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @param fileList
     * @throws Exception
     */
    public void updateFileInfs(List fileList) throws Exception;

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @param fileList
     * @throws Exception
     */
    public void deleteFileInfs(List fileList) throws Exception;

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteFileInf(FileVO fvo) throws Exception;

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<FileVO> selectFileInfs(FileVO vo) throws Exception;
    
    public List<FileVO> selectFileTopOneIconInf(FileVO vo) throws Exception;
    
    
    /**
     * 파일에 대한 목록을 조회한다. 필드를 참조
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<FileVO> selectFileInfFiled(FileVO vo) throws Exception;

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int getMaxFileSN(FileVO fvo) throws Exception;

    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception;
    
    public FileVO selectImageListInf(FileVO fvo) throws Exception;

    /**
     * 전체 파일을 삭제한다.
     * 
     * @param fvo
     * @throws Exception
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception;

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<FileVO> selectFileListByFileNm(FileVO fvo) throws Exception;

    /**
     * 파일명 검색에 대한 목록 전체 건수를 조회한다.
     * 
     * @param fvo
     * @return
     * @throws Exception
     */
    public int selectFileListCntByFileNm(FileVO fvo) throws Exception;

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception;

    public List<FileVO> selectAppDoc(ZValue zvl) throws Exception;

    public List<FileVO> selectBoardArticleFiles(FileVO fvo) throws Exception;

}
