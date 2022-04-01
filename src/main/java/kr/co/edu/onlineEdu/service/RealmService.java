package kr.co.edu.onlineEdu.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.edu.onlineEdu.library.KISA_SEED_CBC;
import kr.co.edu.onlineEdu.paging.RealmPageInfo;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;


public class RealmService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public RealmService() {
		super();

	}
	
	public static int STEP = 1;
	public static int EXAM = 2;
	public static int REPORT = 4;
	public static int ACTIVITY = 8;
	public static int ETC = 16;
	public static int ALL = 32;
	public static int EXC = 77;
	

	/**
	 * 분야별 목록
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("upperclscd", "1000");	//분류별 목록을 불러오기 위한 코드 값 등록
		param.put("grcode", "N000001");		//교육그룹코드 임시 등록
		param.put("pageUnit", "12"); // 목록 갯수
		
		param.put("pGubun1", param.getString("pGubun1", param.getString("gubun", "A")));
		param.put("pGubun2", param.getString("pGubun2", param.getString("option1", "")));
		param.put("pGubun3", param.getString("pGubun3", param.getString("option5", "")));

		// 과정 ON/OFF 여부
		if(!param.getString("p_isonoff").equals("ON") && !param.getString("p_isonoff").equals("OFF")){
			param.setValue("p_isonoff", "");
		}		
		
		// 과정분류 존재여부
		int uClassNmCnt = lmsSqlDao.selectCount("realmListDAO.uClassNmCount", param);

		if (uClassNmCnt < 1) {
			param.setValue("p_uclassnm", "");
		}

		// 목록 갯수 숫자형 여부 체크
		String str = param.getString("pageUnit");
        boolean isNumeric =  str.matches("[+-]?\\d*(\\.\\d+)?");
        
        if(!isNumeric){
        	param.setValue("pageUnit", "");
        }
        
        // p_ordersnm, p_orders, pGubun2 빈 값으로 처리
        String strOnm = param.getString("p_ordersnm");
        String strG2 = param.getString("pGubun2");
        
        if(!strOnm.isEmpty()){
        	param.setValue("p_ordersnm", "");
        	param.setValue("p_orders", "");
        }
		
		// 목록 갯수 숫자형 여부 체크
		//String strPageIndex = param.getString("pageIndex");
        //isNumeric = strPageIndex.matches("[+-]?\\d*(\\.\\d+)?");
        
        if(!strG2.isEmpty()){
        	param.setValue("pGubun2", "");
        }        

		initCmmnParam(param);
				
		//분류별 탭 1depth 목록
		List<ZValue> realmTabList = lmsSqlDao.listDAO("realmListDAO.realmTabList", param);
		model.addAttribute("realmTabList",realmTabList);
		
		//분류별 탭 2depth 목록
		if(!"A".equals(param.getString("pGubun1", "A"))){
			List<ZValue> realmTabList2 = lmsSqlDao.listDAO("realmListDAO.realmTabList2", param);
			
			param.setValue("p_ordr", "2");
			param.setValue("p_code", param.getString("pGubun1"));
			param.setValue("p_type", param.getString("pGubun1"));
			
			//분류 목록
			List<ZValue> gubunList = lmsSqlDao.listDAO("realmListDAO.gubunList", param);
			//난이도 목록
			List<ZValue> levelList = lmsSqlDao.listDAO("realmListDAO.levelList", param);
		
			model.addAttribute("realmTabList2",realmTabList2);
			model.addAttribute("gubunList", gubunList);
			model.addAttribute("levelList", levelList);				
		}
		
		//분류별 탭 3depth 목록
		if(!"".equals(param.getString("pGubun2", ""))){
			List<ZValue> realmTabList3 = lmsSqlDao.listDAO("realmListDAO.realmTabList3", param);
			model.addAttribute("realmTabList3",realmTabList3);
		}
		
		//과정 목록
		if("Y0".equals(param.getString("pGubun1"))){
			super.setCountQueryId("realmListDAO.realmHunetSubjListCnt");
			super.setListQueryId("realmListDAO.realmHunetSubjList");
			
		}else{
			super.setCountQueryId("realmListDAO.realmSubjListCnt");
			super.setListQueryId("realmListDAO.realmSubjList");
		}
		
		paramCtx.setSqlDAO(lmsSqlDao);
		paramCtx.setPageQuery(new RealmPageInfo());
		super.list(paramCtx);
		
	}
	
	
	/**
	 * 분류별 탭 목록(통합검색시 사용)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void realmTabList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> realmTabList = lmsSqlDao.listDAO("realmListDAO.realmTabList", param);
		model.addAttribute("tabList", realmTabList);
	}
	
	
	
	/**
	 * 과정 상세 화면
	 */
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");	//교육그룹코드 임시 등록
		
		String v_subj = "";
		String v_year = "";
		String v_subjseq = "";
		String v_event = "N";
		
		
		v_year = param.getString("p_year");
		v_subjseq = param.getString("p_subjseq");
		v_event = param.getString("event");
		
		// 정규과정 이벤트를 통한 진행이벤트 랜덤 조회
		if(null != v_event && "Y".equals(v_event)){
			ZValue getSubjInfo = lmsSqlDao.selectDAO("realmListDAO.getEventSubjectInfo", param);
			
			v_subj = getSubjInfo.getString("subj");
			v_year = getSubjInfo.getString("year");
			v_subjseq = getSubjInfo.getString("subjseq");
			
			param.putObject("p_subj", v_subj);
			param.putObject("p_year", v_year);
			param.putObject("p_subjseq", v_subjseq);
		}
		
		//과정 필요정보가 없을 경우 필요정보 가져오기
		if("".equals(v_year) || "".equals(v_subjseq)){
			ZValue getAdvanceInfo = lmsSqlDao.selectDAO("realmListDAO.getSubjectAdvanceInfo", param);
			
			v_year = getAdvanceInfo.getString("year");
			v_subjseq = getAdvanceInfo.getString("subjseq");
		}
		param.put("p_year", v_year);
		param.put("p_subjseq", v_subjseq);
		
		//과정 상세정보
		ZValue view = lmsSqlDao.selectDAO("realmListDAO.view", param);
		model.addAttribute("view", view);
		
		//차시 목록
		List<ZValue> lessonList = lmsSqlDao.listDAO("realmListDAO.lessonList", param);
		model.addAttribute("lessonList",lessonList);
		
		
		ZValue tutorInfo = null;
		String subjMuserid = "";
		subjMuserid = view.getString("tutorid");
		param.put("subjmuserid", subjMuserid);
		
		if(!"".equals(subjMuserid)){
			tutorInfo = lmsSqlDao.selectDAO("realmListDAO.getTutorInfo", param);
		}
		model.addAttribute("tutorInfo", tutorInfo);

		ZValue subjDuplCheck = null;

		subjDuplCheck = lmsSqlDao.selectDAO("myLctrumDAO.subjDuplCheck", param);
		
		model.addAttribute("subjDuplCheck", subjDuplCheck.getInt("cnt") < 0 ? "Y": "N");
		
		//연관과정 정보: 연관 과정이란 수강 신청을 해 놓은 과정을 의미함
		ZValue getSearchNM = null;
		String []searchNm = null;
		String removeString = "";
		
		getSearchNM = lmsSqlDao.selectDAO("realmListDAO.getSearchNM", param);
		
		//연관과정 중복 문자열 제거
		removeString = removeDuplicateStringToken(getSearchNM.getString("searchNm").replaceAll("\\p{Z}", ""), ",");
		
		searchNm = removeString.split(",");
		
		List<String> obj = Arrays.asList(searchNm); 
		param.put("searchNm", obj);
		
		String[] searchNmArr = null;
		int rnkLimit = 0;
		searchNmArr = searchNm;
		rnkLimit = (searchNm.length < 3)?searchNmArr.length-1:2;
		param.put("rnkLimit", rnkLimit);
		
		//연관과정 목록
		List<ZValue> nextProposeSubjList = null;
		nextProposeSubjList = lmsSqlDao.listDAO("realmListDAO.nextProposeSubjList", param);
		model.addAttribute("nextProposeSubjList",nextProposeSubjList);
		
		//교육체계도 연결 과정 목록
		List<ZValue> eduSystmList = lmsSqlDao.listDAO("edcSystmDAO.eduSystmList", param);
		model.addAttribute("eduSystmList",eduSystmList);
		
		
	}
	
	
	//연관과정 중복 문자열 제거
	public String removeDuplicateStringToken(String str, String token) throws Exception {
		String v_str = "";
		
		try {
			String []arr = StringUtils.split(str, token.trim());
			
			TreeSet ts = new TreeSet();
			for(int i = 0; i < arr.length; i++){
				ts.add(arr[i]);
			}
			
			Iterator it = ts.iterator();
			while(it.hasNext()){
				v_str += (String)it.next()+token.trim();
			}
			v_str = v_str.substring(0, v_str.lastIndexOf(token.trim()));
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return v_str;
	}
	
	
	/**
	 * 학습 진행화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void viewEdu(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		String loginUserId = user.getUserId();
		param.put("userid", loginUserId);
		param.put("grcode", "N000001");
		
		String isoutsourcing = "";
		String url = "";
		int ieduurl = 0;
		
		String v_year = "";
		String v_cpsubj = "";
		String v_cpsubjseq = "";
		String v_company = "";
		String v_contenttype = "";
		String v_subj = "";
		String v_subjseq = "";
		String v_lesson= "";
		String v_tobeyn= "";
		String v_loginUserId= "";
		String v_subjnm= "";
		
		String tran_date = "";
		
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		Date dt = new Date();
		tran_date = df.format(dt);
		Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        cal.add(Calendar.MONTH,1);
        cal.add(Calendar.DATE,-1);
        param.put("eduEnd", df.format(cal.getTime()) );
		
		v_year = param.getString("s_year");
		v_cpsubj = param.getString("s_cpsubj");
		v_cpsubjseq = param.getString("s_cpsubjseq");
		v_company = param.getString("s_company");
		v_contenttype = param.getString("s_contenttype");
		v_subj = param.getString("s_subj");
		v_subjseq = param.getString("s_subjseq");
		v_lesson = param.getString("s_lesson");
		v_tobeyn = "Y";
		v_loginUserId = loginUserId;
		v_subjnm = param.getString("p_subjnm");
		
		HttpServletResponse response = paramCtx.getResponse();
		String resultMsg = "";
		int subjdupl = 0;
		
		//해당 아이디가 유효한 계정인지 체크
		ZValue memberCheck = lmsSqlDao.selectDAO("myLctrumDAO.memberCheck", param);
		
		//member 테이블에 존재하는 아이디일 경우
		if(memberCheck.getInt("membercnt") > 0){
			
			//학습중인지 체크
			ZValue subjDuplCheck = null;
			
			subjDuplCheck = lmsSqlDao.selectDAO("myLctrumDAO.subjDuplCheck", param);
			
			subjdupl = subjDuplCheck.getInt("cnt");
			log.info("subjdupl ==> "+subjdupl);
			
			if(subjdupl < 1){
				
				//resultMsg = "학습 내용이 초기화 됩니다. \n 이력은 마이페이지 > 나의 강의실 \n학습이력에서 확인 가능합니다.";
				//WebFactory.printHtmlAlert(response, resultMsg);
				
				int isOk = 0;
				param.put("onOff", 1);
				//개인정보 저장(공통)
				isOk = this.memberInfoUpdateNew(paramCtx);
				log.info("isOk ==> "+isOk);
				
				if(isOk > 0){
					
					log.info("수강신청 로직 시작!!!!");
					//수강신청
					//학습이력 백업 insert into tz_lesson_history
					//학습이력 삭제 tz_propose, tz_student, tz_progress, tz_stold(수료번호는 tz_stold, tz_stold_history)
					lmsSqlDao.insertDAO("myLctrumDAO.lessonHistoryInsert", param);
					lmsSqlDao.insertDAO("myLctrumDAO.proposeDelete", param);
					lmsSqlDao.insertDAO("myLctrumDAO.studentDelete", param);
					lmsSqlDao.insertDAO("myLctrumDAO.progressDelete", param);
					lmsSqlDao.insertDAO("myLctrumDAO.stoldDelete", param);
				
					lmsSqlDao.insertDAO("myLctrumDAO.proposeInsert", param);
					lmsSqlDao.insertDAO("myLctrumDAO.studentInsert", param);
					
					isOk = 1;
					log.info("수강신청 완료!!!!");
				}
				
				
				log.info("isOk ==> "+isOk);
				if(isOk > 0){
					
					String toPhone = "";
					String fromPhone = "";
					String v_msg = "";
					String tDate = "";
					
					tDate = tran_date.substring(4, 6) + "월 " + tran_date.substring(6, 8) + "일 ";
					
					if(v_subjnm.length() > 13){
						v_msg = tDate + v_subjnm.substring(0, 12) + "..";
					}else{
						v_msg = tDate + v_subjnm;
					}
					
					log.info("v_msg ==> "+v_msg);
					fromPhone = "02-6310-0770";
					
					//전화번호 가져오기
					ZValue getNumber = lmsSqlDao.selectDAO("myLctrumDAO.getNumber", param);
					if(getNumber != null){
						
						toPhone = getNumber.getString("handphone");
						v_msg = "[EDUKOCCA]\n" + v_msg + " 학습이 시작되었습니다.";
						
						//SMS 전송(DB 저장)
						boolean sms_result = false;
						sms_result = this.sendSMSMsg(paramCtx, toPhone, fromPhone, v_msg, "");
						log.info("SMS 전송(DB 저장) 결과: ["+sms_result+"]");
						
						/*sms_result = true;	//개발서버 임시 sms dbinsert 결과 등록 실서버 반영시 제거
						if(sms_result){
							
							log.info("["+tran_date+"] "+v_subjnm+"과정 시작알림이 SMS로 발송되었습니다!");
							log.info("["+tran_date+"] to: ["+toPhone+"]");
							log.info("["+tran_date+"] from: ["+fromPhone+"]");
							log.info("["+tran_date+"] message: ["+v_msg+"]");
							
						}else{
							log.info("["+tran_date+"] SMS 발송이 실패했습니다!");
							log.info("["+tran_date+"] to: ["+toPhone+"]");
							log.info("["+tran_date+"] from: ["+fromPhone+"]");
							log.info("["+tran_date+"] message: ["+v_msg+"]");
							
						}*/	//sms_result db insert
					}else{
						
						log.info("["+loginUserId+"] 회원정보를 알 수 없어 SMS 발송이 실패했습니다!");
						
					}
					
				}	//isOk 수강신청 
				
			}	//subjdupl 학습중인지 체크 e
			
			
			log.info("학습창 파라미터 넘기기 시작!!!!!!!!!!!!!!!!!!!!");
			//암호화
			v_year = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_year);
			v_cpsubj = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_cpsubj);
			v_cpsubjseq = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_cpsubjseq);
			v_company = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_company);
			v_contenttype = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_contenttype);
			v_subj = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_subj);
			v_subjseq = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_subjseq);
			v_lesson = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_lesson);
			v_tobeyn = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_tobeyn);
			v_loginUserId = KISA_SEED_CBC.CKLTREE_SEED_Encrypt(v_loginUserId);
			
			if("".equals(url)){
				ieduurl = 0;
			}else{
				ieduurl = 1;
			}
			
			//위탁과정일 경우
			if("Y".equals(isoutsourcing)){
				url += "/servlet/controller.contents.EduStart";
				url += "?FIELD1="+v_loginUserId+"&FIELD2="+v_year+"&FIELD3="+v_cpsubj+"&FIELD4="+v_cpsubjseq+"&FIELD99="+v_company+"&FIELD100=N"+"&contenttype="+v_contenttype+"&p_subj="+v_subj+"&p_year="+v_year+"&p_subjseq="+v_subjseq;
				
			//외부과정이 아닌 경우
			}else{
				
				if("".equals(url)){
					url = "https://edulms.kocca.kr/servlet/controller.contents.EduStart?p_subj="+v_subj;
					//url = "http://localhost/servlet/controller.contents.EduStart?p_subj="+v_subj;
//					url = "http://kocca.lc/servlet/controller.contents.EduStart?p_subj="+v_subj;
				}
				
				if(!"".equals(v_year)){
					url += "&p_year="+v_year+"&p_subjseq=";
				}else{
					v_year = KISA_SEED_CBC.CKLTREE_SEED_Encrypt("2000");
					url += "&p_year="+v_year+"&p_subjseq=";
				}
				
				if(!"".equals(v_subjseq)){
					url += v_subjseq;
				}else{
					v_subjseq = KISA_SEED_CBC.CKLTREE_SEED_Encrypt("0001");
					url += v_subjseq;
				}
				
				url += "&contenttype="+v_contenttype+"&p_lesson="+v_lesson+"&p_userid="+v_loginUserId+"&p_iurl="+ieduurl+"&p_tobeyn="+v_tobeyn;
			}
			
			String v_str1 = "";
			String v_str2 = "";
			v_str2 = " YEAR IN ('"+param.getString("s_year")+"') AND SUBJSEQ IN ('"+param.getString("s_subjseq")+"') ";
			v_str1 = v_str2 + " AND USERID IN ('"+loginUserId+"') ";
			param.put("p_str1", v_str1);
			param.put("p_str2", v_str2);
			param.put("userid", loginUserId);
			
			model.addAttribute("p_url",url);
			
			//과정상세정보
			ZValue view = lmsSqlDao.selectDAO("myLctrumDAO.view", param);
			model.addAttribute("view",view);
			
			//과정 차시 상세정보
			ZValue lessonView = lmsSqlDao.selectDAO("myLctrumDAO.lessonView", param);
			model.addAttribute("lessonView",lessonView);
						
			//진도 목차 목록
			String s_contenttype = param.getString("s_contenttype");
			String v_ispreview = param.getString("p_ispreview");
			List<ZValue> eduLessonList = null;

			//Normal MasterForm 정보
			if("N".equals(s_contenttype) || "M".equals(s_contenttype)){
				eduLessonList = lmsSqlDao.listDAO("myLctrumDAO.eduLessonList", param);
				
			//OBC, SCORM MasterForm 정보
			}else if("O".equals(s_contenttype) || "S".equals(s_contenttype)){
				
				//OBC, SCORM 맛보기일 경우
				if("Y".equals(v_ispreview)){
					
					//목록 작업 해야 함
//					eduLessonList = lmsSqlDao.listDAO("myLctrumDAO.eduLessonOBCPreviewList", param);
				}else{
					
					//목록 작업 해야 함
//					eduLessonList = lmsSqlDao.listDAO("myLctrumDAO.eduLessonOBCList", param);
				}
			}
			
			model.addAttribute("eduLessonList",eduLessonList);
			
			
			//나의 진도 정보
			ZValue myProgress = null;
			float percent = (float) 0.0;
