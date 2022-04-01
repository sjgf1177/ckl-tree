package kr.co.edu.careerManage.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.web.DefaultCmmProgramController;
import kr.co.unp.util.ZValue;

@Controller
@RequestMapping("/{siteName}/careerManage/statisticsMng")
public class StatisticsMngController extends DefaultCmmProgramController{
	@Override
	protected String getProgramId(ParameterContext<ZValue> paramCtx) {
		return "statisticsMng";
	}
}
