package kr.co.unp.bbs.accessor;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class BbsArticleAccessor extends DefaultArticleAccessor {

	@Override
	protected boolean canAccess0(ParameterContext<ZValue> paramCtx) throws Exception {
		if ( UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY") ) {
			return true;
		}

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		boolean access = false;
		String targetMethod = paramCtx.getTargetMethod();
		ZValue result = null;
		if ( "view".equals(targetMethod) ) {
			result = (ZValue)model.get(CmmProgramService.RESULT);
			if ( !SearchVO.SECRET.equals(result.getString("secret")) ) {
				return true;
			}
		}
		else {
			result = getSqlDao().selectDAO(getQueryId(), param);
		}

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if( StringUtils.hasText(result.getString("ntcrCi")) && StringUtils.hasText(user.getUserKey()) ){
			if ( result.getString("ntcrCi").equals(user.getUserKey()) ) {
				access = true;
			}
		}
		if( StringUtils.hasText(result.getString("ntcrId")) && user.getUserIdx() > 0 ){
			if ( result.getString("ntcrId").equals(user.getUserIdx()) || result.getInt("ntcrId") == user.getUserIdx() ) {
				access = true;
			}
		}
		return access;
	}

	@Override
	public String getAccessDenyPage(ParameterContext<ZValue> paramCtx) {
		ZValue param = paramCtx.getParam();
		StringBuilder goUrl = new StringBuilder();
		goUrl.append("/").append(param.getString(CmmProgramService.SITE_NAME)).append("/bbs/");
		goUrl.append(param.getString("bbsId")).append("/list.do?menuNo=").append(param.getString("menuNo"));
		return goUrl.toString();
	}
}
