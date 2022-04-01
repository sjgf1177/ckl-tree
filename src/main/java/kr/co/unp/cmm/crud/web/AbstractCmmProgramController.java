package kr.co.unp.cmm.crud.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.config.DefaultCmmProgramManager;
import kr.co.unp.cmm.crud.listener.CmmProgramListener;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.StrUtils;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.MethodInvoker;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.utl.sim.service.EgovClntInfo;
/**
 * CRUD콘트롤러를 위한 추상화컨트롤러이다.
 * 키값이되는 programId로 서비스를 찾는다. 게시판의 경우 bbsId가 될수 있음.
 * 찾은 서비스는 실제구현서비스이며 컨트롤러의 패스버라이어블 targetMethod로
 * 동적으로 메소드를 찾아 실행한다.
 * @author KHD
 *
 * @param <T> - SearchVO를 확장한 VO나 ZValue만 허용한다.
 */
public abstract class AbstractCmmProgramController<T> {

	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 키값인 programId로 실제 구현 서비스와 뷰값을 가져오기 위한 팩토리객체
	 */
    @Resource(name = "defaultCmmProgramManager")
    protected DefaultCmmProgramManager<T> programManager;

	public ModelAndView invoke(T paramVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ParameterContext<T> paramCtx = setProperty(request, response, paramVO, model);
		String programId = getProgramId(paramCtx);
		PropertyUtils.setProperty(paramVO, CmmProgramService.PROGRAM_ID, programId);
		CmmProgramService<T> service = programManager.getService(paramCtx);

		doInvoke(service, paramCtx);

		ModelAndViewResolver<T> mvr = programManager.getModelAndViewResolver(paramCtx);
    	return mvr.getModelAndView(paramCtx);
	}

	public void doInvoke(CmmProgramService<T> service, ParameterContext<T> paramCtx) throws Exception{
		paramCtx.setTargetMethod(getTargetMethod(paramCtx));
		//메소드 실행하기전 등록된 리스너 실행 CompositeCmmProgramListener 인경우 리스너순차적실행
		CmmProgramListener<T> listener = service.getListenerContainer();
		if( listener != null ){
			if( !listener.before(paramCtx) ){
				return;
			}
		}
				
		MethodInvoker invoker = new MethodInvoker();
		invoker.setTargetObject(service);
		invoker.setTargetMethod(getTargetMethod(paramCtx));
		invoker.setArguments(new Object[]{paramCtx});
		invoker.prepare();
		invoker.invoke();

		//메소드 실행후 리스너 실행 CompositeCmmProgramListener경우 역순으로 실행
		if( listener != null ){
			if( !listener.after(paramCtx) ){
				return;
			}
		}
	}

	protected ParameterContext<T> setProperty(HttpServletRequest request, HttpServletResponse response, T param, ModelMap model) throws Exception{
		ParameterContext<T> paramCtx = new ParameterContext<T>();
		paramCtx.setParam(param);
		paramCtx.setRequest(request);
		paramCtx.setResponse(response);
		paramCtx.setModel(model);
		paramCtx.setUserIp(EgovClntInfo.getClntIP(request));

		if( request instanceof MultipartHttpServletRequest ){
			paramCtx.setFiles(((MultipartHttpServletRequest)request).getFileMap());
		}

		String siteName = (String)PropertyUtils.getProperty(param, CmmProgramService.SITE_NAME);
		if( !StringUtils.hasText(siteName) ){
			siteName = StrUtils.split(request.getRequestURI(), "/")[1];
			PropertyUtils.setProperty(param, CmmProgramService.SITE_NAME, siteName);
		}
		return paramCtx;
	}

	public DefaultCmmProgramManager<T> getProgramManager() {
		return programManager;
	}

	public void setProgramManager(DefaultCmmProgramManager<T> programManager) {
		this.programManager = programManager;
	}

	/**
	 * 실제구현 서비스를 찾기위한 키값가져오기
	 * @param paramCtx HttpServletRequest, HttpServletResponse, Model, Parameter등의 정보를 담고있다.
	 * @return 구현서비스를 찾을키값
	 */
	protected abstract String getProgramId(ParameterContext<T> paramCtx);

	/**
	 * 실제구현 서비스의 메소드명 가져오기
	 * @param paramCtx HttpServletRequest, HttpServletResponse, Model, Parameter등의 정보를 담고있다.
	 * @return 구현서비스 실행 메소드
	 */
	protected abstract String getTargetMethod(ParameterContext<T> paramCtx);
}
