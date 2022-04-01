package kr.co.ckl.progrm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

@Controller
@RequestMapping("/{siteName}/progrm/instrctr")
public class ProgrmInstrctrController extends DefaultCmmProgramController{

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "progrmInstrctr";
	}


}