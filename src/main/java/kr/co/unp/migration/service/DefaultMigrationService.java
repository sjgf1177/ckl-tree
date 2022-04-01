
package kr.co.unp.migration.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.dataaccess.SqlDAO;
import kr.co.unp.cmm.file.service.FnwFileManageDAO;
import kr.co.unp.util.StrUtils;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class DefaultMigrationService<T extends SearchVO> implements MigrationService<T> {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "asIsSqlDAO")
	protected ISqlDAO<T> asisDAO;

	@Resource(name = "SqlDAO")
	protected SqlDAO<T> sqlDAO;

	public int maxPlusNttId = 0;

    protected final int DEFAULT_PAGE_UNIT = 100;

    private String asisCountQueryId;
    private String asisListQueryId;
    private String insertQueryId;
    private String maxQueryId;

    @Resource(name = "egovFileIdGnrService")
    protected EgovIdGnrService idgenService;

    @Resource(name = "fnwFileManageDAO")
    protected FnwFileManageDAO fileMngDAO;

	public void setAsisDAO(ISqlDAO<T> asisDAO) {
		this.asisDAO = asisDAO;
	}

	@Override
	public void setAsisCountQueryId(String asisCountQueryId) {
		this.asisCountQueryId = asisCountQueryId;
	}

	@Override
	public void setAsisListQueryId(String asisListQueryId) {
		this.asisListQueryId = asisListQueryId;
	}

	@Override
	public void setInsertQueryId(String insertQueryId) {
		this.insertQueryId = insertQueryId;
	}

	public void setMaxQueryId(String maxQueryId) {
		this.maxQueryId = maxQueryId;
	}

	public String getAsisCountQueryId() {
		return asisCountQueryId;
	}

	public String getAsisListQueryId() {
		return asisListQueryId;
	}

	public String getInsertQueryId() {
		return insertQueryId;
	}

	public String getMaxQueryId() {
		return maxQueryId;
	}

	/**
	 * 이 메소드 오버라이드해서 초기화
	 * @param paramVO
	 * @throws Exception
	 */
	protected void initMigration(T paramVO) throws Exception{

	}

	/**
	 * 이 메소드 오버라이드해서 후처리
	 * @param paramVO
	 * @param resultVO
	 * @throws Exception
	 */
	protected void process(T paramVO, T resultVO) throws Exception{

	}

	protected int getTotCnt(T mgVO) throws Exception{
		return asisDAO.selectCount(asisCountQueryId, mgVO);//300;
	}

	protected List<T> getList(T mgVO) throws Exception{
		return asisDAO.listDAO(asisListQueryId, mgVO);
	}

	protected void insertArticle(T mgVO) throws Exception{
		sqlDAO.insert(insertQueryId, mgVO);
	}

	protected void batchJob(T paramVO, List<T> resultList) throws Exception{

	}

	@Override
	public void migration(T paramVO) throws Exception
	{
		String orgTableNm = paramVO.getOrgTableNm();
		String tableNm = paramVO.getTableNm();
		Assert.hasText(orgTableNm);
		Assert.hasText(tableNm);

		initMigration(paramVO);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(1);
		paginationInfo.setRecordCountPerPage(DEFAULT_PAGE_UNIT);
		paginationInfo.setPageSize(10);

		int cnt = getTotCnt(paramVO);
		paginationInfo.setTotalRecordCount(cnt);

		int totPageCount = paginationInfo.getTotalPageCount();
		log.debug(">cnt : " + cnt);
		log.debug(">paginationInfo.getTotalPageCount() : " + totPageCount);

		maxPlusNttId = sqlDAO.selectCount(maxQueryId, paramVO);

		String orgPath = paramVO.getOrgPath();
		String newPath = paramVO.getNewPath();
		for(int i=1; i<=totPageCount; i++){

			paginationInfo.setCurrentPageNo(i);
			paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
			paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			paramVO.setRowNo(paginationInfo.getRecordCountPerPage() - 10);

			List<T> resultList = getList(paramVO);
			for(T resultVO : resultList){

				resultVO.setTableNm(tableNm);

				process(paramVO, resultVO);

				if( StringUtils.hasText(orgPath) && StringUtils.hasText(newPath) ){
					List<FileVO> fvos = parseFileInf(orgPath, resultVO.getFileNm(), newPath);
					if( CollectionUtils.isNotEmpty(fvos) ){
					    String atchFileId = fileMngDAO.insertFileInfs(fvos);
					    resultVO.setAtchFileId(atchFileId);
					}
				}

				insertArticle(resultVO);

				maxPlusNttId++;
			}

			batchJob(paramVO, resultList);

		}

		log.debug("migration complete!");
	}

    protected List<FileVO> parseFileInf(String orgPath, String fileNames, String newPath) throws Exception {

		List<FileVO> resultList  = null;
		String[] pathData = null;
		String strPathString = null;
		if( StringUtils.hasText(fileNames) && StringUtils.hasText(orgPath) ){
			pathData = StrUtils.split(fileNames, "/");
			log.debug(">pathData : " + ArrayUtils.toString(pathData));
			if( !isEmptyFileString(pathData) ){
			    resultList = new ArrayList<FileVO>();
				String atchFileIdString = idgenService.getNextStringId();
				log.debug(">atchFileIdString : " + atchFileIdString);
				int fileKey = 0;
				for(int i=0; i<pathData.length; i++){
					strPathString = orgPath + pathData[i];
					strPathString = StrUtils.replaceStr(strPathString, "\\", File.separator);
					strPathString = StrUtils.replaceStr(strPathString, "/", File.separator);
					log.debug(">strPathString : " + strPathString);
					FileVO fvo = null;
					File file = new File(strPathString);
					if( file.exists() && !file.isDirectory() ){
						log.debug(">file exists : " + file.getAbsolutePath());
						String fileName = file.getName();
					    int index = fileName.lastIndexOf(".");
					    String fileExt = fileName.substring(index + 1);
					    String newName = "BBS_" + EgovStringUtil.getTimeStamp() + "0" + "." + fileExt;

						fvo = new FileVO();
					    fvo.setFileExtsn(fileExt);
					    fvo.setFileStreCours(newPath);
					    fvo.setFileMg(Long.toString(file.length()));
					    fvo.setOrignlFileNm(fileName);
					    fvo.setStreFileNm(newName);
					    fvo.setAtchFileId(atchFileIdString);
					    fvo.setFileFieldName("");
					    fvo.setFileSn(fileKey);

					    File destFile = new File(newPath+newName);
					    FileUtils.copyFile(file, destFile);

					    resultList.add(fvo);
					    fileKey++;
					}
				}
			}
		}

		return resultList;
    }

    private boolean isEmptyFileString(String[] data){
    	if( ArrayUtils.isEmpty(data) ) return true;

    	boolean result = true;
		for(int i=0; i<data.length; i++){
			String str = data[i];
			if( StringUtils.hasText(str) ){
				result = false;
				break;
			}
		}
		return result;
    }
}
