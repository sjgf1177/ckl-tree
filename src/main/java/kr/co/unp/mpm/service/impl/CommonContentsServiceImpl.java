package kr.co.unp.mpm.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.crud.vo.QueryIdVO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.mpm.service.MasterMenuManager;
import kr.co.unp.mpm.vo.MenuManageVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ServletContextAware;

import egovframework.com.utl.DateUtil;

@Service("commonContentsService")
public class CommonContentsServiceImpl extends DefaultCmmProgramService implements ServletContextAware{

    @Resource(name = "siteMngService")
    private SiteMngService siteMngService;

    @Resource(name = "masterMenuManagerService")
    private MasterMenuManager masterMenuManagerService;

	private ServletContext servletContext;

	public void setServletContext(ServletContext servletContext)
	{
		this.servletContext = servletContext;
	}

	public CommonContentsServiceImpl(){
		super.setListQueryId("commonContentsDAO.getMenuUserList");
		super.setCountQueryId("commonContentsDAO.getMenuUserListTotCnt");
		super.setViewQueryId("commonContentsDAO.getMenuUserDetail");
		super.setDeleteQueryId("commonContentsDAO.deleteProc");
		//super.setInsertQueryId("commonContentsDAO.noticeInsert");
		//super.setUpdateQueryId("commonContentsDAO.noticeUpdate");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = UnpUserDetailsHelper.getAuthenticatedUser();
    	if(UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")){
    		param.put("role", "ROLE_SUPER");
    	}

		param.put("pageSize", param.getInt("rows",10));
    	param.put("userId", adminUser.getUserId());

    	super.list(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception{

    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	if( !StringUtils.hasText(param.getString("sMenuNo")) ){
    		model.addAttribute(ModelAndViewResolver.MSG_KEY, "메뉴를 먼저 선택하여 주십시오.");
    		model.addAttribute(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
    		return;
    	}

    	UsersVO adminUser = UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

		QueryIdVO qvo = new QueryIdVO();
		param.put("pageSize", param.getInt("rows",10));
		qvo.setListQueryId("commonContentsDAO.getMenuUserDetailList");
		qvo.setCountQueryId("commonContentsDAO.getMenuUserDetailListTotCnt");
		paramCtx.setSqlDAO(sqlDao);
		paramCtx.setQueryIdVO(qvo);
		paramCtx.setPageQuery(pageQuery);
		paramCtx.setPageInfo(pageInfo);
		listHandler.invoke(paramCtx);

    	super.forUpdate(paramCtx);

    	ZValue result = (ZValue)model.get("result");
    	//String cvCon = StringUtils.strTohtml( result.getString("cvCon") );
    	//result.put( "cvCon", cvCon );
		String contentsPathRoot = propertyService.getString("contentsPathRoot");
		if( contentsPathRoot.endsWith("/") ) contentsPathRoot = contentsPathRoot.substring(0, contentsPathRoot.length()-1);
		String path = contentsPathRoot + result.getString("contentsPath");
		File file = new File(path);
		String contents = "";
		if (file.isFile() && param.getString("sCvNo").equals("")){
			contents = FileUtils.readFileToString(file, "UTF-8");
			contents = contents.replaceAll("<%\\s*@\\s*page .*%\\s*>", "");
			result.put("cvCon", contents);
		}

    	model.addAttribute("result", result);
    	model.addAttribute("siteMng", siteMngService.getSiteBySiteId(param.getString("siteId")));
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception{

    	ZValue param = paramCtx.getParam();
    	UsersVO adminUser = UnpUserDetailsHelper.getAuthenticatedUser();

    	param.put("userId", adminUser.getUserId());

		String cvCon = StrUtils.htmlTostr( param.getString("cvCon") );
		param.put( "cvCon", cvCon );
		if (param.getString("useYn").equals("Y")){
			sqlDao.updateDAO("commonContentsDAO.menuAllNoZvl", param);
		}
		sqlDao.insertDAO("commonContentsDAO.modifyZvl", param);

		if (param.getString("useYn").equals("Y")) {
			String contentsRoot = propertyService.getString( "contentsPathRoot" );
			ZValue contentsPathVal = sqlDao.selectDAO("commonContentsDAO.selectContentsPathByMenuNo", param);
			String contentsPath = contentsPathVal.getString("contentsPath");
			File file = new File( contentsRoot + contentsPath );

	    	String contents = "<%@page contentType=\"text/html;charset=utf-8\" %>\n" + cvCon;
			FileUtils.writeStringToFile( file, contents, "UTF-8" );
		}

		//컨텐츠 수정후 자료관리담당 최종수정일 바로반영
		@SuppressWarnings("unchecked")
		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)servletContext.getAttribute("menuAll" + param.getString("siteId"));
		masterMenuManagerService.setModifyDay(menuMap, param.getInt("sMenuNo"));

		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리되었습니다.", paramCtx.getModel());
    }

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		if (param.getString("useYn").equals("Y")){
			int cntntsNo = sqlDao.selectCount("commonContentsDAO.lastUseCntntsNo", param);
			param.put("lastUseCntntsNo", cntntsNo);
			sqlDao.updateDAO("commonContentsDAO.lastUseUpdate", param);
		}
		super.delete(paramCtx);

		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리되었습니다.", paramCtx.getModel());
	}

	public void nonAssignedlist(ParameterContext<ZValue> paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

		QueryIdVO qvo = new QueryIdVO();
		qvo.setListQueryId("commonContentsDAO.selectNonAssignedContentsList");
		qvo.setCountQueryId("commonContentsDAO.selectNonAssignedContentsListCnt");
		paramCtx.setQueryIdVO(qvo);
		paramCtx.setPageQuery(pageQuery);
		paramCtx.setPageInfo(pageInfo);
		listHandler.invoke(paramCtx);

		ZValue siteInfo = siteMngService.getSiteBySiteId(param.getString("siteId"));
		model.addAttribute("siteInfo", siteInfo);
	}

	public void assign(ParameterContext<ZValue> paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		sqlDao.updateDAO("commonContentsDAO.assignContentsMenu", param);

		UsersVO paramVO = new UsersVO();
		paramVO.setUserId(param.getString("userId"));
		MenuManageVO menuVo = new MenuManageVO();

		if( StringUtils.hasText(param.getString("userId")) ){
			ZValue userInfo = sqlDao.selectDAO("memberDAO.selectMember", param);
			menuVo.setMenuNo(param.getInt("menuNo"));
			menuVo.setUserId(userInfo.getString("userId"));
			menuVo.setUserName(userInfo.getString("userName"));
			menuVo.setTel(userInfo.getString("userPhone"));
			menuVo.setTeamName(userInfo.getString("teamName"));
			menuVo.setDeptId(userInfo.getString("deptId"));
			menuVo.setDeptName(userInfo.getString("gwaName"));
		}
		else{
			menuVo.setMenuNo(param.getInt("menuNo"));
			menuVo.setUserId("");
			menuVo.setUserName("");
			menuVo.setTel("");
			menuVo.setTeamName("");
			menuVo.setDeptId("");
			menuVo.setDeptName("");
		}

		@SuppressWarnings("unchecked")
		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)servletContext.getAttribute(MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + param.getString("siteId"));
		masterMenuManagerService.setChargeInPerson(menuMap, menuVo);
	}

	public void initContentsCIP(ParameterContext<ZValue> paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		List<String> menuNoData = new ArrayList<String>();
		List<ZValue> changedList = sqlDao.listDAO("commonContentsDAO.selectChangedCIPContentsList", param);
		StringBuffer msg = new StringBuffer();
		for(ZValue val : changedList)
		{
			msg.append(DateUtil.getToday("yyyyMMdd hh:mm:ss"));
			msg.append(" ["+val.getString("menuNo")+"]"+"["+val.getString("path")+"]에 지정된 ");
			msg.append("["+val.getString("usrId")+"]"+"["+val.getString("usrNm")+"] 사용자를 초기화하였습니다.\n");
			menuNoData.add(val.getString("menuNo"));
		}

		param.putObject("menuNoData", menuNoData);
		sqlDao.updateDAO("commonContentsDAO.initContentsCIP", param);

		String path = propertyService.getString("chargeInPerson.fileStorePath");
		FileOutputStream fout = null;
		try {
			fout = new FileOutputStream(new File(path), true);
			IOUtils.write(msg.toString(), fout, "UTF-8");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			IOUtils.closeQuietly(fout);
		}
	}

	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	List<ZValue> resultList = sqlDao.listDAO("commonContentsDAO.selectNonAssignedContentsExcelList", param);
    	List<ZValue> excelList = new ArrayList<ZValue>();

		for(ZValue vo : resultList)
		{
			ZValue _val = new ZValue();
			_val.put("rn", vo.get("rn"));
			_val.put("menuNo", vo.getString("menuNo"));
			_val.put("path", vo.getString("path"));
			excelList.add(_val);
		}

		String[] title = {"번호", "메뉴번호", "메뉴명"};
		ExcelGenerateVO vo = new ExcelGenerateVO("담당자 미지정컨텐츠 리스트", title, excelList);
		model.addAttribute("excel", vo);
	}

	private String getForwardLink(ZValue param) {
		StringBuilder link = new StringBuilder();
		link.append("/bos/mpm/commonContents/forUpdate.do");
		link.append("?siteId=").append(param.getString("siteId"));
		link.append("&sUseYn=").append(param.getString("sUseYn"));
		link.append("&sMenuNo=").append(param.getString("sMenuNo"));
		link.append("&menuNo=").append(param.getString("menuNo"));
		link.append("&viewType=").append(param.getString("viewType"));
		link.append("&gubun=").append(param.getString("gubun"));

		return link.toString();
	}
}
