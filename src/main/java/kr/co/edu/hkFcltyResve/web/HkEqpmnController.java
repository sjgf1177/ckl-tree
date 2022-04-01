package kr.co.edu.hkFcltyResve.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

@Controller
@RequestMapping("/{siteName}/hkFcltyResve/eqpmn")
public class HkEqpmnController extends DefaultCmmProgramController {

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "hkEqpmn";
	}
}