package kr.co.unp.bbs.service;

import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.accessor.ArticleAccessor;
import kr.co.unp.bbs.dao.BBSAttributeManageDAO;
import kr.co.unp.bbs.vo.BoardMasterVO;
import kr.co.unp.cmm.crud.config.DefaultCmmProgramManager;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;

/**
 * @author KHD
 *
 */
public class FnwBBSManager extends DefaultCmmProgramManager<ZValue> {

	Logger log = Logger.getLogger(this.getClass());

	private final String DEFAULT_KEY = "default";

	@Resource(name = "BBSAttributeManageDAO")
	protected BBSAttributeManageDAO attrbMngDAO;

	protected Map<String, String> articleAccessorMap;

	@SuppressWarnings("unchecked")
	public ArticleAccessor<ZValue> getArticleAccessor(ParameterContext<ZValue> paramCtx) {
		ZValue param = paramCtx.getParam();
		String bbsId = param.getString("bbsId");
		String targetName = articleAccessorMap.get(bbsId);
		if( targetName == null ) targetName = articleAccessorMap.get(DEFAULT_KEY);
		if( log.isDebugEnabled() ){
			log.debug("real bean is [" + targetName + "]");
		}
		return (ArticleAccessor<ZValue>)applicationContext.getBean( targetName );
	}

	public BoardMasterVO getMasterVO(String bbsId){
		BoardMasterVO boardMasterVO = null;
		try {
			boardMasterVO = attrbMngDAO.selectAllBBSMasterInf().get(bbsId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardMasterVO;
	}

	@Override
	public FnwBBSManageService getService(ParameterContext<ZValue> paramCtx){
		ZValue param = paramCtx.getParam();
		String bbsId = param.getString("bbsId");
		String targetName = serviceNameMap.get(bbsId);
		if( targetName == null ) targetName = serviceNameMap.get(DEFAULT_KEY);
		if( log.isDebugEnabled() ){
			log.debug("real bean is [" + targetName + "]");
		}
		return (FnwBBSManageService)applicationContext.getBean( targetName );
	}

	public Map<String, String> getArticleAccessorMap() {
		return articleAccessorMap;
	}

	public void setArticleAccessorMap(Map<String, String> articleAccessorMap) {
		this.articleAccessorMap = articleAccessorMap;
	}

	@SuppressWarnings("unchecked")
	@Override
	public ModelAndViewResolver<ZValue> getModelAndViewResolver(ParameterContext<ZValue> paramCtx) {
		ModelAndViewResolver<ZValue> result = null;
		ZValue param = paramCtx.getParam();
		String siteName = param.getString(CmmProgramService.SITE_NAME);
		if( SiteMngService.BOS_SITE_NAME.equals(siteName) ){
			result = (ModelAndViewResolver<ZValue>)applicationContext.getBean("bosBbsModelAndViewResolver");
			return result;
		}
		
		String bbsId = param.getString("bbsId");
		String targetName = mvrNameMap.get(bbsId);
		if( targetName == null ) targetName = mvrNameMap.get(DEFAULT_KEY);
		if( log.isDebugEnabled() ){
			log.debug("real bean is [" + targetName + "]");
		}
		return (ModelAndViewResolver<ZValue>)applicationContext.getBean(targetName);
	}

}
