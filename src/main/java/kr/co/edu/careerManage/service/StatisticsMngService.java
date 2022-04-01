package kr.co.edu.careerManage.service;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;

import kr.co.edu.careerManage.paging.StuCareerMngPageQuery;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

public class StatisticsMngService extends DefaultCmmProgramService {
	Logger log = Logger.getLogger(this.getClass());
	
	public StatisticsMngService() {
		
		
	}
	
	@Override
	public void list(ParameterContext<ZValue> paramCtx) throws Exception {
		paramCtx.setPageQuery(new StuCareerMngPageQuery());
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.setCountQueryId("CareerManageDAO.listStuCnt");
		if (!paramCtx.getParam().containsKey("gubun") || param.getString("gubun").equals("01")) {
			super.setListQueryId("CareerManageDAO.statisticsGubun1");
		} else if (param.getString("gubun").equals("02")) {
			super.setListQueryId("CareerManageDAO.statisticsGubun2");
		} else if (param.getString("gubun").equals("03")) {
			super.setListQueryId("CareerManageDAO.statisticsGubun3");
		} else if (param.getString("gubun").equals("04")) {
			super.setListQueryId("CareerManageDAO.statisticsGubun4");
		}
		
		super.list(paramCtx);
		
		List<ZValue> eduList = sqlDao.listDAO("CareerManageDAO.listEduMng", param);
		model.addAttribute("eduList", eduList);
	}
}
