package kr.co.unp.cmm.crud.service;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.handler.VoListHander;
import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.cmm.crud.paging.VoPageQuery;

import org.springframework.beans.factory.InitializingBean;

public class VoCmmProgramService<T extends SearchVO> extends AbstractCmmProgramService<T> implements InitializingBean {

	@Resource(name = "voListHandler")
	protected VoListHander<T> listHandler;

	protected PageQuery<T> pageQuery = new VoPageQuery<T>();
	@Override
	public void afterPropertiesSet() throws Exception {
		super.setListHandler(listHandler);
		super.setPageQuery(pageQuery);
	}
}
