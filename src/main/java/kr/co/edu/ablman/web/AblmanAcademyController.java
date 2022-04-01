package kr.co.edu.ablman.web;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/{siteName}/ablman/academy")
public class AblmanAcademyController extends DefaultCmmProgramController {

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "ablmanAcademy";
	}
}