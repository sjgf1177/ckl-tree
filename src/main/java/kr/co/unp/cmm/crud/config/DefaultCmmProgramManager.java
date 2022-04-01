package kr.co.unp.cmm.crud.config;

import java.util.Map;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class DefaultCmmProgramManager<T> implements CmmProgramManager<T>, ApplicationContextAware {

	Logger log = Logger.getLogger(this.getClass());

	protected ApplicationContext applicationContext;

	protected Map<String, String> serviceNameMap;

	protected Map<String, String> mvrNameMap;

	protected Map<String, String> validatorNameMap;

	@Override
	@SuppressWarnings("unchecked")
	public CmmProgramService<T> getService(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		String programId = (String)PropertyUtils.getProperty(param, CmmProgramService.PROGRAM_ID);
		String targetName = serviceNameMap.get(programId);
		//targetName이 없는경우 programId + Service
		//ex) programId가 siteMng일경우 서비스명은 siteMngService
		if( targetName == null ) targetName = programId + "Service";
		if( log.isDebugEnabled() ){
			log.debug("real bean is [" + targetName + "]");
		}
		return (CmmProgramService<T>)applicationContext.getBean(targetName);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ModelAndViewResolver<T> getModelAndViewResolver(ParameterContext<T> paramCtx) throws Exception {
		T param = paramCtx.getParam();
		String programId = (String)PropertyUtils.getProperty(param, CmmProgramService.PROGRAM_ID);
		String targetName = mvrNameMap.get(programId);
		//targetName이 없는경우 programId + ProgramService
		//ex) programId가 siteMng일경우 서비스명은 siteMngProgramService
		if( targetName == null ) targetName = mvrNameMap.get(DEFAULT_KEY);
		if( log.isDebugEnabled() ){
			log.debug("real bean is [" + targetName + "]");
		}
		return (ModelAndViewResolver<T>)applicationContext.getBean(targetName);
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext)throws BeansException {
		this.applicationContext = applicationContext;
	}

	public Map<String, String> getServiceNameMap() {
		return serviceNameMap;
	}

	public void setServiceNameMap(Map<String, String> serviceNameMap) {
		this.serviceNameMap = serviceNameMap;
	}

	public Map<String, String> getMvrNameMap() {
		return mvrNameMap;
	}

	public void setMvrNameMap(Map<String, String> mvrNameMap) {
		this.mvrNameMap = mvrNameMap;
	}

	public Map<String, String> getValidatorNameMap() {
		return validatorNameMap;
	}

	public void setValidatorNameMap(Map<String, String> validatorNameMap) {
		this.validatorNameMap = validatorNameMap;
	}
}
