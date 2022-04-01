package kr.co.unp.cmm.sec.ram.service.impl;

import java.io.IOException;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.member.vo.UsersVO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.StrUtils;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class SessionSavedRequestAwareAuthenticationHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private ISqlDAO<EgovMap> sqlDao;

	@Resource(name = "SqlDAO")
	protected ISqlDAO<UsersVO> uSqlDao;

	public static final String TARGET_URL = "_targetUrl_";

	private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {

    	SavedRequest savedRequest = requestCache.getRequest(request, response);

    	String cklDomain = EgovProperties.getProperty("Globals.ckl.domain");

 		String protocol = "http";
		String realMode = EgovProperties.getProperty("Globals.realMode");

 		if ("Y".equals(realMode)) protocol = "https://";
 		else protocol = "http://";
 		cklDomain = protocol + cklDomain;

		try {
			HttpSession session = request.getSession();
			UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
			String targetUrl = (String)session.getAttribute(TARGET_URL);
			String targetUrl2 = savedRequest != null ?savedRequest.getRedirectUrl() : null;

			if (targetUrl2 != null) targetUrl = targetUrl2;
			
			if (request.getParameter("redirecturl") != null){
				targetUrl = request.getParameter("redirecturl");
			}

			String siteNm = this.getDefaultTargetUrl().split("/")[1];
			String menuNo = "200055"; //ckl
			if (SiteMngService.EDU_SITE_NAME.equals(siteNm)) menuNo = "500077";
			else if (SiteMngService.EDUMOBILE_SITE_NAME.equals(siteNm)) menuNo = "600130";
			//System.out.println("+++++++++++++siteNm"+siteNm+"+++++++++++++++++");

			Date nowDt = new Date();
			Date agreChkDt = user.getOtherDt();
			String agreAt = user.getAgreAt();
			Date pwdChangeDt = user.getPwdChangeDt();

			if (!StringUtils.hasText(agreAt) || "N".equals(agreAt)) { //  재동의 || 동의여부 없거나 'N'(구회원)
				targetUrl = "/"+siteNm+"/userMember/reAgre.do?menuNo="+menuNo+"&mode=i";
				if (SiteMngService.CKLMOBILE_SITE_NAME.equals(siteNm)) targetUrl = cklDomain+"/ckl/userMember/reAgre.do?menuNo="+menuNo+"&mode=i&mobileTp=Y";
			}
			else if (agreChkDt != null && agreChkDt.before(nowDt)) { // 3년마다 개인정보처리방침
				targetUrl = "/"+siteNm+"/userMember/reAgre.do?menuNo="+menuNo;
				if (SiteMngService.CKLMOBILE_SITE_NAME.equals(siteNm)) targetUrl = cklDomain+"/ckl/userMember/reAgre.do?menuNo="+menuNo + "&mobileTp=Y";
			}

			//if ("01".equals(user.getMberSe())) { // 일반회원
			if ((pwdChangeDt != null && pwdChangeDt.before(nowDt)) || "N".equals(user.getPwdChangeAt())) { // 6개월마다 비밀번호 변경
				targetUrl = "/"+siteNm+"/userMember/pwdChange.do?menuNo="+menuNo+"&mode=i";
				if (SiteMngService.CKLMOBILE_SITE_NAME.equals(siteNm)) targetUrl = cklDomain+"/ckl/userMember/pwdChange.do?menuNo="+menuNo+"&mode=i&mobileTp=Y";
			}

			uSqlDao.updateDAO("memberDAO.lastLoginDe", user);

	    	if (StringUtils.hasText(targetUrl)) {
	    		//targetUrl = StrUtils.replace(targetUrl, "https", "http");
	    		targetUrl = StrUtils.replace(targetUrl, "&amp;amp;", "&");
	    		targetUrl = StrUtils.replace(targetUrl, "&amp;", "&");
	    		targetUrl = StrUtils.replace(targetUrl, ";amp;", "&");
	    		session.removeAttribute(targetUrl);
	    		getRedirectStrategy().sendRedirect(request, response, targetUrl);
	    	}
	    	else {
	    		super.onAuthenticationSuccess(request, response, authentication);
	    	}
		} catch (Exception e) {
			e.printStackTrace();
		}

    }

	public ISqlDAO<EgovMap> getSqlDao() {
		return sqlDao;
	}
	public void setSqlDao(ISqlDAO<EgovMap> sqlDao) {
		this.sqlDao = sqlDao;
	}

}
