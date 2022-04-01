package kr.co.testbed.concert.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

@Controller
@RequestMapping("/{siteName}/concert/info")
public class ConcertMngController extends DefaultCmmProgramController {
	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "concertMng";
	}
	
	
	@RequestMapping("/createQrCode.do") 
	public ModelAndView createCode(@PathVariable String siteName, @RequestParam String content){ 
		Map<String, Object> param = new HashMap();
		param.put("content", content);
		return new ModelAndView(siteName+"/qrcode/qrcode_writer",param); 
		
	}

}
