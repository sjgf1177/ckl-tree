package kr.co.unp.bbs.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.BoardMasterVO;
import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.pg.dao.PageGeneratorDAO;
import kr.co.unp.pg.vo.FieldAttributeVO;
import kr.co.unp.pg.vo.PageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.validation.Validator;

import com.sun.syndication.feed.rss.Description;
import com.sun.syndication.feed.rss.Item;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class FnwBBSManageServiceImpl extends DefaultCmmProgramService implements FnwBBSManageService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "pageGeneratorDAO")
	protected PageGeneratorDAO pageGeneratorDAO;

	@Resource(name = "siteMngService")
	protected SiteMngService siteMngService;

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

    protected Validator validator;

    @Resource(name="userUpdatableBbsList")
    private List<String> userUpdatableBbsList = new ArrayList<String>();

    public static final String PORTAL_MAIN_CACHE_NAME = "storedMain";

    protected String delPermanentlyQueryId = "BasicBBSManageDAO.delPermanentlyBoardArticle";
    protected String restoreQueryId = "BasicBBSManageDAO.restoreBoardArticle";
    protected String replyListQueryId = "BasicBBSManageDAO.selectReplyArticles";
    protected String cmmntListQueryId = "CommentDAO.selectCommentList";
    protected String updateInqireCoQueryId = "BasicBBSManageDAO.updateInqireCo";
    private String prevQueryId = "BasicBBSManageDAO.selectPrevArticle";
    private String nextQueryId = "BasicBBSManageDAO.selectNexArticle";

    public FnwBBSManageServiceImpl(){
    	super.setListQueryId("BasicBBSManageDAO.selectBoardArticleList");
    	super.setCountQueryId("BasicBBSManageDAO.selectBoardArticleListCnt");
    	super.setViewQueryId("BasicBBSManageDAO.selectBoardArticle");
    	super.setInsertQueryId("BasicBBSManageDAO.insertBoardArticle");
    	super.setUpdateQueryId("BasicBBSManageDAO.updateBoardArticle");
    	super.setDeleteQueryId("BasicBBSManageDAO.deleteBoardArticle");
    	super.setExcelQueryId("BasicBBSManageDAO.selectBoardExcelList");
    }

	@Override
	public void restore(ParameterContext<ZValue> paramCtx) throws Exception
	{
		checkBbsUpdate(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		//삭제코드 관리자 삭제로 초기화
		if( !StringUtils.hasText(param.getString("delcode")) ) param.put("delcode", SearchVO.NON_DELETION);
		sqlDao.updateDAO(restoreQueryId, param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

    @Override
	public void delPermanently(ParameterContext<ZValue> paramCtx) throws Exception
	{
		checkBbsUpdate(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.selectDAO(viewQueryId, param);
		result.put("siteName", param.getString("siteName"));
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("lastUpdusrId", user.getUserId());

		if( !accessor.canAccess(paramCtx) ) {
			String goUrl = accessor.getAccessDenyPage(paramCtx);
			MVUtils.goUrl(goUrl, "본인글만 삭제할 수 있습니다.", model);
			return;
		}

		sqlDao.deleteDAO(delPermanentlyQueryId, param);
		String atchFileId = result.getString("atchFileId");
		if ( StringUtils.hasText(atchFileId) ) {
			FileVO fvo = new FileVO();
			fvo.setAtchFileId(atchFileId);
			fvo.setTableNm(param.getString("tableNm"));
			fnwFileMngService.deleteFileInf(fvo);
		}
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

    @Override
    public void delete(ParameterContext<ZValue> paramCtx) throws Exception
    {
		checkBbsUpdate(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.selectDAO(viewQueryId, param);
		result.put("siteName", param.getString("siteName"));
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("lastUpdusrId", user.getUserId());
		if( SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName")) ){
			param.put("delcode", SearchVO.BOS_DELETION);
			//답변삭제시 원글 상태값 REPLY_AT = 'N'
			if (param.getInt("parnts") > 0) {
				param.put("replyAt", "N");
				sqlDao.updateDAO("optionalBoardDAO.updateReplyAt", param);
			}
		}
		else
		{
			param.put("delcode", SearchVO.USER_DELETION);
		}

		if( !accessor.canAccess(paramCtx) ) {
			String goUrl = accessor.getAccessDenyPage(paramCtx);
			MVUtils.goUrl(goUrl, "본인글만 삭제할 수 있습니다.", model);
			return;
		}

		sqlDao.deleteDAO(deleteQueryId, param);
		cacheUtil.remove(PORTAL_MAIN_CACHE_NAME);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

    @SuppressWarnings("unchecked")
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		BoardMasterVO masterVO = (BoardMasterVO)model.get("masterVO");
		if( masterVO == null ) masterVO = new BoardMasterVO();
		String bbsTyCode = masterVO.getBbsTyCode();
		param.put("bbsTyCode", bbsTyCode);

		param.put("pageUnit", masterVO.getPageUnit());
		param.put("pageSize", masterVO.getPageSize());
		if ((SiteMngService.CKLMOBILE_SITE_NAME).equals(param.getString("siteName")) || (SiteMngService.EDUMOBILE_SITE_NAME).equals(param.getString("siteName"))) {
			if ( masterVO.getPageUnit() == 9 ) param.put("pageUnit", 8);
			/*
			param.put("pageSize", 3);
			*/
			//						공지사항 			취업매거진1		취업매거진2		아카데미 이야기	우수크리에이터
			String [] limitBoardId = {"B0000011", "B0000020", "B0000047", "B0000023", "B0000058"};
			for ( int i=0; i<limitBoardId.length; i++)
				if ( limitBoardId[i].equals(masterVO.getBbsId()) ) param.put("pageSize", 10); //rsg20171214
		}

		if( !StringUtils.hasText(param.getString("delcode")) ) param.put("delcode", SearchVO.NON_DELETION);

		super.list(paramCtx);

		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		Map<String, List<FileVO>> fileMap = (Map<String, List<FileVO>>)model.get("fileMap");
		setBoardFirstFile(resultList, fileMap);
	}

	public void listMy(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("ntcrId", Long.toString(user.getUserIdx()));

		paramCtx.setParam(param);
		list(paramCtx);
	}
	public void listSec(ParameterContext<ZValue> paramCtx) throws Exception
	{
		list(paramCtx);
	}

    @Override
	public void rssService(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
    	param.put("delcode", SearchVO.NON_DELETION);

		list(paramCtx);

		ModelMap model = paramCtx.getModel();
		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		List<Item> itemList = new ArrayList<Item>();
		StringBuilder link = new StringBuilder();
		for(ZValue result : resultList)
		{
			Item item = new Item();
			item.setTitle(result.getString("nttSj"));
			link.append("/").append(result.getString("siteName")).append("/bbs/").append(result.getString("bbsId")).append("/view.do");
			link.append("?nttId=").append(result.getString("nttId"));
			link.append("&menuNo=").append(result.getString("menuNo"));
			item.setLink(link.toString());

			Description des = new Description();
			des.setValue(result.getString("nttCn"));
			item.setDescription(des);

			item.setAuthor(result.getString("ntcrNm"));
			String regDate = result.getString("regDate");
			Date date = DateUtils.parseDate(regDate, new String[]{"yyyy-MM-dd"});
			item.setPubDate(date);

			itemList.add(item);
		}

		model.addAttribute("itemList", itemList);
	}

	/**
	 * 게시글 리스트 첫번째 첨부화일를 저장한다
	 * @param resultList - 게시글 리스트
	 * @param fileMap - 파일아이디를 키로 가지고 있는 게시글건당 파일리스트
	 */
	public void setBoardFirstFile(List<ZValue> resultList, Map<String, List<FileVO>> fileMap){
		if( CollectionUtils.isEmpty(resultList) || MapUtils.isEmpty(fileMap) ) return;
    	for( ZValue val : resultList ) {
    		String atchFileId = val.getString("atchFileId");
    		if( StringUtils.hasText(atchFileId) ){
    			List<FileVO> fileList = fileMap.get(atchFileId);
    			if( CollectionUtils.isNotEmpty(fileList) ){
    				FileVO fileVo = fileList.get(0);
    				val.put("imgUrl", fileVo.getImgUrl());
    				//val.put("imgUrl", fileVo.getFileStreCours()+"\\"+fileVo.getStreFileNm());
    				val.put("orignlFileNm", fileVo.getOrignlFileNm());
    				val.put("fileCount", fileList.size());
    				val.put("fileSn", fileVo.getFileSn());
    				val.put("fileExtsn", fileVo.getFileSn());
    				val.put("streFileNm", fileVo.getStreFileNm());
    			}
    		}
    	}
	}

	protected Map<String, ZValue> selectPrevNexArticle(ZValue param) throws Exception{
		Map<String, ZValue> result = new HashMap<String, ZValue>();
		ZValue prevVal = sqlDao.selectDAO(prevQueryId, param);
		ZValue nextVal = sqlDao.selectDAO(nextQueryId, param);
		result.put("PREV", prevVal);
		result.put("NEXT", nextVal);
		return result;
	}

	public void secureView(ParameterContext<ZValue> paramCtx) throws Exception
	{
		view(paramCtx);
	}

    @Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.selectDAO(viewQueryId, param);
		if( result == null ){
			return;
		}
		model.addAttribute("result", result);

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("user", user);

		if( !accessor.canAccess(paramCtx) ) {
			String goUrl = accessor.getAccessDenyPage(paramCtx);
			MVUtils.goUrl(goUrl, "비공개글 입니다.", model);
			return;
		}

		sqlDao.updateDAO(updateInqireCoQueryId, param);
		getArticle(paramCtx, result.getString("atchFileId"));
	}

    @Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception
	{
		checkBbsUpdate(paramCtx);

		ZValue param = paramCtx.getParam();
		UsersVO usersVO = UnpUserDetailsHelper.getAuthenticatedUser();
		initValue(param, usersVO);


		super.insert(paramCtx);
		if (paramCtx.getPkValue() != null) {
			ModelMap model = paramCtx.getModel();
			BoardMasterVO masterVO = (BoardMasterVO)model.get("masterVO");
			synchronized (masterVO) {
				masterVO.setNttId(Long.parseLong(paramCtx.getPkValue().toString()));
			}
			//cacheUtil.save(PORTAL_MAIN_CACHE_NAME, id + "List", list);
			cacheUtil.remove(PORTAL_MAIN_CACHE_NAME);
		}
		//답변시 원글 상태값 REPLY_AT = 'Y'
		if (param.getInt("parnts") > 0) {
			if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
				param.put("replyAt", "Y");
				sqlDao.updateDAO("optionalBoardDAO.updateReplyAt", param);
			}
		}

	}

	public void forInsertRe(ParameterContext<ZValue> paramCtx) throws Exception
	{
		checkBbsUpdate(paramCtx);

		forInsert(paramCtx);

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.selectDAO(viewQueryId, param);
		model.addAttribute("orgResult", result);
	}

    @Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception
	{
		checkBbsUpdate(paramCtx);

    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	ZValue result = sqlDao.selectDAO(viewQueryId, param);
		model.addAttribute("result", result);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("user", user);

		if( !accessor.canAccess(paramCtx) ) {
			String goUrl = accessor.getAccessDenyPage(paramCtx);
			MVUtils.goUrl(goUrl, "본인글만 수정할 수 있습니다.", model);
			return;
		}

		model.addAttribute("updateFlag", "Y");
		getArticle(paramCtx, result.getString("atchFileId"));

		BoardMasterVO masterVO = (BoardMasterVO)model.get("masterVO");
		masterVO.setNttId(param.getLong("nttId"));
	}

	public void forUpdateRe(ParameterContext<ZValue> paramCtx) throws Exception
	{
		forUpdate(paramCtx);
	}

    protected void getArticle(ParameterContext<ZValue> paramCtx, String atchFileId) throws Exception
    {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
		BoardMasterVO masterVO = (BoardMasterVO)model.get("masterVO");

		if (masterVO.getReplyPosblAt().equals("Y")) { // 답장가능여부
			List<ZValue> replyList = sqlDao.listDAO(replyListQueryId, param);
			model.addAttribute("replyList", replyList);

			Map<String, List<FileVO>> replyFileMap = listHandler.getFileMap(param, replyList);
			model.addAttribute("replyFileMap", replyFileMap);
		}

		if ("Y".equals(masterVO.getFileAtchPosblAt())) { // 파일첨부가능여부
			if (StringUtils.hasText(atchFileId)) {
				FileVO fileVO = new FileVO();
				fileVO.setAtchFileId(atchFileId);
				List<FileVO> fileList = fnwFileMngService.selectFileInfs(fileVO);
				model.addAttribute("fileList", fileList);
				model.addAttribute("fileListCnt", fileList.size());
			}
		}

		/*if ("Y".equals(masterVO.getCmmntPosblAt())) { // 커멘트사용여부
			List<ZValue> cmmntList = sqlDao.listDAO(cmmntListQueryId, param);
			model.addAttribute("cmmntList", cmmntList);
		}*/

		if ("Y".equals(masterVO.getPreNextPosblAt())) { // 이전글다음글가능여부
			Map<String, ZValue> prevNextMap = selectPrevNexArticle(param);
			model.addAttribute("prevNextMap", prevNextMap);
		}
		model.addAttribute("pageQueryString", pageQuery.getPageQueryString(param));
    }

    @Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception
	{
		checkBbsUpdate(paramCtx);

		ZValue param = paramCtx.getParam();
		UsersVO usersVO = UnpUserDetailsHelper.getAuthenticatedUser();
		initValue(param, usersVO);

		super.update(paramCtx);

		cacheUtil.remove(PORTAL_MAIN_CACHE_NAME);
	}

    @Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception
	{
    	ModelMap model = paramCtx.getModel();
    	ZValue param = paramCtx.getParam();
		int pageUnit = param.getInt("pageUnit", 10);
		int pageSize = param.getInt("pageSize", 10);
		int pageIndex = param.getInt("pageIndex", 1);
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(pageSize);

		param.put("firstIndex", paginationInfo.getFirstRecordIndex());
		param.put("lastIndex", paginationInfo.getLastRecordIndex());
		param.put("recordCountPerPage", paginationInfo.getRecordCountPerPage());

		String[] titles = null;
		BoardMasterVO masterVO = (BoardMasterVO)model.get("masterVO");
		PageVO pVo = new PageVO();
		pVo.setPageCode(masterVO.getBbsAttrbCode());
		pVo.setFieldList(param.getString("fieldList"));
		// pVo.setPageType("bbsNews"); // 왜 사용한건지 ??/
		List<FieldAttributeVO> fieldList = pageGeneratorDAO.selectFieldAttributeList(pVo);
		if( CollectionUtils.isNotEmpty(fieldList) ){
			List<String> _titles = new ArrayList<String>();
			for(FieldAttributeVO fVo : fieldList){
				_titles.add(fVo.getFieldText());
			}
			titles = _titles.toArray(new String[0]);

			if( !StringUtils.hasText(param.getString("delcode")) ) param.put("delcode", SearchVO.NON_DELETION);
			List<ZValue> resultList = sqlDao.listDAO(excelQueryId, param);
			List<ZValue> excelList = new ArrayList<ZValue>();
			for(ZValue bVo : resultList)
			{
				ZValue val = new ZValue();
				for(FieldAttributeVO fVo : fieldList){
					String fieldName = fVo.getFieldName();
					if( "atchFileId".equals(fieldName) && StringUtils.hasText(bVo.getString("atchFileId")) ) {
						val.put(fieldName, "/public/cmm/fms/FileDown.do?atchFileId="+bVo.getString("atchFileId")+"&fileSn="+bVo.getString("fileSn"));
					}
					else
						val.put(fieldName, PropertyUtils.getProperty(bVo, fieldName));
				}
				excelList.add(val);
			}
			ExcelGenerateVO vo = new ExcelGenerateVO(masterVO.getBbsNm(), titles, excelList);
			model.addAttribute("excel", vo);
		}
	}

    @Override
    public void initValue(ZValue param, UsersVO usersVO)
	{
		if(usersVO != null)
		{
			if( !StringUtils.hasText(param.getString("ntcrId")) ) param.put("ntcrId", usersVO.getUserIdx());
			//param.put("ntcrId", usersVO.getUserId());
			param.put("ntcrCi", usersVO.getCiInfo());
			param.put("lastUpdusrId", usersVO.getUserIdx());
			param.put("frstRegisterId", usersVO.getUserIdx());
			param.put("deptId", usersVO.getDeptId());
			if( !StringUtils.hasText(param.getString("ntcrNm")) ) param.put("ntcrNm", usersVO.getUserNm());
		}

		if( !StringUtils.hasText(param.getString("secret")) ) param.put("secret", SearchVO.PUBLIC);
		if( !StringUtils.hasText(param.getString("htmlYn")) ) param.put("htmlYn", "Y");
		if( !StringUtils.hasText(param.getString("nttType")) ) param.put("nttType", SearchVO.BASIC_NTT_TYPE);
		if( !StringUtils.hasText(param.getString("useAt")) ) param.put("useAt", SearchVO.USE);
		if( !StringUtils.hasText(param.getString("delcode")) ) param.put("delcode", SearchVO.NON_DELETION);
		if( !StringUtils.hasText(param.getString("replyLc")) ) param.put("replyLc", "0");
		if( !StringUtils.hasText(param.getString("replyAt")) ) param.put("replyAt", "N");
		if( !StringUtils.hasText(param.getString("parnts")) ) param.put("parnts", "0");

		if( StringUtils.hasText(param.getString("nttCn")) ){
			param.put("nttCn", StrUtils.unscript(param.getString("nttCn")));
		}

		if( StringUtils.hasText(param.getString("ntcrZipcode1")) && StringUtils.hasText(param.getString("ntcrZipcode2")) ){
	    	String ntcrZipcode = param.getString("ntcrZipcode1") + "-" + param.getString("ntcrZipcode2");
	    	param.put("ntcrZipcode", ntcrZipcode);
		}
		if( StringUtils.hasText(param.getString("ntcrHp1")) && StringUtils.hasText(param.getString("ntcrHp2")) && StringUtils.hasText(param.getString("ntcrHp3"))){
	    	String ntcrHp = param.getString("ntcrHp1") + "-" + param.getString("ntcrHp2") + "-" + param.getString("ntcrHp3");
	    	param.put("ntcrHp", ntcrHp);
		}
		if( StringUtils.hasText(param.getString("ntcrTel1")) && StringUtils.hasText(param.getString("ntcrTel2")) && StringUtils.hasText(param.getString("ntcrTel3"))){
	    	String ntcrTel = param.getString("ntcrTel1") + "-" + param.getString("ntcrTel2") + "-" + param.getString("ntcrTel3");
	    	param.put("ntcrTel", ntcrTel);
		}
		if( StringUtils.hasText(param.getString("ntcrEmail1")) && StringUtils.hasText(param.getString("ntcrEmail2")) ){
	    	String ntcrEmail = param.getString("ntcrEmail1") + "@" + param.getString("ntcrEmail2");
	    	param.put("ntcrEmail", ntcrEmail);
		}
	}

	public void setDelPermanentlyQueryId(String delPermanentlyQueryId) {
		this.delPermanentlyQueryId = delPermanentlyQueryId;
	}

	public void setRestoreQueryId(String restoreQueryId) {
		this.restoreQueryId = restoreQueryId;
	}

	public void setReplyListQueryId(String replyListQueryId) {
		this.replyListQueryId = replyListQueryId;
	}

	public void setUpdateInqireCoQueryId(String updateInqireCoQueryId) {
		this.updateInqireCoQueryId = updateInqireCoQueryId;
	}

    public String getPrevQueryId() {
		return prevQueryId;
	}

	public void setPrevQueryId(String prevQueryId) {
		this.prevQueryId = prevQueryId;
	}

	public String getNextQueryId() {
		return nextQueryId;
	}

	public void setNextQueryId(String nextQueryId) {
		this.nextQueryId = nextQueryId;
	}

	public String getDelPermanentlyQueryId() {
		return delPermanentlyQueryId;
	}

	public String getRestoreQueryId() {
		return restoreQueryId;
	}

	public String getReplyListQueryId() {
		return replyListQueryId;
	}

	public String getUpdateInqireCoQueryId() {
		return updateInqireCoQueryId;
	}

	public PageGeneratorDAO getPageGeneratorDAO() {
		return pageGeneratorDAO;
	}

	public void setPageGeneratorDAO(PageGeneratorDAO pageGeneratorDAO) {
		this.pageGeneratorDAO = pageGeneratorDAO;
	}

	public List<String> getUserUpdatableBbsList() {
		return userUpdatableBbsList;
	}

	public void setUserUpdatableBbsList(List<String> userUpdatableBbsList) {
		this.userUpdatableBbsList = userUpdatableBbsList;
	}

	@Override
	protected String getFilePath(ZValue param){
		String folder = simpleDateFormat.format(new Date());
		StringBuilder result = new StringBuilder();
		return result.append(propertyService.getString("Globals.fileStorePath")).append("/bbs/").append(param.getString("bbsId")).append("/").append(folder).toString();
	}

	protected void checkBbsUpdate(ParameterContext<ZValue> paramCtx){
		ZValue param = paramCtx.getParam();
		String bbsId = param.getString("bbsId");

		if (!SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			if( !userUpdatableBbsList.contains(bbsId) ){
				Assert.isTrue(UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY"), "관리자만 접근가능합니다.");
			}
		}

	}
}
