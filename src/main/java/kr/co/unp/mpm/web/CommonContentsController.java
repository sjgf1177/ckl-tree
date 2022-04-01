package kr.co.unp.mpm.web;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bos/mpm/commonContents")
public class CommonContentsController extends DefaultCmmProgramController {

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx){
		return "commonContents";
	}
}