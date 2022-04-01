package kr.co.unp.util;

import javax.annotation.Resource;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.springframework.cache.ehcache.EhCacheCacheManager;
import org.springframework.stereotype.Service;

@Service("cacheUtil")
public class CacheUtil {

	@Resource(name = "cacheManager")
	private EhCacheCacheManager cacheManager;

	public void save(String cacheName, String key, Object obj){
		CacheManager cm = cacheManager.getCacheManager();
		Cache cache = cm.getCache(cacheName);
		if( cache == null ){
			cm.addCache(cacheName);
		}
		cache = cm.getCache(cacheName);
		Element element = new Element(key, obj);
		cache.put(element);
	}

	public Object load(String cacheName, String key){
		CacheManager cm = cacheManager.getCacheManager();
		Cache cache = cm.getCache(cacheName);
		if( cache == null ) return null;
		Element ele = cache.get(key);
		if( ele == null ) return null;
		return ele.getValue();
	}

	public void remove(String cacheName){
		CacheManager cm = cacheManager.getCacheManager();
		cm.removeCache(cacheName);
	}

	public void removeAll(){
		CacheManager cm = cacheManager.getCacheManager();
		cm.removalAll();
	}
	
	public Object loadAndSave(String cacheName, String key, CacheCallback callback) {
		Object ret = load(cacheName, key);
		if( ret == null ) {
			try {
				ret = callback.getObject();
			} catch (Exception e) {
				e.printStackTrace();
			} 
			if ( ret != null ) {
				save(cacheName, key, ret);
			}
		}
		return ret;
	}

	public static interface CacheCallback {
		
		public Object getObject() throws Exception;
	}
	
	public static class SqlDaoListCacheCallback<T> implements CacheCallback {

		private ISqlDAO<T> sqlDao;
		private String queryId;
		private T param;
		public SqlDaoListCacheCallback(ISqlDAO<T> sqlDao, String queryId, T param) {
			this.sqlDao = sqlDao;
		}
		
		@Override
		public Object getObject() throws Exception {
			return sqlDao.listDAO(queryId, param);
		}

		public ISqlDAO<T> getSqlDao() {
			return sqlDao;
		}

		public void setSqlDao(ISqlDAO<T> sqlDao) {
			this.sqlDao = sqlDao;
		}

		public String getQueryId() {
			return queryId;
		}

		public void setQueryId(String queryId) {
			this.queryId = queryId;
		}

		public T getParam() {
			return param;
		}

		public void setParam(T param) {
			this.param = param;
		}
		
	}
	
	public static class SqlDaoSelectCacheCallback<T> extends SqlDaoListCacheCallback<T> {

		public SqlDaoSelectCacheCallback(ISqlDAO<T> sqlDao, String queryId, T param) {
			super(sqlDao, queryId, param);
		}
		
		@Override
		public Object getObject() throws Exception {
			return getSqlDao().selectDAO(getQueryId(), getParam());
		}
	}
}
