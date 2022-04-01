package kr.co.ckl.progrm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

@Controller
@RequestMapping("/{siteName}/progrm/master")
public class ProgrmMasterController extends DefaultCmmProgramController{

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "progrmMaster";
	}


}
