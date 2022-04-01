package kr.co.edu.job.service;

import java.util.List;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

/**
 * 채용 공고
 */
public class EmpmnStupService  extends DefaultCmmProgramService  {
	Logger log = Logger.getLogger(this.getClass());

	public EmpmnStupService() {
		super.setDeleteQueryId("empmnStup.deleteempmnStup");
	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		String pblancNm = param.getString("pblancNm");

		if ("".equals(param.getString("pageUnit",""))) {
			param.put("pageUnit", "10");
		}
		if ("".equals(param.getString("pageSize",""))) {
			param.put("pageSize", "10");
		}
		if ((SiteMngService.CKLMOBILE_SITE_NAME).equals(param.getString("siteName")) ) { //rsg20171214
			param.put("pageSize", "3");
		}
		/*
		if ((SiteMngService.CKLMOBILE_SITE_NAME).equals(param.getString("siteName")) || (SiteMngService.EDUMOBILE_SITE_NAME).equals(param.getString("siteName"))) {
			param.put("pageSize", "3");
		}
		*/


		if(pblancNm.indexOf("/") != -1){
			String[] pblancnmArr = pblancNm.split("/");
			param.put("pblancNmArr", pblancnmArr);
			param.put("pblancNm", "");

		}

		if(param.get("acdmcrSe") instanceof String[] && StringUtils.hasText(param.getString("acdmcrSe"))){
			String[] acdmcrSeArr = (String[]) param.get("acdmcrSe");
			param.put("acdmcrSeArr", acdmcrSeArr);
			param.put("acdmcrSe", "");
		}

		if(param.get("acdmcr") instanceof String[] && StringUtils.hasText(param.getString("acdmcr"))){
			String[] acdmcrArr = (String[]) param.get("acdmcr");
			param.put("acdmcrArr", acdmcrArr);
			param.put("acdmcr", "");
		}

		if(param.get("careerSe") instanceof String[] && StringUtils.hasText(param.getString("careerSe"))){
			String[] careerSeArr = (String[]) param.get("careerSe");
			param.put("careerSeArr", careerSeArr);
			param.put("careerSe", "");
		}

		if(param.get("workStle") instanceof String[] && StringUtils.hasText(param.getString("workStle"))){
			String[] workStleArr = (String[]) param.get("workStle");
			param.put("workStleArr", workStleArr);
			param.put("workStle", "");
		}

		param.put("careerMax", param.getString("careerMax"));
		param.put("careerMin", param.getString("careerMin"));

		super.setCountQueryId("empmnStup.selectempmnStupListCnt");
		super.setListQueryId("empmnStup.selectempmnStupList");
		super.list(paramCtx);
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("empmnStup.selectempmnStup");
		super.view(paramCtx);

		ModelMap model = paramCtx.getModel();
		List<FileVO> fileList = null;

		ZValue result = (ZValue)model.get("result");
		if (StringUtils.hasText(result.getString("atchFileIdSe"))) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(result.getString("atchFileIdSe"));
			fileList = fnwFileMngService.selectFileInfs(fileVO);
			model.addAttribute("fileList2", fileList);
		}
		model.put("resultJobNm1", result.getString("chrgJobNm"));
		model.put("resultJoBNm2", result.getString("chrgJob2Nm"));
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		super.forInsert(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("empmnStup.selectempmnStup");
		super.forUpdate(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("empmnStup.insertempmnStup");
		super.insert(paramCtx);
	}
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setUpdateQueryId("empmnStup.updateempmnStup");
		super.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		int pblancSn = param.getInt("pblancSn");
		initCmmnParam(param);
		if( pblancSn > 0 ){
			super.delete(paramCtx);
		}
		else{
			deleteAll(paramCtx);
		}
	}

	/**
	 * 다중 삭제 채용공고
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteAll(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> pblancSnData = param.getList("pblancSnData");
		Assert.notEmpty(pblancSnData);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		for(String pblancSn : pblancSnData){
			initCmmnParam(param);
			param.put("pblancSn", pblancSn);
			param.put("delcode", SearchVO.BOS_DELETION);
			sqlDao.deleteDAO("empmnStup.deleteempmnStup", param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

}
