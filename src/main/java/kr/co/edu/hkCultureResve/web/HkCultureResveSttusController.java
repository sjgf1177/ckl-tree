package kr.co.edu.hkCultureResve.web;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/{siteName}/hkCultureResve/resveSttus")
public class HkCultureResveSttusController extends DefaultCmmProgramController {

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "hkCultureResveSttus";
	}
}