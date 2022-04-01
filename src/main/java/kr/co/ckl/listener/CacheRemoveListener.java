package kr.co.ckl.listener;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import kr.co.unp.cmm.crud.listener.CmmProgramListenerSupport;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

public class CacheRemoveListener extends CmmProgramListenerSupport<ZValue> {

	Logger log = Logger.getLogger(this.getClass());
	
	private String cacheName = "";

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;
	
	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		cacheUtil.remove(cacheName);
		log.debug("["+cacheName+"] 캐시가 삭제 되었습니다.");
		return CONTINUE;
	}

	public String getCacheName() {
		return cacheName;
	}

	public void setCacheName(String cacheName) {
		this.cacheName = cacheName;
	}

}
