package kr.co.edu.hkFcltyResve.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.DateUtil;
import kr.co.edu.hkFcltyResve.paging.ResveSttusPageQuery;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.ems.service.EmsService;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.StringUtil;
import kr.co.unp.util.ZValue;

public class ResveSttusService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	public ResveSttusService() {

	}

	@Resource(name = "emsService")
	private EmsService emsService;


	/**
	 * 시설공간 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listFcltySpceNm(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		List<ZValue> list = sqlDao.listDAO("HkFcltyResveDAO.listFcltySpceNm", param);
		model.addAttribute("resultList",list);
	}



	/**
	 * 일별예약현황 목록  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listDaly(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveDt",""))) param.put("resveDt",sf.format(cal.getTime()));

		List<ZValue> resultList = new ArrayList<ZValue>();
		List<ZValue> list = sqlDao.listDAO("HkFcltyResveDAO.listDalyResveSttus", param);
		int i=0;
		String tmpSn = "";
		ZValue vo = new ZValue();
		for (ZValue result : list) {
			if (!tmpSn.equals(result.getString("fcltySn"))) {
				if (i > 0) resultList.add(vo);
				tmpSn = result.getString("fcltySn");
				vo = new ZValue();
				vo.put("areaSeNm", result.getString("areaSeNm"));
				vo.put("lcSeNm", result.getString("lcSeNm"));
				vo.put("fcltySeNm", result.getString("fcltySeNm"));
				vo.put("spceNm", result.getString("spceNm"));
				vo.put("ntssAt", result.getString("ntssAt"));
				vo.put("schdulCnt", result.getString("schdulCnt"));
				vo.putObject("sumcnt9", null);
				vo.putObject("sumcnt10", null);
				vo.putObject("sumcnt11", null);
				vo.putObject("sumcnt12", null);
				vo.putObject("sumcnt13", null);
				vo.putObject("sumcnt14", null);
				vo.putObject("sumcnt15", null);
				vo.putObject("sumcnt16", null);
				vo.putObject("sumcnt17", null);
				vo.putObject("sumcnt18", null);
				vo.putObject("sumcnt19", null);
				vo.putObject("sumcnt20", null);
				vo.putObject("sumcnt21", null);
				vo = getResveInfoByTime(result,vo);

			}
			else {
				vo = getResveInfoByTime(result,vo);
			}

			if (i > 0 && i == list.size()-1) resultList.add(vo);
			i++;
		}


		model.addAttribute("resultList",resultList);
	}

	public void listDalyExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveDt",""))) param.put("resveDt",sf.format(cal.getTime()));

		List<ZValue> resultList = new ArrayList<ZValue>();
		List<ZValue> list = sqlDao.listDAO("HkFcltyResveDAO.listDalyResveSttus", param);
		int i=0;
		String tmpSn = "";
		ZValue vo = new ZValue();
		for (ZValue result : list) {
			if (!tmpSn.equals(result.getString("fcltySn"))) {
				if (i > 0) resultList.add(vo);
				tmpSn = result.getString("fcltySn");
				vo = new ZValue();
				vo.put("areaSeNm", result.getString("areaSeNm"));
				vo.put("lcSeNm", result.getString("lcSeNm"));
				vo.put("fcltySeNm", result.getString("fcltySeNm"));
				vo.put("spceNm", result.getString("spceNm"));
				vo.put("ntssAt", result.getString("ntssAt"));
				vo.put("schdulCnt", result.getString("schdulCnt"));
				vo.putObject("sumcnt9", null);
				vo.putObject("sumcnt10", null);
				vo.putObject("sumcnt11", null);
				vo.putObject("sumcnt12", null);
				vo.putObject("sumcnt13", null);
				vo.putObject("sumcnt14", null);
				vo.putObject("sumcnt15", null);
				vo.putObject("sumcnt16", null);
				vo.putObject("sumcnt17", null);
				vo.putObject("sumcnt18", null);
				vo.putObject("sumcnt19", null);
				vo.putObject("sumcnt20", null);
				vo.putObject("sumcnt21", null);
				vo = getResveInfoByTime(result,vo);

			}
			else {
				vo = getResveInfoByTime(result,vo);
			}

			if (i > 0 && i == list.size()-1) resultList.add(vo);
			i++;
		}


		model.addAttribute("resultList",resultList);
	}

	/**
	 * 애약조회 시간
	 * @param result
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	private ZValue getResveInfoByTime(ZValue result, ZValue vo) throws Exception {
		if ("".equals(result.getString("resveBeginTime","")) || "".equals(result.getString("resveEndTime",""))) return vo;
		String key = "";
		int beginTm = result.getInt("resveBeginTime");
		int endTm = result.getInt("resveEndTime");

		for (int i =beginTm; i <= endTm; i++) {

			if (i == 9) key = "sumcnt9";
			else if (i == 10) key = "sumcnt10";
			else if (i == 11) key = "sumcnt11";
			else if (i == 12) key = "sumcnt12";
			else if (i == 13) key = "sumcnt13";
			else if (i == 14) key = "sumcnt14";
			else if (i == 15) key = "sumcnt15";
			else if (i == 16) key = "sumcnt16";
			else if (i == 17) key = "sumcnt17";
			else if (i == 18) key = "sumcnt18";
			else if (i == 19) key = "sumcnt19";
			else if (i == 20) key = "sumcnt20";
			else if (i == 21) key = "sumcnt21";

			ZValue subVO = new ZValue();
			if (i == beginTm && endTm-beginTm > 0) subVO.put("colspan", String.valueOf(endTm-beginTm+1));
			else if (endTm-beginTm > 0) subVO.put("colspan", "none");
			subVO.put("resveSn", result.getString("resveSn"));
			subVO.put("fcltySn", result.getString("fcltySn"));
			subVO.put("resveDt", result.getString("resveDt"));
			subVO.put("resveBeginTime", result.getString("resveBeginTime"));
			subVO.put("resveEndTime", result.getString("resveEndTime"));
			subVO.put("resveNm", result.getString("resveNm"));
			subVO.put("useNmpr", result.getString("useNmpr"));
			subVO.put("usePurposeCn", StringUtil.unescapeHtml(result.getString("usePurposeCn")));
			subVO.put("eqpmnCnt", result.getInt("eqpmnCnt"));
			subVO.put("ntssAt", result.getString("ntssAt"));
			subVO.put("schdulCnt", result.getString("schdulCnt"));

			vo.putObject(key, subVO);

		}

		return vo;

	}


	/**
	 * 일별예약현황 엑셀 목록 다운로드  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelDaly(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveDt",""))) param.put("resveDt",sf.format(cal.getTime()));

		String[] titles = {"지역","위치","시설구분","공간명","오전09시","오전10시","오전11시","오전12시","오후01시","오후02시","오후03시","오후04시","오후05시","오후06시","오후07시","오후08시","오후09시"};


		List<ZValue> resultList = sqlDao.listDAO("HkFcltyResveDAO.listDalyResveSttus", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("일별예약현황 목록", titles, resultList);
		model.addAttribute("excel", vo);
	}


	/**
	 * 예약현황 목록  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new ResveSttusPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setCountQueryId("HkFcltyResveDAO.listResveSttusCnt");
		super.setListQueryId("HkFcltyResveDAO.listResveSttus");
		super.list(paramCtx);

		model = paramCtx.getModel();
		param = paramCtx.getParam();
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);


		List<ZValue> listEqpmnNm = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnNm", param);
		model.addAttribute("listEqpmnNm",listEqpmnNm);
	}



	/**
	 * 예약현황 상세  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setPageQuery(new ResveSttusPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkFcltyResveDAO.viewResveSttus");
		super.view(paramCtx);

		List<ZValue> list = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByResve", param);
		model.addAttribute("eqpmnList", list);

		//access history param
		ZValue result = (ZValue)model.get("result");
		param.put("nttSn", result.getString("resveSn"));
		param.put("targetUserSn", result.getString("userSn"));
	}


	/**
	 * 예약현황 등록  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void resveStep1(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		SimpleDateFormat yearSf = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthSf = new SimpleDateFormat("MM");
		Calendar cal = Calendar.getInstance();
		String todayYY = yearSf.format(cal.getTime());
		String todayMM = monthSf.format(cal.getTime());
		model.addAttribute("todayYY", todayYY);
		model.addAttribute("todayMM", todayMM);

		super.forInsert(paramCtx);

		if (session.getAttribute("resultStep1") != null) {
			if (!"prev".equals(param.getString("locationTp"))) session.removeAttribute("resultStep1");
			model.addAttribute("result", session.getAttribute("resultStep1"));
		}
		else {
			if (!"".equals(param.getString("resveSn"))) {
				ZValue resultData = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
				List<ZValue> eqpmnList = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByResve", param);
				resultData.putObject("eqpmnList",eqpmnList);
				model.addAttribute("result", resultData);
			}
		}
	}

	/**
	 * 예약현황 등록 step2  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void resveStep2(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		String areaSe = param.getString("areaSe");
		String lcSe = param.getString("lcSe");
		String fcltySe = param.getString("fcltySe");
		String spceNm = param.getString("spceNm");

		String resveSn = param.getString("resveSn");
		String fcltySn = param.getString("fcltySn");
		String resveDt = param.getString("resveDt");
		String resveBeginTime = param.getString("resveBeginTime");
		String resveEndTime = param.getString("resveEndTime");
		String resveSttus = param.getString("resveSttus");
		String eqpmnsStr = param.getString("eqpmnsStr");
		String eqpnmUseYn = param.getString("eqpnmUseYn","Y");
		String vwSpceAllNm = param.getString("vwSpceAllNm");

		List<ZValue> eqpmnList = super.getJsonConvertZValueList(eqpmnsStr);

		ZValue resultData = new ZValue();
		resultData.put("areaSe", areaSe);
		resultData.put("lcSe", lcSe);
		resultData.put("fcltySe", fcltySe);
		resultData.put("spceNm", spceNm);

		resultData.put("resveSn", resveSn);
		resultData.put("fcltySn", fcltySn);
		resultData.put("resveDt", resveDt);
		resultData.put("resveBeginTime", resveBeginTime);
		resultData.put("resveEndTime", resveEndTime);
		resultData.put("diffTime", (Integer.parseInt(resveEndTime) - Integer.parseInt(resveBeginTime)+1));
		resultData.put("resveSttus", resveSttus);
		resultData.put("vwSpceAllNm",vwSpceAllNm);
		resultData.putObject("eqpmnList",eqpmnList);
		resultData.putObject("eqpnmUseYn",eqpnmUseYn);


		session.setAttribute("resultStep1", resultData);
		if (!"".equals(param.getString("resveSn"))) {
			ZValue viewVO = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
			resultData.putAll(viewVO);
		}


		model.addAttribute("result", resultData);

	}


	/**
	 * 예약현황 저장처리  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void resveSave(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		ZValue resultData = session.getAttribute("resultStep1") == null ? null : (ZValue)session.getAttribute("resultStep1");
		//if (resultData != null) resultData.remove("resveSn");
		resultData.putAll(param);

		Object pkValue = null;

		if (!"".equals(param.getString("resveSn"))) {
			sqlDao.updateDAO("HkFcltyResveDAO.updateResve", resultData);
			sqlDao.deleteDAO("HkFcltyResveDAO.deleteResveEqpmnByResveSn", param);
		}
		else {
			String resveNo =  RandomStringUtils.random(5, "abcdefghijklmnopqrstuvwxyz1234567890");
			resultData.put("resveNo", resveNo);
			pkValue = sqlDao.insertDAO("HkFcltyResveDAO.insertResve", resultData);
		}

		List<ZValue> eqpmnList = resultData.get("eqpmnList") != null ? (List<ZValue>)resultData.get("eqpmnList") : null;

		if (eqpmnList != null) {
			for (ZValue eqpmnVO : eqpmnList) {
				String eqpmnDetailSnStr = eqpmnVO.getString("eqpmnDetailSnStr");
				String[] eqpmnDetailSns = null;
				if (!"".equals(eqpmnDetailSnStr)) {
					eqpmnDetailSns = eqpmnDetailSnStr.split(",");
					for (String eqpmnDetailSn : eqpmnDetailSns) {
						resultData.put("eqpmnDetailSn", eqpmnDetailSn);
						sqlDao.insertDAO("HkFcltyResveDAO.insertResveEqpmn", resultData);
					}
				}
			}
		}

		String resveSn = pkValue != null ? String.valueOf(pkValue) : resultData.getString("resveSn");
		param.put("resveSn", resveSn);

		ZValue vo = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
		String sendTp = vo.getString("resveRecptnSe");
		if ("01".equals(sendTp) || "03".equals(sendTp)) { //sms
			String mbtlnum = vo.getString("mbtlnum","").replaceAll("-", "");
			if (!"".equals(mbtlnum)) {
				String msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 예약이 " + "신청되었습니다.";
				if ("03".equals(vo.getString("resveSttus"))) {
					msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 대기예약이 " + "신청되었습니다.";
				}

				String callback = EgovProperties.getProperty("Globals.sms.edu.fcltyresve.callback");
				param.put("phone", mbtlnum);
		    	param.put("callback", callback);
		    	param.put("msg", msg);

		    	param.put("refkey", "accademy");
				emsService.sndngSms(param);
			}
		}
		if ("02".equals(sendTp) || "03".equals(sendTp)) { //email
			if (!"".equals(vo.getString("email",""))) {
				String title = "[EDUKOCCA]시설예약이 신청되었습니다.";
		    	String email = vo.getString("email");
		    	String content = null;
		    	StringBuffer contSb = new StringBuffer();
		    	contSb.append("<h2 style=\"font-size:30px;font-weight:600\">시설예약 신청정보</h2>");
		    	contSb.append("<p style=\"font-size:14px;padding-top:10px\">안녕하세요. <strong>").append( vo.getString("resveNm") ).append("</strong>님! EDUKOCCA 고객님의 예약정보 입니다.<p>");
		        contSb.append("<ul>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약번호</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveNo") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약일시</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveDt") ).append(" ").append(vo.getString("resveBeginTime")).append(":00 ~ ").append(vo.getString("resveEndTime")).append( ":59 까지</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>공간명</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("spceNm") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약상태</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveSttusNm") ).append( "</span></li><br/>");
		        contSb.append("</ul>");

		        content = contSb.toString();

				param.put("title", title);
				param.put("email", email);
				param.put("name", vo.getString("resveNm"));
				param.put("content", content);

				param.put("siteName", "ckl");
				emsService.sndngEmail(param);
			}
		}

		StringBuilder url = new StringBuilder("/bos/hkFcltyResve/resveSttus/resveComplete.do");
		url.append("?resveSn=").append(resveSn).append("&menuNo=").append(param.getString("menuNo"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

		//access history param
		param.put("nttSn", resveSn);
		param.put("targetUserSn", resultData.getString("userSn"));

	}


	/**
	 * 예약현황 완료  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void resveComplete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		ZValue result = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
		List<ZValue> eqpmnList = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByResve", param);
		result.putObject("eqpmnList",eqpmnList);
		model.addAttribute("result", result);

	}

	/**
	 * 예약상태 변경처리  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void updateResveSttus(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();

		initCmmnParam(param);

		sqlDao.updateDAO("HkFcltyResveDAO.updateResveSttus", param);
		ZValue vo = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);

		//request.setCharacterEncoding("UTF-8");
		String sendTp = vo.getString("resveRecptnSe");

		if ("01".equals(sendTp) || "03".equals(sendTp)) { //sms
			String mbtlnum = vo.getString("mbtlnum","").replaceAll("-", "");
			if (!"".equals(mbtlnum)) {
				String msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 예약이 " + vo.getString("resveSttusNm") + "되었습니다.";
				String callback = EgovProperties.getProperty("Globals.sms.edu.fcltyresve.callback");
				param.put("phone", mbtlnum);
		    	param.put("callback", callback);
		    	param.put("msg", msg);

		    	param.put("refkey", "accademy");
				emsService.sndngSms(param);
			}
		}
		if ("02".equals(sendTp) || "03".equals(sendTp)) { //email
			if (!"".equals(vo.getString("email",""))) {
				String title = "[EDUKOCCA]시설예약상태가 변경되었습니다.";
		    	String email = vo.getString("email");
		    	String content = null;
		    	StringBuffer contSb = new StringBuffer();
		    	contSb.append("<h2 style=\"font-size:30px;font-weight:600\">시설예약 변경정보</h2>");
		    	contSb.append("<p style=\"font-size:14px;padding-top:10px\">안녕하세요. <strong>").append( vo.getString("resveNm") ).append("</strong>님! EDUKOCCA 고객님의 예약정보 입니다.<p>");
		        contSb.append("<ul>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약번호</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveNo") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약일시</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveDt") ).append(" ").append(vo.getString("resveBeginTime")).append(":00 ~ ").append(vo.getString("resveEndTime")).append( ":59 까지</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>공간명</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("spceNm") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약상태</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveSttusNm") ).append( "</span></li><br/>");
		        contSb.append("</ul>");

		        content = contSb.toString();

				param.put("title", title);
				param.put("email", email);
				param.put("name", vo.getString("resveNm"));
				param.put("content", content);


				param.put("siteName", "ckl");
				emsService.sndngEmail(param);
			}
		}

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}


	/**
	 * 예약현황 삭제처리  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setDeleteQueryId("HkFcltyResveDAO.deleteResveSttus");
		super.delete(paramCtx);

		String pageQueryString = pageQuery.getPageQueryString(param);
		StringBuilder url = new StringBuilder("/bos/hkFcltyResve/resveSttus/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));
	}


	/**
	 * 달력 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void listCal(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request =  paramCtx.getRequest();
		initCmmnParam(param);

		//공휴일 목록
		List<ZValue> hldyList = sqlDao.listDAO("HkHldyDAO.listHldy", param);

		//시설관리 상세
		ZValue fcltyVO = sqlDao.selectDAO("HkFcltyResveDAO.viewFclty", param);

		//String wkendResvePolsblAt = fcltyVO.getString("wkendResvePolsblAt");
		String wkendResvePolsblAt = "N";

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat yearSf = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthSf = new SimpleDateFormat("MM");
		SimpleDateFormat daySf = new SimpleDateFormat("DD");
		SimpleDateFormat todaySf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();

		Calendar _cal = (Calendar)cal.clone();

		if (param.getInt("year",0) > 0 &&  param.getInt("month",0) > 0) {
			_cal.set(param.getInt("year",0), param.getInt("month",0)-1, 1);
		}
		else {
			_cal.set(Calendar.DAY_OF_MONTH, 1);
		}

		Calendar prevCal = (Calendar)_cal.clone();
		prevCal.add(Calendar.MONTH, -1);
		prevCal.set(Calendar.DAY_OF_MONTH, 1);
		String prevDt = sf.format(prevCal.getTime());
		model.addAttribute("prevDt", prevDt);

		Calendar nextCal = (Calendar)_cal.clone();
		nextCal.add(Calendar.MONTH, 1);
		nextCal.set(Calendar.DAY_OF_MONTH, 1);
		String nextDt = sf.format(nextCal.getTime());
		model.addAttribute("nextDt", nextDt);


		String dayYY = yearSf.format(_cal.getTime());
		String dayMM = monthSf.format(_cal.getTime());
		String dayDD = daySf.format(_cal.getTime());

		model.addAttribute("dayYY", dayYY);
		model.addAttribute("dayMM", dayMM);
		model.addAttribute("dayDD", dayDD);


		int currDay = cal.get(Calendar.DAY_OF_MONTH);
		int currMonth = cal.get(Calendar.MONTH)+1;
		int currYear = cal.get(Calendar.YEAR);

		String currDate = todaySf.format(cal.getTime());
		int currDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);	//월의 첫번째주일

		int paramMonth = _cal.get(Calendar.MONTH)+1;
		int paramYear = _cal.get(Calendar.YEAR);

		int dayOfWeek = _cal.get(Calendar.DAY_OF_WEEK);	//월의 첫번째주일
		int lastDay = _cal.getActualMaximum(Calendar.DAY_OF_MONTH);				//월의 마지막 날짜


		int weekRowCnt = DateUtil.getWeekCount(dayOfWeek,lastDay);				//월의 주 개수
		String[] arrWeek = {"sun", "mon", "tue", "wed", "thu", "fri", "sat"};

		List<ZValue> calList = new ArrayList<ZValue>();
		ZValue weekVO = new ZValue();

		int k = 1;
		int wpos = 0;

		int chkSum = 0;

		Calendar diffCal = (Calendar)cal.clone();
		diffCal.add(Calendar.MONTH, 1);


		if (paramYear == currYear && paramMonth == currMonth) {
			chkSum = 0;
		}
		else {
			int tmpMonth = currMonth+1 == 13 ? 1 :  currMonth+1;
			if (tmpMonth == _cal.get(Calendar.MONTH)+1) {
				chkSum = (Integer)request.getSession().getAttribute("chkSum");
			}
		}


		for(int i = 1; i <= weekRowCnt * 7; i++) {


			if (i <  dayOfWeek) {
				ZValue dayData = new ZValue();
				if(i % 7 == 0) {
					wpos = (i % 7) - 1;
					if(wpos == -1) wpos = 6;
					weekVO.put(arrWeek[wpos],dayData);
					calList.add(weekVO);
					weekVO = new ZValue();
				}
				else {
					wpos = (i % 7) - 1;
					if(wpos == -1) wpos = 6;
					weekVO.put(arrWeek[wpos], dayData);

				}
			}
			else  {
				if(k <= lastDay) {


					Calendar itemCal = (Calendar)_cal.clone();
					itemCal.set(paramYear, paramMonth-1, k);

					int itemDayOfWeek = itemCal.get(Calendar.DAY_OF_WEEK);

					long diffSec = (itemCal.getTimeInMillis() - cal.getTimeInMillis()) / 1000;       //초
					long diffDay = diffSec/(60 * 60 * 24);

					ZValue dayData = new ZValue();
					dayData.put("day", k);
					dayData.put("diffDay", diffDay);


					if (diffDay >= 0) {
						int chkNum = 0;
						boolean dtFlag = false;
						for (ZValue hldyVO : hldyList) {
							int hldyYy = hldyVO.getInt("hldyYy",0);
							int hldyMm = hldyVO.getInt("hldyMm",0);
							int hldyDd = hldyVO.getInt("hldyDd",0);

							if (paramYear == hldyYy && paramMonth == hldyMm && hldyDd == k) {
								dtFlag = true;
								break;
							}
						}
						if (dtFlag) dayData.put("hldyTp", "Y");

						if (currYear == paramYear && currMonth == paramMonth && currDay == k) dayData.put("todayTp", "Y");


						if (!"bos".equals(param.getString("siteName"))) {

							if (diffDay == 0 || (!dtFlag && !"Y".equals(wkendResvePolsblAt) && itemDayOfWeek > 1 && itemDayOfWeek < 7)) chkNum++;
							else if (diffDay == 0 || (!dtFlag && "Y".equals(wkendResvePolsblAt) )) chkNum++;

							if (chkSum <= 2) {
								if (chkNum == 1) {
									dayData.put("resveWaitTp", "Y");
									chkSum++;
								}
							}
						}
					}


					if(i % 7 == 0) {
						wpos = (i % 7) - 1;
						if(wpos == -1) wpos = 6;
						weekVO.put(arrWeek[wpos], dayData);
						calList.add(weekVO);
						weekVO = new ZValue();
					}
					else {
						wpos = (i % 7) - 1;
						if(wpos == -1) wpos = 6;
						weekVO.put(arrWeek[wpos], dayData);
					}

					k++;
				}
				else {

					ZValue dayData = new ZValue();
					if(i % 7 == 0) {
						wpos = (i % 7) - 1;
						if(wpos == -1) wpos = 6;
						weekVO.put(arrWeek[wpos], dayData);
						calList.add(weekVO);
						weekVO = new ZValue();
					}
					else {
						wpos = (i % 7) - 1;
						if(wpos == -1) wpos = 6;
						weekVO.put(arrWeek[wpos], dayData);

					}
				}

			}

		}
		model.addAttribute("wkendResvePolsblAt", wkendResvePolsblAt);
		model.addAttribute("fcltyItem", fcltyVO);
		model.addAttribute("calList", calList);

		if (currMonth == _cal.get(Calendar.MONTH)+1) request.getSession().setAttribute("chkSum", chkSum); //예약대기일시 수

	}


	/**
	 * 시간선택 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listTime(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = new ZValue();

		List<ZValue> listTime = sqlDao.listDAO("HkFcltyResveDAO.listResveByCal", param);

		for (ZValue item : listTime) {
			int resveBeginTime = item.getInt("resveBeginTime",0);
			int resveEndTime = item.getInt("resveEndTime",0);
			for (int i= resveBeginTime;  i <= resveEndTime; i++) {
				result.put((String)("time"+i), item.getString("resveSttus"));
			}
		}

		model.addAttribute("resultTime", result);
	}


	/**
	 * 장비선택  목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listEqpmn(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();


		List<ZValue> list = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByFclty", param);
		List<ZValue> listByDt = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByDt", param);

		List<ZValue> resultList = new ArrayList<ZValue>();

		String eqpmnDtlSnStr = "";
		String diffEqpmnDtlSnStr = "";

		for (ZValue vo : list) {

			eqpmnDtlSnStr = vo.getString("eqpmnDetailSnList","");
			int num = 0;
			for (ZValue dtVo : listByDt) {
				if (vo.getString("eqpmnSn").equals(dtVo.getString("eqpmnSn"))) {
					num++;
					int remndrQy = vo.getInt("eqpmnQy",0) - dtVo.getInt("eqpmnQy",0);
					vo.put("remndrQy", remndrQy);

					diffEqpmnDtlSnStr = dtVo.getString("eqpmnDetailSnList","");
					String tempSnStr = "";

					if (!"".equals(eqpmnDtlSnStr) && !"".equals(diffEqpmnDtlSnStr)) {
						for (String dtlSn : eqpmnDtlSnStr.split(",")) {
							boolean snFlag = false;
							for (String diffDtlSn : diffEqpmnDtlSnStr.split(",")) {
								if (dtlSn.equals(diffDtlSn)) {
									snFlag = true;
									break;
								}
							}
							if (!snFlag) {
								if (tempSnStr.length() == 0 ) tempSnStr = dtlSn;
								else tempSnStr  += ","+dtlSn;
							}
						}
						vo.put("eqpmnDetailSnStr", tempSnStr);

					}
					else vo.put("eqpmnDetailSnStr", eqpmnDtlSnStr);
					break;
				}
			}
			if (num ==0) {
				vo.put("remndrQy", vo.getString("eqpmnQy"));
				vo.put("eqpmnDetailSnStr", eqpmnDtlSnStr);
			}
			/*
			for (ZValue resVo : listByResve) {
				if (vo.getString("eqpmnSn").equals(resVo.getString("eqpmnSn"))) {
					vo.put("inputEqpmnQy", resVo.getInt("eqpmnQy",0));
					break;
				}
			}
			*/
			resultList.add(vo);

		}

		model.addAttribute("list", resultList);

	}

	/**
	 * 예약현황 엑셀  목록 다운로드  (관리자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
    	ModelMap model = paramCtx.getModel();
    	ZValue param = paramCtx.getParam();
    	/*
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
		*/
		String[] titles = {"예약번호","내/외부구분","지역구분","위치구분","시설구분","공간명","공간명(영문)","장비","예약자명","예약일자","예약시간","예약상태","휴대폰번호","이메일","나이","직업","거주지","사용인원","예약수신방법","사용목적구분","사용목적","사용여부","시스템등록일"};


		List<ZValue> resultList = sqlDao.listDAO("HkFcltyResveDAO.listExcelResveSttus", param);
		List<ZValue> tmpList = new ArrayList<ZValue>();
		for (ZValue tmpVO : resultList) {
			tmpVO.put("usePurposeCn", StringUtil.unescapeHtml(tmpVO.getString("usePurposeCn")));
			tmpList.add(tmpVO);
		}


		ExcelGenerateVO vo = new ExcelGenerateVO("예약현황 목록", titles, resultList);
		model.addAttribute("excel", vo);

	}

	/**
	 * 예약현황 신청 step0 (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void step0(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());

		/*int resveCnt = sqlDao.selectCount("HkFcltyResveDAO.listUserReseveCount", param);*/
		int penaltyCnt = sqlDao.selectCount("HkFcltyResveDAO.listUserPenaltyCount", param);

		/*if (resveCnt >= 5) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "1일 최대 5회 예약 가능 횟수를 초과하였습니다.");
			return;
		}
		else*/ if (penaltyCnt >= 2) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "오늘날짜 기준으로 90일동안 미사용이 2회일 경우, 최종 미사용일로 부터 30일간 예약 불가합니다.");
			return;
		}
		return;
	}

	/**
	 * 예약현황 신청 step1 (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void step1(ParameterContext<ZValue> paramCtx) throws Exception {
		return;
	}

	/**
	 * 예약현황 신청 step2 (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void step2(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());
		/*int resveCnt = sqlDao.selectCount("HkFcltyResveDAO.listUserReseveCount", param);*/
		int penaltyCnt = sqlDao.selectCount("HkFcltyResveDAO.listUserPenaltyCount", param);

		/*if (resveCnt >= 5) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "1일 최대5회 예약 가능 횟수를 초과하였습니다.");
			return;
		}
		else*/ if (penaltyCnt >= 2) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "오늘날짜 기준으로 90일동안 미사용이 2회일 경우, 최종 미사용일로 부터 30일간 예약 불가합니다.");
			return;
		}

		SimpleDateFormat yearSf = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthSf = new SimpleDateFormat("MM");
		Calendar cal = Calendar.getInstance();
		String todayYY = yearSf.format(cal.getTime());
		String todayMM = monthSf.format(cal.getTime());
		model.addAttribute("todayYY", todayYY);
		model.addAttribute("todayMM", todayMM);

		if (!"".equals(param.getString("fcltySn",""))) {
			ZValue fcltyVO = sqlDao.selectDAO("HkFcltyResveDAO.viewFclty", param);
			param.put("areaSe", fcltyVO.getString("areaSe"));
			param.put("lcSe", fcltyVO.getString("lcSe"));
			param.put("fcltySe", fcltyVO.getString("fcltySe"));
			param.put("spceNm", fcltyVO.getString("spceNm"));
		}


		super.forInsert(paramCtx);

		if (session.getAttribute("resultStep1") != null) {
			if (!"prev".equals(param.getString("locationTp"))) session.removeAttribute("resultStep1");
			model.addAttribute("result", session.getAttribute("resultStep1"));
		}
		else {
			if (!"".equals(param.getString("resveSn"))) {
				ZValue resultData = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
				List<ZValue> eqpmnList = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByResve", param);
				resultData.putObject("eqpmnList",eqpmnList);
				model.addAttribute("result", resultData);
			}
		}
	}

	/**
	 * 예약현황 신청 step3 (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void step3(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		String areaSe = param.getString("areaSe");
		String lcSe = param.getString("lcSe");
		String fcltySe = param.getString("fcltySe");
		String spceNm = param.getString("spceNm");

		String resveSn = param.getString("resveSn");
		String fcltySn = param.getString("fcltySn");
		String resveDt = param.getString("resveDt");
		String resveBeginTime = param.getString("resveBeginTime");
		String resveEndTime = param.getString("resveEndTime");
		String resveSttus = param.getString("resveSttus");
		String eqpmnsStr = param.getString("eqpmnsStr");
		String eqpnmUseYn = param.getString("eqpnmUseYn","Y");
		String vwSpceAllNm = param.getString("vwSpceAllNm");

		List<ZValue> eqpmnList = super.getJsonConvertZValueList(eqpmnsStr);

		ZValue resultData = new ZValue();
		resultData.put("areaSe", areaSe);
		resultData.put("lcSe", lcSe);
		resultData.put("fcltySe", fcltySe);
		resultData.put("spceNm", spceNm);

		resultData.put("resveSn", resveSn);
		resultData.put("fcltySn", fcltySn);
		resultData.put("resveDt", resveDt);
		resultData.put("resveBeginTime", resveBeginTime);
		resultData.put("resveEndTime", resveEndTime);
		resultData.put("diffTime", (Integer.parseInt(resveEndTime) - Integer.parseInt(resveBeginTime)+1));
		resultData.put("resveSttus", resveSttus);
		resultData.put("vwSpceAllNm",vwSpceAllNm);
		resultData.putObject("eqpmnList",eqpmnList);
		resultData.putObject("eqpnmUseYn",eqpnmUseYn);

		resultData.put("resveNm", user.getUserNm());
		resultData.put("userSn", user.getUserIdx());
		resultData.put("mbtlnum", user.getMoblphon());
		resultData.put("email", user.getEmail());
		
		param.put("userSn", user.getUserIdx());
		param.put("resveDtCnt", "Y");
		int resve_Dt_Cnt = sqlDao.selectCount("HkFcltyResveDAO.listUserReseveCount", param);
		
		if (resve_Dt_Cnt >= 5) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "1일 최대 5회 예약 가능 횟수를 초과하였습니다.");
			return;
		}
		
		param.put("resveDtCnt", "N");
		int today_resveCnt = sqlDao.selectCount("HkFcltyResveDAO.listUserReseveCount", param);

		if (today_resveCnt >= 5) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "1일 최대 5회 예약 가능 횟수를 초과하였습니다.");
			return;
		}

		session.setAttribute("resultStep1", resultData);
		if (!"".equals(param.getString("resveSn"))) {
			ZValue viewVO = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
			resultData.putAll(viewVO);
		}


		model.addAttribute("result", resultData);
	}

	/**
	 * 예약현황 신청 step4 (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void step4(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		initCmmnParam(param);
		param.put("userSn", user.getUserIdx());

		ZValue result = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
		List<ZValue> eqpmnList = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnByResve", param);
		result.putObject("eqpmnList",eqpmnList);
		model.addAttribute("result", result);
	}

	/**
	 * 예약현황 저장처리  (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void stepSave(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		initCmmnParam(param);

		ZValue resultData = session.getAttribute("resultStep1") == null ? null : (ZValue)session.getAttribute("resultStep1");
		resultData.putAll(param);

		Object pkValue = null;

		if (!"".equals(param.getString("resveSn"))) {
			sqlDao.updateDAO("HkFcltyResveDAO.updateResve", resultData);
			sqlDao.deleteDAO("HkFcltyResveDAO.deleteResveEqpmnByResveSn", param);
		}
		else {
			String resveNo =  RandomStringUtils.random(5, "abcdefghijklmnopqrstuvwxyz1234567890");
			resultData.put("resveNo", resveNo);
			pkValue = sqlDao.insertDAO("HkFcltyResveDAO.insertResve", resultData);
			param.put("resveSn", pkValue);
		}

		List<ZValue> eqpmnList = resultData.get("eqpmnList") != null ? (List<ZValue>)resultData.get("eqpmnList") : null;

		if (eqpmnList != null) {
			for (ZValue eqpmnVO : eqpmnList) {
				String eqpmnDetailSnStr = eqpmnVO.getString("eqpmnDetailSnStr");
				String[] eqpmnDetailSns = null;
				if (!"".equals(eqpmnDetailSnStr)) {
					eqpmnDetailSns = eqpmnDetailSnStr.split(",");
					for (String eqpmnDetailSn : eqpmnDetailSns) {
						resultData.put("eqpmnDetailSn", eqpmnDetailSn);
						sqlDao.insertDAO("HkFcltyResveDAO.insertResveEqpmn", resultData);
					}
				}
			}
		}


		ZValue vo = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
		String sendTp = vo.getString("resveRecptnSe");
		if ("01".equals(sendTp) || "03".equals(sendTp)) { //sms
			String mbtlnum = vo.getString("mbtlnum","").replaceAll("-", "");
			if (!"".equals(mbtlnum)) {
				String msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 예약이 " + "신청되었습니다.";
				if ("03".equals(vo.getString("resveSttus"))) {
					msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 대기예약이 " + "신청되었습니다.";
				}

				String callback = EgovProperties.getProperty("Globals.sms.edu.fcltyresve.callback");
				param.put("phone", mbtlnum);
		    	param.put("callback", callback);
		    	param.put("msg", msg);

		    	param.put("refkey", "accademy");
				emsService.sndngSms(param);
			}
		}
		
		String callback = EgovProperties.getProperty("Globals.sms.edu.fcltyresve.callback");
		String call = EgovProperties.getProperty("Globals.sms.edu.fcltyresve.admin.call");
		String msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt")+"," +vo.getString("resveNm") +" 예약  ";
		param.put("phone", call);
    	param.put("callback", callback);
    	param.put("msg", msg);

    	param.put("refkey", "accademy");
		emsService.sndngSms(param);
		
		if ("02".equals(sendTp) || "03".equals(sendTp)) { //email
			if (!"".equals(vo.getString("email",""))) {
				String title = "[EDUKOCCA]시설예약이 신청되었습니다.";
		    	String email = vo.getString("email");
		    	String content = null;
		    	StringBuffer contSb = new StringBuffer();
		    	contSb.append("<h2 style=\"font-size:30px;font-weight:600\">시설예약 신청정보</h2>");
		    	contSb.append("<p style=\"font-size:14px;padding-top:10px\">안녕하세요. <strong>").append( vo.getString("resveNm") ).append("</strong>님! 한국콘텐츠아카데미랩 고객님의 예약정보 입니다.<p>");
		        contSb.append("<ul>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약번호</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveNo") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약일시</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveDt") ).append(" ").append(vo.getString("resveBeginTime")).append(":00 ~ ").append(vo.getString("resveEndTime")).append( ":59 까지</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>공간명</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("spceNm") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약상태</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveSttusNm") ).append( "</span></li><br/>");
		        contSb.append("</ul>");

		        content = contSb.toString();

				param.put("title", title);
				param.put("email", email);
				param.put("name", vo.getString("resveNm"));
				param.put("content", content);

				emsService.sndngEmail(param);
			}
		}


		StringBuilder url = new StringBuilder("/"+param.getString("siteName")+"/hkFcltyResve/resveSttus/step4.do");
		url.append("?resveSn=").append(param.getString("resveSn")).append("&menuNo=").append(param.getString("menuNo"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

	}

	/**
	 * 예약현황 마이페이지  (사용자)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listMypage(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new ResveSttusPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();

		Calendar endCal = (Calendar)cal.clone();
		endCal.add(Calendar.MONTH, 1);


		if ("".equals(param.getString("resveStDt",""))) param.put("resveStDt",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdDt",""))) param.put("resveEdDt",sf.format(endCal.getTime()));

		param.put("myPageTp", "Y");
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());
		super.setCountQueryId("HkFcltyResveDAO.listResveSttusCnt");
		super.setListQueryId("HkFcltyResveDAO.listResveSttus");
		super.list(paramCtx);

		model = paramCtx.getModel();
		param = paramCtx.getParam();
		int resultCnt = (Integer)model.get("resultCnt");
		int totalPage = (resultCnt - 1) / param.getInt("pageUnit",1) + 1;
		model.addAttribute("totalPage", totalPage);


		List<ZValue> listEqpmnNm = sqlDao.listDAO("HkFcltyResveDAO.listEqpmnNm", param);
		model.addAttribute("listEqpmnNm",listEqpmnNm);

	}


	/**
	 * 예약상태 변경처리  (사용자 예약취소)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void cancelResveSttus(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());
		param.put("resveSttus", "05");
		sqlDao.updateDAO("HkFcltyResveDAO.updateResveSttus", param);
		ZValue vo = sqlDao.selectDAO("HkFcltyResveDAO.viewResveSttus", param);
		String sendTp = vo.getString("resveRecptnSe");
		if ("01".equals(sendTp) || "03".equals(sendTp)) { //sms
			String mbtlnum = vo.getString("mbtlnum","").replaceAll("-", "");
			if (!"".equals(mbtlnum)) {
				String msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 예약이 " + "취소되었습니다.";
				if ("03".equals(vo.getString("resveSttus"))) {
					msg = "["+vo.getString("resveNo")+"]"+ vo.getString("spceNm")+ "," + vo.getString("resveDt") +" 대기예약이 " + "취소되었습니다.";
				}
				String callback = EgovProperties.getProperty("Globals.sms.edu.fcltyresve.callback");
				param.put("phone", mbtlnum);
		    	param.put("callback", callback);
		    	param.put("msg", msg);

		    	param.put("refkey", "accademy");
				emsService.sndngSms(param);
			}
		}
		if ("02".equals(sendTp) || "03".equals(sendTp)) { //email
			if (!"".equals(vo.getString("email",""))) {
				String title = "[EDUKOCCA]시설예약상태가 변경되었습니다.";
		    	String email = vo.getString("email");
		    	String content = null;
		    	StringBuffer contSb = new StringBuffer();
		    	contSb.append("<h2 style=\"font-size:30px;font-weight:600\">시설예약 변경정보</h2>");
		    	contSb.append("<p style=\"font-size:14px;padding-top:10px\">안녕하세요. <strong>").append( vo.getString("resveNm") ).append("</strong>님! EDUKOCCA 고객님의 예약정보 입니다.<p>");
		        contSb.append("<ul>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약번호</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveNo") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약일시</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveDt") ).append(" ").append(vo.getString("resveBeginTime")).append(":00 ~ ").append(vo.getString("resveEndTime")).append( ":59 까지</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>공간명</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("spceNm") ).append( "</span></li><br/>");
		        contSb.append("<li style=\"line-height:30px\"><strong>예약상태</strong> :&nbsp; <span style=\"color:#5c82e8;\">").append( vo.getString("resveSttusNm") ).append( "</span></li><br/>");
		        contSb.append("</ul>");

		        content = contSb.toString();

				param.put("title", title);
				param.put("email", email);
				param.put("name", vo.getString("resveNm"));
				param.put("content", content);

				emsService.sndngEmail(param);
			}
		}

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 관리자 코멘트 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void saveCmmnt(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		sqlDao.updateDAO("HkFcltyResveDAO.updateResveCmmnt", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	/**
	 * 사용여부변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void chgResveSn(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		String[] resveSn_arr = ((String)param.get("resveSn")).split(",");
		
		for(String resveSn : resveSn_arr){
			param.put("resveSn", resveSn);
			sqlDao.updateDAO("HkFcltyResveDAO.chgResveSn", param);
		}

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
}
