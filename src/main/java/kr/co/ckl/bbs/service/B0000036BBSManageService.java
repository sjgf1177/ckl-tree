package kr.co.ckl.bbs.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.unp.bbs.service.OptionalBBSManageService;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class B0000036BBSManageService extends OptionalBBSManageService {

	Logger log = Logger.getLogger(this.getClass());

	public  B0000036BBSManageService() {
		super();
	}

	public void join01(ParameterContext<ZValue> paramCtx) throws Exception {
		HttpServletRequest request=  paramCtx.getRequest();
		HttpSession joinRequest =  request.getSession();
		joinRequest.removeAttribute("joinInfo");
	}

	public void join02(ParameterContext<ZValue> paramCtx) throws Exception{
		HttpServletRequest request=  paramCtx.getRequest();
		HttpSession joinRequest =  request.getSession();
		joinRequest.removeAttribute("joinInfo");
	}
	public void join03(ParameterContext<ZValue> paramCtx) throws Exception{
		// 파일업로드
		super.uploadFile(paramCtx);

		HttpServletRequest request=  paramCtx.getRequest();
		//파라메터 변경  파일 포함 데이터 저장
		ZValue resultInfo = paramCtx.getParam();
		// 파일 불러오기 위한 모델 생성
		ModelMap result = paramCtx.getModel();
		//모델에 입힌후 RESULT 값에 담긴 정보 파일 ID를 위해 저장
		result.addAttribute(RESULT, resultInfo);
		// 파일 불러오기! ** FileList로 불러와서 파라메터로 쓸수있음  **
		super.getFiles(paramCtx);
		// 세션에서 불러와 FORM 데이터를 세션에 저장
		HttpSession joinSession =  request.getSession();
		joinSession.setAttribute("joinInfo", resultInfo);

	}
	public void join04(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param =  paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request=  paramCtx.getRequest();
		HttpSession joinSession = request.getSession();
		ZValue joinInfo = (ZValue) joinSession.getAttribute("joinInfo");
		model.addAttribute("result", joinInfo);
		joinSession.removeAttribute("joinInfo");
		/* removeAttribute("비울이름")세션 비우 기 */
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		 ZValue param  = paramCtx.getParam();
		 HttpServletRequest request=  paramCtx.getRequest();
		 ModelMap model = paramCtx.getModel();
		if(SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){
			super.insert(paramCtx);
		}else {
			// 세션가져오기
			HttpSession joinSession = request.getSession();
			// 파라메터 분리
			ZValue joinInfo = (ZValue) joinSession.getAttribute("joinInfo");
			//세션에서 가져온 파라메터 읽어와 paramCtx 저장
			paramCtx.setParam(joinInfo);
			super.insert(paramCtx);
			StringBuilder url = new StringBuilder("/edu/bbs/B0000036/join04.do");
			url.append("?").append("nttId=").append(paramCtx.getPkValue()).append("&menuNo=").append(param.getString("menuNo"));
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

		}

	}


}
