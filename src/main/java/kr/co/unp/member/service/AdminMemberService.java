package kr.co.unp.member.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.edu.util.HashCipher;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.mvr.UriModelAndViewResolver;
import kr.co.unp.cmm.crud.service.DefaultCmmProgramService;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.cmm.sec.ram.service.AuthorManageVO;
import kr.co.unp.cmm.sec.ram.service.impl.AuthorManageDAO;
import kr.co.unp.cmm.sec.ram.service.impl.LoginHistoryAuthenticationFailureHandler;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

public class AdminMemberService extends DefaultCmmProgramService {

	@Resource(name="passwordEncoder")
	private ShaPasswordEncoder passwordEncoder;

	@Resource(name="authorManageDAO")
	private AuthorManageDAO authorManageDAO;

	@Resource(name="loginHistoryAuthenticationFailureHandler")
	private LoginHistoryAuthenticationFailureHandler loginHistoryAuthenticationFailureHandler;

	@Resource(name = "SqlDAO")
	protected ISqlDAO<UsersVO> sqlUserDAO;

	Logger log = Logger.getLogger(this.getClass());

	public AdminMemberService(){
		super.setCountQueryId("memberDAO.selectMemberListCnt");
		super.setListQueryId("memberDAO.selectMemberList");
		super.setViewQueryId("memberDAO.selectMembers");
		super.setInsertQueryId("memberDAO.insertMember");
		super.setUpdateQueryId("memberDAO.updateMember");
		super.setDeleteQueryId("memberDAO.deleteMember");
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception{
		super.forInsert(paramCtx);

		List<AuthorManageVO> authorList = authorManageDAO.selectAuthorAllList();
        ModelMap model = paramCtx.getModel();
		model.addAttribute("authorList", authorList);

		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		String pwdNew = param.getString("pwdNew");

		/*UsersVO user = new UsersVO();
		user.setUserKey(param.getString("userId"));
		user.setUserNm(param.getString("userNm"));
		user.setCrtfcSe("A");

		Object pkVal = sqlUserDAO.insertDAO("memberDAO.insertUserKey", user);

		param.put("userIdx", pkVal);
		param.put("mType", "0");*/
		param.put("encodedPwd", passwordEncoder.encodePassword(pwdNew, null));
		initParam(param);

		super.insert(paramCtx);

		//access history param
		param.put("targetUserSn", paramCtx.getPkValue());
		param.put("etcInfo", param.getString("authorCode"));
	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception{
		super.forUpdate(paramCtx);

		List<AuthorManageVO> authorList = authorManageDAO.selectAuthorAllList();
        ModelMap model = paramCtx.getModel();
		model.addAttribute("authorList", authorList);

		model.addAttribute("deptList", sqlDao.listDAO("memberDAO.selectAllMemberDeptList", null));
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("userId"));

		initParam(param);

		String pwdNew = param.getString("pwdNew");
		if( StringUtils.hasText(pwdNew) ){
			param.put("encodedPwd", passwordEncoder.encodePassword(pwdNew, null));
		}
		super.update(paramCtx);

		//access history param
		param.put("targetUserSn", param.getString("userIdx"));
		param.put("etcInfo", param.getString("authorCode"));
	}

	@Override
	public void delete(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> userIdData = param.getList("userIdData");
		if( CollectionUtils.isNotEmpty(userIdData) ){
			for(String userId : userIdData){
				param.put("userId", userId);
				sqlDao.deleteDAO("memberDAO.deleteMember", param);
			}
		}
		else{
			sqlDao.deleteDAO("memberDAO.deleteMember", param);
		}
        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 삭제되었습니다.");
	}

	public void forLogin(ParameterContext<ZValue> paramCtx) throws Exception{
		/*
		if( !loginHistoryAuthenticationFailureHandler.checkLoginHistory(paramCtx.getRequest()) ){
			MVUtils.winClose("비밀번호 5회틀릴시 30분동안 로그인할수 없습니다.", paramCtx.getModel());
		}
		*/
	}

	public void toLogin(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

		String username = param.getString("username");
		Assert.hasText(username);
        String password = param.getString("password");
		Assert.hasText(password);

        String goUrl = "/bos/member/forLogin.do";
		if( !loginHistoryAuthenticationFailureHandler.checkLoginHistory(paramCtx.getRequest(), param) ){
			MVUtils.goUrl(goUrl, "비밀번호 5회틀릴시 30분동안 로그인할수 없습니다.", model);
			return;
		}

		param.put("id", username);
		ZValue result = sqlDao.selectDAO("memberDAO.selectLoginInfo", param);
		
		boolean failure = false;
		if ( result != null ) {
			String pwd = result.getString("password");

			if ( !passwordEncoder.isPasswordValid(pwd, password, null) ) {
				failure = true;
			}
		}
		else {
			failure = true;
		}

		if( failure ) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
			loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username);

			MVUtils.goUrl(goUrl, "아이디 혹은 비밀번호가 일치하지 않습니다.", model);
			return;
		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("username", param.getString("username"));
		map.put("password", passwordEncoder.encodePassword(password, null));
		MVUtils.goUrlHidden(map, "/bos/login.do", "로그인 되었습니다.", model);
	}

