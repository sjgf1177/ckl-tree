package kr.co.ckl.progrm.service;


import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.ems.service.EmsService;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.FileMngUtil;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ProgrmApplcntService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;

	@Resource(name="progrmMasterService")
	private ProgrmMasterService progrmMasterService;

	@Resource(name = "emsService")
	protected EmsService emsService;

	public static enum Status {
		WAITING("01"), //????????????
		COMPT("02"), //????????????
		CANCEL("03");  //??????
		private String value;

		private Status(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	public ProgrmApplcntService(){
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		
		param.put("pCol", "");
		param.put("pSortTp", "");
		
		if(param.getString("pid").equals("bd_resveNo")){
			param.put("pCol", "A.RESVE_NO");
		} else if(param.getString("pid").equals("bd_userId")){
			param.put("pCol", "B.USER_ID");
		} else if(param.getString("pid").equals("bd_nm")){
			param.put("pCol", "A.NM");
		} else if(param.getString("pid").equals("bd_sex")){
			param.put("pCol", "A.SEX");
		} else if(param.getString("pid").equals("bd_brthdy")){
			param.put("pCol", "A.BRTHDY");
		} else if(param.getString("pid").equals("bd_rDt")){
			param.put("pCol", "A.RCEPT_DT");
		} else if(param.getString("pid").equals("bd_rceptSttusNm")){
			param.put("pCol", "A.RCEPT_STTUS");
		} else if(param.getString("pid").equals("bd_cDt")){
			param.put("pCol", "A.CANCL_DT");
		} else if(param.getString("pid").equals("bd_confmSttusNm")){
			param.put("pCol", "A.CONFM_STTUS");
		} else if(param.getString("pid").equals("bd_partcptnComptAt")){
			param.put("pCol", "A.PARTCPTN_COMPT_AT");
		}
		
		if(param.getString("pSort").equals("D")){
			param.put("pSortTp", "DESC");
		} else if(param.getString("pSort").equals("A")) {
			param.put("pSortTp", "ASC");
		}

		super.setViewQueryId("progrmMasterDAO.view");
		super.view(paramCtx);

    	ZValue masterResult = (ZValue)model.get("result");
    	ZValue stats = sqlDao.selectDAO("progrmMasterDAO.statsList", param);

    	model.addAttribute("masterResult", masterResult);
		model.addAttribute("stats", stats);
		progrmMasterService.progrsSttusChk(paramCtx);

		super.setCountQueryId("progrmApplcntDAO.listCnt");
		super.setListQueryId("progrmApplcntDAO.list");
		super.list(paramCtx);

		//access history param
		param.put("nttSn", param.getString("prgSn"));
	}

	/**
	 * ?????? ?????? > ???????????? ??????/?????? ??????(?????????)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listMypage(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		param.put("userSn", user.getUserIdx());

		super.setCountQueryId("progrmApplcntDAO.listMypageCnt");
		super.setListQueryId("progrmApplcntDAO.listMypage");
		super.list(paramCtx);
		
    	@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");

		for (ZValue zvl : resultList) {
			param.put("prgSn", zvl.getString("prgSn"));
			progrmMasterService.progrsSttusChk(paramCtx);
			zvl.put("progrsSttus", param.getString("progrsSttus"));
		}
	}

	/**
	 * ????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ctfhvPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());

		if (!accessor.canAccess(paramCtx)) {
			MVUtils.goUrl("javascript:history.back()", "????????? ???????????????.", model);
			return;
		}

		super.setViewQueryId("progrmApplcntDAO.view");
		super.view(paramCtx);

		ZValue masterResult = sqlDao.selectDAO("progrmMasterDAO.view", param);

		model.addAttribute("masterResult", masterResult);

		Calendar date = Calendar.getInstance();

		model.addAttribute("yearMonth", (date.get(Calendar.YEAR))+""+(date.get(Calendar.MONTH)+1));
		model.addAttribute("today", (date.get(Calendar.YEAR))+"??? "+(date.get(Calendar.MONTH)+1)+"??? "+(date.get(Calendar.DATE))+"???");
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());

		if (!accessor.canAccess(paramCtx)) {
			MVUtils.goUrl("javascript:history.back()", "????????? ???????????????.", model);
			return;
		}

		super.setViewQueryId("progrmApplcntDAO.view");
		super.view(paramCtx);

		addInfo(paramCtx); //??????????????????
		ZValue masterResult = sqlDao.selectDAO("progrmMasterDAO.view", param);

		model.addAttribute("masterResult", masterResult);

		//access history param
		param.put("nttSn", param.getString("prgSn"));
		param.put("targetUserSn", param.getString("userSn"));
		model.addAttribute("COM063CodeList", codeList("COM063"));
	}

	/**
	 * ????????? ?????? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listPrintPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String[] userSnList = {param.getString("userSnData")};
		if (param.get("userSnData") != null) {
			if (param.get("userSnData") instanceof String[]) {
				userSnList = (String[])param.get("userSnData");
			}
		}
		if (!"ALL".equals(param.getString("atchFileTp"))) param.putObject("userSnList", userSnList);

		List<ZValue> infoList = sqlDao.listDAO("progrmApplcntDAO.view", param);

		for (ZValue zvl : infoList) {
			param.put("reqstSn", zvl.getString("reqstSn"));
			addInfo(paramCtx); //??????????????????

			@SuppressWarnings("unchecked")
			List<ZValue> addInfo = (List<ZValue>) model.get("addInfoList");
			for (ZValue result : addInfo) {
		    	Map<String, List<FileVO>> fileMap = getFileMap(param, addInfo, "atchFileId");
				result.putObject("fileMap", fileMap);
			}
			zvl.putObject("addInfo", addInfo);
		}

		model.addAttribute("infoList", infoList);
	}

	public Map<String, List<FileVO>> getFileMap(ZValue zvl, List<ZValue> resultList, String fileIdNm) throws Exception{
		Map<String, List<FileVO>> fileMap = Collections.emptyMap();
    	if( CollectionUtils.isNotEmpty(resultList) ){
        	ArrayList<String> _atchFileIdData = new ArrayList<String>();
        	for( ZValue val : resultList ) {
        		if( StringUtils.hasText(val.getString(fileIdNm))) _atchFileIdData.add(val.getString(fileIdNm));
        	}
        	if( CollectionUtils.isNotEmpty(_atchFileIdData) ) {
        		String[] atchFileIdData = _atchFileIdData.toArray(new String[]{""});
        		FileVO fvo = new FileVO();
        		fvo.setAtchFileIdData(atchFileIdData);
        		fileMap = fnwFileMngService.selectArticleFileMap(fvo);
        	}
    	}

    	return fileMap;
	}

	/**
	 * ??????????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void addInfo(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();

		List<ZValue> addInfo = sqlDao.listDAO("progrmApplcntDAO.addInfo", param);
		Map<String, List<FileVO>> fileMap = getFileMap(param, addInfo, "atchFileId");
		model.addAttribute("fileMap", fileMap);

		for (ZValue zvl : addInfo) {
			String attrb = zvl.getString("attrb");
			String attrbDataCn = zvl.getString("attrbDataCn");
			if ("06".equals(attrb) || "07".equals(attrb) || "08".equals(attrb) || "09".equals(attrb)) { //?????????????????? ?????????????????????
				if (StringUtils.hasText(zvl.getString("iemCodeId"))) {
					List<ZValue> codeList = codeList(zvl.getString("iemCodeId"));
					for (ZValue code : codeList) {
						if (code.getString("code").equals(attrbDataCn)) {
							zvl.put("codeNm", code.getString("codeNm"));
						}
					}
					if ("07".equals(attrb)) model.addAttribute("iemCodeList", codeList);
				}
			}
		}
		model.addAttribute("addInfoList", addInfo);
	}

	/**
	 * ?????????????????? ???
	 * @param paramCtx
	 * @throws Exception
	 */
	public void confmSttusPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		model.addAttribute("COM054CodeList", codeList("COM054"));
	}

	/**
	 * ??????????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void confmSttusChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String userSnArr = param.getString("userSnArr");
		String [] arrData = null;
		if (StringUtils.hasText(userSnArr)) {
			arrData = userSnArr.split(",");
			List<String> list = Arrays.asList(arrData);
			for (String val : list) {
				param.put("reqstSn", val);
				sqlDao.updateDAO("progrmApplcntDAO.confmSttusChange", param);
			}
		}
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * ?????????????????? ???
	 * @param paramCtx
	 * @throws Exception
	 */
	public void partcptnComptPopup(ParameterContext<ZValue> paramCtx) throws Exception {
	}

	/**
	 * ??????????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void partcptnComptChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String userSnArr = param.getString("userSnArr");
		String [] arrData = null;
		if (StringUtils.hasText(userSnArr)) {
			arrData = userSnArr.split(",");
			List<String> list = Arrays.asList(arrData);
			for (String val : list) {
				param.put("reqstSn", val);
				sqlDao.updateDAO("progrmApplcntDAO.partcptnComptChange", param);
			}
		}
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * ??????????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void rceptSttusChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		param.put("userSn", user.getUserIdx());
		if (!accessor.canAccess(paramCtx)) {
			MVUtils.goUrl("javascript:history.back()", "????????? ???????????????.", model);
			return;
		}

		sqlDao.updateDAO("progrmApplcntDAO.rceptSttusChange", param);

		// ????????????
		boolean flag = false;
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			if (StringUtils.hasText(param.getString("telNo"))) {
				flag = true;
			}
		}
		else {
			if ("02".equals(user.getAuthSe()) || "03".equals(user.getAuthSe())) { // ?????????????????????
				if (StringUtils.hasText(user.getMoblphon())) {
					param.put("mbtlnum", user.getMoblphon());
					flag = true;
				}
			}
		}
		if (flag == true) {
			String rceptSttusNm = "03".equals(param.getString("rceptSttus")) ? "??????" : "??????";

			String tranMsg = "["+param.getString("prgNm")+"] ??????????????? "+rceptSttusNm+"???????????????.";
			param.put("phone", param.getString("mbtlnum"));
			param.put("callback", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "02-2161-0000" : "02-6310-0770");
//			param.put("callback", "02-2161-0000");
			param.put("msg", tranMsg);
			// emsService.sndngSms(param);
		}

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * SMS?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void smsSndngPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		super.setCountQueryId("progrmApplcntDAO.listCnt");
		super.setListQueryId("progrmApplcntDAO.list");
		super.list(paramCtx);

		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		List<String> mbtlnumList = new ArrayList<String>();

		for (ZValue val : resultList) {
			mbtlnumList.add(val.getString("mbtlnum"));
		}
		session.setAttribute("mbtlnumList", mbtlnumList);

	}

	/**
	 * SMS??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void smsSndng(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		@SuppressWarnings("unchecked")
		List<String> mbtlnumList = (List<String>) session.getAttribute("mbtlnumList");

		for (String val : mbtlnumList) {
			if (StringUtils.hasText(val)) {
				param.put("phone", val);
				param.put("callback", param.getString("tel1") + "-" + param.getString("tel2") + "-" + param.getString("tel3"));
				param.put("msg", param.getString("msg"));
				param.put("refkey", "accademy");

				emsService.sndngSms(param);			
			}
		}
		session.removeAttribute("mbtlnumList");
		MVUtils.winClose("?????????????????????.", model);
	}

	/**
	 * ????????? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setCountQueryId("progrmApplcntDAO.listCnt");
		super.setListQueryId("progrmApplcntDAO.list");
		super.list(paramCtx);
	}

	/**
	 * ?????? - 1. ???????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void reg01(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		String pageQueryString = pageQuery.getPageQueryString(paramCtx.getParam());

		param.put("userSn", user.getUserIdx());

		if (sqlDao.selectCount("progrmApplcntDAO.appRsct", param) > 0) {
			StringBuilder url = new StringBuilder("/"+param.getString("siteName")+"/progrm/master/view.do");
			url.append("?"+StrUtils.replace(pageQueryString, "&amp;", "&"));
//			url.append("?prgSn=").append(param.getString("prgSn")).append("&").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
			MVUtils.goUrl(url.toString(), "?????? ?????????????????????.\\n??????????????? ???????????? ??????\\n[???????????????] - [???????????? ??????/??????] ?????? ???????????????.", model);
			return;
		}

		ZValue masterResult = sqlDao.selectDAO("progrmMasterDAO.view", param);
		ZValue result = sqlDao.selectDAO("progrmMasterDAO.tmplat", param);

		if (result == null) {
			StringBuilder url = new StringBuilder("/"+param.getString("siteName")+"/progrm/master/view.do");
			url.append("?prgSn=").append(param.getString("prgSn")).append("&").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
			MVUtils.goUrl(url.toString(), "????????? ???????????? ????????????.", model);
			return;
		}

		List<ZValue> essntlAtYList = new ArrayList<ZValue>();
		List<ZValue> essntlAtNList = new ArrayList<ZValue>();
		for (ZValue zvl : listTmplatInfo(result)) {
			if ("Y".equals(zvl.getString("essntlAt"))) {
				essntlAtYList.add(zvl);
			}
			else {
				essntlAtNList.add(zvl);
			}
		}
		model.addAttribute("masterResult", masterResult);
		model.addAttribute("result", result);
		model.addAttribute("essntlAtYList", essntlAtYList);
		model.addAttribute("essntlAtNList", essntlAtNList);
		model.addAttribute(PAGE_QUERY_STRING, pageQueryString);
	}

	/**
	 * ?????? - 2. ??????/?????? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void reg02(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		/*
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		if (session.getAttribute("infoList") != null && session.getAttribute("addinfoList") != null) {
			List<ZValue> infoList = (List<ZValue>) session.getAttribute("infoList");
			List<ZValue> addinfoList = (List<ZValue>) session.getAttribute("addinfoList");

			model.addAttribute("infoList", infoList);
			model.addAttribute("listTmplatAddInfo", addinfoList);
		}
		*/

		progrmMasterService.regTmplat(paramCtx);
		ZValue result = (ZValue)model.get("result");

		model.addAttribute("listTmplatInfo", listTmplatInfo(result)); // ???????????? ????????? ??????
		model.addAttribute("user", user);
	}

	/**
	 * ?????? - 3. ???????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void reg03(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		String pageQueryString = pageQuery.getPageQueryString(paramCtx.getParam());

		boolean flag = true;
		Map<String, MultipartFile> files = paramCtx.getFiles();
		if( files != null ){
			String fileFlag = fileUtil.checkFileInfo(files, 50000000, null);
			if (!ModelAndViewResolver.SUCCESS.equals(fileFlag)) {
				String msg = "";
				if (FileMngUtil.RESULT_CD_OVERSIZE.equals(fileFlag)) msg = "??????????????? 50MB????????? ????????? ?????? ??? ????????????.";
				if (FileMngUtil.RESULT_CD_EXTDENIED.equals(fileFlag)) msg = "??????????????? ?????????(JPG, BMP, GIF, PNG), ????????????(DOC, DOCX, HWP, PDF, XLS, XLSX, PPT, PPTX), ??????(TXT, ZIP) ??? ????????? ?????? ??? ????????????.";
				model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
				model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
				flag = false;
			}
		}
		if (!flag) return;

		List<ZValue> infoList = new ArrayList<ZValue>();
		Map<String, String> key = getStartWithParam(param, "key");
		if (MapUtils.isNotEmpty(key)) {
			Iterator<String> it = key.keySet().iterator();
			while (it.hasNext()) {
				String fn = it.next();

				int idx = StrUtils.parseInt(StringUtils.replace(fn, "key", ""));
				String keyType = param.getString("key"+idx);
				String infoData = param.getString("infoData"+idx);

				if ("email".equals(keyType) || "addEmail".equals(keyType)) {
					if (StringUtils.hasText(param.getString("infoData"+idx+"_1"))) {
						infoData = param.getString("infoData"+idx+"_1")+"@"+param.getString("infoData"+idx+"_2");
						param.put("infoData"+idx, infoData);
					}
				}
				else if ("resdnc".equals(keyType)) {
					if (StringUtils.hasText(param.getString("infoData"+idx+"_1"))) {
						infoData = param.getString("infoData"+idx+"_1")+"|"+param.getString("infoData"+idx+"_2");
						param.put("infoData"+idx, infoData);
					}
				}
				else if ("ownhomTelno".equals(keyType) || "mbtlnum".equals(keyType) || "cmpnyTelno".equals(keyType) || "telno".equals(keyType)) {
					if (StringUtils.hasText(param.getString("infoData"+idx+"_1"))) {
						infoData = param.getString("infoData"+idx+"_1")+"-"+param.getString("infoData"+idx+"_2")+"-"+param.getString("infoData"+idx+"_3");
						param.put("infoData"+idx, infoData);
					}
				}

				ZValue info = new ZValue();
				info.put("userSn", param.getString("userSn"));
				info.put("prgSn", param.getString("prgSn"));
				info.put("key", keyType);
				info.put("title", param.getString("title"+idx));
				info.put("infoData", infoData);
				info.put("sortOrdr", param.getString("sortOrdr"+idx));
				info.put("essntlAt", param.getString("essntlAt"+idx));
				infoList.add(info);

				Collections.sort(infoList, new SortAscCompare());

				session.setAttribute("infoList", infoList);
			}
		}
		model.addAttribute("infoList", infoList);

		List<ZValue> addinfoList = new ArrayList<ZValue>();
		Map<String, String> aattrb = getStartWithParam(param, "aattrb");
		if (MapUtils.isNotEmpty(aattrb)) {
			Iterator<String> it = aattrb.keySet().iterator();
			while (it.hasNext()) {
				String fn = it.next();

				int idx = StrUtils.parseInt(StringUtils.replace(fn, "aattrb", ""));
				String attrb = param.getString("aattrb"+idx);
				String attrbDataCn = param.getString("attrbDataCn"+idx);
				String fileNm = "";

				if ("07".equals(attrb)) {
					String attrbDataCnData = StrUtils.getMFormatStr(param.getList("attrbDataCn"+idx), "|");
					attrbDataCn = attrbDataCnData;
				}
				else if ("05".equals(attrb) || "11".equals(attrb) || "14".equals(attrb)) {
					if (StringUtils.hasText(param.getString("attrbDataCn"+idx+"_1"))) {
						String bu = "@";
						if ("05".equals(attrb)) bu = "~";
						if ("14".equals(attrb)) bu = "|";
						attrbDataCn = param.getString("attrbDataCn"+idx+"_1")+bu+param.getString("attrbDataCn"+idx+"_2");
					}
					param.put("attrbDataCn"+idx, attrbDataCn);
				}
				else if ("12".equals(attrb) || "13".equals(attrb)) {
					if (StringUtils.hasText(param.getString("attrbDataCn"+idx+"_1"))) {
						attrbDataCn = param.getString("attrbDataCn"+idx+"_1")+"-"+param.getString("attrbDataCn"+idx+"_2")+"-"+param.getString("attrbDataCn"+idx+"_3");
						param.put("attrbDataCn"+idx, attrbDataCn);
					}
				}
				else if ("15".equals(attrb)) {

					Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
					MultipartFile file;
					FileVO fvo;

					while (itr.hasNext()) {
					    Entry<String, MultipartFile> entry = itr.next();
					    file = entry.getValue();
					    String filename = file.getName();
					    if (("attrbDataCn"+idx).equals(filename) ) {
					    	String filePath = getFilePath(param);
					    	fvo = fileUtil.parseFileInf2(file, "FILE_", 0, null, filePath, param);
					    	fnwFileMngService.insertFileInf(fvo);
					    	param.put("attrbDataCn"+idx, fvo.getAtchFileId());
					    	attrbDataCn = fvo.getAtchFileId();
					    	fileNm = fvo.getOrignlFileNm();
					    	break;
					    }
					}

				}

				ZValue addinfo = new ZValue();
				addinfo.put("userSn", param.getString("userSn"));
				addinfo.put("prgSn", param.getString("prgSn"));
				addinfo.put("addinfoSn", param.getString("addinfoSn"+idx));
				addinfo.put("attrb", attrb);
				addinfo.put("iemNm", param.getString("iemNm"+idx));
				addinfo.put("attrbDataCn", attrbDataCn);
				
				if("RE".equals(attrbDataCn)){
					addinfo.put("attrbDataEtc", param.getString("attrbRetc"+idx).trim());
				}else if(attrbDataCn.indexOf("CE") > -1){
					addinfo.put("attrbDataEtc", param.getString("attrbCetc"+idx));
				}else{
					addinfo.put("attrbDataEtc", "");
				}
				
				addinfo.put("sortOrdr", param.getString("sortOrdr"+idx));
				addinfo.put("addEssntlAt", param.getString("addEssntlAt"+idx));
				addinfo.put("iemCodeId", param.getString("iemCodeId"+idx));
				addinfo.put("atchFileId", param.getString("atchFileId"));
				addinfo.put("fileNm", fileNm);
				addinfoList.add(addinfo);

			}
			Collections.sort(addinfoList, new SortAscCompare());
			session.setAttribute("addinfoList", addinfoList);
			model.addAttribute("addinfoList", addinfoList);
		}

		model.addAttribute(PAGE_QUERY_STRING, pageQueryString);

	}

	/**
	 * ?????? - ??????
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		String siteName = param.getString("siteName");
		String msg = "????????? ?????????????????????.";
		String goUrl = "/"+siteName+"/progrm/applcnt/regCompt.do";
		String deleteAt = "0";
		String rceptSttus = Status.COMPT.value;
		param.put("prgSn", param.getString("prgSn"));

		progrmMasterService.progrsSttusChk(paramCtx);
		String progrsSttus = param.getString("progrsSttus");
		
		if("sjsjgg".equals(user.getUserId())){
			//progrsSttus = "A";
		}

		if (progrsSttus.equals("F")) {
			msg = "????????? ???????????? ?????????????????????.";
			goUrl = "/"+param.getString("siteName")+"/progrm/master/view.do";
			deleteAt = "1";
		}
		else if (progrsSttus.equals("FP")) { //????????? ????????????(????????????)
			if ("02".equals(param.getString("sttus"))) { //????????? ????????? ????????? ??????, ????????????
				msg = "????????? ???????????? ???????????????????????????.";
			}
			else {
				msg = "??????????????? ?????????????????????.";
			}
			rceptSttus = Status.WAITING.value;
		}

		//???????????? ?????????
		if ("Y".equals(param.getString("confmStepAt"))) param.put("confmSttus", "01");

		param.put("deleteAt", deleteAt);
		param.put("rceptSttus", rceptSttus);

		@SuppressWarnings("unchecked")
		List<ZValue> infoList = (List<ZValue>) session.getAttribute("infoList");
		if (infoList != null && infoList.size() > 0) {
			for (ZValue zvl : infoList) {
				String key = zvl.getString("key");
				param.put("prgSn", zvl.getString("prgSn"));
				param.put("userSn", user.getUserIdx());

				if ("nm".equals(key)) param.put("nm", zvl.getString("infoData"));
				if ("brthdy".equals(key)) param.put("brthdy", zvl.getString("infoData"));
				if ("sex".equals(key)) param.put("sex", zvl.getString("infoData"));
				if ("email".equals(key)) param.put("email", zvl.getString("infoData"));
				if ("addEmail".equals(key)) param.put("addEmail", zvl.getString("infoData"));
				if ("ownhomTelno".equals(key)) param.put("ownhomTelno", zvl.getString("infoData"));
				if ("mbtlnum".equals(key)) param.put("mbtlnum", zvl.getString("infoData"));
				if ("cmpnyTelno".equals(key)) param.put("cmpnyTelno", zvl.getString("infoData"));
				if ("telno".equals(key)) param.put("telno", zvl.getString("infoData"));
				if ("adres".equals(key)) param.put("adres", zvl.getString("infoData"));
				if ("resdnc".equals(key)) param.put("resdnc", zvl.getString("infoData"));
				if ("job".equals(key)) param.put("job", zvl.getString("infoData"));
				if ("psitn".equals(key)) param.put("psitn", zvl.getString("infoData"));
			}
		}

		//param.put("resveNo", sqlDao.selectCount("progrmApplcntDAO.resveNo", param));

		super.setInsertQueryId("progrmApplcntDAO.insertInfo");
		super.insert(paramCtx);

		@SuppressWarnings("unchecked")
		List<ZValue> addinfoList = (List<ZValue>) session.getAttribute("addinfoList");
		if (CollectionUtils.isNotEmpty(addinfoList)) {
			for (ZValue zvl : addinfoList) {
				zvl.put("reqstSn", paramCtx.getPkValue());
				zvl.put("deleteAt", deleteAt);
				super.initCmmnParam(param);
				sqlDao.insertDAO("progrmApplcntDAO.insertAddinfo", zvl);
			}
		}

		if (StringUtils.hasText(param.getString("mbtlnum"))) {
			ZValue val = sqlDao.selectDAO("progrmMasterDAO.view", param);

			String tranMsg = "";
			if ("10".equals(val.getString("prgCl"))) {
				tranMsg = "[" + val.getString("prgClNm")+"]"+" ?????? ????????? ?????? ?????? ??? ??????????????? ???????????????.";
			} 
			else {
				tranMsg = "["+val.getString("prgNm")+"] ??????????????? ?????????????????????.";
			}
			
			param.put("phone", param.getString("mbtlnum"));
			if ("16".equals(val.getString("prgCl"))) {
				param.put("callback", "031-759-9307");
			}
			else {
				param.put("callback", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "02-2161-0000" : "02-6310-0770");
			}
			
			param.put("msg", tranMsg);
			emsService.sndngSms(param);
		}

		StringBuilder url = new StringBuilder(goUrl);
		url.append("?prgSn=").append(param.getString("prgSn")).append("&reqstSn=").append(paramCtx.getPkValue()).append("&").append(StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&"));
		MVUtils.goUrl(url.toString(), msg, model);
	}

	/**
	 * ?????? - 4. ????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void regCompt(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		ZValue masterResult = sqlDao.selectDAO("progrmMasterDAO.view", param);
		ZValue result = sqlDao.selectDAO("progrmApplcntDAO.view", param);

		model.addAttribute("masterResult", masterResult);
		model.addAttribute("result", result);
		model.addAttribute("infoList", session.getAttribute("infoList"));
		model.addAttribute("addinfoList", session.getAttribute("addinfoList"));

		//?????? ??????
		session.removeAttribute("infoList");
		session.removeAttribute("addinfoList");
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());

		if (!accessor.canAccess(paramCtx)) {
			MVUtils.goUrl("javascript:history.back()", "????????? ???????????????.", model);
			return;
		}

		super.setViewQueryId("progrmMasterDAO.view");
		super.forUpdate(paramCtx);
		ZValue info = (ZValue)model.get("result");

		progrmMasterService.regTmplat(paramCtx);
		ZValue result = (ZValue)model.get("result");

		addInfo(paramCtx); //??????????????????

		model.addAttribute("info", info);
		model.addAttribute("listTmplatInfo", listTmplatInfo(result)); // ???????????? ????????? ??????
	}

	/**
	 * ?????? - ??????
	 */
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String pageQueryString = pageQuery.getPageQueryString(paramCtx.getParam());
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());

		if (!accessor.canAccess(paramCtx)) {
			MVUtils.goUrl("javascript:history.back()", "????????? ???????????????.", model);
			return;
		}

		boolean flag = true;
		Map<String, MultipartFile> files = paramCtx.getFiles();
		if( files != null ){
			String fileFlag = fileUtil.checkFileInfo(files, 50000000, null);
			if (!ModelAndViewResolver.SUCCESS.equals(fileFlag)) {
				String msg = "";
				if (FileMngUtil.RESULT_CD_OVERSIZE.equals(fileFlag)) msg = "??????????????? 50MB????????? ????????? ?????? ??? ????????????.";
				if (FileMngUtil.RESULT_CD_EXTDENIED.equals(fileFlag)) msg = "??????????????? ?????????(JPG, BMP, GIF, PNG), ????????????(DOC, DOCX, HWP, PDF, XLS, XLSX, PPT, PPTX), ??????(TXT, ZIP) ??? ????????? ?????? ??? ????????????.";
				model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
				model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
				flag = false;
			}
		}
		if (!flag) return;

		Map<String, String> key = getStartWithParam(param, "key");
		if (MapUtils.isNotEmpty(key)) {
			Iterator<String> it = key.keySet().iterator();
			while (it.hasNext()) {
				String fn = it.next();

				int idx = StrUtils.parseInt(StringUtils.replace(fn, "key", ""));
				String keyType = param.getString("key"+idx);
				String infoData = param.getString("infoData"+idx);

				if ("email".equals(keyType) || "addEmail".equals(keyType)) {
					if (StringUtils.hasText(param.getString("infoData"+idx+"_1"))) {
						infoData = param.getString("infoData"+idx+"_1")+"@"+param.getString("infoData"+idx+"_2");
						param.put("infoData"+idx, infoData);
					}
				}
				else if ("resdnc".equals(keyType)) {
					if (StringUtils.hasText(param.getString("infoData"+idx+"_1"))) {
						infoData = param.getString("infoData"+idx+"_1")+"|"+param.getString("infoData"+idx+"_2");
						param.put("infoData"+idx, infoData);
					}
				}
				else if ("ownhomTelno".equals(keyType) || "mbtlnum".equals(keyType) || "cmpnyTelno".equals(keyType) || "telno".equals(keyType)) {
					if (StringUtils.hasText(param.getString("infoData"+idx+"_1"))) {
						infoData = param.getString("infoData"+idx+"_1")+"-"+param.getString("infoData"+idx+"_2")+"-"+param.getString("infoData"+idx+"_3");
						param.put("infoData"+idx, infoData);
					}
				}

				if ("nm".equals(keyType)) param.put("nm", infoData);
				if ("brthdy".equals(keyType)) param.put("brthdy", infoData);
				if ("sex".equals(keyType)) param.put("sex", infoData);
				if ("email".equals(keyType)) param.put("email", infoData);
				if ("addEmail".equals(keyType)) param.put("addEmail", infoData);
				if ("ownhomTelno".equals(keyType)) param.put("ownhomTelno", infoData);
				if ("mbtlnum".equals(keyType)) param.put("mbtlnum", infoData);
				if ("cmpnyTelno".equals(keyType)) param.put("cmpnyTelno", infoData);
				if ("telno".equals(keyType)) param.put("telno", infoData);
				if ("adres".equals(keyType)) param.put("adres", infoData);
				if ("resdnc".equals(keyType)) param.put("resdnc", infoData);
				if ("job".equals(keyType)) param.put("job", infoData);
				if ("psitn".equals(keyType)) param.put("psitn", infoData);
			}
			sqlDao.updateDAO("progrmApplcntDAO.updateInfo", param);
		}

		Map<String, String> aattrb = getStartWithParam(param, "aattrb");
		if (MapUtils.isNotEmpty(aattrb)) {
			Iterator<String> it = aattrb.keySet().iterator();
			while (it.hasNext()) {
				String fn = it.next();

				int idx = StrUtils.parseInt(StringUtils.replace(fn, "aattrb", ""));
				String attrb = param.getString("aattrb"+idx);
				String attrbDataCn = param.getString("attrbDataCn"+idx);
				String attrbUserSn = param.getString("attrbUserSn"+idx);

				if ("07".equals(attrb)) {
					String attrbDataCnData = StrUtils.getMFormatStr(param.getList("attrbDataCn"+idx), "|");
					attrbDataCn = attrbDataCnData;
				}
				else if ("05".equals(attrb) || "11".equals(attrb) || "14".equals(attrb)) {
					if (StringUtils.hasText(param.getString("attrbDataCn"+idx+"_1"))) {
						String bu = "@";
						if ("05".equals(attrb)) bu = "~";
						if ("14".equals(attrb)) bu = "|";
						attrbDataCn = param.getString("attrbDataCn"+idx+"_1")+bu+param.getString("attrbDataCn"+idx+"_2");
					}
				}
				else if ("12".equals(attrb) || "13".equals(attrb)) {
					if (StringUtils.hasText(param.getString("attrbDataCn"+idx+"_1"))) {
						attrbDataCn = param.getString("attrbDataCn"+idx+"_1")+"-"+param.getString("attrbDataCn"+idx+"_2")+"-"+param.getString("attrbDataCn"+idx+"_3");
					}
				}
				else if ("15".equals(attrb)) {
					Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
					MultipartFile file;
					FileVO fvo;

					while (itr.hasNext()) {
					    Entry<String, MultipartFile> entry = itr.next();
					    file = entry.getValue();
					    String filename = file.getName();
					    if (("attrbDataCn"+idx).equals(filename) ) {
					    	String filePath = getFilePath(param);
					    	fvo = fileUtil.parseFileInf2(file, "FILE_", 0, param.getString("atchFileId"+idx), filePath, param);
					    	String atchFileId = param.getString("atchFileId"+idx);
					    	if (StringUtils.hasText(atchFileId)) {
					    		fnwFileMngService.updateFileInf(fvo);
					    	}
					    	else {
					    		fnwFileMngService.insertFileInf(fvo);
					    	}

					    	param.put("atchFileId", fvo.getAtchFileId());
					    	attrbDataCn = fvo.getAtchFileId();
					    	if (!StringUtils.hasText(param.getString("atchFileId"+idx))) {
					    		attrbDataCn = param.getString("atchFileId");
					    	}
					    	else {
					    		attrbDataCn = param.getString("atchFileId"+idx);
					    	}

					    	break;
					    }
					}

				}
				param.put("attrbDataCn", attrbDataCn);
				param.put("addinfoSn", param.getString("addinfoSn"+idx));

				if (StringUtils.hasText(attrbUserSn)) { // ????????? ????????? update
					if (StringUtils.hasText(attrbDataCn)) sqlDao.updateDAO("progrmApplcntDAO.updateAddinfo", param);
				}
				else {
					super.initCmmnParam(param);
					sqlDao.insertDAO("progrmApplcntDAO.insertAddinfo", param);
				}

			}
		}

		StringBuilder url = new StringBuilder("/"+param.getString("siteName")+"/progrm/applcnt/listMypage.do?");
		url.append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		MVUtils.goUrl(url.toString(), "??????????????? ?????????????????????.", model);
	}

	@SuppressWarnings("unchecked")
	private Map<String, String> getStartWithParam(ZValue param, String s) {
		Map<String, String> result = new HashMap<String, String>();
		Iterator<String> it = param.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			if (key.startsWith(s)) {
				result.put(key, param.getString(key));
			}
		}
		return result;
	}

	/**
	 * ????????? ???????????? ???????????? ?????? ????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public List<ZValue> downloadFileList(ZValue param) throws Exception {

		String[] userSnList = {param.getString("userSnData")};
		if (param.get("userSnData") != null) {
			if (param.get("userSnData") instanceof String[]) {
				userSnList = (String[])param.get("userSnData");
			}
		}
		if (!"ALL".equals(param.getString("atchFileTp"))) param.putObject("userSnList", userSnList);

		List<ZValue> resultList = sqlDao.listDAO("progrmApplcntDAO.listAtchFile", param);
		return resultList;

	}

	/**
	 * ????????? ???????????? ??????????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();

		String[] userSnList = {param.getString("userSnData")};
		if (param.get("userSnData") != null) {
			if (param.get("userSnData") instanceof String[]) {
				userSnList = (String[])param.get("userSnData");
			}
		}
		if (!"ALL".equals(param.getString("excelTp"))) param.putObject("userSnList", userSnList);


		ZValue viewVO = sqlDao.selectDAO("progrmApplcntDAO.viewIndvdlinfoIem", param);

		List<ZValue> headerList = new ArrayList<ZValue>();

		viewVO.put("userIdAt", "Y");
		viewVO.put("rceptSttusAt", "Y");
		headerList = listTmplatInfo(viewVO); // ???????????? ????????? ??????

		List<ZValue> resultList = sqlDao.listDAO("progrmApplcntDAO.listExcel", param);

		List<ZValue> excelList = new ArrayList<ZValue>();


		String userSn = "";
		int listNo = 0;
		int countNo = 0;
		int tmpNum = 1;
		ZValue tempVO = new ZValue();
		for (ZValue itemVO : resultList) {
//			System.out.println("+++++++"+itemVO + " " +itemVO.getString("attrbDataCn")+"++++++++++");

			if (!userSn.equals(itemVO.getString("reqstSn"))) {
				userSn = itemVO.getString("reqstSn");
				if (tempVO.size() > 0) {
					listNo++;
					tmpNum = 1;
					excelList.add(tempVO);
				}
				tempVO = new ZValue();
				tempVO.putAll(itemVO);
				if (!"".equals(itemVO.getString("addinfoSn"))) {
					tempVO.put("attrbDataCn"+tmpNum ,itemVO.getString("attrbDataCn"));
				}
			}
			else {
				tmpNum++;
				tempVO.put("attrbDataCn"+tmpNum ,itemVO.getString("attrbDataCn"));
			}
			if (resultList.size() ==  (countNo+1)) {
				excelList.add(tempVO);
			}

			if (listNo == 1) {
				ZValue addinfoVO = new ZValue();
				addinfoVO.put("key","attrbDataCn"+tmpNum);
				addinfoVO.put("title", itemVO.getString("iemNm"));
				headerList.add(addinfoVO);
			}
			countNo++;
		}

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("????????? ??????_"+day, null, excelList);

		model.addAttribute("customTp", "Y");
		HSSFWorkbook wookBook = this.customTrExcelOutputModel(headerList ,excelList);
		model.addAttribute("workBook", wookBook);
		model.addAttribute("excel", vo);

		paramCtx.setModel(model);
	}




	private HSSFWorkbook customTrExcelOutputModel(List<ZValue> headerList, List<ZValue> excelList) throws Exception {


	    HSSFWorkbook objWorkBook = new HSSFWorkbook();
    	HSSFSheet objSheet = objWorkBook.createSheet();

    	// title ?????????
    	HSSFRow titleRow = objSheet.createRow(0);

    	HSSFCellStyle titleStyle = objWorkBook.createCellStyle();
		titleStyle.setFillForegroundColor(HSSFColor.LIME.index);
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderLeft(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderRight(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderTop(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setBorderBottom(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);


    	HSSFCellStyle cellStyle = objWorkBook.createCellStyle();
    	cellStyle.setBorderLeft(HSSFCellStyle.SOLID_FOREGROUND);
    	cellStyle.setBorderRight(HSSFCellStyle.SOLID_FOREGROUND);
    	cellStyle.setBorderTop(HSSFCellStyle.SOLID_FOREGROUND);
    	cellStyle.setBorderBottom(HSSFCellStyle.SOLID_FOREGROUND);
    	cellStyle.setWrapText(true);  //???????????????


    	// title ??? ??????
    	int titleCnt = 0;
		for(ZValue headerVO : headerList ) {
			HSSFCell objCell = titleRow.createCell(titleCnt);
			HSSFRichTextString richTextString = new HSSFRichTextString(headerVO.getString("title"));
			objCell.setCellValue(richTextString);
			objCell.setCellStyle(titleStyle);
			objSheet.setColumnWidth(titleCnt, 4000);
			titleCnt++;
		}

    	// row & cell ??????
		for ( int listCnt = 0 ; listCnt < excelList.size(); listCnt++  ) {
			Object obj = excelList.get(listCnt);
			Map<Object, Object> map = null;
			if (obj instanceof Map ){
				map = (Map)obj;
			}
			else{
				map = BeanUtils.describe(obj);
			}


			HSSFRow dataRow = objSheet.createRow(listCnt + 1);
			int cellCnt = 0;
			for(ZValue headerVO : headerList ) {

				String cellData = String.valueOf(map.get(headerVO.getString("key")));
				HSSFCell dataCell = dataRow.createCell(cellCnt);
				dataCell.setCellStyle(cellStyle);

				// ????????????
				Iterator<String> mapKeys = ((Set)map.keySet()).iterator();
				while(mapKeys.hasNext()) {
					String mapkey = mapKeys.next();

					if (mapkey.equals(headerVO.getString("key")) ) {

						HSSFRichTextString richTextString = new HSSFRichTextString("null".equals(cellData) ? "" : cellData);
						dataCell.setCellValue(richTextString);
					}
				}
				cellCnt++;
			}
		}

		return objWorkBook;

	}

	/**
	 * ???????????? ????????? ??????
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public static List<ZValue> listTmplatInfo(ZValue param) throws Exception {
		List<ZValue> infoList = new ArrayList<ZValue>();

		ZValue prgrmVO = new ZValue();

		if ("Y".equals(param.getString("userIdAt"))) {
			prgrmVO.put("key","userId");
			prgrmVO.put("title","???????????????");
			prgrmVO.put("sortOrdr",-1);
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("nmUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","nm");
			prgrmVO.put("title","??????");
			prgrmVO.put("essntlAt",param.getString("nmEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("nmSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("brthdyUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","brthdy");
			prgrmVO.put("title","????????????");
			prgrmVO.put("essntlAt",param.getString("brthdyEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("brthdySortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("sexUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","sex");
			prgrmVO.put("title","??????");
			prgrmVO.put("essntlAt",param.getString("sexEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("sexSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("emailUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","email");
			prgrmVO.put("title","?????????");
			prgrmVO.put("essntlAt",param.getString("emailEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("emailSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("addEmailUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","addEmail");
			prgrmVO.put("title","???????????????");
			prgrmVO.put("essntlAt",param.getString("addEmailEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("addEmailSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("ownhomTelnoUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","ownhomTelno");
			prgrmVO.put("title","??????????????????");
			prgrmVO.put("essntlAt",param.getString("ownhomTelnoEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("ownhomTelnoSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("mbtlnumUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","mbtlnum");
			prgrmVO.put("title","???????????????");
			prgrmVO.put("essntlAt",param.getString("mbtlnumEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("mbtlnumSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("cmpnyTelnoUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","cmpnyTelno");
			prgrmVO.put("title","??????????????????");
			prgrmVO.put("essntlAt",param.getString("cmpnyTelnoEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("cmpnyTelnoSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("telnoUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","telno");
			prgrmVO.put("title","????????????");
			prgrmVO.put("essntlAt",param.getString("telnoEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("telnoSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("adresUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","adres");
			prgrmVO.put("title","??????");
			prgrmVO.put("essntlAt",param.getString("adresEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("adresSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("resdncUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","resdnc");
			prgrmVO.put("title","????????????");
			prgrmVO.put("essntlAt",param.getString("resdncEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("resdncSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("jobUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","job");
			prgrmVO.put("title","??????");
			prgrmVO.put("essntlAt",param.getString("jobEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("jobSortOrdr"));
			infoList.add(prgrmVO);
		}

		if ("Y".equals(param.getString("psitnUseAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","psitn");
			prgrmVO.put("title","??????");
			prgrmVO.put("essntlAt",param.getString("psitnEssntlAt"));
			prgrmVO.put("sortOrdr",param.getInt("psitnSortOrdr"));
			infoList.add(prgrmVO);
		}
		if ("Y".equals(param.getString("rceptSttusAt"))) {
			prgrmVO = new ZValue();
			prgrmVO.put("key","rceptSttus");
			prgrmVO.put("title","??????");
			prgrmVO.put("rceptSttusAt",param.getString("rceptSttusAt"));
			prgrmVO.put("sortOrdr",100);
			infoList.add(prgrmVO);
		}

		Collections.sort(infoList, new SortAscCompare()); // ??????

		return infoList;
	}


	/**
	 * ?????? ?????? ?????????
	 * @author jks
	 *
	 */
	static class SortAscCompare implements Comparator<ZValue> {

		/**
		 * ????????????(ASC)
		 */
		@Override
		public int compare(ZValue arg0, ZValue arg1) {
			return arg0.getInt("sortOrdr",0) < arg1.getInt("sortOrdr",0) ? -1 : arg0.getInt("sortOrdr",0) > arg1.getInt("sortOrdr",0) ? 1:0;
		}

	}
	
	/**
	 * ???????????? ????????? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsUser(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();

		// ???????????????
		ZValue result = sqlDao.selectDAO("progrmMasterDAO.view", param);
		
		String[] titles = {"??????", "?????????", "??????", "??????", "????????????", "??????/????????????", "??????", "????????????", "????????????"};
		model.addAttribute("titles", titles);
		
		super.setListQueryId("progrmApplcntDAO.excelUserList");
		super.list(paramCtx);
		
    	@SuppressWarnings("unchecked")
		List<ZValue> excelList = (List<ZValue>) model.get("resultList");

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("???????????? ?????? ?????? ????????? ??????(" + result.getString("prgNm") + ")_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}
	
	/**
	 * ????????? ????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void applcntBatchExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> excelList = new ArrayList<ZValue>();
		
		excelList = excelChkeckList(paramCtx);	
		
		if(!param.getString("prgCl").isEmpty()){
			List<ZValue> prgNmList = sqlDao.listDAO("progrmMasterDAO.applcntPgNmList", param);
			model.addAttribute("prgNmList", prgNmList);
		}
		
		param.put("codeId", "COM050");
		param.put("upperCode", param.getString("prgSe"));
		
		model.addAttribute("excelList", excelList);
		model.addAttribute("prgSeOpenCodeList", sqlDao.listDAO("progrmMasterDAO.prgSeOpenCodeList", param));
	}	
	
	/**
	 * ??????????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void applcntPgNmList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> prgNmList = sqlDao.listDAO("progrmMasterDAO.applcntPgNmList", param);
		model.addAttribute("prgNmList", prgNmList);
	}	
	
	/**
	 * ???????????? ??????
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> excelChkeckList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		Map<String, MultipartFile> files = paramCtx.getFiles();
		String fileExt = "";
		List<ZValue> excelList = new ArrayList<ZValue>();
		
		if( files != null ){
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			
	    	while (itr.hasNext()) {
	    	    Entry<String, MultipartFile> entry = itr.next();
	    	    file = entry.getValue();
	
	    	    String orginFileName = file.getOriginalFilename();
	
	    	    if ("".equals(orginFileName)) {
	    	    	continue;
	    	    }
	
	    	    int index = orginFileName.lastIndexOf(".");
	    	    fileExt = orginFileName.substring(index + 1).toLowerCase();
	    	}		
	    	
	    	boolean flag = false;
	    	if(fileExt.equals("xls") || fileExt.equals("xlsx")){
	    		flag = uploadFile(paramCtx);
	    		
		    	if(flag){
					FileVO vo = new FileVO();
					vo.setAtchFileId(param.getString("atchFileId"));
					
					List<FileVO> fileList = fnwFileMngService.selectFileInfs(vo);
					
					if(fileList != null){
						try {
							String xFilePath = fileList.get(0).getFileStreCours().replace("\\",  "/") + "/" + fileList.get(0).getStreFileNm();
							
				            FileInputStream xFile = new FileInputStream(xFilePath);
				            XSSFWorkbook workbook = new XSSFWorkbook(xFile);
				 
				            int rowindex = 0;
				            int columnindex = 0;
				            
				            //?????? ??? (??????????????? ??????????????? 0??? ??????)
				            //?????? ??? ????????? ?????????????????? FOR?????? ????????? ????????????
				            XSSFSheet sheet = workbook.getSheetAt(0);
				            
				            int rows = sheet.getPhysicalNumberOfRows(); //?????? ???
				            String xTitle = "?????????(T/P)|??????|???????????????|?????????|??????"; //sample ??????
				            boolean isErrSample = false; //sample ?????? ?????? ?????? ??????
				            String chkT = ""; //????????? ??????
				            String rMsg = ""; //?????? ?????????
				            String preChkT = ""; //?????? row ????????????
				            String preTnm = ""; //?????? row ??????
				            String prePj = ""; //?????? row ???????????????
				            String userNm = ""; //????????? ??????
				            int userSn = 0; //????????? ????????????
				            boolean isChkErr = false; //????????? ?????? ?????? ??????
				            String dupID = ""; //????????? ?????? ?????? ??????
				            String dupTN = ""; //?????? ?????? ?????? ??????
				            boolean isTL = false; //????????? ??????
				            String preTnErr = ""; //?????? row ?????? ??????
				            
				            model.addAttribute("isCheck", "Y");
				            
				            for(rowindex=0;rowindex<rows;rowindex++){
				                //???????????????
				            	XSSFRow row = sheet.getRow(rowindex);
				            	ZValue xVO = new ZValue();
				            	ZValue uVO = new ZValue();
				            	ZValue tVO = new ZValue();
				            	
				                if(row != null){	
				                	rMsg = "";
				                	chkT = "";
				                	userNm = "";
				                	
				                    for(columnindex=0; columnindex<=4; columnindex++){
				                        //????????? ?????????
				                    	XSSFCell cell = row.getCell(columnindex);
				                        String value = "";
				                        //?????? ?????????????????? ?????? ?????????
				                        if(cell == null){
				                            continue;
				                        }else{
				                        	value = cell.getStringCellValue()+"";
				                        }
				                        
				                        if(rowindex == 0) {
				                        	// ?????? ?????? ??????
				                        	if(xTitle.indexOf(value) == -1){
				                        		isErrSample = true;
				                        		model.addAttribute("isErrSample", isErrSample);
				                        		break;
				                        	}
				                        } else {
				                        	// ????????? ??????
				                            switch (columnindex){
				                            	case 0:
				                            		if("T".equals(value) || "P".equals(value)){
				                            			chkT = value;
				                            			preChkT = "";
				                            			rMsg = "OK";
				                            			preTnErr = "";
				                            			
				                            			if("T".equals(value)){
				                            				isTL = true;
				                            			}
				                            		} else {
				                            			isTL = false;
				                            			if(!"".equals(value)){
				                            				isChkErr = true;
				                            				preChkT = "";
				                            				rMsg = "????????? ??????";
				                            			} else {
					                            			if("".equals(chkT)){
					                            				if("T".equals(preChkT)){
					                            					chkT = preChkT;
							                            			rMsg = "OK";
					                            				}else{
						                            				isChkErr = true;
						                            				preChkT = "";
						                            				rMsg = "????????? ??????";				                            					
					                            				}
					                            			} else {
					                            				isChkErr = true;
					                            				preChkT = "";
					                            				rMsg = "????????? ??????";
					                            			}	
				                            			}
				                            		}
				                            		
				                            		xVO.put("tt", value);
				                            		break;
				                            		
					                            case 1:
					                            	if("T".equals(chkT)){
					                            		if("T".equals(preChkT)){
					                            			value = preTnm;
					                            		}
					                            		
					                            		if("".equals(value)){
					                            			if("OK".equals(rMsg)){
						                            			isChkErr = true;
						                            			rMsg = "?????? ?????????";
					                            			}
					                            		} else {
					                            			if(dupTN.indexOf(value) != -1){
					                            				if(isTL){
							                            			if("OK".equals(rMsg)){
							                            				isChkErr = true;
							                            				rMsg = "?????? ??????";
							                            				preTnErr = "?????? ??????";
							                            			}
						                            			}
					                            			}else{
					                            				preTnm = value;
					                            				rMsg = "OK";
					                            			}
					                            			
					                            			if(isTL){
					                            				tVO.put("prgSn", param.getString("prgSn"));
					                            				tVO.put("teamNm", value);
					                            				int tnCnt = sqlDao.selectCount("progrmApplcntDAO.checkDupTeamNm", tVO);
					                            				
					                            				if(tnCnt > 0){
							                            			if("OK".equals(rMsg)){
							                            				isChkErr = true;
							                            				rMsg = "?????? ????????? ??????";
							                            				
							                            				if("".equals(preTnErr)){
							                            					preTnErr = "?????? ????????? ??????";	
							                            				}
							                            			}
					                            				}
					                            				
						                            			if("".equals(dupTN)) {
						                            				dupTN = value;
						                            			} else {
						                            				dupTN += "|" + value;
						                            			}
					                            			}
					                            		}
					                            		
			                            				if(!"".equals(preTnErr)){
			                            					isChkErr = true;
					                            			rMsg = preTnErr;	
			                            				}
					                            		
					                            		xVO.put("tn", value);
				                            		} else {
				                            			xVO.put("tn", "");
				                            		}

					                                break;
					                                
				                                case 2:
					                            	if("T".equals(chkT)){
					                            		if("T".equals(preChkT)){
					                            			value = prePj;
					                            		}else{
					                            			prePj = value;
					                            		}
				                            			xVO.put("pj", value);
				                            		} else {
				                            			xVO.put("pj", "");
				                            		}					                            	
					                            	
					                                break;
					                                
				                                case 3:
					                            	if("".equals(value)){
				                            			isChkErr = true;
				                            			
				                            			if("OK".equals(rMsg)){
				                            				isChkErr = true;
				                            				rMsg = "ID ?????????";
				                            			}
				                            		} else {
				                            			if(dupID.indexOf(value) != -1){
					                            			if("OK".equals(rMsg)){
					                            				isChkErr = true;
					                            				rMsg = "ID ??????";
					                            			}
				                            			}else{
				                            				uVO.put("userId", value);
				                            				int userCnt = sqlDao.selectCount("memberDAO.checkDupID", uVO);
				                         
				                            				if(userCnt <= 0){
						                            			if("OK".equals(rMsg)){
						                            				isChkErr = true;
						                            				rMsg = "????????? ??????";
						                            			}
				                            				}else{
				                            					ZValue memList = sqlDao.selectDAO("memberDAO.selectUserMembers", uVO);
				                            					
				                            					if(memList != null){
				                            						userNm = memList.getString("userNm");
				                            						userSn = memList.getInt("userSn");
				                            						uVO.put("prgSn", param.getString("prgSn"));
				                            						uVO.put("userSn", userSn);
				                            					}
				                            					
					                            				if (sqlDao.selectCount("progrmApplcntDAO.appRsct", uVO) > 0) {
						                            				isChkErr = true;
						                            				rMsg = "?????? ????????? ??????";
					                            				}				                            					
				                            				}
				                            			}
				                            			
				                            			if("".equals(dupID)) {
				                            				dupID = value;
				                            			} else {
				                            				dupID += "|" + value;
				                            			}
				                            		}
					                            	
					                            	xVO.put("id", value);
					                                break;
					                                
					                            case 4:
					                            	if("".equals(value)){
					                            		if("OK".equals(rMsg)){
					                            			isChkErr = true;
					                            			rMsg = "?????? ?????????";
					                            		}
				                            		}else{
				                            			if(!userNm.equals(value)){
				                            				if("OK".equals(rMsg)){
						                            			isChkErr = true;
						                            			rMsg = "????????? ?????? ?????? ?????????";
				                            				}
				                            			}
				                            		}
					                            	
					                            	xVO.put("nm", value);
					                                break;
				                            }	
				                            
				                            xVO.put("msg", rMsg);
				                        }
				                    }
				                    
				                    if(rowindex > 0){
				                    	preChkT = chkT;
				                    	excelList.add(xVO);
				                    }
				 
				                }
				                
				                if(isErrSample) break;
				            }		
				        }catch(Exception e) {
				            e.printStackTrace();
				        }
					}
		    	}	    		
	    	}
		}
		
		return excelList;
	}
	
	/**
	 * ???????????? ????????? ??????
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void excelInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		FileVO vo = new FileVO();
		vo.setAtchFileId(param.getString("aId"));
					
		List<FileVO> fileList = fnwFileMngService.selectFileInfs(vo);
					
		if(fileList != null){
			try {
				String xFilePath = fileList.get(0).getFileStreCours().replace("\\",  "/") + "/" + fileList.get(0).getStreFileNm();
				
	            FileInputStream xFile = new FileInputStream(xFilePath);
	            XSSFWorkbook workbook = new XSSFWorkbook(xFile);
	 
	            int rowindex = 0;
	            int columnindex = 0;
	            
	            //?????? ??? (??????????????? ??????????????? 0??? ??????)
	            //?????? ??? ????????? ?????????????????? FOR?????? ????????? ????????????
	            XSSFSheet sheet = workbook.getSheetAt(0);
	            
	            int rows = sheet.getPhysicalNumberOfRows(); //?????? ???
	            String chkT = ""; //????????? ??????
	            String preChkT = ""; //?????? row ????????????
	            String preTnm = ""; //?????? row ??????
	            String prePj = ""; //?????? row ???????????????
	            int userSn = 0; //????????? ????????????
	            
	            model.addAttribute("isCheck", "Y");
	            
	            for(rowindex=1;rowindex<rows;rowindex++){
	                //???????????????
	            	XSSFRow row = sheet.getRow(rowindex);
	            	ZValue xVO = new ZValue();
	            	ZValue uVO = new ZValue();
	            	
	                if(row != null){	
	                	chkT = "";
	                	
	                    for(columnindex=0; columnindex<=4; columnindex++){
	                        //????????? ?????????
	                    	XSSFCell cell = row.getCell(columnindex);
	                        String value = "";
	                        //?????? ?????????????????? ?????? ?????????
	                        if(cell == null){
	                            continue;
	                        }else{
	                        	value = cell.getStringCellValue()+"";
	                        }
	                        
                        	// ????????? ??????
                            switch (columnindex){
                            	case 0:
                            		xVO.put("teamLeader", "N");
                            		
                            		if("T".equals(value) || "P".equals(value)){
                            			chkT = value;
                            			preChkT = "";
                            			
                            			if("T".equals(value)){
                            				xVO.put("teamLeader", "Y");
                            			}
                            		}else{
                            			if(!"".equals(value)){
                            				preChkT = "";
                            			}else{
	                            			if("".equals(chkT)){
	                            				if("T".equals(preChkT)){
	                            					chkT = preChkT;
	                            				}else{
		                            				preChkT = "";
	                            				}
	                            			}else{
	                            				preChkT = "";
	                            			}	
                            			}
                            		}
                            		
                            		break;
                            		
	                            case 1:
	                            	xVO.put("teamNm", "");
	                            	
	                            	if("T".equals(chkT)){
	                            		if("T".equals(preChkT)){
	                            			value = preTnm;
	                            		}
	                            		
	                            		if(!"".equals(value)){
	                            			preTnm = value;
	                            			xVO.put("teamNm", value);
	                            		}
                            		}

	                                break;
	                                
                                case 2:
                                	xVO.put("projectNm", "");
                                	
	                            	if("T".equals(chkT)){
	                            		if("T".equals(preChkT)){
	                            			value = prePj;
	                            		}else{
	                            			prePj = value;
	                            		}
                            			xVO.put("projectNm", value);
                            		}					                            	
	                            	
	                            	break;
	                                
                                case 3:
            						xVO.put("userSn", "");
            						xVO.put("prgSn", "");
            						xVO.put("userId", "");
                                	
	                            	if(!"".equals(value)){
                        				uVO.put("userId", value);
                        				int userCnt = sqlDao.selectCount("memberDAO.checkDupID", uVO);
                         
                        				if(userCnt > 0){
                        					ZValue memList = sqlDao.selectDAO("memberDAO.selectUserMembers", uVO);
                        					
                        					if(memList != null){
                        						userSn = memList.getInt("userSn");
                        						
                        						xVO.put("userSn", userSn);
                        						xVO.put("prgSn", param.getInt("prgSn"));
                        						xVO.put("userId", value);
                        					}
                        				}
                        			}
	                            	
	                            	break;
                            	
                            }	
	                    }
	                    
	                    if(rowindex > 0){
	                    	preChkT = chkT;
	                    	
	                    	sqlDao.insertDAO("progrmApplcntDAO.excelInsert", xVO);
	                    }
	                }
	            }		
	        }catch(Exception e) {
	            e.printStackTrace();
	        }
		}
		StringBuilder url = new StringBuilder("/"+param.getString("siteName")+"/progrm/master/list.do");
		url.append("?prgSe=").append(param.getString("prgSe")).append("&siteSe=").append(param.getString("siteSe")).append("&menuNo=").append(param.getString("menuNo"));
		MVUtils.goUrl(url.toString(), "??????????????? ?????? ???????????????.", model);
	}	    		

}
