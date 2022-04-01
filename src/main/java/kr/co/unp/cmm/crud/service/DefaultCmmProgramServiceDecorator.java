package kr.co.unp.cmm.crud.service;

import kr.co.unp.cmm.crud.listener.CmmProgramListenerContainer;


public class DefaultCmmProgramServiceDecorator<T> implements CmmProgramService<T> {

	private AbstractCmmProgramService<T> service;

	@Override
	public void list(ParameterContext<T> paramCtx) throws Exception {
		service.list(paramCtx);
	}

	@Override
	public void view(ParameterContext<T> paramCtx) throws Exception {
		service.view(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext<T> paramCtx) throws Exception {
		service.forInsert(paramCtx);
	}

	@Override
	public void insert(ParameterContext<T> paramCtx) throws Exception {
		service.insert(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<T> paramCtx) throws Exception {
		service.forUpdate(paramCtx);
	}

	@Override
	public void update(ParameterContext<T> paramCtx) throws Exception {
		service.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<T> paramCtx) throws Exception {
		service.delete(paramCtx);
	}

	@Override
	public void downloadExcel(ParameterContext<T> paramCtx) throws Exception {
		service.downloadExcel(paramCtx);
	}

	@Override
	public void uploadExcel(ParameterContext<T> paramCtx) throws Exception {
		service.uploadExcel(paramCtx);
	}

	public AbstractCmmProgramService<T> getService() {
		return service;
	}

	public void setService(AbstractCmmProgramService<T> service) {
		this.service = service;
	}

	@Override
	public CmmProgramListenerContainer<T> getListenerContainer() {
		return service.getListenerContainer();
	}

}
