package kr.co.ckl.progrm.service;

import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

public class ProgrmInstrctrService extends DefaultCmmProgramService {

	public ProgrmInstrctrService(){
		super.setCountQueryId("progrmInstrctrDAO.listCnt");
		super.setListQueryId("progrmInstrctrDAO.list");
		super.setInsertQueryId("progrmInstrctrDAO.insert");
		super.setUpdateQueryId("progrmInstrctrDAO.update");
		super.setDeleteQueryId("progrmInstrctrDAO.delete");
		super.setViewQueryId("progrmInstrctrDAO.view");
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initParam(param);

		super.insert(paramCtx);
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initParam(param);

		super.update(paramCtx);
	}

	private void initParam(ZValue param) throws Exception {

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());
		String tel = param.getString("tel1") + "-" + param.getString("tel2") + "-" + param.getString("tel3");
		param.put("tel", tel);

	}

	/**
	 * 강사 팝업 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void instrctrPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		super.list(paramCtx);
	}

}
