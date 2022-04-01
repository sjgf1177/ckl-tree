package kr.co.edu.job.service;

import java.util.List;

import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

/**
 * 채용 공고
 */
public class jobfairService  extends DefaultCmmProgramService  {
	Logger log = Logger.getLogger(this.getClass());

	public jobfairService() {
	}
	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		super.initCmmnParam(param);
		super.setInsertQueryId("empmnPblanc.insertEmpmnPblanc");
		super.insert(paramCtx);
	}

}
