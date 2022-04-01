package kr.co.unp.cmm.crud.listener;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import kr.co.unp.cmm.crud.service.ParameterContext;

public class CompositeCmmProgramListenerContainer<T> extends CmmProgramListenerContainer<T> {

	private List<CmmProgramListenerContainer<T>> listenerContainers = new ArrayList<CmmProgramListenerContainer<T>>();
	
	public void setListeners(List<? extends CmmProgramListenerContainer<T>> listenerContainers){
		this.listenerContainers.addAll(listenerContainers);
	}
	
	public void register(CmmProgramListenerContainer<T> listenerContainer){
		this.listenerContainers.add(listenerContainer);
	}
	
	@Override
	public boolean before(ParameterContext<T> paramCtx) throws Exception {
		String targetMethod = paramCtx.getTargetMethod();
		for(CmmProgramListenerContainer<T> listenerContainer : listenerContainers){
			if( listenerContainer.canExecute(targetMethod) ) {
				if( !listenerContainer.getCmmProgramListener().before(paramCtx) ) {
					return STOP;
				}
			}
		}
		return CONTINUE;
	}

	@Override
	public boolean after(ParameterContext<T> paramCtx) throws Exception {
		String targetMethod = paramCtx.getTargetMethod();
		List<CmmProgramListenerContainer<T>> reversListenerContainers = new ArrayList<CmmProgramListenerContainer<T>>(listenerContainers);
		Collections.reverse(reversListenerContainers);
		for(CmmProgramListenerContainer<T> listenerContainer : reversListenerContainers){
			if( listenerContainer.canExecute(targetMethod) ) {
				if( !listenerContainer.getCmmProgramListener().after(paramCtx) ) {
					return STOP;
				}
			}
		}
		return CONTINUE;
	}

}
