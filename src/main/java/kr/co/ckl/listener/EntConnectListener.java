package kr.co.ckl.listener;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.listener.CmmProgramListenerSupport;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.file.service.FnwFileMngService;
import kr.co.unp.member.service.MemberService;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;

public class EntConnectListener extends CmmProgramListenerSupport<ZValue> {

	@Resource(name = "memberService")
	private MemberService memberService;

	@Resource(name = "fnwFileMngService")
	private FnwFileMngService fnwFileMngService;

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();

		String targetMethod = paramCtx.getTargetMethod();


		return CONTINUE;
	}

}
