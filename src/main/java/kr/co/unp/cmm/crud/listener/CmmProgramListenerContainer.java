package kr.co.unp.cmm.crud.listener;

import java.util.Set;

import kr.co.unp.cmm.crud.service.ParameterContext;

import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

public class CmmProgramListenerContainer<T> implements CmmProgramListener<T> {

	private String targetMethods;
	private CmmProgramListener<T> cmmProgramListener;
	
	public Set<String> getTargetMethodSet(){
		Set<String> result = null;
		if( StringUtils.hasText(targetMethods) ) {
			result = StringUtils.commaDelimitedListToSet(targetMethods);
		}
		return result;
	}
	
	public boolean canExecute(String targetMethod) {
		Set<String> targetMethodSet = getTargetMethodSet();
		if( CollectionUtils.isEmpty(targetMethodSet) ) {
			return true;
		}
		
		return targetMethodSet.contains(targetMethod);
	}

	public String getTargetMethods() {
		return targetMethods;
	}

	public void setTargetMethods(String targetMethods) {
		this.targetMethods = targetMethods;
	}

	public CmmProgramListener<T> getCmmProgramListener() {
		return cmmProgramListener;
	}

	public void setCmmProgramListener(CmmProgramListener<T> cmmProgramListener) {
		this.cmmProgramListener = cmmProgramListener;
	}

	@Override
	public boolean before(ParameterContext<T> paramCtx) throws Exception {
		String targetMethod = paramCtx.getTargetMethod();
		if( canExecute(targetMethod) ) {
			if( !getCmmProgramListener().before(paramCtx) ) {
				return STOP;
			}
		}
		return CONTINUE;
	}

	@Override
	public boolean after(ParameterContext<T> paramCtx) throws Exception {
		String targetMethod = paramCtx.getTargetMethod();
		if( canExecute(targetMethod) ) {
			if( !getCmmProgramListener().after(paramCtx) ) {
				return STOP;
			}
		}
		return CONTINUE;
	}
	
	
}
