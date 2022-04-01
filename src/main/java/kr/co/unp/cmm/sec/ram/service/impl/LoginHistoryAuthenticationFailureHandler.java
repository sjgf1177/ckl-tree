package kr.co.unp.cmm.sec.ram.service.impl;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.unp.cmm.dataaccess.ISqlDAO;
import kr.co.unp.siteMng.service.SiteMngService;
import kr.co.unp.util.ZValue;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class LoginHistoryAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler implements Serializable {

	private static final long serialVersionUID = 6022675258353128287L;
	private ISqlDAO<EgovMap> sqlDao;
	public static final String LOGIN_TRY_INFO_KEY = "LOGIN_TRY_INFO";

	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {

        saveFailureHistory(request, exception.getAuthentication().getPrincipal().toString());

		super.onAuthenticationFailure(request, response, exception);
	}

	public void saveFailureHistory(HttpServletRequest request, String userId) {
		ZValue params = new ZValue();
    	try {
			EgovMap param = new EgovMap();
			param.put("loginYn", "N");
			param.put("userIp", request.getRemoteAddr());
			param.put("userId", userId);
			param.put("siteNm", request.getAttribute("siteName"));
			sqlDao.updateDAO("loginHistoryDAO.insert", param);
		} catch (Exception e) {
			e.printStackTrace();
		}

		EgovMap lastFailedLoginInfo = getLastFailedLoginInfo(request,params);
        request.getSession().setAttribute(LOGIN_TRY_INFO_KEY, lastFailedLoginInfo);
	}
	
	public void saveSuccessHistory(HttpServletRequest request, String userId) {//rsg20171130
		ZValue params = new ZValue();
		try {
			EgovMap param = new EgovMap();
			param.put("loginYn", "Y");
			param.put("userIp", request.getRemoteAddr());
			param.put("userId", userId);
			param.put("siteNm", request.getAttribute("siteName"));
			sqlDao.updateDAO("loginHistoryDAO.insert", param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		EgovMap lastFailedLoginInfo = getLastFailedLoginInfo(request,params);
		request.getSession().setAttribute(LOGIN_TRY_INFO_KEY, lastFailedLoginInfo);
	}

	private EgovMap getLastFailedLoginInfo(HttpServletRequest request, ZValue params){
    	try {
    		if ("".equals(params.getString("username",""))) params.put("username", request.getParameter("username"));
    		if ("".equals(params.getString("siteName",""))) params.put("siteName", request.getParameter("siteName"));
			EgovMap param = new EgovMap();
			param.put("userIp", request.getRemoteAddr());
			param.put("firstIndex", 0);
			param.put("recordCountPerPage", 5);
			param.put("userId", params.getString("username"));
			param.put("siteNm", params.getString("siteName"));
	    	List<EgovMap> histories = sqlDao.listDAO("loginHistoryDAO.list", param);
	    	if( CollectionUtils.isNotEmpty(histories) ) {
		    	List<EgovMap> failedHistories = new ArrayList<EgovMap>();
		    	for(EgovMap history : histories){
		    		if( "Y".equals((String)history.get("loginYn")) ) {
		    			break;
		    		}
		    		else {
		    			failedHistories.add(history);
		    		}
		    	}

		    	EgovMap lastLoginFailed = histories.get(0);
		    	lastLoginFailed.put("loginFailedCount", failedHistories.size());
		    	return lastLoginFailed;
	    	}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("db error");
		}
    	return null;
	}

	public boolean checkLoginHistory(HttpServletRequest request, ZValue param){
		//HttpSession session = request.getSession();
		//EgovMap lastLoginFailed = (EgovMap)session.getAttribute(LoginHistoryAuthenticationFailureHandler.LOGIN_TRY_INFO_KEY);
		EgovMap lastLoginFailed = getLastFailedLoginInfo(request,param);
		/*if( lastLoginFailed == null ) {
			lastLoginFailed = getLastFailedLoginInfo(request);
            session.setAttribute(LOGIN_TRY_INFO_KEY, lastLoginFailed);
		}*/
		if( lastLoginFailed != null && (Integer)lastLoginFailed.get("loginFailedCount") >= 5 ) {
			if (SiteMngService.BOS_SITE_NAME.equals(param.getString("siteName"))) {

				String loginTryAt = (String)lastLoginFailed.get("loginTryAt");

				if (!"Y".equals(loginTryAt)) return false; // 관리자는 비밀번호 5회 틀린후 30분이후 로그인 가능

				/*Date loginTryDate = (Date)lastLoginFailed.get("loginTryDate");
				Date date1 = new Date();
				Date date2 = DateUtils.addMinutes(date1, -30);
				if (loginTryDate.compareTo(date2) >= 0) {
					return false;
				}*/
			}
			else {
				return false;
			}
		}
		return true;
	}

	public void delLoginHistory(HttpServletRequest request) {
    	try {
			EgovMap param = new EgovMap();
			param.put("userId", request.getParameter("userId"));
			param.put("gubun", request.getParameter("gubun"));
			param.put("siteNm", request.getParameter("siteNm"));
			sqlDao.deleteDAO("loginHistoryDAO.delete", param);
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
