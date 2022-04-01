package kr.co.unp.member.web;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/{siteName}/member")
public class MemberController extends DefaultCmmProgramController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx){
		return "member";
	}
}
