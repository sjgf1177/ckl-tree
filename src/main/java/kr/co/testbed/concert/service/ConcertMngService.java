package kr.co.testbed.concert.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import com.ibm.icu.util.Calendar;
import com.siren24.Base64;

import egovframework.com.cmm.service.Globals;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.ems.service.EmsService;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;
import kr.co.unp.ems.service.EmsService;

/**
 * 채용 공고
 */
@Service("concertMngService")
public class ConcertMngService  extends DefaultCmmProgramService  {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "emsService")
	private EmsService emsService;
	
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){

			if ("".equals(param.getString("pageUnit",""))) 
				param.put("pageUnit", "10");
			if ("".equals(param.getString("pageSize",""))) 
				param.put("pageSize", "10");
//			param.put("pageSize", "3");
			//param.put("compAuth", "Y"); //입주기업 회원만

			super.setCountQueryId("concertDAO.selectConcertListCnt");
			super.setListQueryId("concertDAO.selectConcertList");
			super.list(paramCtx);
		}else{
			
			Calendar gCal = Calendar.getInstance();
			gCal.setTime(new Date());
			int cur_year = gCal.get(Calendar.YEAR);
			int cur_month = gCal.get(Calendar.MONTH)+1;

			// 검색년도가 없으면 현재 년도로 표시
			String yyyy = param.getString("selectedYear");
			if( StringUtils.hasText( yyyy ) == false ){
				param.put("selectedYear", cur_year );
			}
			
			
			// 검색월은 0 일경우 전체검색이므로, -1일 경우 현재 월로 표시.
			String mm = param.getString("selectedMonth");
			if( StringUtils.hasText( mm ) == true && mm.equals("-1") == true ){
				param.put("selectedMonth", cur_month );
			}
			
			if( StringUtils.hasText( mm ) == false && StringUtils.hasText(param.getString("listType") ) == false ){
				param.put("selectedMonth", cur_month );
				mm = String.valueOf( cur_month );
				param.put("listType", 2 );
			}
			
			
			if( param.getInt("listType") == 2 && StringUtils.hasText( mm ) == false ){
				
				super.setCountQueryId("concertDAO.selectConcertFrontMonthlyListCnt");
				super.setListQueryId("concertDAO.selectConcertFrontMonthlyList");
				
			}else{
				if ("".equals(param.getString("pageUnit",""))) 
					param.put("pageUnit", "9");
				if ("".equals(param.getString("pageSize",""))) 
					param.put("pageSize", "9");
				
				super.setCountQueryId("concertDAO.selectConcertFrontListCnt");
				super.setListQueryId("concertDAO.selectConcertFrontList");
			}
			super.list(paramCtx);
		}
	}


	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		// 1 기본 정보
		super.setViewQueryId("concertDAO.selectConcertDetail");
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("userSn", user.getUserIdx());
			param.put("concertTimeId", user.getUserIdx());
		}
		super.view(paramCtx);
		
		// 2 참여 가능한 회차가 존재하는지 여부
		int canReservTimeCnt = sqlDao.selectCount("concertDAO.getCntCanReservTime", param );
		model.addAttribute("canReservTimeCnt", canReservTimeCnt );
	}
 
	// 등록
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.forInsert(paramCtx);
	}
	
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
//		ModelMap model = paramCtx.getModel();
//		super.initCmmnParam(param);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("userId", user.getUserIdx());
		}
		paramCtx.setParam(param);
		/*
		System.out.println("++++++++++++++param"+param+"+++++++++++++");	
		System.out.println("++++++++++++++paramCtx"+paramCtx+"+++++++++++++");
		System.out.println("++++++++++++++paramCtx getUsersVO"+paramCtx.getParam()+"+++++++++++++");
		*/
//		super.initCmmnParam(param);

