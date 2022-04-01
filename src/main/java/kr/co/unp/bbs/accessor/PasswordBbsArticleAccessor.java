package kr.co.unp.bbs.accessor;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.service.CmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

@Service("passwordBbsArticleAccessor")
public class PasswordBbsArticleAccessor extends ArticleAccessorBase {

	@Resource(name="passwordEncoder")
	private PasswordEncoder passwordEncoder;

	@Override
	public boolean canAccess(ParameterContext<ZValue> paramCtx) throws Exception {
		String targetMethod = paramCtx.getTargetMethod();
		ModelMap model = paramCtx.getModel();
		ZValue result = (ZValue)model.get(CmmProgramService.RESULT);
		if ( "view".equals(targetMethod) ) {
			if ( !SearchVO.SECRET.equals(result.getString("secret")) ) {
				return true;
			}
		}
		
		boolean condition = true;
		ZValue param = paramCtx.getParam();
		String inputPassword = param.getString("password");
		Assert.hasText(inputPassword);

		String encodedPassword = passwordEncoder.encodePassword(inputPassword, null);
		if( encodedPassword.equals(result.getString("password")) ){
			condition = true;
		}
		return condition;
	}

}
