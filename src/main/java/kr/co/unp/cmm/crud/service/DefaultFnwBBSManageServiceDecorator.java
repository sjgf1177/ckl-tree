package kr.co.unp.cmm.crud.service;

import kr.co.unp.bbs.service.FnwBBSManageService;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerContainer;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;


public class DefaultFnwBBSManageServiceDecorator implements FnwBBSManageService {

	private FnwBBSManageService service;

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		service.list(paramCtx);
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		service.view(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		service.forInsert(paramCtx);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		service.insert(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		service.forUpdate(paramCtx);
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		service.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		service.delete(paramCtx);
	}

	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		service.downloadExcel(paramCtx);
	}

	@Override
	public void uploadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		service.uploadExcel(paramCtx);
	}

	@Override
	public void delPermanently(ParameterContext<ZValue> paramCtx) throws Exception {
		service.delPermanently(paramCtx);
	}

	@Override
	public void restore(ParameterContext<ZValue> paramCtx) throws Exception {
		service.restore(paramCtx);
	}

	@Override
	public void rssService(ParameterContext<ZValue> paramCtx) throws Exception {
		service.rssService(paramCtx);
	}

	public FnwBBSManageService getService() {
		return service;
	}

	public void setService(FnwBBSManageService service) {
		this.service = service;
	}

	@Override
	public void initValue(ZValue param, UsersVO usersVO) {
		service.initValue(param, usersVO);
	}

	@Override
	public CmmProgramListenerContainer<ZValue> getListenerContainer() {
		return service.getListenerContainer();
	}

}
