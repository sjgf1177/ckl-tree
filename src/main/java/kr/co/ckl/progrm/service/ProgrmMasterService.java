package kr.co.ckl.progrm.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;
import kr.co.unp.cmmncode.service.CmmnCodeCtgryService;
import kr.co.unp.cmmncode.vo.CmmnCodeDetail;

import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class ProgrmMasterService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;

	public static enum Status {
		WAITING("W"), //대기
		PROGRESS("P"), //진행중
		FINISH_PSNCPA("FP"), //선착순 신청마감(대기진행)
		FINISH("F"); //마감
		private String value;

		private Status(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	public ProgrmMasterService() {
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		if (SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName")) || SiteMngService.EDUMOBILE_SITE_NAME.equals(param.getString("siteName"))) {
			param.put("siteSe", SiteMngService.EDU_SITE_NAME);
		}
		else if (SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) || SiteMngService.CKLENG_SITE_NAME.equals(param.getString("siteName")) || SiteMngService.CKLMOBILE_SITE_NAME.equals(param.getString("siteName"))) {
			param.put("siteSe", SiteMngService.CKL_SITE_NAME);
		}
		if(param.getString("siteName").equals("bos")){
			if ( UnpUserDetailsHelper.isAuthenticated("ROLE_TASK_STEPUP_INSITE") ) {
				if(user.getUserId().equals("gameliteracy")){
					param.put("prgClRole", "gameliteracy");
				} else if(user.getUserId().equals("contentv")){ 
					param.put("prgClRole", "valueup");
				}else {
					param.put("prgClRole", "stepup_insite");
				}
			}
		}
		/*paramCtx = new ParameterContext<ZValue>();
		paramCtx.setParam(param);*/
		super.setCountQueryId("progrmMasterDAO.listCnt");
		super.setListQueryId("progrmMasterDAO.list");
		super.list(paramCtx);
		
		/*
    	@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");

		for (ZValue zvl : resultList) {
			param.put("prgSn", zvl.getString("prgSn"));
			progrsSttusChk(paramCtx);
			zvl.put("progrsSttus", param.getString("progrsSttus"));
		}*/
		model.addAttribute("user", user);
		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
		model.addAttribute("prgSeCodeList", codeList("COM050"));
		
		System.out.println(param.getString("siteName"));
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		super.setViewQueryId("progrmMasterDAO.view");
		super.view(paramCtx);

		ZValue result = (ZValue) model.get("result");
		
		if (!SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			if ("N".equals(result.getString("useAt"))) {
				MVUtils.goUrl("javascript:history.back()", "잘못된 접근입니다.", model);
				return;
			}
		}

		progrsSttusChk(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		System.out.println(user);
		if (SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName")) || SiteMngService.EDUMOBILE_SITE_NAME.equals(param.getString("siteName"))) {
			param.put("siteSe", SiteMngService.EDU_SITE_NAME);
		}
		else if (SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) || SiteMngService.CKLENG_SITE_NAME.equals(param.getString("siteName")) || SiteMngService.CKLMOBILE_SITE_NAME.equals(param.getString("siteName"))) {
			param.put("siteSe", SiteMngService.CKL_SITE_NAME);
		}
				
		super.forInsert(paramCtx);
		model.addAttribute("user", user);
		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
		model.addAttribute("prgSeCodeList", codeList("COM050"));
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initParam(param);

		super.setInsertQueryId("progrmMasterDAO.insert");
		super.insert(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forUpdate(paramCtx);

		ModelMap model = paramCtx.getModel();
		System.out.println(model);
		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
		model.addAttribute("prgSeCodeList", codeList("COM050"));
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initParam(param);

		super.setUpdateQueryId("progrmMasterDAO.update");
		super.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.setDeleteQueryId("progrmMasterDAO.delete");
		super.delete(paramCtx);

		sqlDao.updateDAO("progrmApplcntDAO.deleteInfo", param);
		sqlDao.updateDAO("progrmApplcntDAO.deleteAddinfo", param);
	}

	private void initParam(ZValue param) throws Exception {

		super.initCmmnParam(param);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());

		String telNo = param.getString("telNo1") + "-" + param.getString("telNo2") + "-" + param.getString("telNo3");
		param.put("telNo", telNo);

		String reqstBeginDt = param.getString("beginDate") + " " + param.getString("beginHour") + ":" + param.getString("beginMin");
		//Date reqstBeginDt = DateUtils.parseDate(beginDt, DATE_FORMAT);
		param.put("reqstBeginDt", reqstBeginDt);

		String reqstEndDt = param.getString("endDate") + " " + param.getString("endHour") + ":" + param.getString("endMin");
		//Date reqstEndDt = DateUtils.parseDate(endDt, DATE_FORMAT);
		param.put("reqstEndDt", reqstEndDt);

	}

	/**
	 * 프로그램 상태 체크
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public void progrsSttusChk(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String progrsSttus = "";

		ZValue zvl = sqlDao.selectDAO("progrmMasterDAO.progrsSttusChk", param);

		if (Status.WAITING.value.equals(zvl.getString("progrsSttus"))) {
			progrsSttus = Status.WAITING.value;
		}
		else if (Status.PROGRESS.value.equals(zvl.getString("progrsSttus"))) {

			if ("01".equals(zvl.getString("reqstMthd"))) {
				if ("Y".equals(zvl.getString("waitReqstAt"))) {
					if (zvl.getInt("totCnt02") >= zvl.getInt("psncpa")) {
						if (zvl.getInt("totCnt01") < zvl.getInt("waitReqstNmpr")) {
							progrsSttus = Status.FINISH_PSNCPA.value;
						}
						else {
							progrsSttus = Status.FINISH.value;
						}
					}
					else {
						progrsSttus = Status.PROGRESS.value;
					}
				}
				else {
					if (zvl.getInt("totCnt02") < zvl.getInt("psncpa")) {
						progrsSttus = Status.PROGRESS.value;
					}
					else {
						progrsSttus = Status.FINISH.value;
					}
				}
			}
			else {
				progrsSttus = Status.PROGRESS.value;
			}

		}
		else if (Status.FINISH.value.equals(zvl.getString("progrsSttus"))) {
			progrsSttus = Status.FINISH.value;
		}

		param.put("progrsSttus", progrsSttus);
		model.addAttribute("progrsSttus", progrsSttus);
	}

	/**
	 * 템플릿관리 폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void regTmplat(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String pageQueryString = pageQuery.getPageQueryString(paramCtx.getParam());
		ZValue result = sqlDao.selectDAO("progrmMasterDAO.tmplat", param);

		List<ZValue> listTmplatAddInfo = sqlDao.listDAO("progrmMasterDAO.listTmplatAddInfo", param);

		/*ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("listTmplatAddInfoJson", mapper.writeValueAsString(listTmplatAddInfo));*/
		model.addAttribute("listTmplatAddInfo", listTmplatAddInfo);
		model.addAttribute("result", result);
		model.addAttribute(PAGE_QUERY_STRING, pageQueryString);
	}

	/**
	 * 템플릿관리 개인정보
	 * @param paramCtx
	 * @throws Exception
	 */
	public void tmplatInfo(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();

		model.addAttribute("COM056CodeList", codeList("COM056"));
		model.addAttribute("COM063CodeList", codeList("COM063"));
		model.addAttribute("COM079CodeList", codeList("COM079"));
	}

	/**
	 * 템플릿관리 신청부가정보
	 * @param paramCtx
	 * @throws Exception
	 */
	public void tmplatAddinfo(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if (StringUtils.hasText(param.getString("iemCodeId"))) {
			List<ZValue> iemCodeList = codeList(param.getString("iemCodeId"));
			model.addAttribute("iemCodeList", iemCodeList);
		}
	}

	/**
	 * 템플릿 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insertTmplat(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());

		sqlDao.insertDAO("progrmMasterDAO.insertTmplat", param);

		insertTmplatAddInfo(param); //신청부가정보(속성) 등록

		StringBuilder url = new StringBuilder("/bos/progrm/master/regTmplat.do");
		url.append("?prgSn=").append(param.getString("prgSn")).append("&").append(StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));
	}

	/**
	 * 템플릿 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateTmplat(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());

		sqlDao.updateDAO("progrmMasterDAO.updateTmplat", param);

		insertTmplatAddInfo(param); //신청부가정보(속성) 수정

		StringBuilder url = new StringBuilder("/bos/progrm/master/regTmplat.do");
		url.append("?prgSn=").append(param.getString("prgSn")).append("&").append(StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
	}

	/**
	 * 템플릿 신청부가정보(속성) 등록/수정
	 * @param param
	 * @throws Exception
	 */
	public void insertTmplatAddInfo(ZValue param) throws Exception {
		Map<String, String> iemNms = getStartWithParam(param, "iemNm");
		if (MapUtils.isNotEmpty(iemNms)) {
			Iterator<String> it = iemNms.keySet().iterator();
			while (it.hasNext()) {
				String fn = it.next();
				//String attrb = param.getString("attrb").split("_")[0];

				int idx = StrUtils.parseInt(StringUtils.replace(fn, "iemNm", ""));
				param.put("iemNm", iemNms.get(fn));
				param.put("essntlAt", param.getString("essntlAt"+idx));
				param.put("sortOrdr", param.getString("sortOrdr"+idx));
				param.put("iemCodeId", param.getString("iemCodeId"+idx));

				String addinfoSn = param.getString("addinfoSn"+idx);
 				if (StringUtils.hasText(addinfoSn)) {
					param.put("addinfoSn", addinfoSn);
					sqlDao.updateDAO("progrmMasterDAO.updateTmplatAddInfo", param);
				}
 				else {
 					param.put("attrb", param.getString("attrb"+idx));
 					sqlDao.insertDAO("progrmMasterDAO.insertTmplatAddInfo", param);
 				}
			}
		}
	}

	/**
	 * 템플릿 신청부가정보(속성) 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteTmplatAddInfo(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());

		sqlDao.updateDAO("progrmMasterDAO.deleteTmplatAddInfo", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	@SuppressWarnings("unchecked")
	private Map<String, String> getStartWithParam(ZValue param, String s){
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
	 * 템플릿관리 속성항목 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void tmplatPopup(ParameterContext<ZValue> paramCtx) throws Exception {
	}

	/**
	 * 템플릿관리 미리보기 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void prevewTmplatPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue masterResult = sqlDao.selectDAO("progrmMasterDAO.view", param);
		model.addAttribute("masterResult", masterResult);

		model.addAttribute("listTmplatInfo", ProgrmApplcntService.listTmplatInfo(param)); // 개인정보 템플릿 목록

		List<ZValue> essntlAtYList = new ArrayList<ZValue>();
		List<ZValue> essntlAtNList = new ArrayList<ZValue>();
		for (ZValue zvl : ProgrmApplcntService.listTmplatInfo(param)) {
			if ("Y".equals(zvl.getString("essntlAt"))) {
				essntlAtYList.add(zvl);
			}
			else {
				essntlAtNList.add(zvl);
			}
		}
		model.addAttribute("essntlAtYList", essntlAtYList);
		model.addAttribute("essntlAtNList", essntlAtNList);

		//신청부가정보
		StringBuffer addinfoVal = new StringBuffer();

		addinfoVal.append("<table cellspacing='0' cellpadding='0' class='table table-bordered' summary=' '>");
		addinfoVal.append("<caption></caption>");
		addinfoVal.append("<colgroup><col style='width:15%'><col></colgroup>");
		addinfoVal.append("<tbody>");

		if (StringUtils.hasText("idxs")) {
			int idxs = param.getInt("idxs");
			for (int i = 1; i <= idxs; i++) {
				String attrb = param.getString("attrb"+i);
				String iemCodeId = "";
				List<ZValue> codeList = null;

				if (StringUtils.hasText(param.getString("iemCodeId"+i))) {
					iemCodeId = param.getString("iemCodeId"+i);
					codeList = codeList(iemCodeId);
				}

				addinfoVal.append("<tr>");
				addinfoVal.append("<th scope='row'>");

				if ("Y".equals(param.getString("essntlAt"+i))) {
					addinfoVal.append("<span class='hide_star'><span class='sr-only'>(필수입력)</span></span>");
				}

				addinfoVal.append(param.getString("iemNm"+i)).append("</th>");

				addinfoVal.append("<td>");
				if ("01".equals(attrb)) {
					addinfoVal.append("<input type='text' name='TEXTPT1' id='TEXTPT1' style='width:130px' value='' title='텍스트를 입력하세요.' />");
				}
				else if ("02".equals(attrb)) {
					addinfoVal.append("<input type='text' name='TEXTPT2' id='TEXTPT2' style='width:230px' value='' title='텍스트를 입력하세요.' />");
				}
				else if ("03".equals(attrb)) {
					addinfoVal.append("<input type='text' name='TEXTPT2' id='TEXTPT2' style='width:330px' value='' title='텍스트를 입력하세요.' />");
				}
				else if ("04".equals(attrb)) {
					addinfoVal.append("<input type='text' id='sdate1' name='sdate1' title='일자 입력' style='width:130px' value='' /><img src='/bos/images/calendar.gif'/>");
				}
				else if ("05".equals(attrb)) {
					addinfoVal.append("<input type='text' id='sdate' name='sdate' title='기간 시작일 입력' style='width:130px' value='' /><img src='/bos/images/calendar.gif'/> ~");
					addinfoVal.append("<input type='text' id='edate' name='edate' title='기간 종료일 입력' style='width:130px' value='' /><img src='/bos/images/calendar.gif'/>");
				}
				else if ("06".equals(attrb)) {
					addinfoVal.append("<select name='SELS1' id='SELS1' title='선택해 주세요.'>");
					addinfoVal.append("<option value=''>선택</option>");
					for (ZValue code : codeList) {
						addinfoVal.append("<option value=''>"+code.getString("codeNm")+"</option>");
					}
					addinfoVal.append("</select>");
				}
				else if ("07".equals(attrb)) {
					for (ZValue code : codeList) {
						addinfoVal.append(" <input type='checkbox' name='MUTICHKG' value='0' id='' />"+code.getString("codeNm"));
					}
				}
				else if ("08".equals(attrb)) {
					for (ZValue code : codeList) {
						addinfoVal.append(" <input type='radio' name='MUTICHKG' value='0' id='' />"+code.getString("codeNm"));
					}
				}
				else if ("09".equals(attrb)) {
					addinfoVal.append("<select name='SEQCC1' id='SEQCC1' title='대분류를 선택해 주세요.'>");
					addinfoVal.append("<option>선택</option>");
					addinfoVal.append("</select>");
					addinfoVal.append("<select name='SEQCC2' id='SEQCC2' title='중분류를 선택해 주세요.'>");
					addinfoVal.append("<option>선택</option>");
					addinfoVal.append("</select>");
				}
				else if ("10".equals(attrb)) {
					addinfoVal.append("<textarea name='TEXTA1' id='TEXTA1' cols='120' rows='12' class='col-md-12' onfocus='if(this.value=='내용을 입력하여 주세요.')this.value='';' onkeyup='if(this.value=='내용을 입력하여 주세요.')this.value='';' >내용을 입력하여 주세요.</textarea>");
				}
				else if ("11".equals(attrb)) {
					addinfoVal.append("<input type='text' name='EMAILID' id='EMAILID' value='' title='이메일 아이디를 입력하세요.' />");
					addinfoVal.append("@ <input type='text' name='EMAILADDR' id='EMAILADDR' value='' title='이메일 도메인 주소를 입력하세요.' />");
					addinfoVal.append("<select name='EMILIN' id='EMILIN' title='이메일 도메인을 선택해 주세요.'>");
					addinfoVal.append("<option>직접입력</option>");
					addinfoVal.append("</select>");
				}
				else if ("12".equals(attrb)) {
					addinfoVal.append("<select name='TPHONE1' id='TPHONE1' title='전화번호 지역번호를 선택해 주세요.'>");
					addinfoVal.append("<option>지역번호</option>");
					addinfoVal.append("</select>");
					addinfoVal.append("-<input type='text' name='TPHONE2' id='TPHONE2' value='' title='전화번호 중간자리를 입력하세요.' />");
					addinfoVal.append("-<input type='text' name='TPHONE3' id='TPHONE3' value='' title='전화번호 끝자리를 입력하세요.' />");
				}
				else if ("13".equals(attrb)) {
					addinfoVal.append("<select name='MPHONES1' id='MPHONES1' title='이통사 번호를 선택해 주세요.'>");
					addinfoVal.append("<option>이통사 번호</option>");
					addinfoVal.append("</select>");
					addinfoVal.append("-<input type='text' name='MPHONES2' id='MPHONES2' value='' title='전화번호(휴대폰) 중간자리를 입력하세요.' />");
					addinfoVal.append("-<input type='text' name='MPHONES3' id='MPHONES3' value='' title='전화번호(휴대폰) 끝자리를 입력하세요.' />");
				}
				else if ("14".equals(attrb)) {
					addinfoVal.append("<textarea name='TEXTB1' id='TEXTB1' cols='120' rows='12' class='col-md-12' onfocus='if(this.value=='내용을 입력하여 주세요.')this.value='';' onkeyup='if(this.value=='내용을 입력하여 주세요.')this.value='';'  title='동의 내용을 입력해 주세요.'>내용을 입력하여 주세요.</textarea>");
					addinfoVal.append("<label for='CHKSAGR'><input type='checkbox' name='CHKSAGR' id='CHKSAGR' />*****(항목명)에 동의합니다</label>");
				}
				else if ("15".equals(attrb)) {
					addinfoVal.append("<input type='file' name='FILE4' id='FILE4' title='첨부파일 등록' class='col-md-8' />");
				}

				addinfoVal.append("</td>");
				addinfoVal.append("</tr>");
			}
		}
		addinfoVal.append("</tbody>");
		addinfoVal.append("</table>");

		model.addAttribute("addinfoVal", addinfoVal.toString());
	}

	/**
	 * 운영 통계
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsList(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();

		super.setCountQueryId("progrmMasterDAO.statsListCnt");
		super.setListQueryId("progrmMasterDAO.statsList");
		super.list(paramCtx);

		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
		model.addAttribute("prgSeCodeList", codeList("COM050"));
	}

	/**
	 * 프로그램명 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void prgNmList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> prgNmList = sqlDao.listDAO("progrmMasterDAO.prgNmList", param);
		model.addAttribute("prgNmList", prgNmList);
	}

	/**
	 * 관리자 컨텐츠 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listContents(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String gubun = "/progrm/master/list.do?prgSe="+param.getString("prgSe");
		param.put("gubun", gubun);

		model.addAttribute("resultList", sqlDao.listDAO("progrmMasterDAO.listContents", param));
	}


	/**
	 * 콘텐츠코리아랩 메인 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listCklMain(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> progrmList = sqlDao.listDAO("progrmMasterDAO.listCklMain", param);
		model.addAttribute("progrmList", progrmList);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 코드 목록 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void codeListPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setCountQueryId("progrmMasterDAO.listCodeCnt");
		super.setListQueryId("progrmMasterDAO.listCode");
		super.list(paramCtx);
	}

	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"구분", "분류", "프로그램명", "신청방식", "신청기간", "교육기간", "진행상태", "담당부서", "사용여부", "정원", "신청", "대기정원", "대기신청", "사이트구분"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("progrmMasterDAO.listExcel", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("프로그램 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}

	/**
	 * 운영통계 엑셀 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStats(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"구분", "분류", "프로그램명", "만족도점수", "신청자수", "신청완료", "취소", "대기신청", "남", "여", "20대", "30대", "40대", "50대"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("progrmMasterDAO.listExcelStats", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("프로그램 운영 통계 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}

	/**
	 * 프로그램년도 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void prgYearList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> prgYearList = sqlDao.listDAO("progrmMasterDAO.prgYearList", param);
		model.addAttribute("prgYearList", prgYearList);
	}
	
	/**
	 * 공통코드 리스트
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ajaxCodeDetailList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> codeDetailList = sqlDao.listDAO("progrmMasterDAO.codeDetailList", param);
		model.addAttribute("codeDetailList", codeDetailList);
	}
	
	/**
	 * 공통코드 ID Max
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ajaxMaxCode(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue maxCode = sqlDao.selectDAO("progrmMasterDAO.selectMaxCode", param);
		model.addAttribute("maxCode", maxCode);
	}
	
	/**
	 * 공통코드 저장
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public void insertCodeDetail(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		CmmnCodeDetail iCmmnCodeDetail = new CmmnCodeDetail();
		
		if(param.getInt("sortOrdr") < param.getInt("sort")){
			CmmnCodeDetail uCmmnCodeDetail = new CmmnCodeDetail();
			
			param.put("vMode", "A");

			List<ZValue> codeDetailList = sqlDao.listDAO("progrmMasterDAO.codeDetailList", param);

			for (ZValue zvl : codeDetailList) {			
				uCmmnCodeDetail.setCodeNm(zvl.getString("codeNm"));
				uCmmnCodeDetail.setCodeNmEn(zvl.getString("codeNmEn"));
				uCmmnCodeDetail.setCodeDc(zvl.getString("codeDc"));
				uCmmnCodeDetail.setCodeDcEn(zvl.getString("codeDcEn"));
				uCmmnCodeDetail.setUseAt(zvl.getString("useAt"));
				uCmmnCodeDetail.setLastUpdusrId(user.getUserId());
				uCmmnCodeDetail.setSortOrdr((zvl.getInt("sortOrdr") + 1));
				uCmmnCodeDetail.setOption1(zvl.getString("option1"));
				uCmmnCodeDetail.setOption2(zvl.getString("option2"));
				uCmmnCodeDetail.setOption3(zvl.getString("option3"));
				uCmmnCodeDetail.setOption4(zvl.getString("option4"));
				uCmmnCodeDetail.setOption5(zvl.getString("option5"));
				uCmmnCodeDetail.setCodeId(zvl.getString("codeId"));
				uCmmnCodeDetail.setCode(zvl.getString("code"));
				
				cmmnCodeDetailDAO.updateCmmnCodeDetail(uCmmnCodeDetail);
			}
		}
		
		boolean isDupCodeChk = true;
		int v_num = param.getInt("sort");
		String vCode = "";
		
		while(isDupCodeChk){
			vCode = param.getString("codeId") + String.format("%02d", v_num);
			param.put("vCode", vCode);
			
			ZValue dupCnt = sqlDao.selectDAO("progrmMasterDAO.dupCodeChk", param);
			
			if(dupCnt.getInt("cnt") < 1){
				isDupCodeChk = false;
			}
			
			v_num++;
		}
		
		iCmmnCodeDetail.setCodeId(param.getString("codeId"));
		iCmmnCodeDetail.setCode(vCode);
		iCmmnCodeDetail.setCodeNm(param.getString("codeNm"));
		iCmmnCodeDetail.setCodeDc(param.getString("codeNm"));
		iCmmnCodeDetail.setUseAt(param.getString("useAt"));
		iCmmnCodeDetail.setFrstRegisterId(user.getUserId());
		iCmmnCodeDetail.setLastUpdusrId(user.getUserId());
		iCmmnCodeDetail.setUpperCode("0");
		
		if(param.getInt("sortOrdr") > param.getInt("sort")){
			iCmmnCodeDetail.setSortOrdr(param.getInt("sort"));
		}else{
			iCmmnCodeDetail.setSortOrdr(param.getInt("sortOrdr"));
		}
		
		iCmmnCodeDetail.setDepth(1);
		
		cmmnCodeDetailDAO.insertCmmnCodeDetail(iCmmnCodeDetail);
	}
	
	/**
	 * 공통코드 수정
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public void updateCodeDetail(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		CmmnCodeDetail cmmnCodeDetail = new CmmnCodeDetail();
		CmmnCodeDetail uCmmnCodeDetail = new CmmnCodeDetail();
		
		List<ZValue> codeDetailList = null;
		
		int v_num = 0;
		
		if(param.getInt("sortOrdr") > param.getInt("sort")){
			v_num = param.getInt("sort");
			
			param.put("vMode", "B");

			codeDetailList = sqlDao.listDAO("progrmMasterDAO.codeDetailList", param);
		}else if(param.getInt("sortOrdr") < param.getInt("sort")){
			v_num = param.getInt("sortOrdr");
			
			param.put("vMode", "C");

			codeDetailList = sqlDao.listDAO("progrmMasterDAO.codeDetailList", param);		
		}
		System.out.println("=============================111 : ");
		if(codeDetailList != null){
			System.out.println("=============================1112222 : ");
			for (ZValue zvl : codeDetailList) {	
				if("C".equals(param.getString("vMode"))){
					v_num++;
				}
				
				uCmmnCodeDetail.setCodeNm(zvl.getString("codeNm"));
				uCmmnCodeDetail.setCodeNmEn(zvl.getString("codeNmEn"));
				uCmmnCodeDetail.setCodeDc(zvl.getString("codeDc"));
				uCmmnCodeDetail.setCodeDcEn(zvl.getString("codeDcEn"));
				uCmmnCodeDetail.setUseAt(zvl.getString("useAt"));
				uCmmnCodeDetail.setLastUpdusrId(user.getUserId());
				uCmmnCodeDetail.setSortOrdr(v_num);
				uCmmnCodeDetail.setOption1(zvl.getString("option1"));
				uCmmnCodeDetail.setOption2(zvl.getString("option2"));
				uCmmnCodeDetail.setOption3(zvl.getString("option3"));
				uCmmnCodeDetail.setOption4(zvl.getString("option4"));
				uCmmnCodeDetail.setOption5(zvl.getString("option5"));
				uCmmnCodeDetail.setCodeId(zvl.getString("codeId"));
				uCmmnCodeDetail.setCode(zvl.getString("code"));
				
				cmmnCodeDetailDAO.updateCmmnCodeDetail(uCmmnCodeDetail);
				
				if("B".equals(param.getString("vMode"))){
					v_num++;
				}
			}
		}
		System.out.println("=============================222");
		param.put("vMode", "D");

		ZValue codeDetailResult = sqlDao.selectDAO("progrmMasterDAO.codeDetailList", param);
		
		cmmnCodeDetail.setCodeNm(param.getString("codeNm"));
		cmmnCodeDetail.setCodeNmEn(codeDetailResult.getString("codeNmEn"));
		cmmnCodeDetail.setCodeDc(param.getString("codeNm"));
		cmmnCodeDetail.setCodeDcEn(codeDetailResult.getString("codeDcEn"));
		cmmnCodeDetail.setUseAt(param.getString("useAt"));
		cmmnCodeDetail.setLastUpdusrId(user.getUserId());
		cmmnCodeDetail.setSortOrdr(param.getInt("sortOrdr"));
		cmmnCodeDetail.setOption1(codeDetailResult.getString("option1"));
		cmmnCodeDetail.setOption2(codeDetailResult.getString("option2"));
		cmmnCodeDetail.setOption3(codeDetailResult.getString("option3"));
		cmmnCodeDetail.setOption4(codeDetailResult.getString("option4"));
		cmmnCodeDetail.setOption5(codeDetailResult.getString("option5"));
		cmmnCodeDetail.setCodeId(codeDetailResult.getString("codeId"));
		cmmnCodeDetail.setCode(codeDetailResult.getString("code"));
		
		cmmnCodeDetailDAO.updateCmmnCodeDetail(cmmnCodeDetail);
	}	
	
	/**
	 * 공통코드 삭제
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public void deleteCodeDetail(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		CmmnCodeDetail cmmnCodeDetail = new CmmnCodeDetail();
		
		cmmnCodeDetail.setCodeId(param.getString("codeId"));
		cmmnCodeDetail.setCode(param.getString("code"));
		
		cmmnCodeDetailDAO.deleteCmmnCodeDetail(cmmnCodeDetail);
		
		param.put("vMode", "A");

		List<ZValue> codeDetailList = sqlDao.listDAO("progrmMasterDAO.codeDetailList", param);
		
		if(codeDetailList.size() > 0){
			int vOrdr = param.getInt("sortOrdr");
			
			CmmnCodeDetail uCmmnCodeDetail = new CmmnCodeDetail();
			
			for (ZValue zvl : codeDetailList) {			
				uCmmnCodeDetail.setCodeNm(zvl.getString("codeNm"));
				uCmmnCodeDetail.setCodeNmEn(zvl.getString("codeNmEn"));
				uCmmnCodeDetail.setCodeDc(zvl.getString("codeDc"));
				uCmmnCodeDetail.setCodeDcEn(zvl.getString("codeDcEn"));
				uCmmnCodeDetail.setUseAt(zvl.getString("useAt"));
				uCmmnCodeDetail.setLastUpdusrId(user.getUserId());
				uCmmnCodeDetail.setSortOrdr(vOrdr);
				uCmmnCodeDetail.setOption1(zvl.getString("option1"));
				uCmmnCodeDetail.setOption2(zvl.getString("option2"));
				uCmmnCodeDetail.setOption3(zvl.getString("option3"));
				uCmmnCodeDetail.setOption4(zvl.getString("option4"));
				uCmmnCodeDetail.setOption5(zvl.getString("option5"));
				uCmmnCodeDetail.setCodeId(zvl.getString("codeId"));
				uCmmnCodeDetail.setCode(zvl.getString("code"));
				
				cmmnCodeDetailDAO.updateCmmnCodeDetail(uCmmnCodeDetail);
				
				vOrdr++;
			}
		}
	}	
}
