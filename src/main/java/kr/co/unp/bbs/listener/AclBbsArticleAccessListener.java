package kr.co.unp.bbs.listener;

import java.util.List;

import javax.annotation.Resource;

import kr.co.unp.bbs.vo.SearchVO;
import kr.co.unp.cmm.crud.listener.CmmProgramListenerSupport;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.paging.DefaultPageQuery;
import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.vo.AclParamVO;
import kr.co.unp.cmm.crud.vo.AclParamVO.AclParam;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.security.acls.AclPermissionEvaluator;
import org.springframework.security.acls.domain.ObjectIdentityImpl;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.security.acls.model.MutableAcl;
import org.springframework.security.acls.model.ObjectIdentity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

public class AclBbsArticleAccessListener extends CmmProgramListenerSupport<ZValue> {

	@Resource(name="aclService")
	private JdbcMutableAclService aclService;
	@Resource(name="permissionEvaluator")
	private AclPermissionEvaluator permissionEvaluator;
	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;
	private String queryId = "optionalBoardDAO.articeByAccess";
	private PageQuery<ZValue> pageQuery = new DefaultPageQuery();
	
	@Override
	public boolean doBefore(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		boolean result = CONTINUE;
		String targetMethod = paramCtx.getTargetMethod();
		if ("view".equals(targetMethod)) {
			ZValue val = sqlDao.selectDAO(queryId, param);
			if (!SearchVO.SECRET.equals(val.getString("secret")))
				result = CONTINUE;
			if( !hasPermission(param, model, "READ", "비공개글입니다.") ){
				result = STOP;
			}
		}
		else if( "forUpdate".equals(targetMethod) || "update".equals(targetMethod) ){
			if( !hasPermission(param, model, "READ", "본인글만 수정할 수 있습니다.") ){
				result = STOP;
			}
		}
		else if( "delete".equals(targetMethod) || "delPermanently".equals(targetMethod) ){
			if( !hasPermission(param, model, "DELETE", "본인글만 삭제할 수 있습니다.") ){
				result = STOP;
			}
		}
		return result;
	}

	@Override
	public boolean doAfter(ParameterContext<ZValue> paramCtx) throws Exception {
		AclParamVO aclParamVO = paramCtx.getAclParamVO();
		if( aclParamVO == null ){
			return CONTINUE;
		}
		
		Long id = aclParamVO.getId();
		String targetMethod = paramCtx.getTargetMethod();
		if( "insert".equals(targetMethod) ){
			ObjectIdentity oid = new ObjectIdentityImpl(ZValue.class, id);
			MutableAcl acl = aclService.createAcl(oid);
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			acl.setOwner(new PrincipalSid(user.getUserId()));
			List<AclParam> aclParams = aclParamVO.getAclParam();
			if( CollectionUtils.isNotEmpty(aclParams) ){
				for(int i=0; i<aclParams.size(); i++){
					acl.insertAce(i, aclParams.get(i).getPermission(), aclParams.get(i).getSid(), aclParams.get(i).isGranting());
				}
			}
			aclService.updateAcl(acl);
		}
		else if( "delete".equals(targetMethod) ){
			Assert.isTrue(id > 0);

			ObjectIdentity oid = new ObjectIdentityImpl(ZValue.class, id);
			aclService.deleteAcl(oid, true);
		}
		return CONTINUE;
	}
	
	private boolean hasPermission(ZValue param, ModelMap model, String permission, String msg) throws Exception{
		param.put("id", param.getLong("nttId"));
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		if( !permissionEvaluator.hasPermission(authentication, param, "DELETE") ){
			StringBuilder link = new StringBuilder();
			String pq = StringUtils.replace(pageQuery.getPageQueryString(param), "&amp;", "&");
			link.append("/").append(param.getString("siteName")).append("/bbs/").append(param.getString("bbsId")).append("/list.do?").append(pq);
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, link.toString());
			model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
			return false;
		}
		return true;
	}

	public PageQuery<ZValue> getPageQuery() {
		return pageQuery;
	}

	public void setPageQuery(PageQuery<ZValue> pageQuery) {
		this.pageQuery = pageQuery;
	}

	public ISqlDAO<ZValue> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<ZValue> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public String getQueryId() {
		return queryId;
	}

	public void setQueryId(String queryId) {
		this.queryId = queryId;
	}
	
}
