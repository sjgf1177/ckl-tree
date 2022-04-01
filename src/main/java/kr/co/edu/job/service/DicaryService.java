package kr.co.edu.job.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.cmmncode.vo.CmmnCodeDetail;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;


public class DicaryService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
    protected WebFactory WebFactory;

	 @Resource(name="CmmnCodeDetailDAO")
	 private CmmnCodeDetailDAO cmmnCodeDetailDAO;

	public DicaryService() {
		super();

	}

	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		super.setListQueryId("dicaryDAO.selectDicaryList");
		super.setCountQueryId("dicaryDAO.selectDicaryListCnt");

		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) { //관리자 일때
			super.list(paramCtx);

		}else if(SiteMngService.EDU_SITE_NAME.equals(param.getString("siteName"))){ //사용자일떄
 			param.put("codeId", "COM083");
			List<ZValue> COM083CodeList = cmmnCodeDetailDAO.getDetailCodeList(param);
			model.put("COM083CodeList", COM083CodeList);
		}
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.initCmmnParam(param);

		Object cnSn =  sqlDao.insertDAO("dicaryDAO.dicaryInsert", param);
//		/*키값으로 여러개 인서트 하는 구문 만들어야함*/
		param.put("cnSn", cnSn);

		/* 내용 인서트*/
		if (param.get("subSj") instanceof String[] && param.get("subCn") instanceof String[]) {
			String[] titles = (String[])param.get("subSj");
			String[] contents = (String[])param.get("subCn");

			for(int i=0; i< titles.length; i++){
				param.put("subSj", titles[i]);
				param.put("subCn", contents[i]);
				sqlDao.insertDAO("dicaryDAO.dicaryCnInsert", param);
			}
		} else {
        /* 한개 인서트 */
			sqlDao.insertDAO("dicaryDAO.dicaryCnInsert", param);

		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/job/dicary/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.initCmmnParam(param);

		/*널 값 체크*/
		if(!StringUtils.hasText(param.getString("cnSn"))){
			param.put("cnSn", param.getString("dicarySn"));
		}

		/*제목표시줄 업데이트*/
		sqlDao.updateDAO("dicaryDAO.updateDicary", param);

		/* 내용 비우기*/
		sqlDao.deleteDAO("dicaryDAO.deleteDicaryCn", param);
		if (param.get("subSj") instanceof String[] && param.get("subCn") instanceof String[]) {

			/* 다중인서트 내용 인서트*/
			String[] titles = (String[])param.get("subSj");
			String[] contents = (String[])param.get("subCn");
			for(int i=0; i< titles.length; i++){
				param.put("subSj", titles[i]);
				param.put("subCn", contents[i]);
				sqlDao.insertDAO("dicaryDAO.dicaryCnInsert", param);
			}
		 } else {
        /* 한개 인서트 */
			sqlDao.insertDAO("dicaryDAO.dicaryCnInsert", param);
		}

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/job/dicary/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));

	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.initCmmnParam(param);
		if(!StringUtils.hasText(param.getString("cnSn"))){
			param.put("cnSn", param.getString("dicarySn"));
		}

		sqlDao.deleteDAO("dicaryDAO.deleteDicaryCn", param);
		super.setDeleteQueryId("dicaryDAO.deleteDicary");
		super.delete(paramCtx);


	}

	public void selectDelete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.initCmmnParam(param);
		super.setDeleteQueryId("dicaryDAO.selectDeleteDicaryCn");
		super.delete(paramCtx);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));
	}



	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if(!StringUtils.hasText(param.getString("cnSn"))){
			param.put("cnSn", param.getString("dicarySn"));
		}

		List<ZValue> subResults = sqlDao.listDAO("dicaryDAO.selectDicaryCn", param);
		super.setViewQueryId("dicaryDAO.selectDicary");
		super.view(paramCtx);

		model.addAttribute("subResults", subResults);

	}

	public void occpDetailList(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue>  occpList =  sqlDao.listDAO("dicaryDAO.OccpDetailList", param);
		CmmnCodeDetail vo = new CmmnCodeDetail();
		vo.setCode(param.getString("ctgrySe1"));
		vo.setCodeId(param.getString("codeId"));
		CmmnCodeDetail result = cmmnCodeDetailDAO.selectCmmnCodeDetailDetail(vo);
		//List<ZValue> occpCateList =  dplctRemov(occpList, "ctgrySe2");
		//model.addAttribute("occpCateList", occpCateList);
		model.addAttribute("resultList", occpList);
		model.addAttribute("codeNm", result.getCodeNm());
//		super.list(paramCtx);
	}


	/*
	 * 리스트 중복 제거하는 메소드
	 * dplctData 중복 데이터
	 * keyValue 뽑아낼 키값
	 */
	public List<ZValue> dplctRemov(List<ZValue> dplctData, String keyValue) {
		List<ZValue> result = new ArrayList(); //반환받을 변수
		HashSet<String> flag = new HashSet(); //비교할 변수

		for (ZValue value : dplctData) {
			if(!flag.contains(value.getString(keyValue))){
				result.add(value);
				flag.add(value.getString(keyValue));
			}
		}
		return result;
	}



}
