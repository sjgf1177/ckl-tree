package kr.co.unp.cmm.crud.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.service.ParameterContext;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
/**
 * 타입이 SearchVO를 확장한 VO인 CRUD를 위한 모든 컨트롤러는 이 컨트롤러를 확장한다.
 * @author KHD
 *
 * @param <T> SearchVO를 확장한 VO객체
 */
public abstract class VoCmmProgramController<T extends SearchVO> extends AbstractCmmProgramController<T> {

	Logger log = Logger.getLogger(this.getClass());

	@RequestMapping("/{targetMethod}")
	public ModelAndView invoke(@ModelAttribute("paramVO") T paramVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return super.invoke(paramVO, request, response, model);
	}

	@Override
	protected String getTargetMethod(ParameterContext<T> paramCtx){
		return paramCtx.getParam().getTargetMethod();
	}
}
