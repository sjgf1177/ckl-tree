package kr.co.unp.sns.web;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/portal/sns/{snsKind}")
public class SnsController extends DefaultCmmProgramController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx){

		return paramCtx.getParam().getString("snsKind");
	}
}
