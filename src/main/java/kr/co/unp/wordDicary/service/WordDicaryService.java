package kr.co.unp.wordDicary.service;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

@Service("wordDicaryService")
public class WordDicaryService extends DefaultCmmProgramService {

	public WordDicaryService(){
		super.setListQueryId("WordDicaryDAO.selectWordDicaryList");
		super.setCountQueryId("WordDicaryDAO.selectWordDicaryListCnt");
		super.setViewQueryId("WordDicaryDAO.selectWordDicary");
		super.setInsertQueryId("WordDicaryDAO.insertWordDicary");
		super.setDeleteQueryId("WordDicaryDAO.deleteWordDicary");
		super.setUpdateQueryId("WordDicaryDAO.updateWordDicary");
	}

	public void delPermanently(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		sqlDao.updateDAO("WordDicaryDAO.delPermanentlyWordDicary", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "완전 삭제되었습니다.");
	}

	public void restore(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		sqlDao.updateDAO("WordDicaryDAO.restoreWordDicary", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "복구되었습니다.");
	}



}
