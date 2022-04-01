package kr.co.unp.cmm.crud.handler;

import java.security.InvalidParameterException;
import java.util.ArrayList;
import java.util.List;

import kr.co.unp.cmm.crud.service.ParameterContext;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.util.CollectionUtils;

public class HandlerComposite<T> implements Handler<T>, ApplicationContextAware {

	private ApplicationContext context;
	private List<Object> handlers = new ArrayList<Object>();

	public HandlerComposite(Object ...handler){
		@SuppressWarnings("unchecked")
		List<Handler<T>> _handlers = CollectionUtils.arrayToList(handler);
		this.handlers.addAll(_handlers);
	}

	@SuppressWarnings("unchecked")
	public boolean invoke(ParameterContext<T> paramCtx) throws Exception{
		Handler<T> _handler = null;
		for(Object handler : handlers){
			if( handler instanceof String ){
				_handler = (Handler<T>)context.getBean((String)handler);
				if( !_handler.invoke(paramCtx) ) return false;
			}
			else{
				_handler = (Handler<T>)handler;
				if( !_handler.invoke(paramCtx) ) return false;
			}
		}
		return true;
	}

	public void addAll(List<Handler<T>> handlers){
		this.handlers.addAll(handlers);
	}

	public void add(Object handler){
		if( handler instanceof String || handler instanceof Handler ){
		}
		else{
			throw new InvalidParameterException();
		}
		this.handlers.add(handler);
	}

	public void remove(Object handler){
		if( handler instanceof String || handler instanceof Handler ){
		}
		else{
			throw new InvalidParameterException();
		}
		this.handlers.remove(handler);
	}

	public List<Object> getHandlers() {
		return handlers;
	}

	public void setHandlers(List<Object> handlers) {
		this.handlers = handlers;
	}

	@Override
	public void setApplicationContext(ApplicationContext context) throws BeansException {
		this.context = context;
	}

}
