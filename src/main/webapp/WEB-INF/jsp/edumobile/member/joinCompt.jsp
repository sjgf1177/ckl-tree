<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.com.cmm.service.Globals"%>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@ page import="kr.co.unp.banner.vo.Banner"%>
<%@ page import="kr.co.unp.banner.service.BannerService"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<c:set var="siteNm" value="${paramVO.service}"/>
<%
	String domain = request.getServerName();
	session.setAttribute("ssoDomain2", domain);
	
	String requestUri = request.getRequestURL().toString();
	String host = request.getRemoteHost();

	String menuNo = request.getParameter("menuNo");
	String siteNm = (String)pageContext.getAttribute("siteNm");  

	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.EDUMOBILE_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);
	org.springframework.context.ApplicationContext context =
			org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);
%>
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<c:set var="pathData0" value="${pathData[0]}" />
<script type="text/javascript">
//<![CDATA[
      var title = document.title;
      document.title = "가입완료 < " + title;
//]]>
</script>

<div class="memberStep1">

	<div class="signup_step_bar">
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP1</span>
				인증방식선택
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP2</span>
				이용약관동의
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap">
			<p class="step_box">
				<span class="step_title">STEP3</span>
				입력항목작성
			</p>
		</div>
		<div class="step_line_wrap">
			<div class="step_right_arrow">
			</div>
		</div>
		<div class="step_wrap active">
			<p class="step_box">
				<span class="step_title">STEP4</span>
				가입완료
			</p>
		</div>
	</div>

	<div class="signup_complete_con">
		<p class="signup_complete_title">
			한국콘텐츠아카데미 <span>회원가입 신청</span>이<br>
			완료되었습니다.
		</p>
		<hr class="signup_complete_line">
		<p class="signup_complete_text">
			<c:out value="${user.userNm}"/> 회원님, 가입을 축하 드립니다.<br>
			회원님의  입력하신 로그인 정보는
			<span>
				<c:choose>
					<c:when test="${user.mberSe eq '01'}"><c:out value="${user.userId}"/></c:when>
					<c:otherwise>SNS(<c:out value="${user.authAt eq '03' ? '네이버' : '페이스북'}"/> 인증)</c:otherwise>
				</c:choose>
			</span>
			입니다.
		</p>
		<p class="signup_complete_text warning">
			인증수단은 “ <c:out value="${user.authSe eq '01' ? '이메일' : '휴대폰'}"/> ” 인증 입니다. 인증받은 정보가<br>
			변경되는 경우 다시 “재인증” 받으셔야 합니다.
		</p>
	</div>
	<div class="board_util_btn_con center">
		<c:choose>
			<c:when test="${fn:indexOf(pathData0 , '콘텐츠문화광장') != -1 }">
				<c:set var="homeUrl" value="/edumobile/main/main.do?siteName=testbed&menuNo=600125"/>
				<c:set var="loginUrl" value="/edumobile/member/forLogin.do?menuNo=600130"/>
			</c:when>
			<c:otherwise>
				<c:set var="homeUrl" value="/edumobile/main/main.do"/>
				<c:set var="loginUrl" value="/edumobile/member/forLogin.do?menuNo=600141"/>
			</c:otherwise>
		</c:choose>
		<a href="${homeUrl }" class="btn_style_0 blue radius center">
			홈으로
		</a>
		<a href="${loginUrl }" class="btn_style_0 full radius center">
			로그인
		</a>
	</div>

</div>
