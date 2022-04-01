package kr.co.unp.cmm.crud.listener;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

public class AccessLogCmmProgramListener extends CmmProgramListenerSupport<ZValue> {

	private String cateTp = "";

	public void setCateTp(String cateTp) {
		this.cateTp = cateTp;
	}

	Logger log = Logger.getLogger(this.getClass());
	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;



	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		//log.debug(paramCtx.getTargetMethod() + " after");
		if (!UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY")) return CONTINUE;

		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		param.put("cateTp", cateTp);
		param.put("accessIp", request.getRemoteAddr());

		String targetMethod = paramCtx.getTargetMethod();

		String accessCrud = "R";
		if (targetMethod.indexOf("list") > -1) accessCrud = "L";
		else if (targetMethod.indexOf("view") > -1) accessCrud = "R";
		else if (targetMethod.indexOf("insert") > -1) accessCrud = "C";
		else if (targetMethod.indexOf("delete") > -1) accessCrud = "D";
		else if (targetMethod.indexOf("update") > -1) accessCrud = "U";
		else if (targetMethod.indexOf("resveSave") > -1) {
			if (!"".equals(param.getString("resveSn"))) accessCrud = "U";
			else accessCrud = "C";
		}

		param.put("accessCrud", accessCrud);

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("accessAdminId", user.getUserId());


		//nttSn, targetUserSn, etcInfo 별도록 메소드 마다 지정해야함

		sqlDao.insertDAO("AccessHistoryDAO.insert", param);
		return CONTINUE;
	}

}
