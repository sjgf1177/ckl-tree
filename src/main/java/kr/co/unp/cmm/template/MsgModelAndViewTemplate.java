package kr.co.unp.cmm.template;

import kr.co.unp.bbs.mvr.BbsModelAndViewResolver;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public abstract class MsgModelAndViewTemplate<T> {
	Logger log = Logger.getLogger(this.getClass());

	public abstract void callback(T t, ModelMap model) throws Exception;
	
	public void processTemplate(String successMsg, String errorMsg, T t, ModelMap model){
		
		String resultCode = ModelAndViewResolver.SUCCESS;
		String msg = successMsg;
		try {
			callback(t, model);
		} catch (Exception e) {
			e.printStackTrace();
			resultCode = BbsModelAndViewResolver.ERROR;
			msg = errorMsg;
			throw new RuntimeException(e);
		}
		if( model.get(ModelAndViewResolver.RESULT_CODE_KEY) == null )
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, resultCode);
		if( model.get(ModelAndViewResolver.MSG_KEY) == null )
			model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
		
		log.debug("RESULT_CODE_KEY : " + resultCode + ",MSG_KEY : " + msg);
	}

}
