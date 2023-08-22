package kr.co.unp.member.service;

import java.util.ArrayList;
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
import kr.co.unp.cmm.sec.ram.service.impl.LoginHistoryAuthenticationFailureHandler;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetails;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmmncode.dao.CmmnCodeDetailDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.CookieUtil;
import kr.co.unp.util.ZValue;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import com.icross.core.module.crypto.TripleDESCrypto;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class MemberService extends DefaultCmmProgramService {

	@Resource(name="passwordEncoder")
	private ShaPasswordEncoder passwordEncoder;

	@Resource(name = "SqlDAO")
	protected ISqlDAO<UsersVO> sqlUserDAO;
	
	protected ISqlDAO<EgovMap> egovSqlDao;

    @Resource(name="CmmnCodeDetailDAO")
    private CmmnCodeDetailDAO cmmnCodeDetailDAO;

	@Resource(name="loginHistoryAuthenticationFailureHandler")
	protected LoginHistoryAuthenticationFailureHandler loginHistoryAuthenticationFailureHandler;

    public static final String USER_ID_KEY = "MemberService.userId";
    public static final String USER_EMAIL_KEY = "MemberService.userEmail";
    public static final String USER_MBTLNUM_KEY = "MemberService.userMbtlnum";

	protected Log log = LogFactory.getLog(this.getClass());

	public MemberService(){
		super.setCountQueryId("memberDAO.selectMemberListCnt");
		super.setListQueryId("memberDAO.selectMemberList");
		super.setViewQueryId("memberDAO.selectMembers");
		super.setInsertQueryId("memberDAO.insertMember");
		super.setUpdateQueryId("memberDAO.updateMember");
		super.setDeleteQueryId("memberDAO.deleteMember");
	}

	public void join01(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		String naverAppId = propertyService.getString("Sns.naverAppKey");
		String naverCallbackUrl = propertyService.getString("Sns.naverCallbackUrl");
		String kakaoAppId = propertyService.getString("Sns.kakaoAppKey");
		String facebookAppId = propertyService.getString("Sns.facebookAppKey");
		String googleAppId = propertyService.getString("Sns.googlePlusAppKey");

		model.addAttribute("naverAppKey",naverAppId);
		model.addAttribute("naverCallbackUrl",naverCallbackUrl);
		model.addAttribute("kakaoAppKey",kakaoAppId);
		model.addAttribute("facebookAppKey",facebookAppId);
		model.addAttribute("googlePlusAppKey",googleAppId);
	}

	public void join02(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
/*		if (SiteMngService.TESTBED_SITE_NAME.equals(param.getString("siteName"))){  //rsg20170922
			user.setMberSe("03");
		}*/

		model.addAttribute("user", user);
	}

	public void joinMember(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		//nothing
	}

	public void joinCompt(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		

		model.addAttribute("user", user);
	}

	/**
	 * 회원 가입인증 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void vnameOutput(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
    	log.debug("param : " + param);

    	UsersVO vo = new UsersVO();

    	String siteNm = param.getString("siteName");
    	String menuNo = param.getString("menuNo");
    	String url = "/"+siteNm+"/member/join02.do?menuNo="+menuNo;
    	String mberSe = "01";
    	String authSe = param.getString("authSe");

    	if ("03".equals(authSe) || "04".equals(authSe)) { // 03: 네이버, 04: 페이스북
    		int cnt = sqlDao.selectCount("memberDAO.checkDupEmail", param); // 중복되는 이메일 확인
    		if (cnt > 0) {
    			MVUtils.goUrl("javascript:history.back();", "이미 등록된 회원입니다.", model);
    			return;
    		}
    		else {
    			mberSe = "02";
    		}
    	}
    	else {
    		authSe = "";
    	}

    	vo.setMberSe(mberSe);
    	vo.setAuthSe(authSe);
    	vo.setAuthAt(authSe);
    	vo.setUserKey(param.getString("authKey"));
    	vo.setEmail(param.getString("email"));
    	vo.setSex(param.getString("sex"));
    	setAuthentication(vo);

    	if ("02".equals(mberSe)) {
    		MVUtils.goUrl(url, "인증에 성공하였습니다.", model);
    	}
    	else {
    		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
    	}

	}

	public void vnameFail(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "인증에 실패하였습니다.");
		model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
	}

	private void setAuthentication(UsersVO vo){
    	List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
    	SimpleGrantedAuthority vnameAuthority = new SimpleGrantedAuthority("ROLE_VNAME");
    	authorities.add(vnameAuthority);
    	SecurityContext securityContext = SecurityContextHolder.getContext();
    	UnpUserDetails userDetail = new UnpUserDetails(String.valueOf(vo.getUserIdx()), vo.getPassword(), true, vo);
    	securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(userDetail,String.valueOf(vo.getUserIdx()), authorities));
	}

	/**
	 * 아이디 중복조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void checkDupId(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		//Assert.hasText(param.getString("userId"));

		String userId = param.getString("userId").toLowerCase();
		param.put("userId", userId);
		int cnt = sqlDao.selectCount("memberDAO.checkDupID", param);
		model.addAttribute("idCnt", cnt);
		if( cnt == 0 ) {
			paramCtx.getRequest().getSession().setAttribute(USER_ID_KEY, userId);
		}
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

	/**
	 * 이메일 중복조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void checkDupEmail(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		int cnt = sqlDao.selectCount("memberDAO.checkDupEmail", param);
		if( cnt == 0 ) {
			paramCtx.getRequest().getSession().setAttribute(USER_EMAIL_KEY, param.getString("email"));
		}
		model.addAttribute("emailCnt", cnt);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

	/**
	 * 휴대폰번호 중복조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void checkDupMbtlnum(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		int cnt = sqlDao.selectCount("memberDAO.checkDupMbtlnum", param);
		if( cnt == 0 ) {
			paramCtx.getRequest().getSession().setAttribute(USER_MBTLNUM_KEY, param.getString("mbtlnum"));
		}
		model.addAttribute("mbtlnumCnt", cnt);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		//param.put("pwd", passwordEncoder.encodePassword(param.getString("pwdNew"), null));
		param.put("pwd", HashCipher.createHash(param.getString("pwdNew")));


		super.update(paramCtx);
	}

	/**
	 * 로그인 포워딩
	 * @param paramCtx
	 * @throws Exception
	 */
	public void loginForward(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		model.addAttribute(UriModelAndViewResolver.WINDOW_MODE, UriModelAndViewResolver.CONFIRM_URL_WINDOW_MODE);
		model.addAttribute(UriModelAndViewResolver.CONFIRM_MSG_KEY, "인증이 필요한 페이지입니다. 인증페이지로 이동하시겠습니까?");
		model.addAttribute(UriModelAndViewResolver.GO_URL_KEY, "/portal/main/contents.do?menuNo=200412");
	}

	/**
	 * 로그인 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forLogin(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String naverAppId = propertyService.getString("Sns.naverAppKey");
		String naverCallbackUrl = propertyService.getString("Sns.naverCallbackUrl");
		String kakaoAppId = propertyService.getString("Sns.kakaoAppKey");
		String facebookAppId = propertyService.getString("Sns.facebookAppKey");
		String googleAppId = propertyService.getString("Sns.googlePlusAppKey");

		String ssoDomain = EgovProperties.getProperty("Globals.sso.domain");
		String realTp = EgovProperties.getProperty("Globals.realMode");
		String protocol = "http://";
		if ("Y".equals(realTp)) protocol = "https://";
		model.addAttribute("ssoDomain",protocol + ssoDomain);

		model.addAttribute("naverAppKey",naverAppId);
		model.addAttribute("naverCallbackUrl",naverCallbackUrl);
		model.addAttribute("kakaoAppKey",kakaoAppId);
		model.addAttribute("facebookAppKey",facebookAppId);
		model.addAttribute("googlePlusAppKey",googleAppId);
	}

	/**
	 * 로그인 체크(toLoginSSO 에서 선처리)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void toLogin(ParameterContext<ZValue> paramCtx) throws Exception {
		System.out.println("========================toLogin");
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		System.out.println("================ REFERER =============================> " + request.getHeader("REFERER"));
		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

 		if ("Y".equals(realMode)) protocol = "https://";
 		else protocol = "http://";
 		cklDomain = protocol + cklDomain;
		String ssoAuthToken = param.getString("ssoAuthToken");
		String saltkey = param.getString("saltkey","kocca");

		String username = "";
        String password = "";
        String sttus = "";

		param.put("username", "sjsjgg");
		param.put("password", "6699439411d65d9e0aa492afec1d4b8fbafd613a512bbc7196b6a5be595d2c"); //1q2w3e4r5t!
	    
	    /*param.put("username", "kok547");
	    param.put("password", "f46f0abab9477c96662b4c3e7e76c845272879df2e7223784d26473da7014df");*/

		if (!"".equals(ssoAuthToken)) {
			String[] ssoResult = CookieUtil.decodeAccount(ssoAuthToken); // toLoginSSO에서 넘김
			if (ssoResult != null && ssoResult.length > 2) {
				param.put("username", ssoResult[0]);
				param.put("password", ssoResult[1]);
				param.put("sttus", ssoResult[2]);
			}
		}
		else {
			param.put("password", HashCipher.createHash(param.getString("password")));
		}
		
        String siteNm = param.getString("siteName");
		String menuNo = "200055";
		if (SiteMngService.EDU_SITE_NAME.equals(siteNm)) menuNo = "500077";
		else if (SiteMngService.CKLMOBILE_SITE_NAME.equals(siteNm)) menuNo = "400029";
		else if (SiteMngService.EDUMOBILE_SITE_NAME.equals(siteNm)) menuNo = "600130";
		else if (SiteMngService.TESTBED_SITE_NAME.equals(siteNm)) menuNo = "700115";

        String goUrl = "/"+siteNm+"/member/forLogin.do?menuNo="+menuNo;
		username = param.getString("username");
        password = param.getString("password");
        sttus = param.getString("sttus");

        if (username == null || "".equals(username)) username = "none";

        ZValue result = sqlDao.selectDAO("memberDAO.selectUserLoginInfo", param);
        //System.out.println("++++++++++++++++++ username"+ username+"++++++++++++++++++");
		if ("P".equals(sttus)) { // 비밀번호 5회이상 틀릴시
			session.setAttribute("userId", username);
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+siteNm+"/userMember/pwdError.do?menuNo="+param.getString("menuNo"));
			return;
		}

     /*   if ("".equals(param.getString("authSe",""))) {
        	request.setAttribute("siteName", param.getString("siteName"));
			if (!loginHistoryAuthenticationFailureHandler.checkLoginHistory(request,param)) {
				if (result != null) {
					session.setAttribute("userId", username);
					model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+siteNm+"/userMember/pwdError.do?menuNo="+param.getString("menuNo"));
					return;
				}
			}
        }*/
        /*
        if (!"".equals(param.getString("authSe",""))) {
			ZValue simpleVO = sqlDao.selectDAO("memberDAO.selectSimpletUserLoginInfo", param);
			if (simpleVO != null) {
				param.put("userSn",simpleVO.getString("userSn"));
				param.put("username",simpleVO.getString("userId"));
				param.put("password",simpleVO.getString("password"));
				password = simpleVO.getString("password");
			}
		}
		*/
        //Assert.hasText(username);
    	//Assert.hasText(password);

		boolean failure = false;
 		if (result != null) {
			String pwd = result.getString("password");
			//System.out.println("+++++++++++++++ PWD +++++++++++");
			//System.out.println( pwd );
			//System.out.println("+++++++++++++++ PWD +++++++++++");

			if (!password.equals(pwd)) failure = true;

			/*
			if (!passwordEncoder.isPasswordValid(pwd, password, null) && "".equals(param.getString("authSe",""))) {
				failure = true;
			}
			else if (!password.equals(pwd) && !"".equals(param.getString("authSe",""))) {
				failure = true;
			}
			*/
		}
		else {

			// 구회원 디비 조회(콘텐츠아카데미, 창의드림)
			boolean flag = false;
			boolean dreamFlag = false;
			UsersVO vo = new UsersVO();
			ZValue academy = sqlDao.selectDAO("memberDAO.oldAcademyUser", param);
			if (academy != null) {
				if (password.equals(academy.getString("password"))) {
					flag = true;
					vo.setUserNm(academy.getString("userNm"));
				}
				else {
					dreamFlag = true;
				}
			}
			else {
				dreamFlag = true;
			}

			if (dreamFlag == true) {
				ZValue dream = sqlDao.selectDAO("memberDAO.oldDreamUser", param);
				if (dream != null) {
					if (password.equals(dream.getString("password"))) {
						flag = true;
						vo.setUserNm(dream.getString("userNm"));
					}
				}
			}

 			if (flag == true) {
				vo.setEmail(username);
				vo.setStatus("O");
 				setAuthentication(vo);
		    	//session.removeAttribute("ssoAuthToken");
 				if (!"cklmobile".equals(param.getString("siteName"))) {
 					MVUtils.goUrl("/"+param.getString("siteName")+"/userMember/listOldMember.do?menuNo="+menuNo, "기존 아이디에 대해 회원통합을 하셔야 합니다.", model);
 				}
 				else {
 					MVUtils.goUrl(cklDomain+"/ckl/userMember/listOldMember.do?menuNo=200055", "기존 아이디에 대해 회원통합을 하셔야 합니다.", model);
 				}
				return;
			}
			else {
				failure = true;
			}

		}
 		if (!"cklmobile".equals(param.getString("siteName"))) {
 			if (result == null || !saltkey.equals(result.getString("confirmKey"))) {
 				failure = true;
 			}
 		}
 		failure = false;
		if (failure) {

			if (!"O".equals(sttus)) { // 통합회원만
	        	request.setAttribute("siteName", siteNm);
				model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
				loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username);
			}
			if (session != null) session.invalidate();
			MVUtils.goUrl(goUrl, "아이디 혹은 비밀번호가 일치하지 않습니다.", model);
			return;
		}
		else {

			if ("D".equals(sttus)) { // 이관 데이터에서 중복되는 이메일이 있을시 통합페이지로
				UsersVO vo = new UsersVO();
				vo.setUserIdx(result.getInt("userSn"));
				vo.setUserNm(result.getString("userNm"));
				vo.setEmail(result.getString("email"));
				vo.setStatus("D");
 				setAuthentication(vo);
				goUrl = "/"+param.getString("siteName")+"/userMember/listOldMember.do?menuNo="+menuNo;
				if (!"cklmobile".equals(param.getString("siteName"))) {
					MVUtils.goUrl(goUrl, "기존 아이디에 대해 회원통합을 하셔야 합니다.", model);
				}
				else {
					MVUtils.goUrl(cklDomain+"/ckl/userMember/listOldMember.do?menuNo=200055", "기존 아이디에 대해 회원통합을 하셔야 합니다.", model);
				}
				return;
			}
			else if ("E".equals(sttus)) { // 이메일 미인증
				session.setAttribute("userSn", result.getString("userSn"));
				session.setAttribute("email", result.getString("email"));
				session.setAttribute("mbtlnum", result.getString("mbtlnum"));
				goUrl = "/"+siteNm+"/userMember/crtfcEmailError.do?menuNo="+menuNo;
				if (!"cklmobile".equals(param.getString("siteName"))) {
					MVUtils.goUrl(goUrl, "회원가입 시 이메일 인증에 대한 인증이 완료되지 않았습니다.", model);
				}
				else {
					MVUtils.goUrl(cklDomain+"/ckl/userMember/crtfcEmailError.do?menuNo=200055", "회원가입 시 이메일 인증에 대한 인증이 완료되지 않았습니다.", model);
				}
				return;
			}
			else if ("A".equals(sttus)) { // 이메일 및 휴대폰 미인증
				session.setAttribute("userId", result.getString("username"));
				session.setAttribute("userSn", result.getString("userSn"));
				session.setAttribute("email", result.getString("email"));
				session.setAttribute("mbtlnum", result.getString("mbtlnum"));
				if (!"cklmobile".equals(param.getString("siteName"))) {
					goUrl = "/"+siteNm+"/userMember/crtfcError.do?menuNo="+menuNo;
					MVUtils.goUrl(goUrl, "이메일 및 휴대폰으로 인증이 완료되지 않았습니다.", model);
				}
				else {
					MVUtils.goUrl(cklDomain+"/ckl/userMember/crtfcError.do?menuNo=200055", "이메일 및 휴대폰으로 인증이 완료되지 않았습니다.", model);
				}
				return;
			}


			//confirmKey 업데이트
			String confirmKey =  RandomStringUtils.random(5, "abcdefghijklmnopqrstuvwxyz1234567890");
			result.put("newConfirmKey", confirmKey);
			sqlDao.updateDAO("memberDAO.updateConfirmKey", result);

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("username", result.getString("userSn"));
			map.put("password", password);
			
			//insert login success history rsg20171130
        	request.setAttribute("siteName", siteNm);
			loginHistoryAuthenticationFailureHandler.saveSuccessHistory(paramCtx.getRequest(), username);
			
			if ( param.getString("redirectUrl").length() ==0 && SiteMngService.TESTBED_SITE_NAME.equals(siteNm) ) {
				map.put("redirectUrl", "/testbed/main/main.do");
				model.addAttribute("redirectUrl", "/testbed/main/main.do");
			} else {
				model.addAttribute("redirectUrl", param.getString("redirectUrl"));
				map.put("redirectUrl", param.getString("redirectUrl"));
			}
			MVUtils.goUrlHidden(map, "/"+siteNm+"/login.do", "로그인 되었습니다.", model);
		}


	}

	/**
	 * sso 로그인 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forLoginSSO(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		String naverAppId = propertyService.getString("Sns.naverAppKey");
		String naverCallbackUrl = propertyService.getString("Sns.naverCallbackUrl");
		String kakaoAppId = propertyService.getString("Sns.kakaoAppKey");
		String facebookAppId = propertyService.getString("Sns.facebookAppKey");
		String googleAppId = propertyService.getString("Sns.googlePlusAppKey");

		model.addAttribute("naverAppKey",naverAppId);
		model.addAttribute("naverCallbackUrl",naverCallbackUrl);
		model.addAttribute("kakaoAppKey",kakaoAppId);
		model.addAttribute("facebookAppKey",facebookAppId);
		model.addAttribute("googlePlusAppKey",googleAppId);

		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
		String meduDomain = EgovProperties.getProperty("Globals.edumobile.domain");
		String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
		String domain = cklDomain;
		System.out.println("++++++++++++++++++forLoginSSO"+param.getString("service")+"+++++++++++++++++++++++");
		if ("edu".equals(param.getString("service"))) domain = eduDomain;
		else if ("testbed".equals(param.getString("service"))) domain = testbedDomain; 
		else if ("edumobile".equals(param.getString("service"))) domain = meduDomain; 
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";
		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";
		model.addAttribute("domain",protocol + domain);
	}

	/**
	 * sso 로그인 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void incForLoginSSO(ParameterContext<ZValue> paramCtx) throws Exception {
		System.out.println("========================incForLoginSSO");
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		String naverAppId = propertyService.getString("Sns.naverAppKey");
		String naverCallbackUrl = propertyService.getString("Sns.naverCallbackUrl");
		String kakaoAppId = propertyService.getString("Sns.kakaoAppKey");
		String facebookAppId = propertyService.getString("Sns.facebookAppKey");
		String googleAppId = propertyService.getString("Sns.googlePlusAppKey");
		
		model.addAttribute("naverAppKey",naverAppId);
		model.addAttribute("naverCallbackUrl",naverCallbackUrl);
		model.addAttribute("kakaoAppKey",kakaoAppId);
		model.addAttribute("facebookAppKey",facebookAppId);
		model.addAttribute("googlePlusAppKey",googleAppId);

		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
		String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
		String edumobileDomain = EgovProperties.getProperty("Globals.edumobile.domain");
		
		String domain = cklDomain;
		if ("edu".equals(param.getString("service"))) domain = eduDomain;
		else if ("testbed".equals(param.getString("service"))) domain = testbedDomain;
		else if ("medu".equals(param.getString("service"))) domain = edumobileDomain;
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";
		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";
		model.addAttribute("domain",protocol + domain);
	}

	public void checkSSO(ParameterContext<ZValue> paramCtx) throws Exception {
		System.out.println("============================checkSSO");
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		if (session.getAttribute("ssoAuthToken") != null && "Y".equals(param.getString("jsonTp"))) {
			String ssoAuthToken =(String)session.getAttribute("ssoAuthToken");
			String[] result = CookieUtil.decodeAccount(ssoAuthToken);
			if (result != null) param.put("username", result[0]);
			ZValue userInfo = sqlDao.selectDAO("memberDAO.selectUserLoginInfo", param);

			ModelMap model = paramCtx.getModel();
			String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
			String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
			String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
			String edumobileDomain = EgovProperties.getProperty("Globals.edumobile.domain");
			String domain = cklDomain;
			if ("edu".equals(param.getString("service"))) domain = eduDomain;
			else if ("testbed".equals(param.getString("service"))) domain = testbedDomain;
			else if ("medu".equals(param.getString("service"))) domain = edumobileDomain;
			String protocol = "http";
			String realMode = EgovProperties.getProperty("Globals.realMode");

			if ("Y".equals(realMode)) protocol = "https://";
			else protocol = "http://";
			if ("Y".equals(realMode)) protocol = "https://";
			else protocol = "http://";
			model.addAttribute("domain",protocol + domain);
			if (userInfo != null) model.addAttribute("saltkey",userInfo.getString("confirmKey"));
			model.addAttribute("ssoAuthToken",session.getAttribute("ssoAuthToken"));
		}
	}


	public void incJoin01(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		String naverAppId = propertyService.getString("Sns.naverAppKey");
		String naverCallbackUrl = propertyService.getString("Sns.naverCallbackUrl");
		String kakaoAppId = propertyService.getString("Sns.kakaoAppKey");
		String facebookAppId = propertyService.getString("Sns.facebookAppKey");
		String googleAppId = propertyService.getString("Sns.googlePlusAppKey");

		model.addAttribute("naverAppKey",naverAppId);
		model.addAttribute("naverCallbackUrl",naverCallbackUrl);
		model.addAttribute("kakaoAppKey",kakaoAppId);
		model.addAttribute("facebookAppKey",facebookAppId);
		model.addAttribute("googlePlusAppKey",googleAppId);

		String siteNm = param.getString("service","ckl");
		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
		String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
		String edumobileDomain = EgovProperties.getProperty("Globals.edumobile.domain");
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";
		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";

		String redirectUrl = protocol;
		if ("ckl".equals(siteNm)) redirectUrl += cklDomain;
		else if ("edu".equals(siteNm)) redirectUrl += eduDomain;
		else if ("testbed".equals(siteNm)) redirectUrl += testbedDomain;
		else if ("medu".equals(siteNm)) redirectUrl += edumobileDomain;
		else redirectUrl += cklDomain;
		model.addAttribute("redirectUrl", redirectUrl);
	}


	public void incSimpleLogin(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		String naverAppId = propertyService.getString("Sns.naverAppKey");
		String naverCallbackUrl = propertyService.getString("Sns.naverCallbackUrl");
		String kakaoAppId = propertyService.getString("Sns.kakaoAppKey");
		String facebookAppId = propertyService.getString("Sns.facebookAppKey");
		String googleAppId = propertyService.getString("Sns.googlePlusAppKey");

		model.addAttribute("naverAppKey",naverAppId);
		model.addAttribute("naverCallbackUrl",naverCallbackUrl);
		model.addAttribute("kakaoAppKey",kakaoAppId);
		model.addAttribute("facebookAppKey",facebookAppId);
		model.addAttribute("googlePlusAppKey",googleAppId);

		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		param.put("userSn", session.getAttribute("userSn"));

		List<ZValue> simpleList = sqlDao.listDAO("memberDAO.selectSimpleLoginList", param);
		model.addAttribute("simpleList", simpleList);

		String siteNm = param.getString("service","ckl");
		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
		String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
		String edumobileDomain = EgovProperties.getProperty("Globals.edumobile.domain");
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";
		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";

		String redirectUrl = protocol;
		if ("ckl".equals(siteNm)) redirectUrl += cklDomain;
		else if ("edu".equals(siteNm)) redirectUrl += eduDomain;
		else if ("testbed".equals(siteNm)) redirectUrl += testbedDomain;
		else if ("medu".equals(siteNm)) redirectUrl += edumobileDomain;
		else redirectUrl += cklDomain;
		model.addAttribute("redirectUrl", redirectUrl);
	}


	/**
	 * SSO 로그인 처리페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void toLoginSSO(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession(false);

		//param.put("username", Base64.base64Decode(param.getString("username")));
		//param.put("password", Base64.base64Decode(param.getString("password")));

        String ssoDomain = session.getAttribute("ssoDomain2") == null ? "" : (String)session.getAttribute("ssoDomain2");
        if (session != null) session.removeAttribute("ssoDomain2");
        String compareDomain = request.getServerName();
        if (!ssoDomain.equals(compareDomain)) {
        	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
        	MVUtils.goUrl("javascript:history.back();", "잘못된 접근입니다.", model);
        	return;
        }


		String siteNm = param.getString("service","ckl");
		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
		String meduDomain = EgovProperties.getProperty("Globals.edumobile.domain");
		
		String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";

		String redirectUrl = protocol;
		//System.out.println("++++++++++++++++++forLoginSSO"+param.getString("service")+"+++++++++++++++++++++++");
		if ("ckl".equals(siteNm)) redirectUrl += cklDomain;
		else if ("edu".equals(siteNm)) redirectUrl += eduDomain;
		else if ("testbed".equals(siteNm)) redirectUrl += testbedDomain;
		else if ("edumobile".equals(param.getString("service"))) redirectUrl += meduDomain;
		else redirectUrl += cklDomain;
		model.addAttribute("redirectUrl", redirectUrl);

		String username = param.getString("username");
        String password = param.getString("password");

        if (!"".equals(param.getString("authSe",""))) {
			ZValue simpleVO = sqlDao.selectDAO("memberDAO.selectSimpletUserLoginInfo", param);
			if (simpleVO != null) {
				param.put("userSn",simpleVO.getString("userSn"));
				param.put("username",simpleVO.getString("userSn"));
				param.put("password",simpleVO.getString("password"));
				password = simpleVO.getString("password");
			}
		}
        else {
        	Assert.hasText(password);
    		Assert.hasText(username);
        }

		ZValue result = sqlDao.selectDAO("memberDAO.selectUserLoginInfo", param);
		String sttus = "I";
		String confirmKey = "";
		boolean failure = false;
		if (result != null) {
			confirmKey = result.getString("confirmKey");


			//if (!passwordEncoder.isPasswordValid(result.getString("password"), password, null) && "".equals(param.getString("authSe",""))) {
			if (!HashCipher.isPasswordValid(result.getString("password"), password) && "".equals(param.getString("authSe",""))) {
				failure = true;
			}
			else if (!password.equals(result.getString("password")) && !"".equals(param.getString("authSe",""))) {
				failure = true;
			}
			else {
				username = result.getString("username");
				password = result.getString("password");
				String authSe = result.getString("authSe");
				if (StringUtils.hasText(authSe)) {
					if ("01".equals(authSe)) { // 이메일
						if ("N".equals(result.getString("authEmailAt"))) { // 비인증
							sttus = "E";
							failure = true;
						}
					}
				}
				else { // 이메일 및 휴대폰 비인증
					sttus = "A";
					failure = true;
				}
			}

	        if ("".equals(param.getString("authSe",""))) {
	        	request.setAttribute("siteName", siteNm);
	        	param.put("siteName", siteNm);
				if (!loginHistoryAuthenticationFailureHandler.checkLoginHistory(request,param)) { // 비밀번호 5회이상 틀릴시
					sttus = "P";
					failure = true;
				}
	        }

			int cnt = sqlDao.selectCount("memberDAO.checkDupEmail", result);
			if (cnt > 0) { // 로그인시 중복된 이메일이 있을시
				sttus = "D";
				failure = true;
			}

		}
		else {

			boolean flag = false;
			boolean dreamFlag = false;
			ZValue academy = sqlDao.selectDAO("memberDAO.oldAcademyUser", param);
			if (academy != null) {
				if (TripleDESCrypto.encrypt(password).equals(academy.getString("password"))) {
					flag = true;
					username = academy.getString("userId");
					password = academy.getString("password");
					sttus = "O";
				}
				else {
					dreamFlag = true;
				}

			}
			else {
				dreamFlag = true;
			}

			if (dreamFlag == true) {
				ZValue dream = sqlDao.selectDAO("memberDAO.oldDreamUser", param);
				if (dream != null) {
					String oldDreamPwd = sqlDao.selectString("memberDAO.oldDreamPwd", param);
					if (oldDreamPwd.equals(dream.getString("password"))) {
						flag = true;
						username = dream.getString("userId");
						password = dream.getString("password");
						sttus = "O";
					}
				}
			}

			if (flag == true) {
				confirmKey = "unity";
			}
			failure = true;
		}

		String token = CookieUtil.encodeAccount(username, password, sttus);
		model.addAttribute("ssoAuthToken",  token);
		model.addAttribute("saltkey",  confirmKey);
		//System.out.println("++++++++++++++++++siteNm"+siteNm+"+++++++++++++++++++++++");
		if (!failure) {
			session.setAttribute("ssoAuthToken", token);
			session.setAttribute("userSn", result.getString("userSn"));

			UsersVO vo = new UsersVO();
			vo.setUserIdx(result.getLong("userSn"));
			vo.setUserId(result.getString("userId"));
			vo.setPassword(result.getString("password"));
			List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
	    	SimpleGrantedAuthority vnameAuthority = new SimpleGrantedAuthority("ROLE_USER");
	    	authorities.add(vnameAuthority);
	    	SecurityContext securityContext = SecurityContextHolder.getContext();
	    	UnpUserDetails userDetail = new UnpUserDetails(String.valueOf(vo.getUserIdx()), vo.getPassword(), true, vo);
	    	securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(userDetail,String.valueOf(vo.getUserIdx()), authorities));
	    	System.out.println(securityContext);
	    	session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
		}

	}

	/**
	 * 로그아웃
	 * @param paramCtx
	 * @throws Exception
	 */
	public void logout(ParameterContext<ZValue> paramCtx) throws Exception{
		System.out.println("=========== logout ==========");
		String ssoDomain = EgovProperties.getProperty("Globals.sso.domain");
		ZValue param = paramCtx.getParam();

//		String url = "/"+param.getString("siteName")+"/main/main.do";
		String url = "/sso/member/logoutSSO.do?service="+param.getString("siteName");

		HttpServletRequest request = paramCtx.getRequest();
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        SecurityContextHolder.clearContext();

        ModelMap model = paramCtx.getModel();
//		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
//        System.out.println("=========== logout url "+url+"==========");
//		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
        //MVUtils.goUrl(url, "로그아웃 되었습니다.", model);
	}



	public void logoutSSO(ParameterContext<ZValue> paramCtx) throws Exception{
//		System.out.println("=========== logoutSSO ==========");
		ZValue param = paramCtx.getParam();
		String siteNm = param.getString("service","ckl");
		String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");
		String eduDomain = EgovProperties.getProperty("Globals.edu.domain");
		String testbedDomain = EgovProperties.getProperty("Globals.testbed.domain");
		String edumobileDomain = EgovProperties.getProperty("Globals.edumobile.domain");
		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

		if ("Y".equals(realMode)) protocol = "https://";
		else protocol = "http://";

		String redirectUrl = protocol;
		if ("ckl".equals(siteNm)) redirectUrl += cklDomain;
		else if ("edu".equals(siteNm)) redirectUrl += eduDomain;
//		else if ("testbed".equals(siteNm)) redirectUrl += testbedDomain;
		else if ("testbed".equals(siteNm)) redirectUrl += eduDomain;
		else if ("medu".equals(siteNm)) redirectUrl += edumobileDomain;
		else redirectUrl += cklDomain;
		
		redirectUrl += "/"+siteNm+"/main/main.do";
		
		HttpServletRequest request = paramCtx.getRequest();
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        SecurityContextHolder.clearContext();

        ModelMap model = paramCtx.getModel();
//        System.out.println("=========== logoutSSO url "+redirectUrl+"==========");
		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, redirectUrl);
	}


	public void checkId(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		int cnt = sqlDao.selectCount("memberDAO.selectMemberListCnt", param);
		model.addAttribute("TARGET_OBJ", cnt);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

	protected boolean uploadImgFile(ParameterContext<ZValue> paramCtx) throws Exception {
		return true;
	}

	/**
	 * 공통코드 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public List<ZValue> codeList(String codeId, String upperCode) throws Exception {
		ZValue zvl = new ZValue();
		zvl.put("codeId", codeId);
		zvl.put("upperCode", upperCode);
		List<ZValue> codeResult = cmmnCodeDetailDAO.getDetailCodeList(zvl);
		return codeResult;
	}

}
