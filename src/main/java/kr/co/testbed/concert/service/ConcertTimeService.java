package kr.co.testbed.concert.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

/**
 * 채용 공고
 */
public class ConcertTimeService  extends DefaultCmmProgramService  {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){

			super.setCountQueryId("concertDAO.selectConcertTimeListCnt");
			if ("".equals(param.getString("pageUnit",""))) 
				param.put("pageUnit", "10");
			if ("".equals(param.getString("pageSize",""))) 
				param.put("pageSize", "10");
			//param.put("pageSize", "3");
			ZValue concertResult = sqlDao.selectDAO("concertDAO.selectConcertDetail", param);
			model.addAttribute("concertResult", concertResult); //공연정보
			
			super.setCountQueryId("concertDAO.selectConcertTimeListCnt");
			super.setListQueryId("concertDAO.selectConcertTimeList");
			super.list(paramCtx);
		}
	}

	// 공연일정등록 팝업
	public void addTimePopup(ParameterContext<ZValue> paramCtx) throws Exception { 
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		model.addAttribute("result",param);
	}
	// 등록
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		
		//super.setInsertQueryId("memberDAO.selectConcertUserMembers");
		super.forInsert(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("concertDAO.insertConcertTime");

		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			
			String startDt = param.getString("startDt");
			String endDt = param.getString("endDt");
			if ( "".equals(endDt) ){ // 반복이 없는 경우
				super.insert( paramCtx );
				return ;
			}
			// 반복 요일 리스트
			String repeatDays = param.getString("repeatDays");
			String [] strRepeatList = repeatDays.split(",");
			int[] repeatList = new int[strRepeatList.length];
			for ( int r=0; r<repeatList.length; r++ )
				repeatList[r] = Integer.parseInt( strRepeatList[r] );
			// 요일에 해당되는 날짜 입력
			Calendar dtTmp = Calendar.getInstance();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			dtTmp.setTime(transFormat.parse(startDt));
			long diffDt = diffOfDate( startDt, endDt );
			String startTm = param.getString("startTime").split(" ")[1];// 시간 저장
			String endTm = param.getString("endTime").split(" ")[1];
			if ( diffDt == 0 ){ // 시작일, 종료일이 같을 경우
				super.insert( paramCtx );
				return ;
			}
			for ( int d = 0; d<=diffDt; d++ ){// 시작일, 종료일이 다를 경우
				for ( int r=0; r<repeatList.length; r++ )
					if ( dtTmp.get(Calendar.DAY_OF_WEEK) == repeatList[r] ){
						param.set("startTime", transFormat.format(dtTmp.getTime())+" "+startTm );
						param.set("endTime", transFormat.format(dtTmp.getTime())+" "+endTm);
						super.insert( paramCtx );
					}//if
//				System.out.println("++++++++++++++++++++dtTmp "+dtTmp.getTime().toString()+"++++++++++++++++++++");
				dtTmp.add(Calendar.DATE, 1);
			}//outer for
			
		}
	}
	public static long diffOfDate(String begin, String end) throws Exception// 날짜차이 구하기
	{
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	 
	    Date beginDate = formatter.parse(begin);
	    Date endDate = formatter.parse(end);
	 
	    long diff = endDate.getTime() - beginDate.getTime();
	    long diffDays = diff / (24 * 60 * 60 * 1000);
	 
	    return diffDays;
	}
	
	// 수정
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("concertDAO.selectConcertTimeDetail");
		super.forUpdate(paramCtx);
	}
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		//param.put("compAuth", "Y"); //입주기업 회원 등록
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			super.setUpdateQueryId("concertDAO.updateConcertTime");
			super.update(paramCtx);
		}
	}
	// 마감 처리 , 마감 풀기
	public void updateTimeOff(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		//param.put("compAuth", "Y"); //입주기업 회원 등록
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			super.setUpdateQueryId("concertDAO.updateConcertTimeOff");
			super.update(paramCtx);
		}
	}
	
	// 선택삭제
	public void deleteSelected(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		String idList[] = param.getString("timeIdList").split(",");
		for ( int i=0; i<idList.length; i++ )
			if ( !"".equals(idList[i]) ){
				param.set("concertTimeId", idList[i]);
				paramCtx.setParam(param);
				delete(paramCtx);
			}//if
		
		String goUrl = "/bos/concert/info/forUpdate.do?concertId="+param.getString("concertId");
		MVUtils.goUrl(goUrl, "정상적으로 삭제되었습니다.", model);
	}
	// 삭제
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
//		param.put("compAuth", "N");
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			super.setDeleteQueryId("concertDAO.deleteConcertTime");
			super.delete(paramCtx);
		}
	}
	/*
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("concertDAO.selectConcertTimeDetail");
		super.view(paramCtx);
	}

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

}


