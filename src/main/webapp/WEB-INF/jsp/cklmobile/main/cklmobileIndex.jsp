<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%-- <%@page import="kr.co.unp.main.service.impl.MainServiceImpl"%> --%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<%@page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@page import="kr.co.unp.banner.vo.Banner"%>
<%@page import="kr.co.unp.banner.service.BannerService"%>
<%@page import="egovframework.com.cmm.service.EgovProperties"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

    //메뉴설정 SiteMngService.CKLMOBILE_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.CKLMOBILE_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);

	String menuNo = request.getParameter("menuNo");
	if("".equals(menuNo)) throw new Exception("menuNo 값이 없습니다.!");

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
	String realTp = EgovProperties.getProperty("Globals.realMode");
	request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));

	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);

	String position = currentVo.getPosition();
	int depth01 = Integer.parseInt(position.substring(0,2)) -1;
	int depth02 = Integer.parseInt(position.substring(2,4)) -1;
	int depth03 = Integer.parseInt(position.substring(4,6)) -1;
	int depth04 = Integer.parseInt(position.substring(6,8)) -1;
	int depth05 = Integer.parseInt(position.substring(8,10)) -1;
	int depth06 = Integer.parseInt(position.substring(10,12)) -1;
	pageContext.setAttribute("depth01", depth01);
	pageContext.setAttribute("depth02", depth02);
	pageContext.setAttribute("depth03", depth03);
	pageContext.setAttribute("depth04", depth04);
	pageContext.setAttribute("depth05", depth05);
	pageContext.setAttribute("depth06", depth06);



	//인증 리다이렉트페이지
	int port = Globals.OS_TYPE.equals("WINDOWS") ? 80 : 80;
	String protocol = "http";
	if ("Y".equals(realTp)) protocol = "https";
	String _targetUrl = (String)session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
	if( "400029".equals(menuNo)) { //본인인증페이지
		if (StringUtils.hasText(_targetUrl)) {
			session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
		}
	}
	else {
		String _targetUrl_ = org.springframework.security.web.util.UrlUtils.buildFullRequestUrl(protocol, request.getServerName(), port, currentVo.getFullMenuLink(), null);
		_targetUrl_ = _targetUrl_.replaceAll(":80", "");
		session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, _targetUrl_);
	}

	String dataHref = "https://" + request.getServerName();
	if ( port != 80 ) {
		dataHref += ":" + port;
	}
%>
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="<%= Globals.OS_TYPE %>" />
<c:set var="list" value="${fn:contains(includePage, 'list')}" />
<c:set var="read" value="${fn:contains(includePage, 'read')}" />
<c:set var="reg" value="${fn:contains(includePage, 'reg')}" />
<c:set var="view" value="${fn:contains(includePage, 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
   <c:set var="title" value=""/>
