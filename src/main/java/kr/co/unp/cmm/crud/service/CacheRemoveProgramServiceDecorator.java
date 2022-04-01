package kr.co.unp.cmm.crud.service;

import javax.annotation.Resource;

import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.util.Assert;

public class CacheRemoveProgramServiceDecorator extends DefaultCmmProgramServiceDecorator<ZValue> implements InitializingBean {

	@Resource(name = "cacheUtil")
	protected CacheUtil cacheUtil;
	private String cacheName;

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.hasText(cacheName);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.insert(paramCtx);

		cacheUtil.remove(cacheName);
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		super.update(paramCtx);

		cacheUtil.remove(cacheName);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		super.delete(paramCtx);

		cacheUtil.remove(cacheName);
	}

	public String getCacheName() {
		return cacheName;
	}

	public void setCacheName(String cacheName) {
		this.cacheName = cacheName;
	}
}
