package kr.co.testbed.concert.service;

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
public class ConcertUserService  extends DefaultCmmProgramService  {
	Logger log = Logger.getLogger(this.getClass());
	
	
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))){

			if ("".equals(param.getString("pageUnit",""))) 
				param.put("pageUnit", "10");
			if ("".equals(param.getString("pageSize",""))) 
				param.put("pageSize", "10");
			param.put("pageSize", "3");
			param.put("compAuth", "Y"); //입주기업 회원만

			super.setCountQueryId("memberDAO.selectConcertUserMemberListCnt");
			super.setListQueryId("memberDAO.selectConcertUserMembers");
			super.list(paramCtx);
		}
	}

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("memberDAO.selectConcertUserMembers");
		super.view(paramCtx);
	}
	
	// 수정
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("memberDAO.selectConcertUserMembers");
		super.forUpdate(paramCtx);
	}
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		param.put("compAuth", "Y"); //입주기업 회원 등록
		super.setUpdateQueryId("memberDAO.insertConcertUserMember");
		super.update(paramCtx);
	}

	// 등록
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		
		super.setInsertQueryId("memberDAO.selectConcertUserMembers");
		super.forInsert(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		int cnt = sqlDao.selectCount("memberDAO.checkDupID", param);
		if ( cnt == 0 )
			param.put("concertUseAt", "N"); //아직 가입하지 않은 회원
		param.put("compAuth", "Y"); //입주기업 회원 등록
		super.setInsertQueryId("memberDAO.insertConcertUserMember");
		super.insert(paramCtx);
	}
	
	// 삭제
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		param.put("compAuth", "N");
		super.setUpdateQueryId("memberDAO.updateUseAtConcertUser");
		super.update(paramCtx);
	}
	/*

	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		super.setViewQueryId("empmnPblanc.selectEmpmnPblanc");
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
		super.setViewQueryId("empmnPblanc.selectEmpmnPblanc");
		super.forUpdate(paramCtx);
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("empmnPblanc.insertEmpmnPblanc");
		super.insert(paramCtx);
	}
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setUpdateQueryId("empmnPblanc.updateEmpmnPblanc");
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

	*//**
	 * 다중 삭제 채용공고
	 * @param paramCtx
	 * @throws Exception
	 *//*
	public void deleteAll(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> pblancSnData = param.getList("pblancSnData");
		Assert.notEmpty(pblancSnData);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		for(String pblancSn : pblancSnData){
			initCmmnParam(param);
			param.put("pblancSn", pblancSn);
			param.put("delcode", SearchVO.BOS_DELETION);
			sqlDao.deleteDAO("empmnPblanc.deleteEmpmnPblanc", param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}*/

}
