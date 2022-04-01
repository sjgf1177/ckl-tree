package kr.co.edu.hkCultureResve.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.util.StringUtil;
import kr.co.unp.util.ZValue;


public class CultureStatsService  extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());


	public CultureStatsService() {

	}

	/**
	 * 시설예약(시설/공간) 통계
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsFclty(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsFclty", param);
		model.addAttribute("resultList",list);
	}


	/**
	 * 시설예약(시설/공간) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsFclty(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		String[] titles = {"지역","위치","시설구분","공간명","승인대기","승인완료","승인불가","대기예약","예약취소","예약상태(합계)","사용","미사용","대기","사용여부(합계)"};


		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsFclty", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(시설/공간) 통계", titles, list);
		model.addAttribute("excel", vo);

	}


	/**
	 * 시설예약(장비) 통계
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsEqpmn(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsEqpmn", param);
		model.addAttribute("resultList",list);

		//장비목록
		List<ZValue> listEqpmnNm = sqlDao.listDAO("HkCultureResveDAO.listEqpmnNm", param);
		model.addAttribute("listEqpmnNm",listEqpmnNm);
	}


	/**
	 * 시설예약(장비) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsEqpmn(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		String[] titles = {"장비구분","승인대기","승인완료","승인불가","대기예약","예약취소","예약상태(합계)","사용","미사용","대기","사용여부(합계)"};


		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsEqpmn", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(장비) 통계", titles, list);
		model.addAttribute("excel", vo);

	}

	/**
	 * 시설예약(사용목적) 통계
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsUsePurps(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsUsePurps", param);
		model.addAttribute("resultList",list);
	}


	/**
	 * 시설예약(사용목적) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsUsePurps(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		String[] titles = {"지역","위치","시설구분","공간명","사용목적\n(행사)","사용목적\n(창작회의)","사용목적\n(창작활동)","사용목적\n(시설대관)","사용목적\n(기타)","사용목적구분\n(합계)"};


		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsUsePurps", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(사용목적) 통계", titles, list);
		model.addAttribute("excel", vo);

	}


	/**
	 * 시설예약(열린공간 방문) 통계
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsVisit(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsVisit", param);
		model.addAttribute("resultList",list);
	}

	/**
	 * 시설예약(열린공간 방문) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsVisit(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));

		String[] titles = {"공간","계"};


		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsVisit", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(열린공간 방문) 통계", titles, list);
		model.addAttribute("excel", vo);

	}


	/**
	 * 시설예약(원시데이터) 통계화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsOriData(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));
	}

	/**
	 * 시설예약(원시데이터) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsOriData(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		String[] titles = {"년월","일자","시설구분","사용목적구분","세부장소","예약자","인원","사용시간","이용목적"};

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsOriData", param);
		List<ZValue> resultList = new ArrayList<ZValue>();
		for (ZValue result : list) {
			result.put("usePurposeCn", StringUtil.unescapeHtml(result.getString("usePurposeCn")));
			resultList.add(result);
		}

		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(원시데이터) 통계", titles, list);
		model.addAttribute("excel", vo);
	}


	/**
	 * 시설예약(시설이용목적별) 통계화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsUsePurpsByMonth(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));
	}

	/**
	 * 시설예약(시설이용목적별 현황) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStatsUsePurpsByMonth(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		String[] titles = {"년월","행사","창작회의","창작활동","시설대관","기타","총계"};

		List<ZValue> list = sqlDao.listDAO("HkCultureResveDAO.listStatsUsePurpsByMonth", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(시설이용목적별 현황) 통계", titles, list);
		model.addAttribute("excel", vo);
	}



	/**
	 * 시설예약(시설별 이용현황) 통계화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void statsFcltyByMonth(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");
		Calendar cal = Calendar.getInstance();
		if ("".equals(param.getString("resveSdate",""))) param.put("resveSdate",sf.format(cal.getTime()));
		if ("".equals(param.getString("resveEdate",""))) param.put("resveEdate",sf.format(cal.getTime()));
	}

	/**
	 * 시설예약(시설별 이용현황) 통계 엑셀다운로드
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public void downloadExcelStatsFcltyByMonth(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		List<String> titList = new ArrayList<String>();
		List<ZValue> titVoList = sqlDao.listDAO("HkCultureResveDAO.listFcltyTitle", param);
		titList.add("");
		for (ZValue titVO : titVoList) {
			titList.add(titVO.getString("spceNm"));
		}

		String[] titles = new String[titList.size()];
		titles =  titList.toArray(titles);

		List<ZValue> tmpList = sqlDao.listDAO("HkCultureResveDAO.listStatsFcltyByMonth", param);
		List<ZValue> dateList = new ArrayList<ZValue>();
		String tmpKeyStr = "";
		int countNo = 0;
		ZValue tmpVO = new ZValue();
		for (ZValue itemVO : tmpList) {
			if (!tmpKeyStr.equals(itemVO.getString("resveYyyymm"))) {
				tmpKeyStr = itemVO.getString("resveYyyymm");
				if (tmpVO.size() > 0) {
					dateList.add(tmpVO);
				}
				tmpVO = new ZValue();
				tmpVO.put("resveDate" ,itemVO.getString("resveYyyymm"));
				tmpVO.put((itemVO.getString("lcSe")+"@"+itemVO.getString("fcltySn")) ,itemVO.getInt("useNmpr"));
			}
			else {
				tmpVO.put((itemVO.getString("lcSe")+"@"+itemVO.getString("fcltySn")) ,itemVO.getInt("useNmpr"));
			}
			if (tmpList.size() ==  (countNo+1)) {
				dateList.add(tmpVO);
			}
			countNo++;
		}

		List<ZValue> resultList = new ArrayList<ZValue>();
		int n = 0;
		Integer[] lcSum = new Integer[titVoList.size()];
		for (Integer i : lcSum) {
			lcSum[n] = 0;
			n++;
		}
		n = 0;

		for (ZValue dateVO : dateList) {
			ZValue vo = new ZValue();
			vo.put("resveDate", dateVO.getString("resveDate","총합계"));
			int j = 0;
			for (ZValue tvo : titVoList) {
				vo.put(tvo.getString("lcSe")+"@"+tvo.getString("fcltySn"), "");
				if (dateVO.containsKey(tvo.getString("lcSe")+"@"+tvo.getString("fcltySn"))) {
					int num = dateVO.getInt(tvo.getString("lcSe")+"@"+tvo.getString("fcltySn"),0);
					lcSum[j] = lcSum[j].intValue() + num;
				}
				j++;
			}
			vo.putAll(dateVO);
			if (n == dateList.size()-1) {
				j = 0;
				for (ZValue tvo : titVoList) {
					if (j < titVoList.size()-1) vo.put(tvo.getString("lcSe")+"@"+tvo.getString("fcltySn"), lcSum[j]);
					j++;
				}
			}
			resultList.add(vo);
			n++;
		}
		ExcelGenerateVO vo = new ExcelGenerateVO("문화광장 시설예약(시설별 이용현황) 통계", titles, resultList);
		model.addAttribute("excel", vo);
	}


}
