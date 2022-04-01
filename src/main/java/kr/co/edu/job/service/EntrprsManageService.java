package kr.co.edu.job.service;

import java.util.List;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

public class EntrprsManageService extends DefaultCmmProgramService{
	Logger log = Logger.getLogger(this.getClass());
	public EntrprsManageService(){
		super.setViewQueryId("entrprsManage.selectEntrprsManage");
		super.setCountQueryId("entrprsManage.entrprsManageListCnt");

		super.setDeleteQueryId("entrprsManage.deleteEntrprsManage");
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.forInsert(paramCtx);
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setListQueryId("entrprsManage.entrprsManageList");
		super.list(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		if(StringUtils.hasText(param.getString("telno1")) && StringUtils.hasText(param.getString("telno2")) && StringUtils.hasText(param.getString("telno3"))){
			String telno = param.getString("telno1") +"-"+ param.getString("telno2") +"-"+ param.getString("telno3");
			param.put("telno", telno);

		}
		super.setInsertQueryId("entrprsManage.insertEntrprsManage");
		super.insert(paramCtx);
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initCmmnParam(param);
		if(StringUtils.hasText(param.getString("telno1")) && StringUtils.hasText(param.getString("telno2")) && StringUtils.hasText(param.getString("telno3"))){
			String telno = param.getString("telno1") +"-"+ param.getString("telno2") +"-"+ param.getString("telno3");
			param.put("telno", telno);

		}
		super.setUpdateQueryId("entrprsManage.updateEntrprsManage");
		super.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int entrprsSn = param.getInt("entrprsSn");
		initCmmnParam(param);
		if( entrprsSn > 0 ){
			super.delete(paramCtx);
		}
		else{
			deleteAll(paramCtx);
		}

	}

	/**
	 * 다중 삭제 기업리스트
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteAll(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> entrprsSnData = param.getList("entrprsSnData");
		Assert.notEmpty(entrprsSnData);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		for(String entrprsSn : entrprsSnData){
			initCmmnParam(param);
			param.put("entrprsSn", entrprsSn);
			param.put("delcode", SearchVO.BOS_DELETION);
			sqlDao.deleteDAO("entrprsManage.deleteEntrprsManage", param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}
	/**
	 * 기업선택 팝업리스트
	 * @param paramCtx
	 * @throws Exception
	 */
	public void entrprsListPopup(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		super.setListQueryId("entrprsManage.entrprsManagePopupList");
		super.list(paramCtx);


	}
}
