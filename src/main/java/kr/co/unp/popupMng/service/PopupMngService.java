package kr.co.unp.popupMng.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.main.service.MainService;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.ui.ModelMap;

public class PopupMngService extends DefaultCmmProgramService {

	public static final String POPUP_INFO_KEY = MainService.PORTAL_MAIN_CACHE_NAME;

	@Resource(name="siteMngService")
	private SiteMngService siteMngService;

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	public PopupMngService(){
		super.setListQueryId("popupMngDAO.selectPopupList");
		super.setCountQueryId("popupMngDAO.selectPopupListCnt");
		super.setInsertQueryId("popupMngDAO.addPopup");
		super.setUpdateQueryId("popupMngDAO.updatePopup");
		super.setViewQueryId("popupMngDAO.selectPopup");
		super.setDeleteQueryId("popupMngDAO.delPopup");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception{
		super.list(paramCtx);

		ModelMap model = paramCtx.getModel();
		List<ZValue> siteList = siteMngService.getSiteList();
		model.addAttribute("siteList", siteList);
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception{
		super.forInsert(paramCtx);

		ModelMap model = paramCtx.getModel();
		List<ZValue> siteList = siteMngService.getSiteList();
		model.addAttribute("siteList", siteList);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception{
		super.forUpdate(paramCtx);

		ModelMap model = paramCtx.getModel();
		List<ZValue> siteList = siteMngService.getSiteList();
		model.addAttribute("siteList", siteList);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		String siteIdData = StrUtils.getMFormatStr(param.getList("siteId"), ",");
		param.put("siteId", siteIdData);

		super.insert(paramCtx);

		setPubPopupInfoInContext();

	}


	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		String siteIdData = StrUtils.getMFormatStr(param.getList("siteId"), ",");
		param.put("siteId", siteIdData);

		super.update(paramCtx);

		setPubPopupInfoInContext();
	}


	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception{
		super.delete(paramCtx);

		setPubPopupInfoInContext();
	}

	private void setPubPopupInfoInContext() throws Exception {
		List<ZValue> popupList = sqlDao.listDAO("popupMngDAO.selectPubPopupList", null);
		cacheUtil.save(POPUP_INFO_KEY, "popupList", popupList);
	}

	public void popup(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
    	@SuppressWarnings("unchecked")
    	List<ZValue> popupList = (List<ZValue>)cacheUtil.load(POPUP_INFO_KEY, "popupList");
		if( popupList == null ){
			popupList = sqlDao.listDAO("popupMngDAO.selectPubPopupList", null);
		}
		if( CollectionUtils.isNotEmpty(popupList) ){
			Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, popupList);
			model.addAttribute("fileMap", fileMap);

			String pno = param.getString("pno");
			for(ZValue pop : popupList){
				String _pno = pop.getString("pno");
				if( pno.equals(_pno) ){
					String atchFileId = pop.getString("atchFileId");
					List<FileVO> files = fileMap.get(atchFileId);
					if( CollectionUtils.isNotEmpty(files) ){
						pop.put("fileSn", files.get(0).getFileSn());
						pop.put("fileCn", files.get(0).getFileCn());
					}
					model.addAttribute("result", pop);
					return;
				}
			}
		}
	}

	public void script(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
    	@SuppressWarnings("unchecked")
    	List<ZValue> popupList = (List<ZValue>)cacheUtil.load(POPUP_INFO_KEY, "popupList");
		if( popupList == null ){
			popupList = sqlDao.listDAO("popupMngDAO.selectPubPopupList", null);
		}
		if( CollectionUtils.isNotEmpty(popupList) ){
			List<ZValue> resultList = new ArrayList<ZValue>();
			String siteId = param.getString("siteId");
			for(ZValue pop : popupList){
				String siteIdData = pop.getString("siteId");
				if( siteIdData.indexOf(siteId) != -1 ){
					resultList.add(pop);
				}
			}

			ModelMap model = paramCtx.getModel();
			model.addAttribute("popupList", resultList);
		}
	}

}
