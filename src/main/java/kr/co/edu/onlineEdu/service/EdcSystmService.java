package kr.co.edu.onlineEdu.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;


public class EdcSystmService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	public EdcSystmService() {
		super();

	}


	/**
	 * 교육체계도 목록
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		/*//방송영상 교육체계도 3levle 목록
		List<ZValue> brdcstEdcSystmAList = lmsSqlDao.listDAO("edcSystmDAO.brdcstEdcSystmAList", param);
		model.addAttribute("brdcstEdcSystmAList",brdcstEdcSystmAList);

		//방송영상 교육체계도 4levle 목록
		List<ZValue> brdcstEdcSystmBList = lmsSqlDao.listDAO("edcSystmDAO.brdcstEdcSystmBList", param);
		model.addAttribute("brdcstEdcSystmBList",brdcstEdcSystmBList);

		//방송영상 교육체계도 5levle 목록
		List<ZValue> brdcstEdcSystmCList = lmsSqlDao.listDAO("edcSystmDAO.brdcstEdcSystmCList", param);
		model.addAttribute("brdcstEdcSystmCList",brdcstEdcSystmCList);*/
		
		List<ZValue> eduSystemAList = lmsSqlDao.listDAO("edcSystmDAO.eduSystemAList", param);
		model.addAttribute("eduSystemAList", eduSystemAList);
		
		List<ZValue> eduSystemBList = lmsSqlDao.listDAO("edcSystmDAO.eduSystemBList", param);
		model.addAttribute("eduSystemBList", eduSystemBList);
		
		List<ZValue> eduSystemSubjList = lmsSqlDao.listDAO("edcSystmDAO.eduSystemSubjList", param);
		model.addAttribute("eduSystemSubjList", eduSystemSubjList);

	}


	/**
	 * 교육체계도 스크랩
	 * @param paramCtx
	 * @throws Exception
	 */
	public void eduSystmScrapInsert(ParameterContext<ZValue> paramCtx) throws Exception {
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

		if("".equals(userId) || "anonymousUser".equals(userId)){
			system_msg = "로그인 후 스크랩 할 수 있습니다!";
			log.info(system_msg);
			result = -1;

		}else{

			ZValue getScrapInfo = lmsSqlDao.selectDAO("edcSystmDAO.getScrapInfo", param);

			if(getScrapInfo != null){
				system_msg = "해당 교육체계도는 이미 스크랩되었습니다!";
				log.info(system_msg);
				result = -3;

			}else{

				lmsSqlDao.insertDAO("edcSystmDAO.eduSystmScrapInsert", param);
				system_msg = "해당 교육체계도가 스크랩 되었습니다!";
				result = 1;
			}
		}

		model.addAttribute("system_msg", system_msg);
		model.addAttribute("result", result);
	}



	/**
	 * 교육체계도 스크랩 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	public void eduSystmScrapDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		int result = 0;
		String system_msg = "";

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userid", user.getUserId());

		//교육체계도 스크랩 삭제
		result = lmsSqlDao.deleteDAO("edcSystmDAO.eduSystmScrapDelete", param);

		if(result > -1){
			system_msg = "정상적으로 삭제되었습니다!";
		}else{
			system_msg = "해당 작업 진행중 오류가 발생했습니다!";
		}
		String goUrl = "/edu/onlineEdu/mylctrum/listRecomendLrnCours.do?menuNo="+param.getString("menuNo");
		StringBuilder url = new StringBuilder(goUrl);
		MVUtils.goUrl(url.toString(), system_msg, model);

	}



	/**
	 * 해당과정 목록 그리기
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listSubj(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		StringBuffer sb = null;

		String v_chartcode = "";
		v_chartcode = param.getString("p_chartcode");	//교육체계분류 코드

		String v_chartcodename = "";

		//1.교육체계 분류 코드가 있을경우에만 해당 과정 목록을 가져옴
		if(v_chartcode != null && !v_chartcode.equals("")){

			//5depth 경로에 연결된 과정 목록
			List<ZValue> eduSystmSubjList = lmsSqlDao.listDAO("edcSystmDAO.eduSystmSubjList", param);


			sb = new StringBuffer();

			if(eduSystmSubjList != null && eduSystmSubjList.size() > 0){

				v_chartcodename = (String) eduSystmSubjList.get(0).getString("chartname");

				sb.append("<li>");
				sb.append("<strong>"+v_chartcodename+"</strong>");
				sb.append("<ol class=\"decimal\">");

				for(int i = 0; i < eduSystmSubjList.size(); i++){
					ZValue item = (ZValue) eduSystmSubjList.get(i);

					sb.append("<li><a href=\"#\" onclick=\"fnCmdViewPage('"+item.getString("subj")+"', '"+item.getString("year")+"', '"+item.getString("subjseq")+"'); return false;\">"+item.getString("subjnm")+"</a></li>");
				}
				sb.append("</ol></li>");
			}
		}

		if (sb == null) sb =  new StringBuffer();
		String str = sb.toString();
		model.addAttribute("listSubj",str);

	}








}
