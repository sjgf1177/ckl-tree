package kr.co.edu.dream.service;

import java.util.List;

import javax.annotation.Resource;

import kr.co.edu.dream.paging.DreamQuery;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class MentorManageService extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
	protected WebFactory WebFactory;

	public MentorManageService() {

	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		paramCtx.setPageQuery(new DreamQuery());
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		super.setCountQueryId("mentorManageDAO.selectMentorManageCnt");
		if((param.getString("siteName").equals("edumobile") || param.getString("siteName").equals("edu")) && !StringUtils.hasText(param.getString("insttSn"))){
				param.put("insttSn", psitnCodeList.get(0).getString("insttSn"));
		}
		paramCtx.setParam(param);
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {

			super.setListQueryId("mentorManageDAO.selectMentorManageList");
		}else{
			super.setListQueryId("mentorManageDAO.selectEduMentorManageList");
		}
		super.list(paramCtx);
		model.addAttribute("psitnCodeList", psitnCodeList);

	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		super.setPageQuery(new DreamQuery());
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		super.setViewQueryId("mentorManageDAO.selectMentorManage");
		super.view(paramCtx);
		model.addAttribute("psitnCodeList", psitnCodeList);
	}
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		List<ZValue> psitnCodeList = sqlDao.listDAO("mentorManageDAO.psitnCodeList", param);
		super.forInsert(paramCtx);
		model.addAttribute("psitnCodeList", psitnCodeList);
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("mentorManageDAO.mentorManageInsert");
		super.insert(paramCtx);
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.initCmmnParam(param);
		super.setUpdateQueryId("mentorManageDAO.updateMentorManage");
		super.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setDeleteQueryId("mentorManageDAO.deleteMentorManage");
		super.delete(paramCtx);
	}
}
