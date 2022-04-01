package kr.co.unp.member.service;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.co.edu.util.HashCipher;
import kr.co.unp.bbs.vo.FileVO;
import kr.co.unp.cmm.crud.mvr.ModelAndViewResolver;
import kr.co.unp.cmm.crud.mvr.UriModelAndViewResolver;
import kr.co.unp.cmm.crud.service.ParameterContext;
import kr.co.unp.cmm.crud.util.MVUtils;
import kr.co.unp.cmm.sec.ram.service.impl.AuthorManageDAO;
import kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper;
import kr.co.unp.cmm.view.vo.ExcelGenerateVO;
import kr.co.unp.ems.service.EmsService;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.FileMngUtil;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.siren24.Base64;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.sim.service.EgovFileScrty;

public class UserMemberService extends MemberService {

	@Resource(name="passwordEncoder")
	private ShaPasswordEncoder passwordEncoder;

	@Resource(name="authorManageDAO")
	private AuthorManageDAO authorManageDAO;

	@Resource(name = "emsService")
	protected EmsService emsService;

	protected Log log = LogFactory.getLog(this.getClass());

	public UserMemberService(){
		super.setCountQueryId("memberDAO.selectUserMemberListCnt");
		super.setListQueryId("memberDAO.selectUserMemberList");
		super.setViewQueryId("memberDAO.selectUserMembers");
		super.setInsertQueryId("memberDAO.insertUserMember");
		super.setUpdateQueryId("memberDAO.updateUserMember");
		super.setDeleteQueryId("memberDAO.deleteUserMember");
	}


	@Override
	public void view(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		initParam(param);
		super.view(paramCtx);
		List<ZValue> simpleList = sqlDao.listDAO("memberDAO.selectSimpleLoginList", param);
		model.addAttribute("simpleList", simpleList);

		//access history param
		param.put("targetUserSn", param.getString("userSn"));
		model.addAttribute("COM063CodeList", codeList("COM063"));
	}

	@Override
	public void forInsert(ParameterContext<ZValue> paramCtx) throws Exception{
		ModelMap model = paramCtx.getModel();

		super.forInsert(paramCtx);

		model.addAttribute("COM063CodeList", codeList("COM063"));
	}

	@Override
	public void insert(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		initParam(param);

		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			param.put("password", HashCipher.createHash(param.getString("mbtlnum3")));
			param.put("mberSe", "01");
		}

		super.insert(paramCtx);