<c:forEach var="x" begin="0" end="${fn:length(pathData)-1}">
	<c:choose>
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(목록) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(읽기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(쓰기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(수정) | ${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]} | ${title}"/></c:otherwise>
	</c:choose>
</c:forEach>

<c:set var="topCategories" value="${menuAll4['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="curD01" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll4[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll4[curD03menuKey]}" />



<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<c:set var="title" value="${title} 콘텐츠코리아랩" />
<title>${title}</title>

<jsp:include page="/WEB-INF/jsp/cklmobile/inc/cklmobileHead.jsp" flush="true" />

</head>
<body>
<ul class="skip">
	<li><a href="#content">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>
<div id="wrap">

	<!-- header -->
	<div id="header">
		<div class="heading">
			<a href="javascript:history.back();" class="back"><img src="/cklmobile/images/common/back.png" alt="이전페이지로 이동" /></a>
			<c:if test="${fn:length(curD02Categories)>0}">
				<c:set var="curD" value="${curD02Categories[depth02]}" />
				<c:set var="curD02" value="${curD02Categories[depth02]}" />
			</c:if>
			<h1>${curD.menuNm}</h1>
		</div>
		<div class="gnbOpenSet">
			<!-- 전체메뉴 열기 -->
			<div class="gnbOpen">
				<a href="#self"><img src="/edumobile/images/common/gnbOpen.png" alt="전체 메뉴 열기" /></a>
			</div>
			<!-- 전체메뉴 열기 -->
		</div>
	</div>
	<!-- //header -->

	<!-- gnb -->
	<div class="gnbSet">
		<div class="gnbLink">
			<a href="/cklmobile/main/main.do" class="gnbHome"><img src="/cklmobile/images/common/gnbHome.png" alt="홈페이지로 이동" /></a>
			<sec:authorize ifNotGranted="ROLE_USER">
				<a href="/cklmobile/member/forLogin.do?menuNo=400029" class="btn btn-sm btn-default">로그인</a>
			</sec:authorize>
			<sec:authorize ifAnyGranted="ROLE_USER">
				<a href="/cklmobile/member/logout.do" class="btn btn-sm btn-default">로그아웃</a>
			</sec:authorize>
		</div>
		<div class="gnb" id="gnb">
			<ul>
			<c:set var="topCategories" value="${menuAll4['menu_0']}" />
			<c:forEach var="x" begin="0" end="5">
				<li class="tms${x+1} ${topCategories[x].menuNo eq curD01.menuNo ? 'on' : ''}"><a href="javascript:void(0); return flase;" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll4[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">

					<ul>
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li ${d02Categories[y].menuNo eq curD02.menuNo ? 'class="on"' : ''}><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
						</c:forEach>
					</ul>
					</c:if>
				</li>
			</c:forEach>
			</ul>

			<div class="snsGoSet">
				<ul>
					<li><a href="https://www.facebook.com/ContentKoreaLab" target="_blank" title="콘텐츠코리아랩 페이스북 바로가기(새창열림)"><span class="snsLinkSet snsLink1"></span>
					페이스북</a></li>
					<li><a href="http://blog.naver.com/icp_ckl" target="_blank" title="콘텐츠코리아랩 네이버 바로가기(새창열림)"><span class="snsLinkSet snsLink2"></span>
					네이버</a></li>
					<li><a href="https://www.youtube.com/channel/UCfoovETPwMFH8dbW6NWMAnw" target="_blank" title="콘텐츠코리아랩 유튜브 바로가기(새창열림)"><span class="snsLinkSet snsLink3"></span>
					유튜브</a></li>
				</ul>
			</div>
			<a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">전체메뉴 닫기</span></a>
		</div>
	</div>
	<!-- //gnb -->


	<div class="nav">
		<div class="h">
			<c:if test="${fn:length(curD03Categories)>0}">
			<c:set var="curD" value="${curD03Categories[depth03]}" />

			<h1>${curD.menuNm}</h1><!-- 현재 타이틀  -->
			<button class="navOpen"><span class="hidden">창의인재동반 열고 닫기</span></button>
			</c:if>
		</div>

		<!-- 3Depth -->
		<div class="navList">
		<c:if test="${fn:length(curD03Categories)>0}">
			<ul>
			<c:set var="curD03" value="${curD03Categories[depth03]}" />
			<c:set var="curD" value="${curD03Categories[depth03]}" />
			<c:forEach var="x" begin="0" end="${fn:length(curD03Categories)-1}">
				<c:set var="clss" value="" />
				<c:choose>
					<c:when test="${x eq depth03}">
						<c:set var="clss" value="on" />
					</c:when>
				</c:choose>
				<li class="menu0${(x+1)} ${clss}">
				 	<a href="${curD03Categories[x].fullMenuLink}" ${curD03Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}>${curD03Categories[x].menuNm}</a>
				</li>
			</c:forEach>
			</ul>
		</c:if>
		</div>
	</div>

	<!-- content -->
	<div id="content">
	<!-- contentDB -->
		<c:choose>
			<c:when test="${not empty cvCon}">
				${cvCon}
			</c:when>
			<c:otherwise>
				<c:set var="_includePage" value="" />
				<c:choose>
					<c:when test="${not empty param.incPage}"><c:set var="_includePage" value="${incPage}" /></c:when>
					<c:when test="${empty includePage}"><c:set var="_includePage" value="${currMenu.contentsPath}" /></c:when>
					<c:otherwise><c:set var="_includePage" value="${includePage}" /></c:otherwise>
				</c:choose>
				<c:catch var ="catchException">
					<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true">
						<jsp:param name="menuNm" value="${currMenu.menuNm }" />
					</jsp:include>
				</c:catch>
			</c:otherwise>
		</c:choose>
	<!-- //contentDB -->
	</div>
	<!-- //content -->

	<div class="tailer">
	<jsp:include page="/WEB-INF/jsp/cklmobile/inc/cklmobileFooter.jsp" flush="true" />
	</div>

</div>
</body>
</html>