package kr.co.unp.banner.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;


public class BannerService extends DefaultCmmProgramService {

	@Resource(name = "siteMngService")
	protected SiteMngService siteMngService;

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	public BannerService(){
		super.setCountQueryId("BannerDAO.selectBannerListTotCnt");
		super.setListQueryId("BannerDAO.selectBannerList");
		super.setViewQueryId("BannerDAO.selectBannerDetail");
		super.setDeleteQueryId("BannerDAO.deleteBanner");
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.setInsertQueryId("BannerDAO.insertBanner");
		super.initCmmnParam(param);
		super.insert(paramCtx);

		cacheUtil.remove("storedMain");
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.setUpdateQueryId("BannerDAO.updateBanner");
		super.initCmmnParam(param);
		super.update(paramCtx);

		cacheUtil.remove("storedMain");
	}

	public void selectAllList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	List<ZValue> resultList = sqlDao.listDAO("BannerDAO.selectPublishList", param);
    	model.addAttribute( "resultList", resultList );
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
    	super.list(paramCtx);

     	ModelMap model = paramCtx.getModel();
		List<ZValue> useBannerList = siteMngService.getSiteList();
		model.addAttribute("useBannerList", useBannerList);
	}

	@Override
    public void view(ParameterContext<ZValue> paramCtx) throws Exception {
    	super.view(paramCtx);

    	ModelMap model = paramCtx.getModel();
		List<ZValue> useBannerList = siteMngService.getSiteList();
		model.addAttribute("useBannerList", useBannerList);
	}

	@Override
    public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forInsert(paramCtx);

    	ModelMap model = paramCtx.getModel();
		List<ZValue> useBannerList = siteMngService.getSiteList();
		model.addAttribute("useBannerList", useBannerList);
    }

	public void listPublish(ParameterContext<ZValue> paramCtx) throws Exception {
		List<ZValue> resultList = sqlDao.listDAO("BannerDAO.selectPublishList", paramCtx.getParam());
		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(paramCtx.getParam(), resultList);
		UnpCollectionUtils.setFirstFile(resultList, fileMap, "atchFileId");
	}

	public List<ZValue> getBanner(ZValue param) throws Exception {
		List<ZValue> resultList = sqlDao.listDAO("BannerDAO.selectPublishList", param);
		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, resultList);
		UnpCollectionUtils.setFirstFile(resultList, fileMap, "atchFileId");



		return resultList;
	}

	@Override
    public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		super.delete(paramCtx);
		cacheUtil.remove("storedMain");
	}

}
