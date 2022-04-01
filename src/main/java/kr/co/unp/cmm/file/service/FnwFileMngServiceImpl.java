package kr.co.unp.cmm.file.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.BoardVO;
import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.util.FileMngUtil;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("fnwFileMngService")
public class FnwFileMngServiceImpl extends EgovAbstractServiceImpl implements FnwFileMngService {

    Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "fnwFileManageDAO")
	protected FnwFileManageDAO fnwFileManageDAO;

	@Resource(name = "fileMngUtil")
	protected FileMngUtil fileUtil;
    /**
     * 여러 개의 파일을 삭제한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInfs(java.util.List)
     */
    public void deleteFileInfs(List<FileVO> fvoList) throws Exception {
    	fnwFileManageDAO.deleteFileInfs(fvoList);
    }

    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInf(egovframework.com.cmm.service.FileVO)
     */
    public String insertFileInf(FileVO fvo) throws Exception {
	String atchFileId = fvo.getAtchFileId();

	fnwFileManageDAO.insertFileInf(fvo);

	return atchFileId;
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInfs(java.util.List)
     */
    public String insertFileInfs(List<FileVO> fvoList) throws Exception {
	String atchFileId = "";

	if (fvoList.size() != 0) {
	    atchFileId = fnwFileManageDAO.insertFileInfs(fvoList);
	}

	return atchFileId;
    }




    /**
     * 파일에 대한 목록을 조회한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInfs(egovframework.com.cmm.service.FileVO)
     */
    public List<FileVO> selectFileInfs(FileVO fvo) throws Exception {
    	List<FileVO> resultList =
    		fnwFileManageDAO.selectFileInfs(fvo);

    	setImgUrl(resultList);

		return resultList;
    }

    public void setImgUrl(List<FileVO> fileList) {
		if( CollectionUtils.isNotEmpty(fileList) ){
			for(FileVO vo : fileList){
				setImgUrl(vo);
			}
		}

    }

    public void setImgUrl(BoardVO boardVO) throws Exception{
		String atchFileId = boardVO.getAtchFileId();
		if( StringUtils.hasText(atchFileId) )
		{
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			List<FileVO> fileList = fnwFileManageDAO.selectFileInfs(fileVO);
			if( CollectionUtils.isNotEmpty(fileList) ){
				FileVO fVO = fileList.get(0);
				setImgUrl(fVO);
				boardVO.setImgUrl(fVO.getImgUrl());
			}
		}
	}

    public void setBoardImgUrl(List<BoardVO> boardList) throws Exception{
    	if( CollectionUtils.isEmpty(boardList) ) return;
    	for(BoardVO vo : boardList){
    		setImgUrl(vo);
    	}
    }

    public void setImgUrl(FileVO vo){
    	if( vo == null ) return;
		String fileStreCours = vo.getFileStreCours();
		fileStreCours = StringUtils.cleanPath(fileStreCours);
		String globalsFileStreCours = propertyService.getString("Globals.fileStorePath");
		globalsFileStreCours = StringUtils.cleanPath(globalsFileStreCours);

		String imgUrl = StringUtils.replace(fileStreCours, globalsFileStreCours, "");
		imgUrl = imgUrl.startsWith("/") ? ROOT_IMG_URL + imgUrl : ROOT_IMG_URL + "/" + imgUrl;
		imgUrl = imgUrl.endsWith("/") ? imgUrl + vo.getStreFileNm() : imgUrl + "/" + vo.getStreFileNm();
		vo.setImgUrl(imgUrl);

    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#updateFileInfs(java.util.List)
     */
    public void updateFileInfs(List<FileVO> fvoList) throws Exception {
	//Delete & Insert
	fnwFileManageDAO.updateFileInfs(fvoList);
    }


    public void updateFileInf(FileVO fvo) throws Exception {
    	if (fvo != null) {
    		List<FileVO> fvoList = new ArrayList<FileVO>();
        	fvoList.add(fvo);
        	//Delete & Insert
        	fnwFileManageDAO.updateFileInfs(fvoList);
    	}
    }


    /**
     * 하나의 파일을 삭제한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInf(egovframework.com.cmm.service.FileVO)
     */
    public void deleteFileInf(FileVO fvo) throws Exception {
    	FileVO vo = selectFileInf(fvo);
    	if (vo!=null) {
	    	String path = vo.getFileStreCours() + File.separator + vo.getStreFileNm();
	    	log.debug(">>delete file path : " + path);
	    	File file = new File(path);
	    	if (file.isFile()) {
		    	if( file.delete() )
		        	log.debug(">>file delete successfully (" + path + ")");
	    	}
	    	fnwFileManageDAO.deleteFileInf(fvo);
    	}
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInf(egovframework.com.cmm.service.FileVO)
     */
    public FileVO selectFileInf(FileVO fvo) throws Exception {
	return fnwFileManageDAO.selectFileInf(fvo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#getMaxFileSN(egovframework.com.cmm.service.FileVO)
     */
    public int getMaxFileSN(FileVO fvo) throws Exception {
	return fnwFileManageDAO.getMaxFileSN(fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteAllFileInf(egovframework.com.cmm.service.FileVO)
     */
    public void deleteAllFileInf(FileVO fvo) throws Exception {
    	List<FileVO> fileList = selectBoardArticleFiles(fvo);
    	for(FileVO vo : fileList){
        	String path = vo.getFileStreCours() + File.separator + vo.getStreFileNm();
        	log.debug(">>delete file path : " + path);
        	File file = new File(path);
        	if( file.delete() )
            	log.debug(">>file delete successfully (" + path + ")");
    	}
    	fnwFileManageDAO.deleteAllFileInf(fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileListByFileNm(egovframework.com.cmm.service.FileVO)
     */
    public Map<String, Object> selectFileListByFileNm(FileVO fvo) throws Exception {
	List<FileVO>  result = fnwFileManageDAO.selectFileListByFileNm(fvo);
	int cnt = fnwFileManageDAO.selectFileListCntByFileNm(fvo);

	Map<String, Object> map = new HashMap<String, Object>();

	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     *
     * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.FileVO)
     */
    public List<FileVO> selectImageFileList(FileVO vo) throws Exception {
	return fnwFileManageDAO.selectImageFileList(vo);
    }

    public List<FileVO> selectBoardArticleFiles(FileVO vo) throws Exception {
	return fnwFileManageDAO.selectBoardArticleFiles(vo);
    }

    public List<FileVO> selectTeacherBoardArticleFiles(FileVO vo) throws Exception {
    	return fnwFileManageDAO.selectTeacherBoardArticleFiles(vo);
        }

    public Map<String, List<FileVO>> selectArticleFileMap(FileVO fileVO) throws Exception {
    	Map<String, List<FileVO>> resultMap = new HashMap<String, List<FileVO>>();
    	List<FileVO> list = fnwFileManageDAO.selectFileListByAtchFileIdData(fileVO);;
    	setImgUrl(list);
    	for(FileVO vo : list) {
    		List<FileVO> files = resultMap.get(vo.getAtchFileId());
    		if( files == null ) {
    			files = new ArrayList<FileVO>();
    			resultMap.put(vo.getAtchFileId(), files);
    		}
			files.add(vo);
    	}
    	return resultMap;
    }

	@Override
	public String saveFile(Map<String, MultipartFile> files, String atchFileId, String filePath) throws Exception {
		if (!files.isEmpty()) {
			if (!StringUtils.hasText(atchFileId)) {
				List<FileVO> result = fileUtil.parseFileInf(files, "FILE_", 0,atchFileId, filePath);
				atchFileId = insertFileInfs(result);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				List<FileVO> _result = fileUtil.parseFileInf(files, "FILE_", 0,atchFileId, filePath);
				updateFileInfs(_result);
			}
		}
		return atchFileId;
	}

	@Override
	public <T> String saveFile(Map<String, MultipartFile> files, String atchFileId, String filePath, T param) throws Exception {
		if (!files.isEmpty()) {
			if (!StringUtils.hasText(atchFileId)) {
				List<FileVO> result = fileUtil.parseFileInf(files, "FILE_", 0,atchFileId, filePath, param);
				atchFileId = insertFileInfs(result);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				List<FileVO> _result = fileUtil.parseFileInf(files, "FILE_", 0,atchFileId, filePath, param);
				updateFileInfs(_result);
			}
		}
		return atchFileId;
	}
}
