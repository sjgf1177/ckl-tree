package kr.co.unp.cmm.crud.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.crud.paging.IPageInfo;
import kr.co.unp.cmm.crud.paging.PageQuery;
import kr.co.unp.cmm.crud.vo.AclParamVO;
import kr.co.unp.cmm.crud.vo.CacheVO;
import kr.co.unp.cmm.crud.vo.QueryIdVO;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

public class ParameterContext<T> {

	private HttpServletRequest request;
	private HttpServletResponse response;
	Map<String, MultipartFile> files;
	private ModelMap model;
	private T param;
	private Object pkValue;
	private String userIp;
	private QueryIdVO queryIdVO;
	private IPageInfo pageInfo;
	private PageQuery<T> pageQuery;
	private UsersVO usersVO;
	private CacheVO cacheVO;
	private String targetMethod;
	private AclParamVO aclParamVO;
	private ISqlDAO<T> sqlDAO;
	private String upFileTp = "";

	public Object getId() {
		return getPkValue();
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	public ModelMap getModel() {
		return model;
	}
	public void setModel(ModelMap model) {
		this.model = model;
	}
	public T getParam() {
		return param;
	}
	public void setParam(T param) {
		this.param = param;
	}
	public Map<String, MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(Map<String, MultipartFile> files) {
		this.files = files;
	}
	public Object getPkValue() {
		return pkValue;
	}
	public void setPkValue(Object pkValue) {
		this.pkValue = pkValue;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	public QueryIdVO getQueryIdVO() {
		return queryIdVO;
	}
	public void setQueryIdVO(QueryIdVO queryIdVO) {
		this.queryIdVO = queryIdVO;
	}
	public IPageInfo getPageInfo() {
		return pageInfo;
	}
	public void setPageInfo(IPageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}
	public PageQuery<T> getPageQuery() {
		return pageQuery;
	}
	public void setPageQuery(PageQuery<T> pageQuery) {
		this.pageQuery = pageQuery;
	}
	public UsersVO getUsersVO() {
		return usersVO;
	}
	public void setUsersVO(UsersVO usersVO) {
		this.usersVO = usersVO;
	}
	public CacheVO getCacheVO() {
		return cacheVO;
	}
	public void setCacheVO(CacheVO cacheVO) {
		this.cacheVO = cacheVO;
	}
	public String getTargetMethod() {
		return targetMethod;
	}
	public void setTargetMethod(String targetMethod) {
		this.targetMethod = targetMethod;
	}
	public AclParamVO getAclParamVO() {
		return aclParamVO;
	}
	public void setAclParamVO(AclParamVO aclParamVO) {
		this.aclParamVO = aclParamVO;
	}
	public ISqlDAO<T> getSqlDAO() {
		return sqlDAO;
	}
	public void setSqlDAO(ISqlDAO<T> sqlDAO) {
		this.sqlDAO = sqlDAO;
	}
	public String getUpFileTp() {
		return upFileTp;
	}
	public void setUpFileTp(String upFileTp) {
		this.upFileTp = upFileTp;
	}
}