	public void logout(ParameterContext<ZValue> paramCtx) throws Exception{

		String url = "/bos/member/forLogin.do";

		HttpServletRequest request = paramCtx.getRequest();
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        SecurityContextHolder.clearContext();

        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
	}

	public void checkId(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        String userId = param.getString("userId");
		Assert.hasText(userId);

		int cnt = sqlDao.selectCount("memberDAO.selectMemberListCnt", param);
		model.addAttribute("cnt", cnt);
	}

	public void forUpdateMy(ParameterContext<ZValue> paramCtx) throws Exception{
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getUserId();

		ZValue param = paramCtx.getParam();
		param.put("userId", userId);

		forUpdate(paramCtx);
	}

	public void updateMy(ParameterContext<ZValue> paramCtx) throws Exception{
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getUserId();

		ZValue param = paramCtx.getParam();
		param.put("userId", userId);

		initParam(param);

		String pwdNew = param.getString("pwdNew");
		if( StringUtils.hasText(pwdNew) ){
			param.put("encodedPwd", passwordEncoder.encodePassword(pwdNew, null));
		}
		sqlDao.updateDAO("memberDAO.updateMemberMy", param);
		ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "javascript:history.back();");
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 수정되었습니다.");
		model.addAttribute(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
	}

	public void listPop(ParameterContext<ZValue> paramCtx) throws Exception{
		super.list(paramCtx);
	}

	private void initParam(ZValue param){
		String email = param.getString("userEmail1") + "@" + param.getString("userEmail2");
		param.put("email", email);
		String telNo = param.getString("telNo1") + "-" + param.getString("telNo2") + "-" + param.getString("telNo3");
		param.put("telNo", telNo);

	}
	
	/**
	 * 관리자 기존 비밀번호 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void adminPwdCheck(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue result = sqlDao.selectDAO("memberDAO.selectLoginInfo", param);
		String password= param.getString("password");
		String pwd = result.getString("password");
		
		if (!passwordEncoder.isPasswordValid(pwd, password, null)) {
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.ERROR);
		}
		else {
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
		}
	}
	
	/**
	 * 관리자 비밀번호 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void adminPwdChangeRequest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userIdx", user.getUserIdx());
		
		param.put("password", passwordEncoder.encodePassword(param.getString("password"), null));
		sqlDao.updateDAO("memberDAO.adminPwdChangeRequest", param);

		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
	}

	/**
	 * 관리자 비밀번호 다음에 변경(한달후)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void adminPwdNextChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.updateDAO("memberDAO.adminPwdNextChange", param);

		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
	}


}
