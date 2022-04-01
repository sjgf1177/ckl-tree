package kr.co.unp.cmm.crud.listener;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import kr.co.unp.cmm.crud.service.ParameterContext;

public class CompositeCmmProgramListener<T> implements CmmProgramListener<T> {

	private List<CmmProgramListener<T>> listeners = new ArrayList<CmmProgramListener<T>>();
	
	public void setListeners(List<? extends CmmProgramListener<T>> listeners){
		this.listeners.addAll(listeners);
	}
	
	public void register(CmmProgramListener<T> listener){
		this.listeners.add(listener);
	}
	
	@Override
	public boolean before(ParameterContext<T> paramCtx) throws Exception {
		for(CmmProgramListener<T> listener : listeners){
			if( !listener.before(paramCtx) ){
				return STOP;
			}
		}
		return CONTINUE;
	}

	@Override
	public boolean after(ParameterContext<T> paramCtx) throws Exception {
		List<CmmProgramListener<T>> reversListeners = new ArrayList<CmmProgramListener<T>>(listeners);
		Collections.reverse(reversListeners);
		for(CmmProgramListener<T> listener : reversListeners){
			if( !listener.after(paramCtx) ){
				return STOP;
			}
		}
		return CONTINUE;
	}

}
