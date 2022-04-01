package kr.co.unp.ntcn.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.main.service.MainService;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CacheUtil;
import kr.co.unp.util.CacheUtil.CacheCallback;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.ui.ModelMap;

public class NtcnAlertProgramService extends DefaultCmmProgramService {

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	private String initNttCn = "";

	public NtcnAlertProgramService(){
		super.setCountQueryId("NtcnAlertDAO.selectNtcnAlertListTotCnt");
		super.setListQueryId("NtcnAlertDAO.selectNtcnAlertList");
		super.setInsertQueryId("NtcnAlertDAO.insertNtcnAlert");
		super.setViewQueryId("NtcnAlertDAO.selectNtcnAlertDetail");
		super.setUpdateQueryId("NtcnAlertDAO.updateNtcnAlert");
		super.setDeleteQueryId("NtcnAlertDAO.deleteNtcnAlert");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
    	super.list(paramCtx);

    	ModelMap model = paramCtx.getModel();
    	@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		if( CollectionUtils.isNotEmpty(resultList) ){
			Map<String, List<FileVO>> fileMap = listHandler.getFileMap(paramCtx.getParam(), resultList);
			UnpCollectionUtils.setFirstFile(resultList, fileMap, "atchFileId");
		}
	}

	@Override
    public void view(ParameterContext<ZValue> paramCtx) throws Exception {
    	super.view(paramCtx);

    	ModelMap model = paramCtx.getModel();
		model.addAttribute("initNttCn", getInitNttCn());
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("frstRegisterId", user.getUserId());
		param.put("lastUpdusrId", user.getUserId());
		super.insert(paramCtx);
		cacheUtil.remove("storedMain");
	}

	@Override
    public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forUpdate(paramCtx);

    	ModelMap model = paramCtx.getModel();
		model.addAttribute("initNttCn", getInitNttCn());
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("frstRegisterId", user.getUserId());
		param.put("lastUpdusrId", user.getUserId());
		super.update(paramCtx);
		cacheUtil.remove("storedMain");
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		super.delete(paramCtx);
		cacheUtil.remove("storedMain");
	}

	@Override
    public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forInsert(paramCtx);

    	ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("frstRegisterId", user.getUserId());
		param.put("lastUpdusrId", user.getUserId());

		model.addAttribute("initNttCn", getInitNttCn());
    }

	@Override
	protected String getFilePath(ZValue param) throws Exception{
		StringBuilder result = new StringBuilder();
		result.append(propertyService.getString("Globals.fileStorePath")).append("/");
		result.append("ntcnAlert");
		return result.toString();
	}

	public void selectAllList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	model.addAttribute("resultList", sqlDao.listDAO("NtcnAlertDAO.selectNtcnAlertAllList", param));
	}

	//@SuppressWarnings("unchecked")
	public List<ZValue> selectPublishList(final ZValue param) throws Exception {
		/*List<ZValue> resultList = (List<ZValue>)cacheUtil.loadAndSave(MainService.PORTAL_MAIN_CACHE_NAME, "mainVisualList", new CacheCallback() {
			@Override
			public Object getObject() throws Exception {*/
				List<ZValue> list = sqlDao.listDAO("NtcnAlertDAO.selectPublishList", param);
				if( CollectionUtils.isNotEmpty(list) ){
					Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, list);
					if (CollectionUtils.isNotEmpty(list)) {
						if (MapUtils.isNotEmpty(fileMap)) {
							for (ZValue val : list) {
								List<FileVO> files = fileMap.get(val.getString("atchFileId"));
								if (CollectionUtils.isNotEmpty(files)) {
									for ( FileVO fvo : files ) {
										if ( "file1".equals(fvo.getFileFieldName()) ) {
											val.put("file1Sn", fvo.getFileSn());
											val.put("file1Cn", fvo.getFileCn());
											val.put("file1StreFileNm", fvo.getStreFileNm());
										}
										else {
											val.put("file2Sn", fvo.getFileSn());
											val.put("file2Cn", fvo.getFileCn());
											val.put("file2StreFileNm", fvo.getStreFileNm());
										}
									}
								}
							}
						}
					}
				}
				return list;
			/*}
		});
		Collections.reverse(resultList);
		return resultList;*/
	}

	public String getInitNttCn() {
		return initNttCn;
	}

	public void setInitNttCn(String initNttCn) {
		this.initNttCn = initNttCn;
	}

}