//		String goUrl = "/bos/concert/info/list.do?concertId="+param.getString("concertId")+"&concertTimeId="+param.getString("concertTimeId");
//		MVUtils.goUrl(goUrl, "정상적으로 변경되었습니다.", model);
		super.setInsertQueryId("concertDAO.insertConcert");
		super.insert( paramCtx );
	}
	
	// 수정
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		super.setViewQueryId("concertDAO.selectConcertDetail");
		List<ZValue> resultTime = sqlDao.listDAO("concertDAO.selectConcertTimeList", param );
		model.addAttribute("TimeList", resultTime);
		super.forUpdate(paramCtx);
	}
	
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.setUpdateQueryId("concertDAO.updateConcert");
		super.update(paramCtx);
	}
	
	// 삭제
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		
		super.setDeleteQueryId("concertDAO.deleteConcert");
		super.delete(paramCtx);
	}
	
	
	
	public void history( ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
//		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("userSn", user.getUserIdx());
		}
		
		if ("".equals(param.getString("pageUnit",""))) 
			param.put("pageUnit", "10");
		if ("".equals(param.getString("pageSize",""))) 
			param.put("pageSize", "10");
		
		
		// 일자별조회가 아닐경우 조회조건 및 시작일, 종료일을 모두 제거함.
		String searchType = param.getString("searchType");
		if( searchType != null && searchType.equals("datelySearch") == false ){
			param.remove("sdate");
			param.remove("edate");
			param.remove("searchCnd");
			
			if( param.get("periodSelectDate") == null ){
				param.put( "periodSelectDate", 3 );
			}
			
		}else{
			// 기간별 조회가 아닐 경우 선택일도 모두 제거함.
			param.remove("periodSelectDate");
		}

		paramCtx.setParam(param);
		super.setCountQueryId("concertDAO.selectReservHistoryCnt");
		super.setListQueryId("concertDAO.selectReservHistory");
		super.list(paramCtx);
	}
	
	
	
	public void historyview(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("concertDAO.selectReservMasterInfo");
		super.view(paramCtx);
	}
	
	public void getTimeListAtDate( ParameterContext<ZValue> paramCtx ) throws Exception{
		//Assert.hasText(param.getString("userId"));
		/*String userId = param.getString("userId").toLowerCase();
		param.put("userId", userId);
		int cnt = sqlDao.selectCount("memberDAO.checkDupID", param);
		model.addAttribute("idCnt", cnt);
		if( cnt == 0 ) {
			paramCtx.getRequest().getSession().setAttribute(USER_ID_KEY, userId);
		}*/
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());
		
		List<ZValue> list = sqlDao.listDAO("concertDAO.getTimeListAtDate", param);
		model.addAttribute("timeList",list);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
