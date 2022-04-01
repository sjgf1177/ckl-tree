package kr.co.testbed.concert.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

/**
 * 채용 공고
 */
public class ConcertReservService  extends DefaultCmmProgramService  {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			ZValue concertReservStatus = sqlDao.selectDAO("concertDAO.selectConcertReservStatus", param);
			model.addAttribute("concertReservStatus", concertReservStatus); //공연정보
			
			super.setCountQueryId("concertDAO.selectConcertReservListCnt");
			super.setListQueryId("concertDAO.selectConcertReservList");
			super.list(paramCtx);
		}
	}
	
	/**
	 * 운영통계 엑셀 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void reservExcelDownload(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"예약번호", "아이디", "이름", "연락처", "좌석", "예약구분", "참석"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("concertDAO.selectConcertReservExcelList", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("콘텐츠문화광장 예약명단_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}
	
	public void viewTempReservMember(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			
			model.addAttribute("resultList", sqlDao.listDAO("concertDAO.selectConcertTempReservList", param));
			model.addAttribute("resultListCnt", sqlDao.selectDAO("concertDAO.selectConcertTempReservListCnt", param));
			
		}
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue reservMasterInfo = sqlDao.selectDAO("concertDAO.selectReservMasterInfo", param);
		model.addAttribute("reservMasterInfo", reservMasterInfo );
		
		super.setViewQueryId("concertDAO.selectConcertReservDetail");
		super.view(paramCtx);
	}
	
	
	
	
	// 예약 상세 리스트 반환 ( 프린트용 )
	public void getMasterInfoList( ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<String> masterCodeList = param.getList("checkMasterCodeList[]");
		ZValue p = new ZValue();
		List<ZValue> resultList = new ArrayList<ZValue>();
		
		for (String masterCode : masterCodeList) {
			p.put( "reservMasterCode", masterCode );
			ZValue result = sqlDao.selectDAO("concertDAO.selectReservMasterInfo", p);
			resultList.add(result);
		}
		
		model.addAttribute("resultList",resultList);
		
	}
	
	
	
	// 예약 통계
	public void statistic( ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		
		super.setCountQueryId("concertDAO.selectStatsListCnt");
		super.setListQueryId("concertDAO.selectStatsList");
		super.list(paramCtx);
		
		
		/*ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		

		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
		model.addAttribute("prgSeCodeList", codeList("COM050"));*/
	}
	
	
	/*	
	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"구분", "분류", "프로그램명", "신청방식", "신청기간", "교육기간", "진행상태", "담당부서", "사용여부", "정원", "사이트구분"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("progrmMasterDAO.listExcel", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("프로그램 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}
 	*/
	/**
	 * 운영통계 엑셀 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void downloadExcelStats(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"공연명", "공연일", "회차", "총좌석", "온라인예약", "전화예약", "현장예약", "남은좌석", "예매율", "남", "여", "10대", "20대", "30대", "40대", "50대", "60대이상"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("concertDAO.selectExcelStatsList", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("콘텐츠문화광장 예약 통계 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}
	
	

	// 등록
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		// 1 기본 정보
		ZValue concertInfo = sqlDao.selectDAO("concertDAO.selectConcertDetail", param);
		model.addAttribute("concertInfo", concertInfo );
		
		super.forInsert(paramCtx);
	}
	
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		

		String sitListStr = param.getString("sitIdList");
		String[] sitList = sitListStr.split(",");
		param.put("sitListCollection", sitList);
		int sitDuplicateCnt = sqlDao.selectCount("concertDAO.selectDuplicateSitCnt", param );
		
		if( sitDuplicateCnt > 0 ){
			MVUtils.goUrl("javascript:history.back()", "선택하신 좌석의 예매내역이 존재합니다. 좌석을 다시 선택해주세요.", model);
			return;
		}
		

		ZValue masterCode = sqlDao.selectDAO("concertDAO.getReservMasterCode", param );
		long reservMasterCode = masterCode.getLong("reservMasterCode");
		
		sqlDao.insertDAO("concertDAO.insertConcertReserv", param );
		

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
		
		String goUrl = "/bos/concert/reserv/list.do?concertId="+param.getString("concertId")+"&concertTimeId="+param.getString("concertTimeId")+"&"+ StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		MVUtils.goUrl(goUrl, "정상적으로 등록되었습니다.", model);
	}
	
	// 수정
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue concertInfo = sqlDao.selectDAO("concertDAO.selectConcertDetail", param);
		model.addAttribute("concertInfo", concertInfo );
		
		super.setViewQueryId("concertDAO.selectConcertReservDetail");
		super.forUpdate(paramCtx);
	}
	
	
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		
		String sitListStr = param.getString("sitIdList");
		String[] sitList = sitListStr.split(",");
		param.put("sitListCollection", sitList);
		int sitDuplicateCnt = sqlDao.selectCount("concertDAO.selectDuplicateSitCnt", param );
		
		if( sitDuplicateCnt > 0 ){
			MVUtils.goUrl("javascript:history.back()", "선택하신 좌석의 예매내역이 존재합니다. 좌석을 다시 선택해주세요.", model);
			return;
		}
		
		
		// 기존 좌석을 삭제하고, 
		sqlDao.deleteDAO("concertDAO.deleteSitInfo", param);
		
		long reservMasterCode = param.getLong("reservMasterCode");
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
		
		
		super.setUpdateQueryId("concertDAO.updateConcertReserv");
		super.update(paramCtx);
		
		
		String goUrl = "/bos/concert/reserv/list.do?concertId="+param.getString("concertId")+"&concertTimeId="+param.getString("concertTimeId")+"&"+ StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, goUrl );
		
	}
	//참석여부 변경
	public void changeSelectedStatus(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		String idList[] = param.getString("reservCodeList").split(",");
		for ( int i=0; i<idList.length; i++ )
			if ( !"".equals(idList[i]) ){
				param.set("reservMasterCode", idList[i]);
				paramCtx.setParam(param);
				changeJoinStatus(paramCtx);
			}//if
		
		String goUrl = "/bos/concert/reserv/list.do?concertId="+param.getString("concertId")+"&concertTimeId="+param.getString("concertTimeId")+"&"+ StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		MVUtils.goUrl(goUrl, "정상적으로 변경되었습니다.", model);
	}
	public void changeJoinStatus(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setUpdateQueryId("concertDAO.updateConcertReservStatus");
		super.update(paramCtx);
	}
	
	//  예약상태 변경
	public void changeReservStatus(ParameterContext<ZValue> paramCtx) throws Exception {
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		String statusType = param.getString("statusType");
		int status = param.getInt("status");
		
		// 예약 취소를 호출하였으므로..
		if( statusType != null && statusType.equals("reserv") && status == 0 ){

			// 기존 좌석을 삭제, 
			sqlDao.deleteDAO("concertDAO.deleteSitInfo", param);
		}
		
		super.setUpdateQueryId("concertDAO.updateConcertReservStatus");
		super.update(paramCtx);
		
		String goUrl = "/bos/concert/reserv/list.do?concertId="+param.getString("concertId")+"&concertTimeId="+param.getString("concertTimeId")+"&"+ StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&");
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, goUrl );
	}
	
	
	// 삭제
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
//		param.put("compAuth", "N");
		super.setDeleteQueryId("concertDAO.deleteConcertReserv");
		super.delete(paramCtx);
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
	

}
