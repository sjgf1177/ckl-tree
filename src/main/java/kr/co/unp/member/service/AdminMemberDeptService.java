package kr.co.unp.member.service;

import java.util.List;

import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;

public class AdminMemberDeptService extends DefaultCmmProgramService {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	public AdminMemberDeptService(){
		super.setCountQueryId("memberDAO.selectMemberDeptListCnt");
		super.setListQueryId("memberDAO.selectMemberDeptList");
		super.setInsertQueryId("memberDAO.insertMemberDept");
		super.setUpdateQueryId("memberDAO.updateMemberDept");
		super.setDeleteQueryId("memberDAO.deleteMemberDept");
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> userIdData = param.getList("deptIdData");
		if( CollectionUtils.isNotEmpty(userIdData) ){
			for(String userId : userIdData){
				param.put("deptId", userId);
				sqlDao.deleteDAO(deleteQueryId, param);
			}
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 삭제되었습니다.");
	}
}
