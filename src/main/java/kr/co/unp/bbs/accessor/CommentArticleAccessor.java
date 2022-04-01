package kr.co.unp.bbs.accessor;

import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

public class CommentArticleAccessor extends ArticleAccessorBase {

	@Override
	public boolean canAccess(ParameterContext<ZValue> paramCtx) throws Exception {
		if( UnpUserDetailsHelper.isAuthenticated("ROLE_ADMIN") ) return true;
		
		ModelMap model = paramCtx.getModel();
		ZValue result = (ZValue)model.get(CmmProgramService.RESULT);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		if( user == null ) return false;
		boolean condition = false;
		if( StringUtils.hasText(result.getString("ntcrPinno")) && StringUtils.hasText(user.getDupInfo()) ){
			if( result.getString("ntcrPinno").equals(user.getDupInfo()) )
				condition = true;
		}
		return condition;
	}
}