		//access history param
		param.put("targetUserSn", paramCtx.getPkValue());
	}


	public void forUpdateConfirm(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

	}

	@Override
	public void forUpdate(ParameterContext<ZValue> paramCtx) throws Exception{
		
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

//		sqlDao.insertDAO("memberDAO.insertConcertUserMember", param);
		if (!SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			if (!"".equals(param.getString("chkPwd",""))) {
				String pwd = HashCipher.createHash(param.getString("chkPwd"));
				param.put("chkPwd", pwd);
				param.put("username", user.getUserId());
				ZValue vo = sqlDao.selectDAO("memberDAO.selectUserLoginInfo", param);
				if (vo == null) {
					MVUtils.goUrl("/"+param.getString("siteName")+"/userMember/forUpdateConfirm.do?menuNo="+param.getString("menuNo"), "비밀번호가 일치하지 않습니다.", model);
					return;
				}
			}
			else {
				MVUtils.goUrl("/"+param.getString("siteName")+"/userMember/forUpdateConfirm.do?menuNo="+param.getString("menuNo"), null, model);
				return;
			}

			param.put("userSn", user.getUserIdx());
			param.put("concertUseAt", "Y");
			ZValue resultTestbed = sqlDao.selectDAO("memberDAO.selectConcertUserMembers", param);
			if ( resultTestbed != null ){
				model.addAttribute("resultTestbed", resultTestbed );
			}
			/*if ("03".equals(user.getMberSe())){  //rsg20170922
//			if (SiteMngService.TESTBED_SITE_NAME.equals(param.getString("siteName"))){  //rsg20170922
				ZValue resultTestbed = sqlDao.selectDAO("memberDAO.selectConcertUserMembers", param);
				model.addAttribute("resultTestbed", resultTestbed );
			}*/
		}

		super.forUpdate(paramCtx);

		model.addAttribute("COM063CodeList", codeList("COM063"));
	}

	@Override
	public void update(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		initParam(param);
		
		String concertEmailAt= param.getString("concertEmailAt");
		String concertSmsAt= param.getString("concertSmsAt");
		if ( "Y".equals(concertEmailAt) || "Y".equals(concertSmsAt) ) {
			param.put("mberSe", "03");
			param.put("concertUseAt", "Y");
			sqlDao.updateDAO("memberDAO.insertConcertUserMember", param);
		}
		else if ( "N".equals(concertEmailAt) && "N".equals(concertSmsAt) ) {
			param.put("mberSe", "02");
			param.put("concertUseAt", "N");
			sqlDao.updateDAO("memberDAO.insertConcertUserMember", param);
		}
		
		// 회원 정보 수정
		sqlDao.updateDAO("memberDAO.updateUserMember", param);

		// lms 회원정보 수정
		lmsSqlDao.updateDAO("lmsMemberDAO.updateMember", param);

		ModelMap model = paramCtx.getModel();
		/*if (SiteMngService.TESTBED_SITE_NAME.equals(param.getString("siteName"))) //rsg20170922
			//param.put("concertUseAt", "Y");
			sqlDao.updateDAO("memberDAO.insertConcertUserMember", param);*/
		if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			MVUtils.goUrl("/bos/userMember/list.do?"+param.getString("pageQueryString"), "정상적으로 수정되었습니다.", model);
		}
		else {
			MVUtils.goUrl("/"+param.getString("siteName")+"/userMember/forUpdate.do?menuNo="+param.getString("menuNo"), "정상적으로 수정되었습니다.", model);
		}

		//access history param
		param.put("targetUserSn", param.getString("userSn"));
	}

	public void delete(ParameterContext<ZValue> paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		List<String> userSnData = param.getList("userSnData");
		if (CollectionUtils.isNotEmpty(userSnData)) {
			for (String userSn : userSnData) {
				param.put("userSn", userSn);
				sqlDao.deleteDAO("memberDAO.deleteUserMember", param);
				//access history param
				param.put("targetUserSn", param.getString("userSn"));
			}
		}
		else {
			sqlDao.deleteDAO("memberDAO.deleteUserMember", param);
			//access history param
			param.put("targetUserSn", param.getString("userSn"));
		}

        ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 삭제되었습니다.");
	}

	/**
	 * 회원 비밀번호 초기화
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdInitl(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		try {
			String telno = param.getString("telno");
			param.put("pwd", HashCipher.createHash(telno));
			param.put("password", HashCipher.createHash(telno));
			sqlDao.updateDAO("memberDAO.pwdInitl", param);
			try {
				lmsSqlDao.updateDAO("lmsMemberDAO.updatePwd", param);
			}
			catch (Exception e) {
				e.printStackTrace();
			}

			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
		}
		catch (Exception e) {
			e.printStackTrace();
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY , UriModelAndViewResolver.ERROR);
		}
	}

	public void pwdReset(ParameterContext<ZValue> paramCtx) throws Exception{

		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("userId"));
		ModelMap model = paramCtx.getModel();
		model.addAttribute("userId",param.getString("userId"));

	}

	public void updatePwdReset(ParameterContext<ZValue> paramCtx) throws Exception{

		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("userId"));
		Assert.hasText(param.getString("password2"));
		ModelMap model = paramCtx.getModel();
		model.addAttribute("userId",param.getString("userId"));

		String inputOldPasswd = param.getString("oldPasswd");
		if( StringUtils.hasText(inputOldPasswd) ) {
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			String oldPasswd = user.getPassword();
			String encodePasswd = HashCipher.createHash(inputOldPasswd);
			if( !encodePasswd.equals(oldPasswd) ) {
				MVUtils.goUrl("javascript:history.back();", "비밀번호가 맞지않습니다.", model);
				return;
			}
		}

		param.put("password2", HashCipher.createHash(param.getString("password2")));
		sqlDao.updateDAO("memberDAO.updateUserMemberPwdReset", param);
		StringBuilder link = new StringBuilder();
		link.append("/bos/userMember/list.do?").append(param.getString("pageQueryString"));
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);

		if (!SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, link.toString());
		} else {
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY,"javascript:window.close();");
		}
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상처리하였습니다.");
	}

	private void initParam(ZValue param) throws Exception {
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("frstRegisterId", user.getUserIdx());
			param.put("lastUpdusrId", user.getUserIdx());
		}

		String email = param.getString("email1") + "@" + param.getString("email2");
		param.put("email", email);

		String mbtlnum = param.getString("mbtlnum1") + "-" + param.getString("mbtlnum2") + "-" + param.getString("mbtlnum3");
		if (StringUtils.hasText(param.getString("mbtlnum"))) mbtlnum = param.getString("mbtlnum");
		param.put("mbtlnum", mbtlnum);


		String parntsMbtlnum = param.getString("parntsMbtlnum1") + "-" + param.getString("parntsMbtlnum2") + "-" + param.getString("parntsMbtlnum3");
		if (StringUtils.hasText(param.getString("parntsMbtlnum"))) parntsMbtlnum = param.getString("parntsMbtlnum");
		param.put("parntsMbtlnum", parntsMbtlnum);

	}

	/**
	 * 사용자 회원등록
	 */
	@Override
	public void joinMember(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		String mberSe = user.getMberSe();

		String password = param.getString("password");
		if (StringUtils.hasText(password)) {
			param.put("pwd", password);
			param.put("password", HashCipher.createHash(password));
		}

		initParam(param);
		param.put("all", "Y");


		// 아이디 중복체크
		String userId = session.getAttribute(MemberService.USER_ID_KEY) == null ? "" : (String)session.getAttribute(MemberService.USER_ID_KEY);
		param.put("userId", userId);
		session.removeAttribute(MemberService.USER_ID_KEY);
		int cnt = sqlDao.selectCount("memberDAO.checkDupID", param);
		if (cnt > 0) {
			MVUtils.goUrl("javascript:history.back();", "사용 불가능한 아이디입니다.", model);
		}
		else {
			super.checkDupEmail(paramCtx); // 이메일 중복체크

			int emailCnt = Integer.parseInt(model.get("emailCnt").toString());

			if (emailCnt > 0) {
				MVUtils.goUrl("javascript:history.back();", "사용 불가능한 이메일입니다.", model);
			}
			else {
				super.checkDupMbtlnum(paramCtx); // 휴대폰번호 중복체크

				int mbtlnumCnt = Integer.parseInt(model.get("mbtlnumCnt").toString());

				if (mbtlnumCnt > 0) {
					MVUtils.goUrl("javascript:history.back();", "사용 불가능한 휴대폰번호입니다.", model);
				}
				else {

					String authSe = "";
					String emailAuthAt = param.getString("emailAuthAt");
					String mbtlnumAuthAt = param.getString("mbtlnumAuthAt");

					if ("Y".equals(emailAuthAt) && "".equals(mbtlnumAuthAt)) { // 이메일 인증
						authSe = "01";
					}
					else if ("".equals(emailAuthAt) && "Y".equals(mbtlnumAuthAt)) { // 핸드폰 인증
						authSe = "02";
					}
					else if ("Y".equals(emailAuthAt) && "Y".equals(mbtlnumAuthAt)) { // 둘다 인증
						authSe = "03";
					}
					param.put("authSe", authSe);

	    			String concertEmailAt= param.getString("concertEmailAt");
	    			String concertSmsAt= param.getString("concertSmsAt");
//	    			System.out.println("++++++++++++++++++"+concertEmailAt + concertSmsAt+"+++++++++++++++++");
	    			if ( "Y".equals(concertEmailAt) || "Y".equals(concertSmsAt) ) {
	    				param.put("mberSe", "03");
	    				param.put("concertUseAt", "Y");
	    				sqlDao.updateDAO("memberDAO.insertConcertUserMember", param);
	    			}
					Object userSnPk = sqlDao.insertDAO("memberDAO.insertUserMember", param);

	    			if ("02".equals(mberSe)) { // SNS로 인증시 간편로그인 등록
	    				param.put("userSn", userSnPk);
	    				param.put("authKey", user.getUserKey());
	    				sqlDao.insertDAO("memberDAO.insertSimpleUserMember", param);
	    			}
	    			if ("Y".equals(emailAuthAt)) { // 인증메일 발송
						param.put("authSeGubun", "01");
	    				param.put("userSn", userSnPk);
						if ("01".equals(mberSe)) crtfcSndng(paramCtx);
	    			}
	    			if ("Y".equals(mbtlnumAuthAt)) { // 휴대폰인증시 가입문자 발송
	    				String siteNm = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "콘텐츠코리아랩" : "EDUKOCCA";
	    				String tranMsg = "["+siteNm+"] 회원가입이 완료되었습니다. [아이디-"+param.getString("userId")+"]";
	    				param.put("phone", param.getString("mbtlnum"));
	    				param.put("callback", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "02-2161-0000" : "02-6310-0770");
//	    				param.put("callback", "02-6310-0770");
	    				param.put("msg", tranMsg);
	    				emsService.sndngSms(param);
	    			}

//	    			System.out.println("++++++++++++++++++"+param.getString("siteName")+" testbed insert"+"+++++++++++++++++");
//	    			if (SiteMngService.TESTBED_SITE_NAME.equals(param.getString("siteName"))){  //rsg20170922

						//param.put("compNm", "");
						//param.put("concertEmail", "");
//	    			}
	    			insertLmsMember(paramCtx); // LMS 회원등록

	    			user.setAuthSe(authSe);
	    			user.setUserId(param.getString("userId"));

					MVUtils.goUrl("/"+param.getString("siteName")+"/member/joinCompt.do?menuNo="+param.getString("menuNo"), "정상적으로 등록되었습니다.", model);
				}
			}
		}

	}

	/**
	 * LMS회원등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insertLmsMember(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		try {
			//param.put("password", EgovFileScrty.encryptPassword(param.getString("pwd")));
			param.put("sex", "M".equals(param.getString("sex")) ? "1" : "2");

			String brthdy = param.getString("brthdy");
			if (StringUtils.hasText(brthdy)) {
				param.put("memberyear", brthdy.split("-")[0]);
				param.put("membermonth", brthdy.split("-")[1]);
				param.put("memberday", brthdy.split("-")[2]);
			}
			lmsSqlDao.insertDAO("lmsMemberDAO.insert", param);
		} catch (Exception e) {}
	}

	/**
	 * 간편로그인 설정화면
	 * @param paramCtx
	 * @throws Exception
	 * 	 */
	public void simpleLogin(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		/*
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());

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

		List<ZValue> simpleList = sqlDao.listDAO("memberDAO.selectSimpleLoginList", param);
		model.addAttribute("simpleList", simpleList);
		*/
	}

	/**
	 * 간편로그인 연결하기
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insertSimpleLogin(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		param.put("userSn", session.getAttribute("userSn"));
		param.put("snsAuthSe", param.getString("authSe"));

		sqlDao.insertDAO("memberDAO.insertSimpleUserMember", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}


	/**
	 * 간편로그인 삭제하기
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteSimpleLogin(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		param.put("userSn", session.getAttribute("userSn"));

		sqlDao.deleteDAO("memberDAO.deleteSimpleLogin", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 회원 아이디 찾기 폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idSearch(ParameterContext<ZValue> paramCtx) throws Exception {
	}

	/**
	 * 회원 아이디 찾기 요청
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idSearchRequest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> idList = sqlDao.listDAO("memberDAO.searchRequest", param);

		if (CollectionUtils.isEmpty(idList)) {
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.ERROR);
		}
		else {
			model.addAttribute("idList", idList);
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
		}

	}

	/**
	 * 회원 비밀번호 찾기 폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdSearch(ParameterContext<ZValue> paramCtx) throws Exception {
	}

	/**
	 * 회원 비밀번호 찾기 요청
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdSearchRequest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue val = sqlDao.selectDAO("memberDAO.searchRequest", param);
		String msg = "임시 비밀번호를 회원가입 시 인증받은 휴대폰 또는 메일 주소로 발송해드렸습니다.";

		if (val == null) {
			msg = "일치하는 정보가 없습니다.";
		}
		else {
			String authSe = val.getString("authSe");
			String pwdNew = "";
			System.out.println(authSe);
			if ("01".equals(authSe)) {
				if ("Y".equals(val.getString("authEmailAt"))) {
					if (StringUtils.hasText(val.getString("email"))) pwdNew = val.getString("email").split("@")[0];
				}
				else {
					msg = "해당 계정은 이메일 인증이 완료되지 않았습니다.";
				}
			}
			else {
				if (StringUtils.hasText(authSe)) {
					String mbtlnum = val.getString("mbtlnum").replaceAll("-", "");

					if (mbtlnum.length() > 3 && StringUtils.hasText(val.getString("mbtlnum"))) pwdNew = mbtlnum.substring(mbtlnum.length()-4,mbtlnum.length());
				}
				else {
					msg = "해당 계정은 이메일 또는 휴대폰으로 인증이 완료되지 않았습니다.";
				}
			}

			if (StringUtils.hasText(pwdNew)) {
				val.put("pwd", HashCipher.createHash(pwdNew));
				val.put("password", HashCipher.createHash(pwdNew));
				sqlDao.updateDAO("memberDAO.pwdInitl", val);
				try {
					lmsSqlDao.updateDAO("lmsMemberDAO.updatePwd", val);
				}
				catch (Exception e) {
					e.printStackTrace();
				}
				String siteNm = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "콘텐츠코리아랩" : "EDUKOCCA";
				String eduDomain = "https://" + EgovProperties.getProperty("Globals.edu.domain") + "/edu/member/forLogin.do?menuNo=500077";
				String cklDomain = Globals.HOST_URL + "/ckl/member/forLogin.do?menuNo=200055";
				String siteUrl = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? cklDomain : eduDomain;
				if ("01".equals(authSe)) {
					StringBuffer contSb = new StringBuffer();
					contSb.append("<h2 style='font-size:30px;font-weight:600'>비밀번호 찾기 결과</h2>");
					contSb.append("<p style='font-size:14px;padding-top:10px'>안녕하세요. <strong>"+val.getString("userNm")+"</strong>님!<br/>");
					contSb.append("아이디 (<strong>"+val.getString("userId")+"</strong>)에 대한 임시비밀번호 <strong>“"+pwdNew+"”</strong>가 발급되었습니다.<br/>");
					contSb.append("해당 비밀번호는 보안에 취약하므로 로그인 시 바로 변경해주시기 바랍니다.</p>");
					contSb.append("<div style='text-align:center;text-align:center;'>");
					contSb.append("<a href='"+siteUrl+"' style='display:inline-block;font-weight:600;padding:15px 50px;background:#eb1c24;color:#fff;text-decoration:none;' target='_blank' title='로그인페이지로 이동(새창열림)'>로그인페이지로 이동</a>");
					contSb.append("</div>");

					param.put("title", "["+siteNm+"] 비밀번호 찾기 결과 메일");
					param.put("name", siteNm);
					param.put("content", contSb.toString());
					param.put("email", val.getString("email"));
					emsService.sndngEmail(param);
				} else if ("03".equals(authSe) && "1".equals(param.getString("returnTp"))){
					StringBuffer contSb = new StringBuffer();
					contSb.append("<h2 style='font-size:30px;font-weight:600'>비밀번호 찾기 결과</h2>");
					contSb.append("<p style='font-size:14px;padding-top:10px'>안녕하세요. <strong>"+val.getString("userNm")+"</strong>님!<br/>");
					contSb.append("아이디 (<strong>"+val.getString("userId")+"</strong>)에 대한 임시비밀번호 <strong>“"+pwdNew+"”</strong>가 발급되었습니다.<br/>");
					contSb.append("해당 비밀번호는 보안에 취약하므로 로그인 시 바로 변경해주시기 바랍니다.</p>");
					contSb.append("<div style='text-align:center;text-align:center;'>");
					contSb.append("<a href='"+siteUrl+"' style='display:inline-block;font-weight:600;padding:15px 50px;background:#eb1c24;color:#fff;text-decoration:none;' target='_blank' title='로그인페이지로 이동(새창열림)'>로그인페이지로 이동</a>");
					contSb.append("</div>");

					param.put("title", "["+siteNm+"] 비밀번호 찾기 결과 메일");
					param.put("name", siteNm);
					param.put("content", contSb.toString());
					param.put("email", val.getString("email"));
					emsService.sndngEmail(param);
				} else {
					String tranMsg = "["+siteNm+"] 아이디("+val.getString("userId")+")에 대한 임시비밀번호 \""+pwdNew+"\"가 발급되었습니다.";
					param.put("phone", val.getString("mbtlnum"));
					param.put("callback", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "02-2161-0000" : "02-6310-0770");
					param.put("refkey", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "cklab" : "academy");
					param.put("msg", tranMsg);
					emsService.sndngSms(param);
				}
			}

		}
		model.addAttribute(UriModelAndViewResolver.MSG_KEY, msg);
		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);

	}


	/**
	 * 회원 비밀번호 변경 폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		model.addAttribute("user", user);
	}

	/**
	 * 회원 기존 비밀번호 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdCheck(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue result = sqlDao.selectDAO("memberDAO.selectUserLoginInfo", param);

		if (!HashCipher.isPasswordValid(result.getString("password"), param.getString("password"))) {
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.ERROR);
		}
		else {
			model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
		}
	}

	/**
	 * 회원 비밀번호 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdChangeRequest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn", user.getUserIdx());
		param.put("userId", user.getUserId());

		param.put("password", HashCipher.createHash(param.getString("password")));
		sqlDao.updateDAO("memberDAO.pwdChangeRequest", param);
		try {
			lmsSqlDao.updateDAO("lmsMemberDAO.updatePwd", param);
		}
		catch (Exception e) {
			e.printStackTrace();
		}


		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
	}

	/**
	 * 회원 비밀번호 다음에 변경(한달후)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdNextChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.updateDAO("memberDAO.pwdNextChange", param);

		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
	}

	@Override
	protected boolean uploadImgFile(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		String atchFileId = param.getString("atchFileId");
		String filePath = getFilePath(param);

		Map<String, MultipartFile> files = paramCtx.getFiles();
		if ( files != null ) {
			String fileFlag = fileUtil.checkFileInfo(files, 50000000, null);
			if (ModelAndViewResolver.SUCCESS.equals(fileFlag)) {
				atchFileId = fnwFileMngService.saveFile(files, atchFileId, filePath, param);
				if ( StringUtils.hasText(atchFileId) ) param.put("atchFileId", atchFileId);
			}
			else {
				String msg = "";
				if (FileMngUtil.RESULT_CD_OVERSIZE.equals(fileFlag)) msg = "첨부파일은 50MB이하로 업로드 하실 수 있습니다.";
				if (FileMngUtil.RESULT_CD_EXTDENIED.equals(fileFlag)) msg = "첨부파일은 이미지(JPG, BMP, GIF, PNG), 문서파일(DOC, DOCX, HWP, PDF, XLS, XLSX, PPT, PPTX) 만 업로드 하실 수 있습니다.";
				ModelMap model = paramCtx.getModel();
				model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
				model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
				return false;
			}
		}
		return true;
 	}

	/**
	 * 회원찾기 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void memberPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		super.list(paramCtx);
	}


	/**
	 * 회원찾기 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void snsTrmnat(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.deleteDAO("memberDAO.deleteSimpleLogin", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}


	/**
	 * 회원 인증 팝업(이메일/SMS)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		if (StringUtils.hasText(param.getString("mode"))) crtfcSndng(paramCtx);
	}
	
	/**
	 * 회원 인증 팝업(이메일)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcEmailPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		if (StringUtils.hasText(param.getString("mode"))) crtfcEmailSndng(paramCtx);
	}


	/**
	 * 14세 미만 회원 인증 부모 팝업(SMS)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void parntsCrtfcPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		if (StringUtils.hasText(param.getString("mode"))) crtfcSndng(paramCtx);
	}

	/**
	 * 회원 인증 발송
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcSndng(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		String authSe = param.getString("authSe");
		String val = param.getString("val");
		if (!StringUtils.hasText(val)) val = param.getString("email");
		if (StringUtils.hasText(param.getString("authSeGubun"))) authSe = "01"; // 회원가입시

		if ("01".equals(authSe)) { // 이메일

			if ("FU".equals(param.getString("mode"))) {
				param.put("userSn", user.getUserIdx());
				param.put("userNm", user.getUserNm());
				if ("02".equals(param.getString("authSeVal")) || "03".equals(param.getString("authSeVal"))) {
					param.put("authSe", "03");
				}
				else {
					param.put("authSe", "01");
				}
				authSeChange(paramCtx);
			}
			String siteNm = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "콘텐츠코리아랩" : "EDUKOCCA";
			StringBuffer contSb = new StringBuffer();
			contSb.append("<h2 style='font-size:30px;font-weight:600'>본인확인을 위한 <span style='color:#eb1c24'>이메일 인증</span></h2>");
			contSb.append("<p style='font-size:14px;padding-top:10px'>안녕하세요. <strong>"+param.getString("userNm")+"</strong>님!</p><p></p>");
			contSb.append("<p style='line-height:24px;font-size:14px;'>사이트의 서비스를 이용하기 위해서는 본인확인이 필요합니다. <br/>");
			contSb.append("<strong>"+val+"</strong> 주소를 인증하시려면 아래의 <strong>“이메일 승인”</strong> 버튼을 클릭해 주시기 바랍니다.</p>");
			contSb.append("<div style='text-align:center;text-align:center;'>");
			contSb.append("<a href='"+Globals.HOST_URL+"/"+param.getString("siteName")+"/userMember/crtfcEmail.do?userSn="+Base64.base64Encode(param.getString("userSn"))+"&authEmailAt="+Base64.base64Encode("Y")+"&email="+Base64.base64Encode(val)+"' style='display:inline-block;font-weight:600;padding:15px 50px;background:#eb1c24;color:#fff;text-decoration:none;' target='_blank' title='이메일 승인(새창열림)'>이메일 승인</a>");
			contSb.append("</div>");

			param.put("title", "["+siteNm+"] 본인확인을 위한 인증메일");
			param.put("name", siteNm);
			param.put("content", contSb.toString());
			param.put("email", val);

			emsService.sndngEmail(param);
		}
		else { // SMS
			String siteNm = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "콘텐츠코리아랩" : "EDUKOCCA";
			String authNum = RandomStringUtils.random(6, "1234567890"); // 인증번호 난수로 변경
			String tranMsg = "["+siteNm+"] 인증번호는 ["+authNum+"] 입니다.";
			param.put("phone", val);
			param.put("callback", SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "02-2161-0000" : "02-6310-0770");
//			param.put("callback", "02-2161-0000");
			param.put("msg", tranMsg);
			emsService.sndngSms(param);

			session.setAttribute("authNum", authNum);
			model.addAttribute("authNum", authNum);
		}

		if ("i".equals(param.getString("mode"))) model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS); // 재발송시
	}
	
	/**
	 * 회원 이메일 인증 발송
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcEmailSndng(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		
		String val = param.getString("val");
		if (!StringUtils.hasText(val)) val = param.getString("email");
		
		if ("FU".equals(param.getString("mode"))) {
			param.put("userSn", user.getUserIdx());
			param.put("userNm", user.getUserNm());
			if ("02".equals(param.getString("authSeVal")) || "03".equals(param.getString("authSeVal"))) {
				param.put("authSe", "03");
			}
			else {
				param.put("authSe", "01");
			}
			authSeChange(paramCtx);
		}

		String siteNm = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "콘텐츠코리아랩" : "한국콘텐츠아카데미";
		StringBuffer contSb = new StringBuffer();
		String authNum = RandomStringUtils.random(6, "1234567890"); // 인증번호 난수로 변경
		contSb.append("<h2 style='font-size:30px;font-weight:600'>본인확인을 위한 <span style='color:#eb1c24'>이메일 인증</span></h2>");
		contSb.append("<p style='line-height:24px;font-size:14px;'>사이트의 서비스를 이용하기 위해서는 본인확인이 필요합니다. <br/>");
		contSb.append("<strong>"+val+"</strong> 주소의 인증번호는 <strong>["+authNum+"]</strong> 입니다.</p>");

		param.put("title", "["+siteNm+"] 본인확인을 위한 인증메일");
		param.put("name", siteNm);
		param.put("content", contSb.toString());
		param.put("email", val);
		
		emsService.sndngEmail(param);
		
		session.setAttribute("authNum", authNum);
		model.addAttribute("authNum", authNum);

		if ("i".equals(param.getString("mode"))) model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS); // 재발송시
	}

	/**
	 * 회원 SMS 번호인증
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcSms(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		super.initCmmnParam(param);

		String flag = ModelAndViewResolver.SUCCESS;
		String msg = "인증완료되었습니다.";

		if (param.getString("authNum").equals(session.getAttribute("authNum"))) {
			String mode = param.getString("mode");
			session.removeAttribute("authNum");
			if ("PE".equals(mode)) { // 로그인 오류 안내에서 호출
				pwdUnlocking(paramCtx);
				msg = "인증완료되었습니다. 로그인페이지로 이동합니다.";
			}
			else if ("CE".equals(mode)) { // 이메일 인증 오류 안내에서 호출
				param.put("userSn", session.getAttribute("userSn"));
				param.put("authSe", "02");
				authSeChange(paramCtx);
				msg = "인증완료되었습니다. 로그인페이지로 이동합니다.";
				session.removeAttribute("userSn");
			}
			else if ("FU".equals(mode)) { // 회원수정페이지에서 호출
				if ("01".equals(param.getString("authSeVal"))) {
					param.put("authSe", "03");
				}
				else {
					param.put("authSe", "02");
				}
				authSeChange(paramCtx);
				sqlDao.updateDAO("memberDAO.updateUserMemberMbtlnum", param);
			}
		}
		else {
			flag = ModelAndViewResolver.ERROR;
			msg = "인증실패되었습니다. 인증번호를 확인해주세요.";
		}

		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, flag);
	}
	
	/**
	 * 회원 이메일 인증 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcEmailChk(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		String flag = ModelAndViewResolver.SUCCESS;
		String msg = "인증완료되었습니다.";

		if (param.getString("authNum").equals(session.getAttribute("authNum"))) {
			String mode = param.getString("mode");
			session.removeAttribute("authNum");
		}
		else {
			flag = ModelAndViewResolver.ERROR;
			msg = "인증실패되었습니다. 인증번호를 확인해주세요.";
		}

		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, flag);
	}

	/**
	 * 로그인 이메일 인증 오류 안내
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcEmailError(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		model.addAttribute("userSn", session.getAttribute("userSn"));
		model.addAttribute("email", session.getAttribute("email"));
		model.addAttribute("mbtlnum", session.getAttribute("mbtlnum"));
	}

	/**
	 * 로그인 인증 오류 안내
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcError(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		model.addAttribute("userId", session.getAttribute("username"));
		model.addAttribute("userSn", session.getAttribute("userSn"));
		model.addAttribute("email", session.getAttribute("email"));
		model.addAttribute("mbtlnum", session.getAttribute("mbtlnum"));
	}

	/**
	 * 이메일 인증
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcEmail(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (StringUtils.hasText(param.getString("authEmailAt"))) param.put("authEmailAt", Base64.base64Decode(param.getString("authEmailAt")));
		if (StringUtils.hasText(param.getString("userSn"))) param.put("userSn", Base64.base64Decode(param.getString("userSn")));
		if (StringUtils.hasText(param.getString("email"))) param.put("email", Base64.base64Decode(param.getString("email")));
		if (StringUtils.hasText(param.getString("userId"))) {
			param.put("userId", Base64.base64Decode(param.getString("userId")));
			sqlDao.deleteDAO("memberDAO.loginHistoryDelete", param);
		}

		int cnt = sqlDao.selectCount("memberDAO.checkDupEmailAuth", param);
		if (cnt > 0 && StringUtils.hasText(param.getString("userSn"))) {
			sqlDao.updateDAO("memberDAO.authEmailAtChange", param);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "인증에 성공하였습니다.");
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+param.getString("siteName")+"/main/main.do");
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		}
		else {
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "회원가입완료 후 인증해 주시기 바랍니다.");
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+param.getString("siteName")+"/main/main.do");
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
			model.addAttribute(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
		}




	}

	/**
	 * 개인정보처리방침 재동의 안내
	 * @param paramCtx
	 * @throws Exception
	 */
	public void reAgre(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		
		model.addAttribute("user", user);
		System.out.println(model);
	}

	/**
	 * 개인정보처리방침 동의 및 정보수신여부
	 * @param paramCtx
	 * @throws Exception
	 */
	public void reAgreRequest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.updateDAO("memberDAO.reAgreRequest", param);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 로그인 오류 안내(비밀번호 5회 틀릴시)
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdError(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		param.put("userId", session.getAttribute("userId"));
		session.removeAttribute("userId");
		ZValue result = sqlDao.selectDAO("memberDAO.selectUserMembers", param);
		String siteNm = SiteMngService.CKL_SITE_NAME.equals(param.getString("siteName")) ? "콘텐츠코리아랩" : "한국콘텐츠아카데미";

		if ("01".equals(result.getString("authSe"))) { // 이메일인증 사용자 메일보내기
			StringBuffer contSb = new StringBuffer();
			contSb.append("<h2 style='font-size:30px;font-weight:600'>아이디 잠김상태 해제를 위한 <span style='color:#eb1c24'>이메일 인증</span></h2>");
			contSb.append("<p style='font-size:14px;padding-top:10px'>안녕하세요. <strong>"+result.getString("userNm")+"</strong>님!</p><p></p>");
			contSb.append("<p style='line-height:24px;font-size:14px;'>아이디 (<strong>"+result.getString("userId")+"</strong>)에 대해서 비밀번호 5회 오류로 인하여 <strong>“아이디 잠김상태”</strong>로 전환되었습니다.<br/>");
			contSb.append("잠김상태를 해제 하시려면 아래의 <strong>“이메일 승인”</strong> 버튼을 클릭해 주시기 바랍니다.</p>");
			contSb.append("<div style='text-align:center;text-align:center;'>");
			contSb.append("<a href='"+Globals.HOST_URL+"/"+param.getString("siteName")+"/userMember/crtfcEmail.do?userSn="+Base64.base64Encode(result.getString("userSn"))+"&userId="+Base64.base64Encode(result.getString("userId"))+"&authEmailAt="+Base64.base64Encode("Y")+"&email="+Base64.base64Encode(result.getString("email"))+"' style='display:inline-block;font-weight:600;padding:15px 50px;background:#eb1c24;color:#fff;text-decoration:none;' target='_blank' title='이메일 승인(새창열림)'>이메일 승인</a>");
			contSb.append("</div>");

			param.put("title", "["+siteNm+"] 아이디 잠김상태 해제를 위한 인증메일");
			param.put("name", siteNm);
			param.put("content", contSb.toString());
			param.put("email", result.getString("email"));
			emsService.sndngEmail(param);
		}
		//System.out.println("++++++++++++++++++++++pwdError param"+param+"++++++++++++++++++++");
		model.addAttribute("result", result);
	}

	/**
	 * 비밀번호 잠금해제
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdUnlocking(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();

		loginHistoryAuthenticationFailureHandler.delLoginHistory(paramCtx.getRequest()); // 로그인 히스토리 삭제

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 회원인증 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void authSeChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.updateDAO("memberDAO.authSeChange", param);

		if (!"FU".equals(param.getString("mode"))) model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 회원통합 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listOldMember(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		param.put("userNm", user.getUserNm());
		param.put("email", user.getEmail());
		param.put("status", user.getStatus());

		List<ZValue> listOldMember = sqlDao.listDAO("memberDAO.listOldMember", param);
		String rm = "";
		for (ZValue zvl : listOldMember) {
			rm += zvl.getString("siteSe")+":"+zvl.getString("userId")+"|";
		}

		model.addAttribute("rm", rm);
		model.addAttribute("user", user);
		model.addAttribute("listOldMember", listOldMember);
	}

	/**
	 * 회원통합 상세
	 * @param paramCtx
	 * @throws Exception
	 */
	public void oldMember(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String userData = param.getString("userData");
		String[] data = userData.split("[|]");
		model.addAttribute("userData", userData);
		model.addAttribute("data", data);
	}

	/**
	 * 회원통합 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insertOldMember(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		String siteSe = param.getString("siteSe");
		String password = param.getString("password");
		if (StringUtils.hasText(password)) {
			param.put("pwd", password);
			param.put("password", HashCipher.createHash(password));
		}
		param.put("mberSe", "01");
		if ("".equals(param.getString("mbtlnum",""))) param.put("authSe", "01");
		else param.put("authSe", "03");
		param.put("pwdChangeAt", "Y");
		param.put("authEmailAt", "Y");
		param.put("userSttus", "U");
		param.put("agreAt", "Y");


		ZValue val = new ZValue();
		val.put("email", user.getEmail());

		if ("kocca".equals(siteSe)) {
			param.put("userSn", param.getString("userSn"));
			sqlDao.updateDAO("memberDAO.updateUserMember", param);
			val.put("userSn", param.getString("userSn"));
		}
		else {
			Object pkValue = sqlDao.insertDAO("memberDAO.insertUserMember", param);
			val.put("userSn", pkValue);

			insertLmsMember(paramCtx); // LMS 회원등록
		}

		sqlDao.updateDAO("memberDAO.updateUseAtUser", val);
		sqlDao.updateDAO("memberDAO.updateOldAcademy", val);
		sqlDao.updateDAO("memberDAO.updateOldDream", val);



		MVUtils.goUrl("/"+param.getString("siteName")+"/member/forLogin.do?menuNo="+param.getString("menuNo"), "정상적으로 등록되었습니다. 로그인 페이지로 이동합니다.", model);
	}

	/**
	 * 회원탈퇴 폼
	 * @param paramCtx
	 * @throws Exception
	 */
	public void secsn(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();

		model.addAttribute("user", user);
	}

	/**
	 * 회원탈퇴
	 * @param paramCtx
	 * @throws Exception
	 */
	public void secsnRequest(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (SiteMngService.TESTBED_SITE_NAME.equals(param.getString("siteName"))){  //rsg20170922
			param.put("concertUseAt", "N");
			sqlDao.deleteDAO("memberDAO.updateUseAtConcertUser", param);
		}
		
		sqlDao.deleteDAO("memberDAO.deleteSimpleLogin2", param);
		sqlDao.deleteDAO("memberDAO.deleteUserMember", param);
		sqlDao.insertDAO("memberDAO.insertSecsn", param);
		lmsSqlDao.updateDAO("lmsMemberDAO.updateSecsn", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * 14세 이상 회원으로 전환
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateParntsAgreChange(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userSn",user.getUserIdx());
		sqlDao.updateDAO("memberDAO.updateParntsAgreChange", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * SMS발송 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void smsSndngPopup(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		super.setCountQueryId("progrmApplcntDAO.listCnt");// 소스코드 수정 필요함
		super.setListQueryId("progrmApplcntDAO.list");
		super.list(paramCtx);

		@SuppressWarnings("unchecked")
		List<ZValue> resultList = (List<ZValue>) model.get("resultList");
		List<String> mbtlnumList = new ArrayList<String>();

		for (ZValue val : resultList) {
			mbtlnumList.add(val.getString("mbtlnum"));
		}
		session.setAttribute("mbtlnumList", mbtlnumList);

	}

	/**
	 * SMS발송
	 * @param paramCtx
	 * @throws Exception
	 */
	public void smsSndng(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		@SuppressWarnings("unchecked")
		List<String> mbtlnumList = (List<String>) session.getAttribute("mbtlnumList");

		for (String val : mbtlnumList) {
			if (StringUtils.hasText(val)) {
				param.put("phone", val);
				param.put("callback", param.getString("telNo"));
				param.put("msg", param.getString("msg"));
				//emsService.sndngSms(param);
			}
		}
		session.removeAttribute("mbtlnumList");
		MVUtils.winClose("발송되었습니다.", model);
	}
	
	/**
	 * 회원일괄등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forBatchExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> excelList = new ArrayList<ZValue>();
		
		excelList = excelChkeckList(paramCtx);	
		
		model.addAttribute("excelList", excelList);
	}
	
	/**
	 * 엑셀파일 체크
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> excelChkeckList(ParameterContext<ZValue> paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		Map<String, MultipartFile> files = paramCtx.getFiles();
		String fileExt = "";
		List<ZValue> excelList = new ArrayList<ZValue>();
		
		if(files != null){
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			MultipartFile file;
			
	    	while(itr.hasNext()){
	    	    Entry<String, MultipartFile> entry = itr.next();
	    	    file = entry.getValue();
	
	    	    String orginFileName = file.getOriginalFilename();
	
	    	    if("".equals(orginFileName)){
	    	    	continue;
	    	    }
	
	    	    int index = orginFileName.lastIndexOf(".");
	    	    fileExt = orginFileName.substring(index + 1).toLowerCase();
	    	}		
	    	
	    	boolean flag = false;
	    	if(fileExt.equals("xlsx")){
	    		flag = uploadFile(paramCtx);
	    		
		    	if(flag){
					FileVO vo = new FileVO();
					vo.setAtchFileId(param.getString("atchFileId"));
					
					List<FileVO> fileList = fnwFileMngService.selectFileInfs(vo);
					
					if(fileList != null){
						try{
							String xFilePath = fileList.get(0).getFileStreCours().replace("\\",  "/") + "/" + fileList.get(0).getStreFileNm();
							
				            FileInputStream xFile = new FileInputStream(xFilePath);
				            XSSFWorkbook workbook = new XSSFWorkbook(xFile);
				 
				            int rowindex = 0;
				            int columnindex = 0;
				            
				            //시트 수 (첫번째에만 존재하므로 0을 준다)
				            //만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
				            XSSFSheet sheet = workbook.getSheetAt(0);
				            
				            int rows = sheet.getPhysicalNumberOfRows(); //행의 수
				            String xTitle = "이름|생년월일|성별|아이디|비밀번호|이메일|휴대폰|인재캠퍼스정보수신여부|콘텐츠문화광장정보수신여부|직업"; //sample 양식
				            boolean isErrSample = false; //sample 양식 오류 체크 변수
				            String rMsg = ""; //결과 메시지
				            int userSn = 0; //조회된 유저번호
				            boolean isChkErr = false; //데이터 체크 오류 변수
				            String dupID = ""; //아이디 중복 체크 변수
				            String strID = ""; // 아이디
				            String patternId = "^[a-z0-9]{6,30}$"; // id패턴
				            String patternPw = "^.*(?=.{8,16})(?=.*[0-9!@#$%^&*()_+=<>?])(?=.*[a-zA-Z]).*$"; // pw패턴
				            
				            model.addAttribute("isCheck", "Y");
				            
				            for(rowindex=0;rowindex<rows;rowindex++){
				                //행을읽는다
				            	XSSFRow row = sheet.getRow(rowindex);
				            	ZValue xVO = new ZValue();
				            	ZValue uVO = new ZValue();
				            	ZValue tVO = new ZValue();
				            	
				                if(row != null){	
				                	rMsg = "";
				                	strID = "";
				                	
				                    for(columnindex=0; columnindex<=11; columnindex++){
				                        //셀값을 읽는다
				                    	XSSFCell cell = row.getCell(columnindex);
				                        String value = "";
				                        //셀이 빈값일경우를 위한 널체크
				                        if(cell == null){
				                            continue;
				                        }else{
				                        	switch(cell.getCellType()){ 
				                        		case XSSFCell.CELL_TYPE_FORMULA: 
				                        			value=cell.getCellFormula(); 
				                        			break; 
				                        		case XSSFCell.CELL_TYPE_NUMERIC: 
				                        			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				                        			value = cell.getStringCellValue();
				                        			break; 
				                        		case XSSFCell.CELL_TYPE_STRING: 
				                        			value=cell.getStringCellValue()+""; 
				                        			break; 
				                        	    case XSSFCell.CELL_TYPE_BLANK:
				                        	        value = "";
				                        	        break;				                        			
				                        		case XSSFCell.CELL_TYPE_ERROR: 
				                        			value=cell.getErrorCellValue()+""; 
				                        			break; 
				                        	}
				                        }
				                        
				                        if(rowindex == 0){
				                        	// 엑셀 양식 체크
				                        	// 양식 타이틀 변경(성별, 정보수신여부, 직업)
				                        	switch(columnindex){
				                        		case 2:
				                        			if(value.replace(" ",  "").indexOf("성별") > -1){
				                        				value = "성별";
				                        			}
				                        			break;
				                        		case 7:
				                        		case 8:
				                        			if(value.replace(" ",  "").indexOf("인재캠퍼스정보수신여부") > -1){
				                        				value = "인재캠퍼스정보수신여부";
				                        			}
				                        			break;		
				                        		case 9:
				                        		case 10:
				                        			if(value.replace(" ",  "").indexOf("콘텐츠문화광장정보수신여부") > -1){
				                        				value = "콘텐츠문화광장정보수신여부";
				                        			}
				                        			break;		
				                        		case 11:
				                        			if(value.replace(" ",  "").indexOf("직업") > -1){
				                        				value = "직업";
				                        			}
				                        			break;					                        			
				                        	}
				                        	
				                        	if(xTitle.indexOf(value.trim()) == -1){
				                        		isErrSample = true;
				                        		model.addAttribute("isErrSample", isErrSample);
				                        		break;
				                        	}
				                        }else if(rowindex > 1){
				                        	// 데이터 체크
				                            switch(columnindex){
				                            	case 0:
				                            		if("".equals(value)){
				                            			isChkErr = true;
				                            			rMsg = "이름 미입력";
				                            		}else{
				                            			rMsg = "OK";
				                            		}
				                            		
				                            		xVO.put("nm", value);
				                            		break;
					                            case 1:
					                            	System.out.println(" validationDate : " + value + " // " + validationDate(value));
					                            	
					                            	if(!validationDate(value)){
					                            		if("OK".equals(rMsg)){
					                            			isChkErr = true;
					                            			rMsg = "생년월일 날짜 형식 오류";
					                            		}
					                            	}
					                            	
					                            	xVO.put("bd", value);
					                                break;
				                                case 2:	
					                            	if(!"M".equals(value.toUpperCase()) && !"W".equals(value.toUpperCase())){
					                            		if("OK".equals(rMsg)){
					                            			isChkErr = true;
					                            			rMsg = "성별 코드 오류";
					                            		}
					                            	}
					                            	
					                            	xVO.put("sx", value.toUpperCase());
					                                break;
				                                case 3:
					                            	if("".equals(value)){
				                            			if("OK".equals(rMsg)){
				                            				isChkErr = true;
				                            				rMsg = "ID 미입력";
				                            			}
				                            		}else{
				                            			if(dupID.indexOf(value) != -1){
					                            			if("OK".equals(rMsg)){
					                            				isChkErr = true;
					                            				rMsg = "ID 중복";
					                            			}
				                            			}else{
				                            				uVO.put("userId", value);
				                            				int userCnt = sqlDao.selectCount("memberDAO.checkDupID", uVO);
				                         
				                            				if(userCnt > 0){
						                            			if("OK".equals(rMsg)){
						                            				isChkErr = true;
						                            				rMsg = "가입된 ID";
						                            			}
				                            				}else{
				                            					if(!Pattern.matches(patternId, value)){
							                            			if("OK".equals(rMsg)){
							                            				isChkErr = true;
							                            				rMsg = "ID 형식 오류";
							                            			}
				                            					}			                            					
				                            				}
				                            			}
				                            			
				                            			if("".equals(dupID)){
				                            				dupID = value;
				                            			}else{
				                            				dupID += "|" + value;
				                            			}
				                            		}
					                            	
					                            	strID = value;
					                            	
					                            	xVO.put("id", value);
					                                break;
					                            case 4:
					                            	if("".equals(value)){
					                            		value = strID + "!";
				                            		}
					                            	
	                            					if(!Pattern.matches(patternPw, value)){
				                            			if("OK".equals(rMsg)){
				                            				isChkErr = true;
				                            				rMsg = "비밀번호 형식 오류";
				                            			}
	                            					}
					                            	
					                            	xVO.put("nm1", value);
					                                break;
				                            }	
				                            
				                            xVO.put("msg", rMsg);
				                        }
				                    }
				                    
				                    if(rowindex > 1){
				                    	//preChkT = chkT;
				                    	excelList.add(xVO);
				                    }
				 
				                }
				                
				                if(isErrSample) break;
				            }		
				        }catch(Exception e) {
				            e.printStackTrace();
				        }
					}
		    	}	    		
	    	}
		}
		
		return excelList;
	}	
	
	/**
	 * 엑셀파일 생년월일 날짜 유효성 체크
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public boolean validationDate(String checkDate){
		try{
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

			dateFormat.setLenient(false);
			dateFormat.parse(checkDate);
			
			return true;
       }catch(ParseException  e){
         return false;
       }
	}
	
	@Override
	public void downloadExcel(ParameterContext<ZValue> paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		String[] titles = {"구분", "성명", "아이디", "인증방식", "가입일시", "휴면전환예정일"};
		model.addAttribute("titles", titles);
		List<ZValue> excelList = sqlDao.listDAO("memberDAO.listExcel", paramCtx.getParam());

    	Date today = new Date();
    	SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    	String day = date.format(today);
		ExcelGenerateVO vo = new ExcelGenerateVO("프로그램 목록_"+day, titles, excelList);
		model.addAttribute("excel", vo);
	}
}