//		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");		
	}
	
	
	
	public void getSitData( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> reservedSitDataList = sqlDao.listDAO("concertDAO.getSitData", param);
		model.addAttribute("reservedSitDataList",reservedSitDataList);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	
	
	public void getConcertDate( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> concertDateList = sqlDao.listDAO("concertDAO.getConcertDate", param);
		model.addAttribute("concertDateList",concertDateList);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	
	
	
	public void getReservStatus( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue reservStatus = sqlDao.selectDAO("concertDAO.getReservStatus", param);
		model.addAttribute("reservStatus",reservStatus);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	
	
	public void saveReservData( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		String sitListStr = param.getString("sitList");
		String[] sitList = sitListStr.split(",");
		param.put("sitListCollection", sitList);
		int sitDuplicateCnt = sqlDao.selectCount("concertDAO.selectDuplicateSitCnt", param );
		
		if( sitDuplicateCnt > 0 ){
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "seatDuplicate" );
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.FAIL);
			return;
		}
		
		
		ZValue masterCode = sqlDao.selectDAO("concertDAO.getReservMasterCode", param );
		long reservMasterCode = masterCode.getLong("reservMasterCode");

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("reservMasterCode", reservMasterCode );
		param.put("userSn", user.getUserIdx() );
		param.put("memberTel", user.getMoblphon() );
		param.put("userId", user.getUserId() );
		param.put("memberName", user.getUserNm() );
		param.put("homeArea", user.getAddress() );
		param.put("job", user.getJobSe() );
		param.put("dept", user.getDeptNm() );
		param.put("sex", user.getSex() );
		param.put("memberEmail", user.getEmail() );
		param.put("birthday", user.getBrthdy() );
		
		sqlDao.insertDAO("concertDAO.insertReservData", param );
		
		
		
		
		int concertTimeId = param.getInt("concertTimeId");
		
		if( StringUtils.hasText(sitListStr) && sitList.length > 0 && ((String)sitList[0]).equals("") == false ){
			for (String sitId : sitList) {
				ZValue sitObject = new ZValue();
				sitObject.put( "sitId", sitId );
				sitObject.put( "concertTimeId", concertTimeId );
				sitObject.put( "reservMasterCode", reservMasterCode );
				
				sqlDao.insertDAO("concertDAO.insertReservSitData", sitObject );			
			}
		}else{
			int memberCnt = param.getInt("viewPeopleNum");
			for( int i = 0 ; i < memberCnt ; i++ ){
				ZValue sitObject = new ZValue();
				sitObject.put( "sitId", "" );
				sitObject.put( "concertTimeId", concertTimeId );
				sitObject.put( "reservMasterCode", reservMasterCode );
				
				sqlDao.insertDAO("concertDAO.insertReservSitData", sitObject );
			}
		}
		
		
		model.addAttribute("reservMasterCode", reservMasterCode );
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	
	
	public void saveTempReservData( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("memberTel", user.getMoblphon() );
		param.put("userId", user.getUserId() );
		param.put("memberName", user.getUserNm() );
		
		int tempReservCnt = sqlDao.selectCount("concertDAO.selectDuplicateTempReservCnt", param );
		
		if( tempReservCnt > 0 ){
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "tempReservDuplicate" );
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.FAIL);
			return;
		}
		
		sqlDao.insertDAO("concertDAO.insertReservTempData", param );
		
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "success"  );
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	
	
	public void cancelReservStatus( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		sqlDao.updateDAO("concertDAO.cancelReservStatus", param);
		sqlDao.deleteDAO("concertDAO.deleteSitInfo", param);
		
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	
	
	
	
	
	public void allCompleteSendMessage( ParameterContext<ZValue> paramCtx ) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		sqlDao.updateDAO("concertDAO.updateMessageAgreeStatus", param );
		
		// TODO :: 문자 및 메일 전송 필요함. ( rsg )
		if( param.getInt("agreeSms") == 1 ){ // 문자전송

			String siteNm = "콘텐츠문화광장";
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			String tranMsg = "["+siteNm+"] 예약완료. [아이디-"+user.getUserId()+"]";
			param.put("phone", param.getString("mbtlnum"));
			param.put("callback", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "02-2161-0000" : "02-6310-0770");
//			param.put("callback", "02-6310-0770");
			param.put("msg", tranMsg);
			//emsService.sndngSms(param);
		}
		
		if( param.getInt("agreeEmail") == 1 ){ // 메일전송
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			param.put("userId", user.getUserId());
			ZValue reservCon = sqlDao.selectDAO("concertDAO.selectConcertDetail", param);
			ZValue reservTime = sqlDao.selectDAO("concertDAO.selectTimeDetail", param);
			ZValue reservSit = sqlDao.selectDAO("concertDAO.selectConcertReservDetail", param);
//			ZValue concertUser = sqlDao.selectDAO("memberDAO.selectConcertUserMembers", param);//
//			String email = concertUser.getString("concertEmail");
//			if ( "".equals(email) || email == null )
//				email = user.getEmail();
				
			Date today = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
			StringBuffer contSb = new StringBuffer();
			contSb.append("<h2 style='font-size:30px;font-weight:600'>콘텐츠문화광장 <span style='color:#eb1c24'>예약완료</span></h2>");
			contSb.append("<p style='font-size:14px;padding-top:10px'><strong>"+user.getUserNm()+"</strong>님 안녕하세요?</p><p></p>");
			contSb.append("<p style='line-height:24px;font-size:14px;'>콘텐츠문화광장 예약을 이용해주셔서 진심으로 감사드립니다.<br/>");
			contSb.append("<strong>"+sdf.format(today)+"</strong> 예약이 정상적으로 이루어졌습니다.<br/>아래 예약내역을 확인해주세요.</p>");
			contSb.append("<p style='font-size:14px;padding-top:10px'>- 공연명 : "+reservCon.getString("concertTitle")+"<br/>");
			contSb.append("- 예약번호 : "+param.getString("reservMasterCode")+"<br/>");
			contSb.append("- 날짜 : "+param.getString("reservDate")+"<br/>");
			contSb.append("- 시간 : "+reservTime.getString("startTime").substring(0, 2)+"시"+reservTime.getString("startTime").substring(3, 5)+"분"+"<br/>");
			contSb.append("- 좌석 : "+reservSit.getString("sitIdList")+"<br/></p>");
			contSb.append("<p style='font-size:14px;padding-top:10px'><a href='https://edu.kocca.kr/testbed/concert/info/view.do?concertId="+reservCon.getInt("concertId")+"&menuNo=700130'>https://edu.kocca.kr/testbed/concert/info/view.do?concertId="+reservCon.getInt("concertId")+"&menuNo=700130</a></p>");
			contSb.append("<p style='font-size:14px;padding-top:10px'><img src='https://edu.kocca.kr/testbed/concert/info/createQrCode.do?content="+reservSit.getString("reservMasterCode")+"' alt='공연 예매 QRcode'></p>");
			
			param.put("siteName", SiteMngService.TESTBED_SITE_NAME );
			param.put("title", "[콘텐츠문화광장] 공연·행사 예약내역 확인");
			param.put("name", "콘텐츠문화광장");
			param.put("content", contSb.toString());
			param.put("email", user.getEmail() );
//			System.out.println("++++++++++++++++ param"+param+"+++++++++++++++++");
			emsService.sndngEmail(param);
//			System.out.println("++++++++++++++++ sndngEmail after param"+param+"+++++++++++++++++");
		}
		
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}
	
	/*

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("empmnPblanc.selectEmpmnPblanc");
		super.view(paramCtx);

		ModelMap model = paramCtx.getModel();
		List<FileVO> fileList = null;

		ZValue result = (ZValue)model.get("result");
		if (StringUtils.hasText(result.getString("atchFileIdSe"))) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(result.getString("atchFileIdSe"));
			fileList = fnwFileMngService.selectFileInfs(fileVO);
			model.addAttribute("fileList2", fileList);
		}
		model.put("resultJobNm1", result.getString("chrgJobNm"));
		model.put("resultJoBNm2", result.getString("chrgJob2Nm"));
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forInsert(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("empmnPblanc.selectEmpmnPblanc");
		super.forUpdate(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("empmnPblanc.insertEmpmnPblanc");
		super.insert(paramCtx);
	}
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setUpdateQueryId("empmnPblanc.updateEmpmnPblanc");
		super.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int pblancSn = param.getInt("pblancSn");
		initCmmnParam(param);
		if( pblancSn > 0 ){
			super.delete(paramCtx);
		}
		else{
			deleteAll(paramCtx);
		}
	}

	*//**
	 * 다중 삭제 채용공고
	 * @param paramCtx
	 * @throws Exception
	 *//*
	public void deleteAll(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> pblancSnData = param.getList("pblancSnData");
		Assert.notEmpty(pblancSnData);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		for(String pblancSn : pblancSnData){
			initCmmnParam(param);
			param.put("pblancSn", pblancSn);
			param.put("delcode", SearchVO.BOS_DELETION);
			sqlDao.deleteDAO("empmnPblanc.deleteEmpmnPblanc", param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}*/
	
	
	public void rentList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){

			if ("".equals(param.getString("pageUnit",""))) 
				param.put("pageUnit", "10");
			if ("".equals(param.getString("pageSize",""))) 
				param.put("pageSize", "10");
//			param.put("pageSize", "3");
			//param.put("compAuth", "Y"); //입주기업 회원만

			super.setCountQueryId("concertDAO.selectConcertListCnt");
			super.setListQueryId("concertDAO.selectConcertList");
			super.list(paramCtx);
		}else{
			
			Calendar gCal = Calendar.getInstance();
			gCal.setTime(new Date());
			int cur_year = gCal.get(Calendar.YEAR);
			int cur_month = gCal.get(Calendar.MONTH)+1;

			// 검색년도가 없으면 현재 년도로 표시
			String yyyy = param.getString("selectedYear");
			if( StringUtils.hasText( yyyy ) == false ){
				param.put("selectedYear", cur_year );
			}
			
			
			// 검색월은 0 일경우 전체검색이므로, -1일 경우 현재 월로 표시.
			String mm = param.getString("selectedMonth");
			if( StringUtils.hasText( mm ) == true && mm.equals("-1") == true ){
				param.put("selectedMonth", cur_month );
			}
			
			if( StringUtils.hasText( mm ) == false && StringUtils.hasText(param.getString("listType") ) == false ){
				param.put("selectedMonth", cur_month );
				mm = String.valueOf( cur_month );
				param.put("listType", 2 );
			}
			
			if( param.getInt("listType") == 2){
				super.setCountQueryId("concertDAO.selectConcertFrontMonthlyRentListCnt");
				super.setListQueryId("concertDAO.selectConcertFrontMonthlyRentList");
				
			}else{
				if ("".equals(param.getString("pageUnit",""))) 
					param.put("pageUnit", "10");
				if ("".equals(param.getString("pageSize",""))) 
					param.put("pageSize", "10");
				
				super.setCountQueryId("concertDAO.selectConcertFrontRentListCnt");
				super.setListQueryId("concertDAO.selectConcertFrontRentList");
				
				List<ZValue> rentDaysList = sqlDao.listDAO("concertDAO.selectConcertDaysList", param );
				model.addAttribute("rentDaysList", rentDaysList);
			}
			super.list(paramCtx);
		}
	}

}
