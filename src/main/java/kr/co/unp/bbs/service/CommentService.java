package kr.co.unp.bbs.service;

import java.util.List;
import java.util.Map;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.UnpCollectionUtils;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class CommentService extends DefaultCmmProgramService{

	public CommentService(){
    	super.setCountQueryId("CommentDAO.selectCommentListCnt");
    	super.setListQueryId("CommentDAO.selectCommentList");
    	super.setViewQueryId("CommentDAO.selectComment");
    	super.setInsertQueryId("CommentDAO.insertCommentArticle");
    	super.setUpdateQueryId("CommentDAO.updateCommentState");
    	super.setDeleteQueryId("CommentDAO.deleteCommentArticle");
	}

	@Override
    public void list(ParameterContext<ZValue> paramCtx) throws Exception
    {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> resultList = sqlDao.listDAO(listQueryId, param);
		model.addAttribute("resultList", resultList);

		/*super.list(paramCtx);
    	@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
*/
		if ( CollectionUtils.isNotEmpty(resultList) ) {
			Map<String, List<FileVO>> fileMap = listHandler.getFileMap(paramCtx.getParam(), resultList);
			UnpCollectionUtils.setFirstFile(resultList, fileMap, "atchFileId");
		}
    }

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("ntcrIdx", user.getUserIdx());
		param.put("ntcrId", user.getUserId());
		param.put("ntcrNm", user.getUserNm());
		param.put("cmmntSe", user.getCrtfcSe());
		param.put("ntcrCi", user.getDupInfo());
		param.put("delcode", 0);
		param.put("lastUpdusrId", user.getUserId());

		sqlDao.insertDAO("CommentDAO.insertCommentArticle", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "댓글이 등록되었습니다.");
    }

	@Override
    public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception
    {
		ZValue param = paramCtx.getParam();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("ntcrPinno", user.getDupInfo());
		super.forUpdate(paramCtx);
    }

	@Override
    public void update(ParameterContext<ZValue> paramCtx) throws Exception
    {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		if( !getAccessor().canAccess(paramCtx) ){
			return;
		}

		sqlDao.updateDAO("CommentDAO.updateCommentState", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "댓글이 수정되었습니다.");
    }

	@Override
    public void delete(ParameterContext<ZValue> paramCtx) throws Exception
    {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if( !getAccessor().canAccess(paramCtx) ){
			return;
		}

		if( !StringUtils.hasText(param.getString("delcode")) ) param.put("delcode", SearchVO.NON_DELETION);
		sqlDao.updateDAO("CommentDAO.deleteCommentArticle", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "댓글이 삭제되었습니다.");
    }

	@Override
    public void view(ParameterContext<ZValue> paramCtx) throws Exception
    {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.selectDAO("CommentDAO.selectComment", param);
    	model.addAttribute("result", result);
    }

    public void recommend(ParameterContext<ZValue> paramCtx) throws Exception
    {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		sqlDao.updateDAO("CommentDAO.recommend", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
    }

}
