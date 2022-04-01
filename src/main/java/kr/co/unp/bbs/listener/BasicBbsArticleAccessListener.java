package kr.co.unp.bbs.listener;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerSupport;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.DefaultPageQuery;
import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class BasicBbsArticleAccessListener extends CmmProgramListenerSupport<ZValue> {

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;
	private String queryId = "optionalBoardDAO.articeByAccess";
	private PageQuery<ZValue> pageQuery = new DefaultPageQuery();

	@Override
	public boolean doBefore(ParameterContext<ZValue> paramCtx) throws Exception {
		if (UnpUserDetailsHelper.isAuthenticated("ROLE_ADMIN"))
			return CONTINUE;

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		StringBuilder link = new StringBuilder();
		link.append("/").append(param.getString("siteName")).append("/bbs/").append(param.getString("bbsId")).append("/list.do?").append(pageQuery.getPageQueryString(param));
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, link.toString());
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.MODIFY_FAIL);
		
		ZValue result = sqlDao.selectDAO(queryId, param);
		String targetMethod = paramCtx.getTargetMethod();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		boolean condition = false;
		if (StringUtils.hasText(result.getString("ntcrCi")) && StringUtils.hasText(user.getUserKey())) {
			if (result.getString("ntcrCi").equals(user.getUserKey()))
				condition = true;
		}
		if (StringUtils.hasText(result.getString("ntcrId")) && StringUtils.hasText(user.getUserId())) {
			if (result.getString("ntcrId").equals(user.getUserId()))
				condition = true;
		}
		if ("view".equals(targetMethod)) {
			if (!SearchVO.SECRET.equals(result.getString("secret")))
				return CONTINUE;
			if( !condition ){
				model.addAttribute(ModelAndViewResolver.MSG_KEY, "비공개글 입니다.");
				return STOP;
			}
		}
		if ("forUpdate".equals(targetMethod) || "update".equals(targetMethod) ) {
			if (!condition) {
				model.addAttribute(ModelAndViewResolver.MSG_KEY, "본인글만 수정할 수 있습니다.");
				return STOP;
			}
		}
		if ("delete".equals(targetMethod) || "delPermanently".equals(targetMethod) ) {
			if (!condition) {
				model.addAttribute(ModelAndViewResolver.MSG_KEY, "본인글만 삭제할 수 있습니다.");
				return STOP;
			}
		}

		return condition;
	}

	public String getQueryId() {
		return queryId;
	}

	public void setQueryId(String queryId) {
		this.queryId = queryId;
	}

	public ISqlDAO<ZValue> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<ZValue> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public PageQuery<ZValue> getPageQuery() {
		return pageQuery;
	}

	public void setPageQuery(PageQuery<ZValue> pageQuery) {
		this.pageQuery = pageQuery;
	}

}
