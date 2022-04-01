package kr.co.edu.hkFcltyResve.service;

import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.StrUtils;
import kr.co.unp.util.ZValue;

public class HldyService  extends DefaultCmmProgramService {

	Logger log = Logger.getLogger(this.getClass());


	public HldyService() {

	}

	/**
	 * 휴일관리 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		Calendar cal = Calendar.getInstance();
		int currYear = cal.get(Calendar.YEAR);
		model.addAttribute("currYear",currYear);

		if ("".equals(param.getString("hldyYear",""))) {
			param.put("hldyYear",currYear);
		}

		List<ZValue> list = sqlDao.listDAO("HkHldyDAO.listHldy", param);
		model.addAttribute("resultList",list);
	}



	/**
	 * 휴일관리 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);
		super.forInsert(paramCtx);
	}


	/**
	 * 휴일관리 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);


		super.setInsertQueryId("HkHldyDAO.insertHldy");
		super.insert(paramCtx);


		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/hkFcltyResve/hldy/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.insert"));

	}


	/**
	 * 휴일관리 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setViewQueryId("HkHldyDAO.viewHldy");
		super.forUpdate(paramCtx);
	}


	/**
	 * 휴일관리 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setUpdateQueryId("HkHldyDAO.updateHldy");
		super.update(paramCtx);

		String pageQueryString = param.getString("pageQueryString");
		StringBuilder url = new StringBuilder("/bos/hkFcltyResve/hldy/forUpdate.do");
		url.append("?hldyDe=").append(param.getString("hldyDe")).append("&").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.update"));
	}


	/**
	 * 휴일관리 삭제처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initCmmnParam(param);

		super.setDeleteQueryId("HkHldyDAO.deleteHldy");
		super.delete(paramCtx);

		String pageQueryString = pageQuery.getPageQueryString(param);
		StringBuilder url = new StringBuilder("/bos/hkFcltyResve/hldy/list.do");
		url.append("?").append(StrUtils.replace(pageQueryString, "&amp;", "&"));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, egovMessageSource.getMessage("success.common.delete"));
	}

	/*
	public void fileChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String fileDir = "E:\\curlurist_atch\\culture\\pds_upd\\";
		try {
			File dir = new File(fileDir);
			if (dir.isDirectory()) {
				File[] fileList = dir.listFiles();
				int i=0;
				for (File file : fileList) {
					i++;
					int index = file.getName().lastIndexOf(".");
				    //String fileName = orginFileName.substring(0, index);
				    String fileExt = file.getName().substring(index + 1);
				    String newFileNm = System.currentTimeMillis() + "_" + i +"."+ fileExt;
					param.put("oriFilenm", file.getName());
					param.put("newFilenm", newFileNm);
					sqlDao.insertDAO("HkHldyDAO.insertFileChg", param);

					  File file_rename = new File(fileDir + newFileNm);
				      file.renameTo(file_rename);


				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	*/
}
