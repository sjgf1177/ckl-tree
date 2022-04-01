package kr.co.ckl.noticeBBS.service;

import kr.co.unp.bbs.service.OptionalBBSManageService;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;


public class NoticeBBSManageService extends OptionalBBSManageService {

	Logger log = Logger.getLogger(this.getClass());

	public NoticeBBSManageService() {
		super();
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String bbsId = param.getString("bbsId");
		checkBbsUpdate(paramCtx);
		UsersVO usersVO = UnpUserDetailsHelper.getAuthenticatedUser();
		initValue(param, usersVO);

		if(param.get("bbsTypeData") instanceof String[]){
			String[] noticesBBS = (String[]) param.get("bbsTypeData");


			for (int i = 0; i < noticesBBS.length; i++) {
				param.put("bbsId", noticesBBS[i]);
				boolean flag = uploadFile(paramCtx);
				if (!flag) return;
				sqlDao.insertDAO(insertQueryId, param);
				param.put("atchFileId", "");

			}


			param.put("bbsId", bbsId);
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));
		}else{

			param.put("bbsId", param.getString("bbsTypeData"));
			boolean flag = uploadFile(paramCtx);
			if (!flag) return;
			sqlDao.insertDAO(insertQueryId, param);
			param.put("bbsId", bbsId);
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

		}


	}

}
