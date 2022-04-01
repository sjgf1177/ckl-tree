package kr.co.unp.bbs.listener;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.cmm.crud.listener.CmmProgramListenerSupport;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.vo.AclParamVO.AclParam;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.security.acls.domain.ObjectIdentityImpl;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.security.acls.model.MutableAcl;
import org.springframework.security.acls.model.ObjectIdentity;

public class AclSaveArticleListener extends CmmProgramListenerSupport<ZValue> {

	@Resource(name="aclService")
	private JdbcMutableAclService aclService;

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		ObjectIdentity oid = new ObjectIdentityImpl(ParameterContext.class);
		MutableAcl acl = aclService.createAcl(oid);
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		acl.setOwner(new PrincipalSid(String.valueOf(user.getUserIdx())));
		List<AclParam> aclParams = getAclParams(paramCtx);
		if( CollectionUtils.isNotEmpty(aclParams) ){
			for(int i=0; i<aclParams.size(); i++){
				acl.insertAce(i, aclParams.get(i).getPermission(), aclParams.get(i).getSid(), aclParams.get(i).isGranting());
			}
		}
		aclService.updateAcl(acl);
		return CONTINUE;
	}
	
	protected List<AclParam> getAclParams(ParameterContext<ZValue> paramCtx) throws Exception {
		return paramCtx.getAclParamVO().getAclParam();
	}
	
}
