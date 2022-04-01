package kr.co.unp.cmm.crud.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import kr.co.unp.bbs.accessor.ArticleAccessor;
import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.handler.ListHandler;
import kr.co.unp.cmm.crud.listener.CmmProgramListener;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerContainer;
import kr.co.unp.cmm.crud.listener.CompositeCmmProgramListenerContainer;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.IPageInfo;
import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.crud.vo.QueryIdVO;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.excel.service.IExcelUploadService;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.FileMngUtil;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.rte.fdl.property.EgovPropertyService;
/**
 * 프로그램 기본 CRUD, 엑셀다운, 엑셀업로드생성을 위한 클래스
 * @author KHD
 *
 * @param <T> 타입파라미터는 SearchVO를 확장한 VO와 ZValue만을 허용한다
 */
public abstract class AbstractCmmProgramService<T> implements CmmProgramService<T> {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "SqlDAO")
	protected ISqlDAO<T> sqlDao;

	@Resource(name = "fnwFileMngService")
	protected FnwFileMngService fnwFileMngService;

	@Resource(name = "fileMngUtil")
	protected FileMngUtil fileUtil;

	/**
	 * ibatis 목록 쿼리 아이디
	 */
	protected String listQueryId;
	/**
	 * ibatis 목록 총개수 쿼리 아이디
	 */
	protected String countQueryId;
	/**
	 * ibatis 보기 쿼리 아이디
	 */
	protected String viewQueryId;
	/**
	 * ibatis 등록 쿼리 아이디
	 */
	protected String insertQueryId;
	/**
	 * ibatis 수정  쿼리 아이디
	 */
	protected String updateQueryId;
	/**
	 * ibatis 삭제  쿼리 아이디
	 */
	protected String deleteQueryId;
	/**
	 * ibatis 엑셀다운로드 쿼리 아이디
	 */
	protected String excelQueryId;

	protected IExcelUploadService<T> excelUploadService;
	protected ListHandler<T> listHandler;

	/**
	 * 페이지네비게이션
	 */
	@Resource(name = "pageInfo")
	protected IPageInfo pageInfo;
	/**
	 * 페이지 파라미터정보
	 */
	protected PageQuery<T> pageQuery;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

    @Resource(name="egovMessageSource")
    protected EgovMessageSource egovMessageSource;

	protected SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM");

	private CmmProgramListener<T>[] listeners;

	private CompositeCmmProgramListenerContainer<T> listenerContainer = new CompositeCmmProgramListenerContainer<T>();

	protected ArticleAccessor<T> accessor;

	public AbstractCmmProgramService(){

	}
	/**
	 * 페이징이 포함된 일반 게시글의 목록 실제 목록은 ListHandler가 담당한다.
	 * ListHandler로 목록이 아닌 뷰,등록화면에서도 페이징을 가져올수 있다.
	 */
	@Override
	public void list(ParameterContext<T> paramCtx) throws Exception{
		if( paramCtx.getQueryIdVO() == null ){
			QueryIdVO qvo = new QueryIdVO();
			qvo.setListQueryId(listQueryId);
			qvo.setCountQueryId(countQueryId);
			paramCtx.setQueryIdVO(qvo);
		}
		if( paramCtx.getPageQuery() == null ){
			paramCtx.setPageQuery(pageQuery);
		}
		if( paramCtx.getPageInfo() == null ){
			paramCtx.setPageInfo(pageInfo);
		}
		if (paramCtx.getSqlDAO() != null) listHandler.setSqlDao(paramCtx.getSqlDAO());
		else  listHandler.setSqlDao(sqlDao);
		listHandler.invoke(paramCtx);
	}

	@Override
	public void view(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ISqlDAO<T> sqlDao = null;
		if (paramCtx.getSqlDAO() != null) sqlDao = paramCtx.getSqlDAO();
		else sqlDao = this.sqlDao;
		T result = sqlDao.selectDAO(viewQueryId, param);
		model.addAttribute(RESULT, result);

		getFiles(paramCtx);

		model.addAttribute(PAGE_QUERY_STRING, pageQuery.getPageQueryString(param));
	}

	@SuppressWarnings("unchecked")
	protected void getFiles(ParameterContext<T> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		T result = (T)model.get(RESULT);
		String atchFileId = "";
		try {
			atchFileId = (String)PropertyUtils.getProperty(result, ATCH_FILE_ID);
		}
		catch (Exception e) {

		}
		if( StringUtils.hasText(atchFileId) )
		{
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			List<FileVO> fileList = fnwFileMngService.selectFileInfs(fileVO);
			model.addAttribute("fileList", fileList);
			model.addAttribute("fileListCnt", fileList.size());
		}
	}

	@Override
	public void forInsert(ParameterContext<T> paramCtx) throws Exception {
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("user", user);
		String pageQueryString = pageQuery.getPageQueryString(paramCtx.getParam());
		model.addAttribute(PAGE_QUERY_STRING, pageQueryString);
	}

	@Override
	public void insert(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();

		boolean flag = uploadFile(paramCtx);
		if (!flag) return;

		ISqlDAO<T> sqlDao = null;
		if (paramCtx.getSqlDAO() != null) sqlDao = paramCtx.getSqlDAO();
		else sqlDao = this.sqlDao;
		Object pkValue = sqlDao.insertDAO(insertQueryId, param);
		paramCtx.setPkValue(pkValue);
		ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));
	}

	@Override
	public void forUpdate(ParameterContext<T> paramCtx) throws Exception{
		if ( !accessor.canAccess(paramCtx) ) {
			MVUtils.goUrl(accessor.getAccessDenyPage(paramCtx), "잘못된 접근입니다.", paramCtx.getModel());
		}

		ModelMap model = paramCtx.getModel();
		model.addAttribute("updateFlag", "Y");

		view(paramCtx);
	}

	@Override
	public void update(ParameterContext<T> paramCtx) throws Exception {
		if ( !accessor.canAccess(paramCtx) ) {
			MVUtils.goUrl(accessor.getAccessDenyPage(paramCtx), "잘못된 접근입니다.", paramCtx.getModel());
		}

		T param = paramCtx.getParam();

		boolean flag = uploadFile(paramCtx);
		if (!flag) return;

		ISqlDAO<T> sqlDao = null;
		if (paramCtx.getSqlDAO() != null) sqlDao = paramCtx.getSqlDAO();
		else sqlDao = this.sqlDao;
		sqlDao.updateDAO(updateQueryId, param);
		ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
	}

	protected boolean uploadFile(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		Map<String, MultipartFile> files = paramCtx.getFiles();
		if( files != null ){
			String fileFlag = fileUtil.checkFileInfo(files, 50000000, null);
			if (ModelAndViewResolver.SUCCESS.equals(fileFlag)) {
				String atchFileId = (String)PropertyUtils.getProperty(param, ATCH_FILE_ID);
				String filePath = getFilePath(param);
				atchFileId = fnwFileMngService.saveFile(files, atchFileId, filePath, param);
				if( StringUtils.hasText(atchFileId) ){
					PropertyUtils.setProperty(param, ATCH_FILE_ID, atchFileId);
				}
			}
			else {
				String msg = "";
				if (FileMngUtil.RESULT_CD_OVERSIZE.equals(fileFlag)) msg = "첨부파일은 50MB이하로 업로드 하실 수 있습니다.";
				if (FileMngUtil.RESULT_CD_EXTDENIED.equals(fileFlag)) msg = "첨부파일은 이미지(JPG, BMP, GIF, PNG), 문서파일(DOC, DOCX, HWP, PDF, XLS, XLSX, PPT, PPTX), 기타(TXT, ZIP) 만 업로드 하실 수 있습니다.";
				model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
				model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
				return false;
			}
		}
		return true;
	}

	protected String getFilePath(T param) throws Exception{
		String folder = simpleDateFormat.format(new Date());
		String programId = (String)PropertyUtils.getProperty(param, PROGRAM_ID);
		StringBuilder result = new StringBuilder();
		result.append(propertyService.getString("Globals.fileStorePath")).append("/");
		result.append(programId);
		result.append("/").append(folder).toString();
		return result.toString();
	}

	@Override
	public void delete(ParameterContext<T> paramCtx) throws Exception{
		if ( !accessor.canAccess(paramCtx) ) {
			MVUtils.goUrl(accessor.getAccessDenyPage(paramCtx), "잘못된 접근입니다.", paramCtx.getModel());
		}

		T param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ISqlDAO<T> sqlDao = null;
		if (paramCtx.getSqlDAO() != null) sqlDao = paramCtx.getSqlDAO();
		else sqlDao = this.sqlDao;
		sqlDao.deleteDAO(deleteQueryId, param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));
	}

	@Override
	public void downloadExcel(ParameterContext<T> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = (String[])model.get("titles");
		Assert.notNull(titles, "titles must not be null");

		T param = paramCtx.getParam();
		List<T> excelList = sqlDao.listDAO(excelQueryId, param);
		ExcelGenerateVO vo = new ExcelGenerateVO("data", titles, excelList);
		model.addAttribute("excel", vo);
	}

	@Override
	public void uploadExcel(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		final Map<String, MultipartFile> files = paramCtx.getFiles();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {
				excelUploadService.uploadExcel(param, file.getInputStream());
			}
		}
	}

	public void setListenerContainers(CmmProgramListenerContainer<T>[] listenerContainers){
		for (int i = 0; i < listenerContainers.length; i++) {
			this.listenerContainer.register(listenerContainers[i]);
		}
	}

	public CmmProgramListener<T>[] getListeners(){
		return listeners;
	}

	@Override
	public CmmProgramListenerContainer<T> getListenerContainer() {
		return listenerContainer;
	}

	public void setListQueryId(String listQueryId) {
		this.listQueryId = listQueryId;
	}

	public void setCountQueryId(String countQueryId) {
		this.countQueryId = countQueryId;
	}

	public void setViewQueryId(String viewQueryId) {
		this.viewQueryId = viewQueryId;
	}

	public void setInsertQueryId(String insertQueryId) {
		this.insertQueryId = insertQueryId;
	}

	public void setUpdateQueryId(String updateQueryId) {
		this.updateQueryId = updateQueryId;
	}

	public void setDeleteQueryId(String deleteQueryId) {
		this.deleteQueryId = deleteQueryId;
	}

	public void setExcelQueryId(String excelQueryId) {
		this.excelQueryId = excelQueryId;
	}

	public void setPageInfo(IPageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public void setSqlDao(ISqlDAO<T> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public void setListHandler(ListHandler<T> listHandler) {
		this.listHandler = listHandler;
	}

	public void setPageQuery(PageQuery<T> pageQuery) {
		this.pageQuery = pageQuery;
	}

	public void setExcelUploadService(IExcelUploadService<T> excelUploadService) {
		this.excelUploadService = excelUploadService;
	}

	public void setFnwFileMngService(FnwFileMngService fnwFileMngService) {
		this.fnwFileMngService = fnwFileMngService;
	}
	public ArticleAccessor<T> getAccessor() {
		return accessor;
	}
	public void setAccessor(ArticleAccessor<T> accessor) {
		this.accessor = accessor;
	}

}
