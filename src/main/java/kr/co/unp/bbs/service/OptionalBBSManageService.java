package kr.co.unp.bbs.service;

import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.service.FnwBBSManageServiceImpl;
import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

public class OptionalBBSManageService extends FnwBBSManageServiceImpl {

	public OptionalBBSManageService(){
		super.setCountQueryId("optionalBoardDAO.selectBoardArticleListCnt");
		super.setListQueryId("optionalBoardDAO.selectBoardArticleList");
		super.setViewQueryId("optionalBoardDAO.selectBoardArticle");
		super.setInsertQueryId("optionalBoardDAO.insertBoardArticle");
		super.setUpdateQueryId("optionalBoardDAO.updateBoardArticle");
		super.setDeleteQueryId("optionalBoardDAO.deleteBoardArticle");
		super.setUpdateInqireCoQueryId("optionalBoardDAO.updateInqireCo");
		super.setReplyListQueryId("optionalBoardDAO.selectReplyArticles");
		super.setExcelQueryId("optionalBoardDAO.selectBoardExcelList");
		super.setPrevQueryId("optionalBoardDAO.selectPrevArticle");
		super.setNextQueryId("optionalBoardDAO.selectNextArticle");
	}

	@Override
	public void delPermanently(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		int nttId = param.getInt("nttId");
		if( nttId > 0 ){
			super.delPermanently(paramCtx);
		}
		else{
			deleteAllPermanently(paramCtx);
		}
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		int nttId = param.getInt("nttId");
		if( nttId > 0 ){
			super.delete(paramCtx);
		}
		else{
			deleteAll(paramCtx);
		}
	}

	public List<ZValue> listAll(ZValue param) throws Exception
	{
		List<ZValue> resultList = sqlDao.listDAO("optionalBoardDAO.selectAllBoardArticles", param);
		Map<String, List<FileVO>> fileMap = listHandler.getFileMap(param, resultList);
		setBoardFirstFile(resultList, fileMap);
		return resultList;
	}

	public void deleteAll(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> nttIdData = param.getList("nttIdData");
		Assert.notEmpty(nttIdData);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		for(String nttId : nttIdData){
			param.put("nttId", nttId);
			param.put("lastUpdusrId", user.getUserId());
			param.put("delcode", SearchVO.BOS_DELETION);
			sqlDao.deleteDAO(deleteQueryId, param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

	public void deleteAllPermanently(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> nttIdData = param.getList("nttIdData");
		Assert.notEmpty(nttIdData);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		for(String nttId : nttIdData){
			param.put("nttId", nttId);
			param.put("lastUpdusrId", user.getUserId());
			param.put("delcode", SearchVO.BOS_DELETION);
			sqlDao.deleteDAO(delPermanentlyQueryId, param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}
}
