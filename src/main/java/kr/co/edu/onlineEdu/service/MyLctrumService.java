package kr.co.edu.onlineEdu.service;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;


public class MyLctrumService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public MyLctrumService() {
		super();

	}
	
	public final static String SPLIT_COMMA = ",";
	public final static String SPLIT_COLON = ":";
	
	public final static String DEFAULT_GRCODE = "N000001";
	public final static String DEFAULT_SUBJ = "SUBJ";
	
	//public final static String DIST_CODE = "0010";
	public final static String DIST_CODE = "0054";
	
	public final static String SUL_TYPE = "0011";
	
	public final static String OBJECT_QUESTION = "1";
	public final static String MULTI_QUESTION = "2";
	public final static String SUBJECT_QUESTION = "3";
	public final static String COMPLEX_QUESTION = "4";
	public final static String FSCALE_QUESTION = "5";
	public final static String SSCALE_QUESTION = "6";
	
	public final static String F_GUBUN = "";
	public final static String SUBJECT_SULMUN = "S";
	public final static String TARGET_SULMUN = "T";
	public final static String COMMON_SULMUN = "C";
	public final static String CONTENTS_SULMUN = "O";
		
	    
	

	/**
	 * 학습목록
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		String viewType = param.getString("viewType", "current");//rsg20170912
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		param.put("viewType", viewType);//rsg20170912
		
		if(viewType.equals("current")){//rsg20170912
			super.setCountQueryId("myLctrumDAO.eduListCnt");
			super.setListQueryId("myLctrumDAO.eduList");
		}else{
			super.setCountQueryId("myLctrumDAO.eduOldListCnt");
			super.setListQueryId("myLctrumDAO.eduOldList");
		}
//		System.out.println("+++++++++++++++++"+paramCtx.getPageQuery()+"++++++++++++++++++");
//		System.out.println("+++++++++++++++++super"+super.pageQuery.getPageQueryString(param)+"++++++++++++++++++");
//		System.out.println("+++++++++++++++++super"+super.PAGE_QUERY_STRING+"++++++++++++++++++");
		
		paramCtx.setParam(param);
//		System.out.println("+++++++++++++++++ paramCtx"+super.pageQuery.getPageQueryString(param)+"++++++++++++++++++");
		paramCtx.setSqlDAO(lmsSqlDao);
		super.list(paramCtx);
	}
	
	/**
	 * 수료증 출력
	 */
	public void viewCtfhv(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		
		//수료증 정보
		ZValue ctfhvInfo = null;
		ZValue getIsalways = null;
		
		
		//상시학습 여부
		getIsalways = lmsSqlDao.selectDAO("myLctrumDAO.getIsalways", param);
		param.put("pIsalways", getIsalways.getString("isalways"));
		
		
		if("1".equals(param.getString("p_kind"))){
			ctfhvInfo = lmsSqlDao.selectDAO("myLctrumDAO.ctfhvInfo1", param);
			
		}else if("2".equals(param.getString("p_kind"))){
			ctfhvInfo = lmsSqlDao.selectDAO("myLctrumDAO.ctfhvInfo2", param);
		}
		model.addAttribute("ctfhvInfo",ctfhvInfo);
		
	}
	
	
	/**
	 * 찜등록
	 */
	public void regSubjFavorInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		int result = 0;
		String system_msg = "";
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getUserId();
		
		String grcode = param.getString("grcode");
		grcode = "".equals(grcode) ? param.getString("tem_grcode"):grcode;
		
		param.put("userid", userId);
		param.put("grcode", "N000001");
		
		if("".equals(userId)){
			log.info("사용자 정보를 확인할 수 없습니다.\\n다시 로그인 하신 후 시도해주세요!");
			system_msg = "사용자 정보를 확인할 수 없습니다.\\n다시 로그인 하신 후 시도해주세요!";
			result = -1;
			return;
			
		}else{
			
			//찜목록 취소
			if("cancel".equals(param.getString("p_jobtype"))){
				
				result = lmsSqlDao.deleteDAO("myLctrumDAO.regSubjFavorDelete", param);
				log.info("찜목록 취소 결과 ==>"+result);
				system_msg = "해당 과정이 찜취소 되었습니다!";
				result = 1;
				
			//찜목록 등록
			}else if("register".equals(param.getString("p_jobtype"))){
				
				//30번째 찜목록 삭제
				result = lmsSqlDao.deleteDAO("myLctrumDAO.regSubjFavorLastDelete", param);
				log.info("찜목록 삭제 갯수 ==>"+result);
				
				
				if(result > -1){
					lmsSqlDao.insertDAO("myLctrumDAO.regSubjFavorInsert", param);
					system_msg = "해당 과정이 찜등록 되었습니다!";
					result = 1;
					
				}else{
					system_msg = "최대 찜목록 갯수를 초과하여 더이상 등록할 수 없습니다!";
					log.info("최대 찜목록 갯수를 초과하여 더이상 등록할 수 없습니다!");
					result = -2;
					return;
				}
				
			}else{
				system_msg = "진행할 작업을 알 수 없습니다.\n다시 시도해주세요!";
				log.info("진행할 작업을 알 수 없습니다.\n다시 시도해주세요!");
				result = -3;
				return;
			}
			
		}
		
		model.addAttribute("system_msg", system_msg);
		model.addAttribute("result", result);
		
	}
	
	
	
	
	
	/**
	 * 찜목록
	 */
	public void listDibs(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		
		super.setCountQueryId("myLctrumDAO.dibsListCnt");
		super.setListQueryId("myLctrumDAO.dibsList");
		
		paramCtx.setSqlDAO(lmsSqlDao);
		super.list(paramCtx);
		
	}
	
	
	/**
	 * 설문지 목록
	 */
	public void listQestnr(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		
		//해당 아이디가 유효한 계정인지 체크
		ZValue memberCheck = lmsSqlDao.selectDAO("myLctrumDAO.memberCheck", param);
		
		//member 테이블에 존재하는 아이디일 경우
		if(memberCheck.getInt("membercnt") > 0){
		
			//과정 상세정보
			ZValue view = lmsSqlDao.selectDAO("realmListDAO.view", param);
			model.addAttribute("view", view);
			
			
			param.put("s_subj", param.getString("p_subj"));
			param.put("s_year", param.getString("p_year"));
			param.put("s_subjseq", param.getString("p_subjseq"));
		
			//나의 진도 정보
			ZValue myProgress = null;
			float percent = (float) 0.0;
			myProgress = lmsSqlDao.selectDAO("myLctrumDAO.sulMyProgress", param);
			if(myProgress != null){
				percent = myProgress.getFloat("tstep");
			}
			model.addAttribute("myProgress",String.valueOf(percent));
			
			//과정 설문 목록 
			List<ZValue> subjQestnrList = lmsSqlDao.listDAO("myLctrumDAO.subjQestnrList", param);
			model.addAttribute("subjQestnrList",subjQestnrList);
			
			//일반 설문 목록 
			List<ZValue> contentsQestnrList = lmsSqlDao.listDAO("myLctrumDAO.contentsQestnrList", param);
			model.addAttribute("contentsQestnrList",contentsQestnrList);
			
			
			//설문지 목록
			List<ZValue> realmTabList = lmsSqlDao.listDAO("myLctrumDAO.qestnrList", param);
			model.addAttribute("resultList",realmTabList);
			
		//member 테이블에 존재하는 아이디가 아닌 경우
		}else{
			
			HttpServletResponse response = paramCtx.getResponse();
			String resultMsg = "유효하지 않는 계정입니다!";
			WebFactory.printHtml(response, resultMsg, "javascript:history.back();");
			
		}
		
	}
	
	
	/**
	 * 설문문제 목록
	 */
	public void listQestnar(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue getPapernumSeq = null;
		ZValue getSulnums = null;
		StringBuffer sb = null;
		
		int v_sulpapernum = 0;
		v_sulpapernum = param.getInt("p_sulpapernum");	//설문지 번호
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");

		
		//1.설문지번호가 없을 경우 설문지 번호를 가져옴
		if(v_sulpapernum == 0){
			
			log.info("1.설문지번호를 찾을 수 없어 설문지 번호를 가져옵니다!! s");
			getPapernumSeq = lmsSqlDao.selectDAO("myLctrumDAO.getPapernumSeq", param);
			v_sulpapernum = getPapernumSeq.getInt("maxno") - 1;
			log.info("1.가져온 설문지 번호: "+v_sulpapernum);
			log.info("1.설문지번호를 찾을 수 없어 설문지 번호를 가져옵니다!! e");
		}
		
		//1.1설문지 번호 자원 등록
		param.put("p_sulpapernum", v_sulpapernum);
		log.info("1.1.설문지 번호 자원 등록 완료!");
		
		
		//2.설문지번호에 해당하는 설문번호를 vector형태로 받음
		getSulnums = lmsSqlDao.selectDAO("myLctrumDAO.getSulnums", param);
		log.info("2.설문번호[vector type]: "+getSulnums.getString("sulnums"));
		
		
		String []sulnumarr = null;
		sulnumarr = getSulnums.getString("sulnums").split(",");
		List<String> obj = Arrays.asList(sulnumarr);
		param.put("sulnum", obj);
		param.put("distcode", DIST_CODE);
		param.put("sultype", SUL_TYPE);
		

		//3.설문 목록
		List<ZValue> qestnarList = lmsSqlDao.listDAO("myLctrumDAO.getSelnums", param);
		
		//4.설문문제 목록 만들기
		if(qestnarList != null && qestnarList.size() > 0){
			
			log.info("4.설문문제 목록 만들기 s");
			String selmax = "";
			String subsulnum = "";
			String nextsulnum = "";
			String checkedRadio = "";
			sb = new StringBuffer();
			
			for(int i = 0; i < qestnarList.size(); i++){
				ZValue item = (ZValue) qestnarList.get(i);
				
				//복합형 기타 의견 영역을 보기 마지막에 그려주기 위한 다음 설문지번호
				if(i < qestnarList.size()-1){
					nextsulnum = qestnarList.get(i+1).getString("sulnum");
				}
				
				selmax = "";
				selmax = item.getString("sultype").equals("2")?"("+item.getString("selmax")+"개 까지 선택 가능)":"";
				
				//4.1.설문문제 그리기
				if(!subsulnum.equals(item.getString("sulnum"))){
					subsulnum = item.getString("sulnum");
					sb.append("		<li><span class=\"question\">"+item.getString("sultext")+" "+selmax+"</span>");
					log.info("4.1.설문문제 : "+subsulnum+"."+item.getString("sultext"));
				}
				
				/*
				 * 2017.05.13 요청에의해 디폴트선택 해제
				checkedRadio = "";
				if("1".equals(item.getString("selnum"))){
					checkedRadio = "checked";
				}
				*/
				
				//4.2.설문문제 보기 그리기
				//단일선택
				if(item.getString("sultype").equals(OBJECT_QUESTION)){
					sb.append("			<label for=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"db\">");
					sb.append("			<input type=\"radio\" "+checkedRadio+" name=\""+item.getString("sulnum")+"\" value=\""+item.getString("selnum")+"\" id=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"sulanswer\" />");
					sb.append("			"+item.getString("seltext")+"</label>");
					
				//복수선택
				}else if(item.getString("sultype").equals(MULTI_QUESTION)){
					sb.append("			<label for=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"db\">");
					sb.append("			<input type=\"checkbox\" name=\""+item.getString("sulnum")+"\" value=\""+item.getString("selnum")+"\" id=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"sulanswer\" />");
					sb.append("			"+item.getString("seltext")+"</label>");
					
				//서술형
				}else if(item.getString("sultype").equals(SUBJECT_QUESTION)){
					sb.append("<textarea name=\""+item.getString("sulnum")+"\" id=\""+item.getString("sulnum")+"\" cols=\"30\" rows=\"10\" title=\"하고 싶은 말을 입력하세요.\" style=\"width:100%;\" class=\"sulanswer\"></textarea>");
					
				//복합형
				}else if(item.getString("sultype").equals(COMPLEX_QUESTION)){
					sb.append("			<label for=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"db\">");
					sb.append("			<input type=\"radio\" "+checkedRadio+" name=\""+item.getString("sulnum")+"\" value=\""+item.getString("selnum")+"\" id=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"sulanswer\" />");
					sb.append("			"+item.getString("seltext")+"</label>");
					
					//기타의견 작성영역: 해당 설문번호 보기 마지막에 그려준다
					if(!nextsulnum.equals(subsulnum)){
						sb.append("<textarea name=\""+item.getString("sulnum")+"|C\" id=\""+item.getString("sulnum")+"|C\" cols=\"30\" rows=\"10\" title=\"기타의견을 적어주세요.\" style=\"width:100%;\" maxlength=\"200\" class=\"sulanswer\">기타의견을 적어주세요.</textarea>");
					}
					
				//5점척도
				}else if(item.getString("sultype").equals(FSCALE_QUESTION)){
					sb.append("			<label for=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"db\">");
					sb.append("			<input type=\"radio\" "+checkedRadio+" name=\""+item.getString("sulnum")+"\" value=\""+item.getString("selnum")+"\" id=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"sulanswer\" />");
					sb.append("			"+item.getString("seltext")+"</label>");
					
				//7점척도
				}else if(item.getString("sultype").equals(SSCALE_QUESTION)){
					sb.append("			<label for=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"db\">");
					sb.append("			<input type=\"radio\" "+checkedRadio+" name=\""+item.getString("sulnum")+"\" value=\""+item.getString("selnum")+"\" id=\""+item.getString("sulnum")+"_"+item.getString("selnum")+"\" class=\"sulanswer\" />");
					sb.append("			"+item.getString("seltext")+"</label>");
				}
			}
			sb.append("		</li>");
			
			log.info("4.설문문제 목록 만들기 e");
		}
		
		String str = sb.toString();
		model.addAttribute("qestnarList",str);
		
	}
	
	
	
	
	/**
	 * 설문지 제출
	 */
	public void insertQestnar(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		
		int result = 0;
		String system_msg = "";
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		
		log.info("p_sulnums===>"+param.getString("p_sulnums"));
		log.info("p_answers===>"+param.getString("p_answers"));
		
		//설문지 문제
		String[] arr_sulnums = param.getString("p_sulnums").split("\\,");
		
		//설문지 선택 값
		String[] arr_answers = param.getString("p_answers").split("\\,", -1);
		
		String v_distcode = "";
		String v_sultype = "";
		String v_distcode10 = "";	//소감
		String v_answer = "";	//주관식 답
		
		ZValue getSulGubun = null;
		ZValue getSulselPoint = null;
		ZValue getSuleachCheck = null;
		
		int getSulresultCheck = 0;
		
		int v_arr_answers = 0;	//객관식 답
		int v_selpoint = 0;		//문제 보기 점수
		
		int v_code1 = 0;	//과정만족도
		int v_code2 = 0;	//내용이해도
		int v_code3 = 0;	//과정난이도
		int v_code4 = 0;	//업무활용도
		int v_code5 = 0;	//질문대응
		int v_code6 = 0;	//장애대응
		int v_code7 = 0;	//강사만족도
		
		int v_code1_cnt = 0;	//과정만족도
		int v_code2_cnt = 0;	//내용이해도
		int v_code3_cnt = 0;	//과정난이도
		int v_code4_cnt = 0;	//업무활용도
		int v_code5_cnt = 0;	//질문대응
		int v_code6_cnt = 0;	//장애대응
		int v_code7_cnt = 0;	//강사만족도
		
		double v_code1_avg = 0;	//과정만족도
		double v_code2_avg = 0;	//내용이해도
		double v_code3_avg = 0;	//과정난이도
		double v_code4_avg = 0;	//업무활용도
		double v_code5_avg = 0;	//질문대응
		double v_code6_avg = 0;	//장애대응
		double v_code7_avg = 0;	//강사만족도
		
		if(arr_sulnums != null && arr_sulnums.length > 0){
			
			for(int i = 0; i < arr_sulnums.length; i++){
				
				param.put("sulnum", arr_sulnums[i]);
				getSulGubun = lmsSqlDao.selectDAO("myLctrumDAO.getSulGubun", param);
				
				//문제당 분류코드
				v_distcode = getSulGubun.getString("distcode");
				v_sultype = getSulGubun.getString("sultype");
				
				log.info("문제 분류 코드: ["+v_distcode+"]");
				log.info("문제 유형: ["+v_sultype+"]");
				
				//소감
				if("10".equals(v_distcode)){
					v_distcode10 = arr_answers[i];
				}

				if(arr_answers[i] == null) {
					v_answer = "";
				} else {
					v_answer = arr_answers[i];
				}
				
				log.info("소감 등록 값: ["+v_distcode10+"], v_answer: ["+v_answer+"]");
				
				//주관식 답: TZ_SULRESULTP에 insert 함
				if(SUBJECT_QUESTION.equals(v_sultype)){
					
					log.info("주관식 답 등록 s");
					//자원등록
					param.put("sulnum", arr_sulnums[i]);
					param.put("distcode", v_distcode);
					param.put("sultype", v_sultype);
					param.put("arr_answers", v_answer);
					
					log.info("주관식 답 등록을 위한 자원 등록 완료!");
					
					//주관식 답 등록 여부 체크
					getSulresultCheck = lmsSqlDao.selectCount("myLctrumDAO.getSulresultCheck", param);
					log.info("주관식 답 등록 여부 체크 결과: ["+getSulresultCheck+"]");
					
					if(getSulresultCheck < 1){
						log.info("등록된 주관식 답이 없으므로 새로 등록합니다 i");
						lmsSqlDao.insertDAO("myLctrumDAO.tzSulresultpInsert", param);
						
					}else{
						log.info("등록된 주관식 답이 있으므로 답을 수정합니다u");
						lmsSqlDao.updateDAO("myLctrumDAO.tzSulresultpUpdate", param);
						
					}
					
					log.info("주관식 답 등록 완료");
					log.info("주관식 답 등록 e");
					
				}else{
					
					//객관식 답
					v_arr_answers = 0;
					v_selpoint = 0;
					v_arr_answers = Integer.parseInt(arr_answers[i]);
					log.info("객관식 답 값: ["+v_arr_answers+"]");
					if(v_arr_answers != 0){
						
						log.info("객관식 답 등록 s");
						//객관식 답 자원 등록
						param.put("sulnum", arr_sulnums[i]);
						param.put("arrAnswers", v_arr_answers);
						
						log.info("객관식 답 등록을 위한 자원 등록 완료!");
						getSulselPoint = lmsSqlDao.selectDAO("myLctrumDAO.getSulselPoint", param);
						
						//문제 보기 점수
						v_selpoint = getSulselPoint.getInt("selpoint");
						log.info("문제 보기 점수: ["+v_selpoint+"]점");
						
						
						log.info("점수 계산 s");
						//점수 계산
						if("1".equals(v_distcode)){
							v_code1 += v_selpoint;
							v_code1_cnt++;
						}
						if("2".equals(v_distcode)){
							v_code2 += v_selpoint;
							v_code2_cnt++;
						}
						if("3".equals(v_distcode)){
							v_code3 += v_selpoint;
							v_code3_cnt++;
						}
						if("4".equals(v_distcode)){
							v_code4 += v_selpoint;
							v_code4_cnt++;
						}
						if("5".equals(v_distcode)){
							v_code5 += v_selpoint;
							v_code5_cnt++;
						}
						if("6".equals(v_distcode)){
							v_code6 += v_selpoint;
							v_code6_cnt++;
						}
						if("7".equals(v_distcode)){
							v_code7 += v_selpoint;
							v_code7_cnt++;
						}
						log.info("점수 계산 e");
					}
				}
			}
			
			log.info("설문결과 등록 준비");
			if(v_code1_cnt != 0){ v_code1_avg = v_code1 / (double)v_code1_cnt; }
			if(v_code2_cnt != 0){ v_code2_avg = v_code2 / (double)v_code2_cnt; }
			if(v_code3_cnt != 0){ v_code3_avg = v_code3 / (double)v_code3_cnt; }
			if(v_code4_cnt != 0){ v_code4_avg = v_code4 / (double)v_code4_cnt; }
			if(v_code5_cnt != 0){ v_code5_avg = v_code5 / (double)v_code5_cnt; }
			if(v_code6_cnt != 0){ v_code6_avg = v_code6 / (double)v_code6_cnt; }
			if(v_code7_cnt != 0){ v_code7_avg = v_code7 / (double)v_code7_cnt; }
			
			
			//과거에 등록된 아이디 존재 여부 체크
			getSuleachCheck = lmsSqlDao.selectDAO("myLctrumDAO.getSuleachCheck", param);
			log.info("과거에 등록된 아이디 존재 여부 체크 완료!");
			
			
			//과거에 등록된 사용자 정보가 없을 경우 설문 결과를 등록하도록 함
			if(getSuleachCheck == null){
				
				log.info("설문결과 등록 s");
				
				//자원등록
				param.put("code1", v_code1);
				param.put("code2", v_code2);
				param.put("code3", v_code3);
				param.put("code4", v_code4);
				param.put("code5", v_code5);
				param.put("code6", v_code6);
				param.put("code7", v_code7);
				
				param.put("code1_avg", v_code1_avg);
				param.put("code2_avg", v_code2_avg);
				param.put("code3_avg", v_code3_avg);
				param.put("code4_avg", v_code4_avg);
				param.put("code5_avg", v_code5_avg);
				param.put("code6_avg", v_code6_avg);
				param.put("code7_avg", v_code7_avg);
				
				param.put("distcode10", v_distcode10);
				log.info("설문결과 등록을 위한 자원 등록 완료!");
				
				//설문결과 등록
				lmsSqlDao.insertDAO("myLctrumDAO.sulResultInsert", param);
				
				log.info("설문결과 등록 완료!");
				log.info("설문결과 등록 e");
				
			}else{
				result = -3;
				system_msg = "이미 해당 설문에 응답하셨습니다!";
				log.info(system_msg);
				model.addAttribute("system_msg", system_msg);
				model.addAttribute("result", result);
				
				return;
			}
			
			result = 1;
			system_msg = "설문에 응답해 주셔서 감사합니다!";
			log.info(system_msg);
			model.addAttribute("system_msg", system_msg);
			model.addAttribute("result", result);
			
			return;
			
		//설문지 번호가 없는 경우
		}else{
			result = -2;
			system_msg = "설문지 번호를 찾을 수 없습니다.\n다시 전 화면으로 이동하여 다시 시도해주세요!";
			log.info(system_msg);
			model.addAttribute("system_msg", system_msg);
			model.addAttribute("result", result);
			
			return;
		}
		
		
		
	}
	
	
	
	
	/**
	 * 추천학습경로
	 */
	public void listRecomendLrnCours(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		
		//스크랩한 교육체계도 목록
		List<ZValue> edcSystmList = lmsSqlDao.listDAO("edcSystmDAO.edcSystmList", param);
		model.addAttribute("edcSystmList",edcSystmList);
		
		//방송영상 교육체계도 5levle 목록
		List<ZValue> brdcstEdcSystmCList = lmsSqlDao.listDAO("edcSystmDAO.brdcstEdcSystmCList", param);
		model.addAttribute("brdcstEdcSystmCList",brdcstEdcSystmCList);
		
	}
	
	/**
	 * 학습이력
	 */
	public void listLessonHistory(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());
		param.put("grcode", "N000001");
		
		//방송영상 교육체계도 5levle 목록
		List<ZValue> lessonHistoryList = lmsSqlDao.listDAO("myLctrumDAO.lessonHistoryList", param);
		model.addAttribute("lessonHistoryList",lessonHistoryList);
		
		//방송영상 교육체계도 5levle 목록
		List<ZValue> lessonHistoryListCnt = lmsSqlDao.listDAO("myLctrumDAO.lessonHistoryListCnt", param);
		model.addAttribute("lessonHistoryListCnt",lessonHistoryListCnt);
		
	}

	/**
	 * 온라인교육 학습중인 과정 수 조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void selectMyStudyCount(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		int studyCount = 0;
		try{
			
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			param.put("userid", user.getUserId());
			param.put("grcode", "N000001");
			
			// 온라인교육 학습중인과정 수
			studyCount = lmsSqlDao.selectCount("myLctrumDAO.selectMyStudyCount", param);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("studyCount", studyCount);
	}
}
