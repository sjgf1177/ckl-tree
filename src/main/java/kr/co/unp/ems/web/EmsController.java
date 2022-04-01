package kr.co.unp.ems.web;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.ems.service.EmsService;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/{siteName}/ems")
public class EmsController extends DefaultCmmProgramController {

	@Resource(name="emsService")
    private EmsService emsService;

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "ems";
	}

}
