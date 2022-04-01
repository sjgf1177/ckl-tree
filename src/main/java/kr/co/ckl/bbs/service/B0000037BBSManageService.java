package kr.co.ckl.bbs.service;


import kr.co.unp.bbs.service.OptionalBBSManageService;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;


public class B0000037BBSManageService extends OptionalBBSManageService {

	public B0000037BBSManageService() {
		super();
	}


	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();

		super.list(paramCtx);

		model.addAttribute("bbsId", param.getString("bbsId"));
	}

	@Override
	public void listMy(ParameterContext<ZValue> paramCtx) throws Exception {
		super.listMy(paramCtx);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		//답변시 원글 상태값 REPLY_AT = 'Y'
		if (param.getInt("parnts") > 0) {
			if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
				param.put("replyAt", "Y");
				sqlDao.updateDAO("optionalBoardDAO.updateReplyAt", param);
			}
		}else {
			param.put("replyAt", "N");
		}

		super.insert(paramCtx);
		 
		if ("Y".equals(param.getString("myAt")) && "B0000076".equals(param.getString("bbsId"))) model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+param.getString("siteName")+"/bbs/"+param.getString("bbsId")+"/listMy.do?menuNo=500201");
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if (param.getInt("parnts") > 0) {
			if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
				param.put("replyAt", "Y");
				sqlDao.updateDAO("optionalBoardDAO.updateReplyAt", param);
			}
		}else {
			param.put("replyAt", "N");
		}

		super.update(paramCtx);

		if ("Y".equals(param.getString("myAt"))) model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+param.getString("siteName")+"/bbs/"+param.getString("bbsId")+"/listMy.do?"+StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&"));
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception  {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			//답변삭제시 원글 상태값 REPLY_AT = 'N'
			if (param.getInt("parnts") > 0) {
				param.put("replyAt", "N");
				sqlDao.updateDAO("optionalBoardDAO.updateReplyAt", param);
			}
		}
		super.delete(paramCtx);

		if ("Y".equals(param.getString("myAt"))) model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+param.getString("siteName")+"/bbs/"+param.getString("bbsId")+"/listMy.do?"+StrUtils.replace(param.getString("pageQueryString"), "&amp;", "&"));
	}

	/**
	 * 담당자 지정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void chargerChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.updateDAO("optionalBoardDAO.chargerChange", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}


}
