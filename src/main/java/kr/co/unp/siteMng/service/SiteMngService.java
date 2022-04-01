package kr.co.unp.siteMng.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.ui.ModelMap;

public class SiteMngService extends DefaultCmmProgramService {

	public static final String BOS_SITE_ID = "1";
	public static final String BOS_SITE_NAME = "bos";
	public static final String CKL_SITE_ID = "2";
	public static final String CKL_SITE_NAME = "ckl";
	public static final String CKLENG_SITE_ID = "3";
	public static final String CKLENG_SITE_NAME = "ckleng";
	public static final String CKLMOBILE_SITE_ID = "4";
	public static final String CKLMOBILE_SITE_NAME = "cklmobile";
	public static final String EDU_SITE_ID = "5";
	public static final String EDU_SITE_NAME = "edu";
	public static final String EDUMOBILE_SITE_ID = "6";
	public static final String EDUMOBILE_SITE_NAME = "edumobile";
	public static final String TESTBED_SITE_ID = "7";
	public static final String TESTBED_SITE_NAME = "testbed";
	public static final String TESTBEDENG_SITE_ID = "8";
	public static final String TESTBEDENG_SITE_NAME = "testbedeng";
	public static final String SITE_MNG_CACHE_NAME = "storedSiteMng";

	@Resource(name = "cacheUtil")
	protected CacheUtil cacheUtil;

	public SiteMngService(){
		super.setListQueryId("siteMngDAO.selectSiteList");
		super.setCountQueryId("siteMngDAO.selectSiteListCount");
		super.setViewQueryId("siteMngDAO.selectSite");
		super.setInsertQueryId("siteMngDAO.addSite");
		super.setDeleteQueryId("siteMngDAO.delSite");
		super.setUpdateQueryId("siteMngDAO.updateSite");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception{
		List<ZValue> resultList = getSiteList();
		paramCtx.getModel().addAttribute("resultList", resultList);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception{
		super.insert(paramCtx);

		ModelMap model = paramCtx.getModel();
		model.addAttribute(CACHE_KEY, SITE_MNG_CACHE_NAME);
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/bos/siteMng/list.do");
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception{
		super.update(paramCtx);

		ModelMap model = paramCtx.getModel();
		model.addAttribute(CACHE_KEY, SITE_MNG_CACHE_NAME);
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/bos/siteMng/list.do");
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception{
		super.delete(paramCtx);

		ModelMap model = paramCtx.getModel();
		model.addAttribute(CACHE_KEY, SITE_MNG_CACHE_NAME);
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/bos/siteMng/list.do");
	}

	@SuppressWarnings("unchecked")
	public List<ZValue> getSiteList() throws Exception{
		List<ZValue> resultList = (List<ZValue>)cacheUtil.load(SITE_MNG_CACHE_NAME, "siteList");
		
		if( resultList == null ){
			resultList = sqlDao.listDAO(listQueryId, null);
		}

		if( CollectionUtils.isNotEmpty(resultList) ){
			for(ZValue site : resultList ){
				site.put("siteDomain", getDomain(site.getString("siteUrl")));
			}

			cacheUtil.save(SITE_MNG_CACHE_NAME, "siteList", resultList);
		}
		return resultList;
	}

	public ZValue getSiteBySiteId(String siteId) throws Exception{
		ZValue result = null;
		List<ZValue> resultList = getSiteList();
		if( CollectionUtils.isNotEmpty(resultList) ){
			for(ZValue val : resultList){
				if( val.getString("siteId").equals(siteId) ){
					result = val;
					break;
				}
			}
		}
		return result;
	}

	public ZValue getSiteBySiteName(String siteName) throws Exception{
		ZValue result = null;
		List<ZValue> resultList = getSiteList();
		if( CollectionUtils.isNotEmpty(resultList) ){
			for(ZValue val : resultList){
				if( val.getString("siteName").equals(siteName) ){
					result = val;
					break;
				}
			}
		}
		return result;
	}

	private String getDomain(String siteUrl){
		String result = null;
		if( siteUrl == null ){
			return null;
		}

		result = siteUrl.replaceAll("(http|https)://", "");
		if( result.endsWith("/") ){
			result = result.substring(0, result.length()-1);
		}
		return result;
	}
}
