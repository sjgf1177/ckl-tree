package kr.co.unp.bbs.service;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

public interface FnwBBSManageService extends CmmProgramService<ZValue>{

	public void delPermanently(ParameterContext<ZValue> paramCtx) throws Exception;

	public void restore(ParameterContext<ZValue> paramCtx) throws Exception;

	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception;

	public void initValue(ZValue param, UsersVO usersVO);

	public void rssService(ParameterContext<ZValue> paramCtx) throws Exception;

}
