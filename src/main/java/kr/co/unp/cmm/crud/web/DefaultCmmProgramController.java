package kr.co.unp.cmm.crud.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;
/**
 * 타입이 ZValue인 CRUD를 위한 모든 컨트롤러는 이 컨트롤러를 확장한다.
 * @author KHD
 *
 */
public class DefaultCmmProgramController extends AbstractCmmProgramController<ZValue> {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping("/{targetMethod}")
	public ModelAndView invoke(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		
		
//		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		
		ZValue paramVO = WebFactory.getAttributes(request);
		return invoke(paramVO, request, response, model);
	}
	
	
	@RequestMapping( value = "/test.do", method = RequestMethod.POST )
	public @ResponseBody Map<String, Object> getRequestReport( @RequestParam(required = false)int programRequestSeq){
		
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put( "result", true );
		result.put( "message", "aasdfasdf");
		result.put( "data", 5 );
		
		
		return result;
	}

	@Override
	protected ParameterContext<ZValue> setProperty(HttpServletRequest request, HttpServletResponse response, ZValue param, ModelMap model) throws Exception{
		ParameterContext<ZValue> paramCtx = super.setProperty(request, response, param, model);
		//패스버라이어블을 파라미터에 담기 VO형은 기본적으로 담겨져 있음
		@SuppressWarnings("unchecked")
		Map<String, String> uriTemplateVars = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
		if( uriTemplateVars != null ){
			param.putAll(uriTemplateVars);
		}
		model.addAttribute("paramVO", param);
		return paramCtx;
	}

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx){
		return paramCtx.getParam().getString(CmmProgramService.PROGRAM_ID);
	}

	@Override
	protected String getTargetMethod(ParameterContext<ZValue> paramCtx) {
		return paramCtx.getParam().getString("targetMethod");
	}
}
