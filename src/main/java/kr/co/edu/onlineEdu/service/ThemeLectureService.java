package kr.co.edu.onlineEdu.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import kr.co.edu.onlineEdu.paging.ThemeLecturePageInfo;
import kr.co.unp.cmm.crud.paging.PageInfo;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;
import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class ThemeLectureService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	@Resource(name = "themeLecturePageInfo")
    private ThemeLecturePageInfo ThemeLecturePageInfo;

	@Resource(name = "pageInfo")
	private PageInfo pageInfo;

	public ThemeLectureService() {
		super();
	}
	
	/**
	 * 메인화면
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.setCountQueryId("themeListDAO.selectMainThemeListCnt");
		super.setListQueryId("themeListDAO.selectMainThemeList");

		paramCtx.setParam(param);
		paramCtx.setSqlDAO(lmsSqlDao);
		super.list(paramCtx);
	}
	
	@SuppressWarnings("deprecation")
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		/* 키값 체크 */
		if(!"".equals(param.getString("pId")) ){
			String sId = lmsSqlDao.selectString("themeListDAO.selectThemeStatusCheck", param);
			if(sId == null || sId.equals("")){
				MVUtils.goUrl("/edu/main/main.do", "진행중인 테마과정이 아닙니다.", model);
				return;
			}
			param.put("pId", sId);
		}
		
		List<ZValue> themeSubjList = lmsSqlDao.listDAO("themeListDAO.selectThemeSubjList", param);
		model.addObject("themeSubjList", themeSubjList);
		
		paramCtx.setSqlDAO(lmsSqlDao);
		super.setViewQueryId("themeListDAO.selectViewTheme");
		super.view(paramCtx);
	}
	
	@SuppressWarnings("unchecked")
	public void studySubjReg(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		String sReturnCode = "needLogin";
		int sReturnSubjCnt = 0;
		int sReturnGoldClassCnt = 0;
		
		log.debug(user);
		/*로그인 여부 체크 */
		if(!user.getUserId().isEmpty() && !user.getUserId().equals("") && !user.getUserId().equals(null) && !user.getUserId().equals("anonymousUser")){
			String loginUserId = user.getUserId();
			
			//해당 아이디가 유효한 계정인지 체크
			param.put("userid", loginUserId);
			param.put("grcode", "N000001");
			ZValue memberCheck = lmsSqlDao.selectDAO("myLctrumDAO.memberCheck", param);
			
			//member 테이블에 존재하는 아이디일 경우
			if(memberCheck.getInt("membercnt") > 0){
				String tran_date = "";
				
				DateFormat df = new SimpleDateFormat("yyyyMMdd");
				Date dt = new Date();
				tran_date = df.format(dt);
				Calendar cal = Calendar.getInstance();
		        cal.setTime(dt);
		        cal.add(Calendar.MONTH,1);
		        cal.add(Calendar.DATE,-1);
		        
				List<String> pCourseIdList = JSONArray.fromObject(param.getString("p_course_id"));
				for(int i = 0; i < pCourseIdList.size(); i++){
					ZValue pParam = new ZValue();
					pParam.putObject("userid", loginUserId);
					pParam.putObject("grcode", "N000001");
					pParam.putObject("pCourseId", pCourseIdList.get(i));
					ZValue courseInfo = lmsSqlDao.selectDAO("themeListDAO.getCourseInfo", pParam); //과정 정보 가져오기
					
					if(courseInfo.getString("type").equals("S")){ //정규 강좌 일 경우
						pParam.putObject("s_subj", courseInfo.getString("courseId"));
						pParam.putObject("s_subjseq", courseInfo.getString("subjseq"));
						pParam.putObject("s_year", courseInfo.getString("year"));
						pParam.putObject("eduEnd", df.format(cal.getTime()));
						
						//학습중인지 체크
						ZValue subjDuplCheck = lmsSqlDao.selectDAO("myLctrumDAO.subjDuplCheck", pParam);
						int subjdupl = subjDuplCheck.getInt("cnt");
						log.info("subjdupl ==> "+subjdupl);
						if(subjdupl < 1){ // 학습중인 과정이 없다면
							log.info("수강신청 로직 시작!!!!");
							//수강신청
							//학습이력 백업 insert into tz_lesson_history
							//학습이력 삭제 tz_propose, tz_student, tz_progress, tz_stold(수료번호는 tz_stold, tz_stold_history)
							lmsSqlDao.insertDAO("myLctrumDAO.lessonHistoryInsert", pParam);
							lmsSqlDao.insertDAO("myLctrumDAO.proposeDelete", pParam);
							lmsSqlDao.insertDAO("myLctrumDAO.studentDelete", pParam);
							lmsSqlDao.insertDAO("myLctrumDAO.progressDelete", pParam);
							lmsSqlDao.insertDAO("myLctrumDAO.stoldDelete", pParam);
						
							lmsSqlDao.insertDAO("myLctrumDAO.proposeInsert", pParam);
							lmsSqlDao.insertDAO("myLctrumDAO.studentInsert", pParam);
							log.info("수강신청 완료!!!!");
							sReturnSubjCnt++;
							
							/* SMS 발송 */
							String toPhone = "";
							String fromPhone = "";
							String v_msg = "";
							String tDate = "";
							
							tDate = tran_date.substring(4, 6) + "월 " + tran_date.substring(6, 8) + "일 ";
							if(courseInfo.getString("courseName").length() > 13)
								v_msg = tDate + courseInfo.getString("courseName").substring(0, 12) + "..";
							else
								v_msg = tDate + courseInfo.getString("courseName");
							
							log.info("v_msg ==> "+v_msg);
							fromPhone = "02-6310-0770";
							
							//전화번호 가져오기
							ZValue getNumber = lmsSqlDao.selectDAO("myLctrumDAO.getNumber", pParam);
							if(getNumber != null){
								toPhone = getNumber.getString("handphone");
								log.debug("toPhone ::: " + toPhone);
								v_msg = "[EDUKOCCA]\n" + v_msg + " 학습이 시작되었습니다.";
								
								//SMS 전송(DB 저장)
								boolean sms_result = false;
								sms_result = this.sendSMSMsg(paramCtx, toPhone, fromPhone, v_msg, "");
								log.info("SMS 전송(DB 저장) 결과: ["+sms_result+"]");
							}
						}
					}else{ //열린 강좌 일 경우
						lmsSqlDao.updateDAO("themeListDAO.updateUserGoldClassList", pParam);
						sReturnGoldClassCnt++;
					}
				}
			}
			sReturnCode = "success";
		}
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("sReturnCode", sReturnCode);
		resultMap.put("sReturnSubjCnt", sReturnSubjCnt);
		resultMap.put("sReturnGoldClassCnt", sReturnGoldClassCnt);
		model.addAttribute("result", resultMap);
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
		}
		return result;
	}
}