//			int isOk = 0;
			//미리보기가 아닌 경우에만 보여줌
			if(!"Y".equals(param.getString("p_ispreview")) && !"2000".equals(param.getString("s_year"))){
				
				//점수 계산
//				isOk = this.calcScore(paramCtx, 32);
				
				myProgress = lmsSqlDao.selectDAO("myLctrumDAO.myProgress", param);
				percent = myProgress.getFloat("tstep");
			}
			model.addAttribute("myProgress",String.valueOf(percent));
			
			model.addAttribute("p_subj", param.getString("s_subj"));
		//member 테이블에 존재하는 아이디가 아닌 경우
		}else{
			
			resultMsg = "유효하지 않는 계정이므로 학습할 수 없습니다!";
			WebFactory.printHtml(response, resultMsg, "javascript:history.back();");
			
		}
		
	}
	
	
		
	/**
	 * 개인정보 저장(공통)
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public int memberInfoUpdateNew(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int result = 0;
		
		int onOff = param.getInt("onOff");
		String v_subj = param.getString("s_subj");
		
		String p_comptext = "";
		String p_handphone = "";
		String p_jikchaeknm = "";
		String p_deptnam = "";
		String privateyn = "";
		
		p_comptext = param.getString("p_comptext");
		p_handphone = param.getString("p_handphone");
		p_jikchaeknm = param.getString("p_jikchaeknm");
		p_deptnam = param.getString("p_deptnam");
		privateyn = param.getString("p_privateYn");
		
		String p_militarystatus = "";
		String p_militarymemo = "";
		String p_militarystart = "";
		String p_militaryend = "";
		
		p_militarystatus = param.getString("p_militarystatus");
		p_militarymemo = param.getString("p_militarymemo");
		p_militarystart = param.getString("p_militarystart");
		p_militaryend = param.getString("p_militaryend");
		
		
		try {
			
			log.info("학습 시작 전 개인정보 저장(공통) s");
			
			param.put("p_comptext", p_comptext);
			param.put("p_handphone", p_handphone);
			param.put("p_jikchaeknm", p_jikchaeknm);
			param.put("p_deptnam", p_deptnam);
			param.put("p_privateYn", privateyn);
			
			//1.회사명 갱신
			lmsSqlDao.updateDAO("myLctrumDAO.memberInfoUpdate", param);
			log.info("1.회사명 갱신 완료!");

			
			param.put("p_militarystatus", p_militarystatus);
			param.put("p_militarymemo", p_militarymemo);
			param.put("p_militarystart", p_militarystart);
			param.put("p_militaryend", p_militaryend);
			
			//병역정보 갱신
			//2.1병역정보 삭제
			lmsSqlDao.deleteDAO("myLctrumDAO.militaryDelete", param);
			log.info("2.1병역정보 삭제 완료!");
			
			//2.2병역정보 신규 등록
			lmsSqlDao.insertDAO("myLctrumDAO.militaryInsert", param);
			log.info("2.2병역정보 신규 등록 완료!");
			

			log.info("3.과정 신청 추가 정보 삭제 s: [subj: "+v_subj.length()+"]");
			//3.과정 신청 추가 정보 삭제
			if(v_subj.length() > 0){
				
				if(onOff == 1){
					//3.1온라인과정 신청 추가 정보 삭제
					lmsSqlDao.deleteDAO("myLctrumDAO.proposeInfoDelete", param);
					log.info("3.1온라인과정 신청 추가 정보 삭제 완료");
					
				}else{
					//3.1오프라인과정 신청 추가 정보 삭제
					lmsSqlDao.deleteDAO("myLctrumDAO.offProposeDelete", param);
					log.info("3.2오프라인과정 신청 추가 정보 삭제 완료");
				}
			}
			log.info("3.과정 신청 추가 정보 삭제 e");
			
			
			
			//4.과정 신청 추가 정보 등록
			if(onOff == 1){
				
				//4.1온라인과정 신청 추가 정보 입력
				lmsSqlDao.insertDAO("myLctrumDAO.proposeInfoInsert", param);
				log.info("4.1온라인과정 신청 추가 정보 입력 완료");
				
			}else{
				//4.1오프라인과정 신청 추가 정보 입력
				lmsSqlDao.insertDAO("myLctrumDAO.offProposeInfoInsert", param);
				log.info("4.2오프라인과정 신청 추가 정보 입력 완료");
				
			}
			
			result = 1;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return result;
	}
	
	
	/**
	 * 개인정보 저장(공통)
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public int isCurrentLesson(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int result = 0;
		
		String p_militaryend = param.getString("p_militaryend");
		
		
		try {
			
			log.info("현재 학습 중인지 체크");
			
			//1.회사명 갱신
			lmsSqlDao.updateDAO("myLctrumDAO.memberInfoUpdate", param);
			param.put("p_militaryend", p_militaryend);
			
			
			result = 1;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return result;
	}
	
	/**
	 * 개인정보 저장(공통)
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public int insertNextLesson(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int result = 0;
		
		String p_militaryend = param.getString("p_militaryend");
		
		
		try {
			
			log.info("학습 시작 전 개인정보 저장(공통) s");
			
			//1.회사명 갱신
			lmsSqlDao.updateDAO("myLctrumDAO.memberInfoUpdate", param);
			param.put("p_militaryend", p_militaryend);
			
			
			result = 1;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		return result;
	}
	
	/**
	 * SMS 전송(DB 저장)
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public boolean sendSMSMsg(ParameterContext<ZValue> paramCtx, String toPhone, String fromPhone, String v_msgStr, String dateStr) throws Exception {
		ZValue param = paramCtx.getParam();
		boolean result = false;
		
		param.put("toPhone", toPhone);
		param.put("fromPhone", fromPhone);
		param.put("msgStr", v_msgStr);
		param.put("dateStr", dateStr);
		
		try {
			
			//SMS 전송(DB 저장)
			lmsSqlDao.insertDAO("myLctrumDAO.sendSMSMsg", param);
			log.info("SMS DB 저장 완료!");
			
			result = true;
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}
	
	
	
	
	/**
	 * 과정별 자료실 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listData(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		String loginUserId = user.getUserId();
		param.put("userid", loginUserId);
		param.put("grcode", "N000001");
		param.put("pMenu", "21");
		
		int isOk = 0;
		int sdTabseq = 0;
		String tabseq = "";
		
		String system_msg = "";
		
		isOk = this.writeLog(paramCtx);
		tabseq = param.getString("pTabseq");
		
		if("".equals(tabseq)){
			
			param.put("pType", "SD");
			param.put("pGrcode", "0000000");
			param.put("pComp", "0000000000");
			
			ZValue getSDTabseq = lmsSqlDao.selectDAO("realmListDAO.getSDTabseq", param);
			
			if(getSDTabseq != null){
				sdTabseq = getSDTabseq.getInt("tabseq");
				
			}else{
				
				ZValue getSubjcnt = lmsSqlDao.selectDAO("realmListDAO.getSubjcnt", param);
				
				if(getSubjcnt != null && getSubjcnt.getInt("cnt") > 0){
					
					ZValue getTabseq = lmsSqlDao.selectDAO("realmListDAO.getTabseq", param);
					sdTabseq = getTabseq.getInt("tabseq");
					
					param.put("pTabseq", sdTabseq);
					lmsSqlDao.insertDAO("realmListDAO.dataSeqInsert", param);
					
				}else{
					sdTabseq = 0;
				}
			}
			
			
			if(sdTabseq == 0){
				system_msg = "잘못된 자료실입니다!";
				log.info(system_msg);
			}else{
				param.put("pTabseq", String.valueOf(sdTabseq));
				log.info("tabseq를 정상적으로 가져왔습니다! ==> "+sdTabseq);
			}
			
			
			param.put("pSearchtext", param.getString("pSearchtext").trim());
			
			super.setCountQueryId("realmListDAO.listDataCnt");
			super.setListQueryId("realmListDAO.listData");
			
			paramCtx.setSqlDAO(lmsSqlDao);
			paramCtx.setPageQuery(new RealmPageInfo());
			super.list(paramCtx);
			
		}
		
	}
	
	
	/**
	 * 과정별 자료실 상세화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void viewData(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		String loginUserId = user.getUserId();
		param.put("userid", loginUserId);
		param.put("grcode", "N000001");
		param.put("pMenu", "21");
		
		//과정자료실 상세정보
		ZValue viewData = lmsSqlDao.selectDAO("realmListDAO.viewData", param);
		model.addAttribute("viewData", viewData);
		
		
		//과정자료실 파일 목록
		List<ZValue> listFileData = lmsSqlDao.listDAO("realmListDAO.listFileData", param);
		model.addAttribute("listFileData",listFileData);
		
		
		//조회수 증가
		lmsSqlDao.updateDAO("realmListDAO.dataBoardUpdate", param);
		
		
	}
	
	
	
	
	/**
	 * 자료실 진입 로그 작성
	 * @param paramCtx
	 * @return
	 * @throws Exception
	 */
	public int writeLog(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int result = 0;
		
		String v_grcode = param.getString("grcode", param.getString("tem_grcode"));
		String v_subj = param.getString("p_subj", param.getString("pSubj"));
		String v_year = param.getString("p_year", param.getString("pYear"));
		String v_subjseq = param.getString("p_subjseq", param.getString("pSubjseq"));
		String v_menu = param.getString("pMenu");
		
		int dataMenuCnt = 0;
		
		try {
			
			log.info("자료실 진입 로그 작성 s");
			
			if(!"".equals(v_grcode) && !"".equals(v_subj) && !"".equals(v_year) && !"".equals(v_subjseq) && !"".equals(v_menu)){
				
				ZValue getDataMenuCnt = lmsSqlDao.selectDAO("realmListDAO.getDataMenuCnt", param);
				dataMenuCnt = getDataMenuCnt.getInt("cnt");
				
				if(dataMenuCnt > 0){
					//과정자료실 로그가 등록 되어있을 경우 카운트 1 증가
					lmsSqlDao.updateDAO("realmListDAO.dataMenuUpdate", param);
					log.info("과정자료실 로그가 등록 되어있을 경우 카운트 1 증가");
					
				}else{
					//과정자료실 로그가 등록 되지 않았을 경우 로그 기록 등록
					lmsSqlDao.insertDAO("realmListDAO.dataMenuInsert", param);
					log.info("과정자료실 로그가 등록 되지 않았을 경우 로그 기록 등록");
					
				}
				
			}
			result = 1;
			log.info("자료실 진입 로그 작성 e");
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 점수 계산
	 * @param paramCtx
	 * @param p_gubun
	 * @param p_subj
	 * @param p_year
	 * @param p_subjseq
	 * @param p_userid
	 * @return
	 * @throws Exception
	 */
	public int calcScore(ParameterContext<ZValue> paramCtx, int s_gubun) throws Exception {
		ZValue param = paramCtx.getParam();
		
		int result = 0;
		String v_contenttype = "";
		String v_calcContenttype = "";
		
		
		ZValue subjseqData = null;
		ZValue getContenttype = null;
		ZValue getCalcContenttype = null;
		ZValue getTargetGrcode = null;
		
		ZValue getCalcStepDcnt = null;
		ZValue getCalcStepEduDcnt = null;
		
		List<ZValue> getFinishTargetStudent = null;
		
		String v_subj = "";
		String v_year = "";
		String v_subjseq = "";
		String v_userid = "";
		
		v_subj = param.getString("s_subj");
		v_year = param.getString("s_year");
		v_subjseq = param.getString("s_subjseq");
		v_userid = param.getString("s_userid");
		
		
		
		int v_datecnt = 0;
		int v_edudatecnt = 0;
		
		double tstep = 0;
		double wstep = 0;
		double avtstep = 0;
		
		wstep = param.getDouble("wstep");
		
		
		try {
			
			//세션변수에서 사용자 아이디를 가져옴
			v_userid = param.getString("s_userid");
			
			//수료처리 완료여부, 학습중 검토
			subjseqData = lmsSqlDao.selectDAO("myLctrumDAO.subjseqData", param);
			
			
			if("2000".equals(v_year)){
				log.info("v_year: ["+v_year+"]");
				return 3;
			}
			
			if("Y".equals(subjseqData.getString("isclosed"))){
				log.info("isclosed: ["+subjseqData.getString("isclosed")+"]");
				return 2;
			}
			
			//컨텐츠 유형 가져오기
			getContenttype = lmsSqlDao.selectDAO("myLctrumDAO.getContenttype", param);
			v_contenttype = getContenttype.getString("contenttype");
			
			
			getTargetGrcode = lmsSqlDao.selectDAO("myLctrumDAO.getTargetGrcode", param);
			param.put("s_grcode", getTargetGrcode.getString("grcode"));
			
			//학습자 커서
			getFinishTargetStudent = lmsSqlDao.listDAO("myLctrumDAO.getFinishTargetStudent", param);
			
			if(getFinishTargetStudent != null && getFinishTargetStudent.size() > 0){
				for(ZValue data :getFinishTargetStudent) {
					
					
					param.put("wstep", subjseqData.getDouble("wstep"));
					param.put("wmtest", subjseqData.getDouble("wmtest"));
					param.put("whtest", subjseqData.getDouble("whtest"));
					param.put("wftest", subjseqData.getDouble("wftest"));
					param.put("wreport", subjseqData.getDouble("wreport"));
					
					param.put("wact", subjseqData.getDouble("wact"));
					param.put("wetc1", subjseqData.getDouble("wetc1"));
					param.put("wetc2", subjseqData.getDouble("wetc2"));
					param.put("gradscore", subjseqData.getInt("gradscore"));
					
					param.put("gradstep", subjseqData.getInt("gradstep"));
					param.put("gradexam", subjseqData.getInt("gradexam"));
					param.put("gradreport", subjseqData.getInt("gradreport"));
					param.put("gradftest", subjseqData.getInt("gradftest"));
					param.put("gradhtest", subjseqData.getInt("gradhtest"));
					
					
					if(STEP == s_gubun){
						if("S".equals(v_contenttype) || "O".equals(v_contenttype) || "N".equals(v_contenttype) || "M".equals(v_contenttype)){
							
							getCalcContenttype = lmsSqlDao.selectDAO("myLctrumDAO.getCalcContenttype", param);
							v_calcContenttype = getCalcContenttype.getString("contenttype");
							
							//점수 계산
							param.put("calcContenttype", v_calcContenttype);
							getCalcStepDcnt = lmsSqlDao.selectDAO("myLctrumDAO.getCalcStepDcnt", param);
							getCalcStepEduDcnt = lmsSqlDao.selectDAO("myLctrumDAO.getCalcStepEduDcnt", param);
								
							
							v_datecnt = getCalcStepDcnt.getInt("datecnt");
							v_edudatecnt = getCalcStepEduDcnt.getInt("edudatecnt");
							
							
							if(v_edudatecnt == 0){
								tstep = 0;
							}else{
								tstep = (double) Math.round((double) v_edudatecnt / v_datecnt * 100 * 100) / 100;
							}
							
							if(tstep > 100){
								tstep = 100;
							}
							
							if(wstep == 0){
								avtstep = 0;
							}else{
								avtstep = (double) Math.round(tstep * wstep) / 100;
							}
							
							if(avtstep > wstep){
								avtstep = wstep;
							}
							
							
							param.put("wstep", wstep);
							param.put("avtstep", avtstep);
							param.put("tstep", tstep);
							
							
						}
						
					}
				}
			}
			
			
			
			
			
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		
		
		return result;
	}
	
	/**
	 * 하위 분류 리스트
	 */
	public void gubunList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(!"".equals(param.getString("p_code"))){
			//분류 목록
			List<ZValue> gubunList = lmsSqlDao.listDAO("realmListDAO.gubunList", param);
			model.addAttribute("gubunList", gubunList);
			
			if("2".equals(param.getString("p_ordr"))){
				//난이도 목록
				List<ZValue> levelList = lmsSqlDao.listDAO("realmListDAO.levelList", param);
				model.addAttribute("levelList", levelList);
			}
		}
		
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
