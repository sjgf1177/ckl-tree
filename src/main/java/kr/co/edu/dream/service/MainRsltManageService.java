package kr.co.edu.dream.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.edu.dream.paging.DreamQuery;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.WebFactory;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

public class MainRsltManageService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "webFactory")
	protected WebFactory WebFactory;

	public MainRsltManageService() {
		super.setCountQueryId("mainRsltManageDAO.selectMainRsltManageCnt");
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("mainRsltManageDAO.mainRsltManageInsert");
		super.insert(paramCtx);
	}
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setUpdateQueryId("mainRsltManageDAO.updateMainRsltManage");
		super.update(paramCtx);
	}
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setDeleteQueryId("mainRsltManageDAO.deleteMainRsltManage");
		super.delete(paramCtx);
	}
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		super.setPageQuery(new DreamQuery());
		super.setListQueryId("mainRsltManageDAO.selectMainRsltManageList");
		super.list(paramCtx);

		List<ZValue> yearList = (List<ZValue>) model.get("resultList");
		List<String> years =  dplctRemov(yearList,"yearNm"); //리스트 중복제거후 year데이터만 담음
		Collections.reverse(years); // year날짜 를 역순으로 정렬
		model.addAttribute("years",years); //year날짜 도데이터를 넣어줌
	}
	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		ZValue param = paramCtx.getParam();
		super.setViewQueryId("mainRsltManageDAO.selectMainRsltManage");
		super.setPageQuery(new DreamQuery());
		super.view(paramCtx);
	}

	/*
	 * 리스트 중복 제거하는 메소드
	 * dplctData 중복 데이터
	 * keyValue 뽑아낼 키값
	 */
	public List<String> dplctRemov(List<ZValue> dplctData, String keyValue) {
		List<String> result = new ArrayList(); //반환받을 변수
		HashSet<String> flag = new HashSet(); //비교할 변수

		for (ZValue value : dplctData) {
			if(!flag.contains(value.getString(keyValue))){
				result.add(value.getString(keyValue));
				flag.add(value.getString(keyValue));
			}
		}
		return result;
	}
	public void mainRsltPopList(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.setListQueryId("mainRsltManageDAO.popUpMainRsltManageList");
		super.list(paramCtx);
		List<ZValue> yearList = (List<ZValue>) model.get("resultList");
		List<String> years =  dplctRemov(yearList,"yearNm"); //리스트 중복제거후 year데이터만 담음
		model.addAttribute("years",years); //year날짜 도데이터를 넣어줌
	}

}
