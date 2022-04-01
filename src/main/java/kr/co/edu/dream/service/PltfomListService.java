package kr.co.edu.dream.service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.edu.dream.paging.PltfomQuery;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class PltfomListService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
	protected WebFactory WebFactory;

	public PltfomListService() {
	}
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		super.setPageQuery(new PltfomQuery());
		super.setViewQueryId("pltfomInsttDAO.selectpltfomInstt");
		super.view(paramCtx);
		super.setCountQueryId("pltfomInsttDAO.mentorListCnt");
		super.setListQueryId("pltfomInsttDAO.selectMentorManageList");
		super.list(paramCtx);

	}
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setListQueryId("pltfomInsttDAO.selectPltFomInsttList");
		super.setCountQueryId("pltfomInsttDAO.selectPltFomInsttCnt");
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		paramCtx.setPageQuery(new PltfomQuery());
		super.list(paramCtx);
	}

	public void mentoDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		super.setDeleteQueryId("mentorManageDAO.deleteMentorManage");
		super.delete(paramCtx);
		super.initCmmnParam(param);
		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/dream/pltfomList/view.do");
		url.append("?").append("insttSn=").append(param.getString("insttSn")).append("&").append("menuNo=").append(param.getString("menuNo"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));

	}
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setDeleteQueryId("pltfomInsttDAO.deletePltfomInstt");
		super.delete(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("pltfomInsttDAO.pltfomInsttInsert");
		super.insert(paramCtx);
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setUpdateQueryId("pltfomInsttDAO.updatePltfomInstt");
		super.update(paramCtx);
	}


}
