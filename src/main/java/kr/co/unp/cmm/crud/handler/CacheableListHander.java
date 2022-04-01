package kr.co.unp.cmm.crud.handler;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.vo.CacheVO;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Service;

@Service("cacheableListHander")
public class CacheableListHander extends DefaultListHander{

	@Resource(name = "cacheUtil")
	protected CacheUtil cacheUtil;
	
	@Override
	@SuppressWarnings("unchecked")
	protected List<ZValue> getResultList(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		CacheVO cvo = paramCtx.getCacheVO();
		List<ZValue> resultList = (List<ZValue>)cacheUtil.load(cvo.getCacheName(), cvo.getKey());
		if( resultList == null ){
			resultList = sqlDao.listDAO(paramCtx.getQueryIdVO().getListQueryId(), param);
			cacheUtil.save(cvo.getCacheName(), cvo.getKey(), resultList);
		}
		return resultList;
	}

	@Override
	protected int getListCount(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		CacheVO cvo = paramCtx.getCacheVO();
		Integer count = (Integer)cacheUtil.load(cvo.getCacheName(), cvo.getKey()+"Count");
		if( count == null ){
			count = sqlDao.selectCount(paramCtx.getQueryIdVO().getCountQueryId(), param);
			cacheUtil.save(cvo.getCacheName(), cvo.getKey()+"Count", count);
		}
		return count;
	}

}
