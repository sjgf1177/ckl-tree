package kr.co.unp.bbs.accessor;

import java.util.Iterator;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.springframework.util.StringUtils;

public class DefaultArticleAccessor implements ArticleAccessor<ZValue> {

	private String queryId;
	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;
	private String goUrl;

	@Override
	public boolean canAccess(ParameterContext<ZValue> paramCtx) throws Exception {
		//접근제한은 한번만 검사
		String accessApplied = (String)paramCtx.getModel().get(ACCESS_APPLIED);
		if ( StringUtils.hasText(accessApplied) ) {
			return true;
		}

		boolean access = false;
		if ( canAccess0(paramCtx) ) {
			access = true;
			paramCtx.getModel().put(ACCESS_APPLIED, ACCESS_APPLIED);
		}
		return access;
	}

	protected boolean canAccess0(ParameterContext<ZValue> paramCtx) throws Exception {
		boolean access = false;
		if ( UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY") ) {
			access = true;
		}
		else {
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			ZValue val = sqlDao.selectDAO(queryId, paramCtx.getParam());
			if ( user.getUserIdx() == val.getInt("userIdx") ) {
				access = true;
			}
			else if ( val.getString("userId").equals(user.getUserId()) ) {
				access = true;
			}
		}
		return access;
	}

	@SuppressWarnings("unchecked")
	public String getAccessDenyPage(ParameterContext<ZValue> paramCtx) {
		ZValue param = paramCtx.getParam();
		StringBuilder goUrlLink = new StringBuilder();
		if ( StringUtils.hasText(goUrl) ) {
			String link = goUrl;
			Iterator<String> it = param.keySet().iterator();
			while (it.hasNext()) {
				String name = it.next();
				String value = param.getString(name);
				link = StringUtils.replace(link, "["+name+"]", value);
			}
			goUrlLink.append(link);
		}
		else {
			goUrlLink.append("/").append(param.getString(CmmProgramService.SITE_NAME)).append("/");
			goUrlLink.append(param.getString(CmmProgramService.PROGRAM_ID)).append("/list.do?menuNo=").append(param.getString("menuNo"));
		}
		return goUrlLink.toString();
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

	public String getGoUrl() {
		return goUrl;
	}

	public void setGoUrl(String goUrl) {
		this.goUrl = goUrl;
	}

}
