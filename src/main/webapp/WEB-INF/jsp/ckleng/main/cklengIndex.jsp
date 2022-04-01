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

    //메뉴설정 SiteMngService.CKLENG_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.CKLENG_SITE_ID;
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

	//배너
	/*
	CacheUtil cacheUtil = (CacheUtil)context.getBean("cacheUtil");
	List<Banner> bannerList = (List<Banner>)cacheUtil.load("storedMain", "bannerList");
	if( bannerList == null ){
		BannerService bannerService = (BannerService)context.getBean("bannerService");
		bannerList = bannerService.selectPublishList(new Banner());
		cacheUtil.save("storedMain", "bannerList", bannerList);
	}
	pageContext.setAttribute("bannerList", bannerList);

	SiteMngService siteMngService = (SiteMngService)context.getBean("siteMngService");
 	ZValue site = siteMngService.getSiteBySiteName("ckl");
	pageContext.setAttribute("siteVO", site);
 */


	//배너
	CacheUtil cacheUtil = (CacheUtil)context.getBean("cacheUtil");
	List<ZValue> bannerList = (List<ZValue>)cacheUtil.load("storedMain", "bannerList");
	if( bannerList == null ){
		BannerService bannerService = (BannerService)context.getBean("bannerService");
		ZValue mainBanner = new ZValue();
		mainBanner.put("gubun","01"); //CKL 전체01 , EDU 전체 02, 교육 03, 창의동반 04, 채용정보 05
		bannerList = bannerService.getBanner(mainBanner);
		cacheUtil.save("storedMain", "bannerList", bannerList);
	}

// 	pageContext.setAttribute("bannerList", bannerList);
	application.setAttribute("bannerList", bannerList);
	SiteMngService siteMngService = (SiteMngService)context.getBean("siteMngService");
	ZValue site = siteMngService.getSiteBySiteName("ckl");
	pageContext.setAttribute("siteVO", site);



	//인증 리다이렉트페이지
	int port = Globals.OS_TYPE.equals("WINDOWS") ? 80 : 80;
	String protocol = "http";
	if ("Y".equals(realTp)) protocol = "https";
	String _targetUrl = (String)session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
	if("200053".equals(menuNo) || "200054".equals(menuNo) || "200055".equals(menuNo)) { //본인인증페이지
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
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(List) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(Read) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(Write) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(Modify) | ${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]} | ${title}"/></c:otherwise>
	</c:choose>
</c:forEach>

<c:set var="topCategories" value="${menuAll3['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll3[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll3[curD03menuKey]}" />

<jsp:include page="/WEB-INF/jsp/ckleng/inc/cklengHead.jsp" flush="true" />

<meta name="title" content="${fn:replace(title, '"', '˝')}" /> <!-- ' -->

<meta name="type" content="website" />

<c:set var="title" value="${title} Content Korea Lab" />
<title>${title}</title>

</head>
<body class="sub01">
<ul class="skip">
	<li><a href="#content">Go to Contents</a></li>
	<li><a href="#gnb">Go to Menu</a></li>
</ul>


<div class="subVisualSet"></div>
<div id="wrap">

<script type="text/javascript">
//<![CDATA[

function search2(form){
	if(!form.q.value){
		alert("검색어를 입력하세요.");
		$("#q2")[0].focus();
		return false;
	}
	return true;
}

$(function() {
	<sec:authorize ifAnyGranted="ROLE_USER">
	$('.loginIng').show();
	</sec:authorize>

	$(".logoutBtn").click(function() {

		$.get("/ckl/member/logout.json",function(data) {
			location.href="${ssoDomain}/sso/member/logoutSSO.do?service=ckl";
		},"json");
		return false;
     });

});
//]]>
</script>

	<!-- global -->
	<div class="globalSet">
		<ul class="globalLink">
			<li><a href="http://eng.kocca.kr/en/main.do" target="_blank" title="New Window">Korea Creative Content Agency<span class="mainIcos icoArr"></span></a></li>
			<li><a href="https://edu.kocca.kr" target="_blank" title="New Window">Korea Contents Academy<span class="mainIcos icoArr"></span></a></li>
		</ul>
		<ul class="globalUtil">
			<%-- <sec:authorize ifNotGranted="ROLE_USER">
						<li class="bar"><a href="/ckl/member/forLogin.do?menuNo=200055">로그인</a></li>
						<li class="bar"><a href="/ckl/member/join01.do?menuNo=200054">회원가입</a></li>
						</sec:authorize>
						<sec:authorize ifAnyGranted="ROLE_USER">
						<li class="bar"><strong class="text-danger"><c:out value="${userVO.userNm }"/></strong>님 로그인중입니다.</li>
						<li class="bar"><a href="/ckl/member/logout.do" class="ico4 logoutBtn" >로그아웃</a></li>
						<li class="bar"><a href="/ckl/userMember/forUpdate.do?menuNo=200033" class="myInfo">나의정보</a></li>
						</sec:authorize> --%>
			<li class="mr20"><a href="/ckl/main/main.do">Korean</a></li>
			<%-- <li class="schIcos">
							<!-- search -->

							<div class="shSet">
								<form name="frmSearch2" method="post" action="/ckl/search/list.do?menuNo=200061" onsubmit="return search2(this);">
									<fieldset>
										<legend>검색창 입력양식</legend>
										<input type="text" class="schWd" name="q" id="q2" value="" title="검색어를 입력하세요." />
										<input type="image" class="schGo" src="/ckl/images/common/schGo.png" name="SCHGO" id="SCHGO" alt="검색 확인" title="검색 확인"  />
									</fieldset>
								</form>
							</div>
							<!-- //search -->
						</li> --%>
		</ul>
	</div>
	<!-- //global -->

	<div id="header">
		<div class="logoSet">
				<p class="mCommon orgLogo"><span class="hidden">Small but bright idea develops into global contents ! </span></p>
				<h1 class="mCommon logo"><a href="/ckleng/main/main.do"><span class="hidden">Content korea lab</span></a></h1>
		</div>

		<div id="gnb">
			<c:set var="topCategories" value="${menuAll3['menu_0']}" />
			<ul>
				<c:forEach var="x" begin="0" end="3">
					<li id="smenu${x+1}" ${x eq depth01 ? 'class="on"' : ''}><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
					<%--
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
						<c:if test="${fn:length(d02Categories)>0}">
						<ul>
							<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
								<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank"' : ''}>${d02Categories[y].menuNm}</a></li>
							</c:forEach>
						</ul>
						</c:if>
					--%>
					</li>
				</c:forEach>
			</ul>

			<!-- 전체메뉴 열기 -->
			<div class="gnbTotMenu"><a href="#self"><span class="hidden">open all nav </span></a></div>
			<div class="totMenuT">
				<c:forEach var="x" begin="0" end="3">
					<dl class="tms${x+1}">
						<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
						<dd>
							<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
							<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
							<c:if test="${fn:length(d02Categories)>0}">
							<ul>
								<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
									<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
								</c:forEach>
							</ul>
							</c:if>
						</dd>
					</dl>
				</c:forEach>
				<a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">close all nav </span></a>
			</div>
			<!-- 전체메뉴 열기 -->

		</div>
	</div>

	<!-- snb -->
	<div class="navSet">
		<div id="lnb">
			<div class="lnbHome dib fl"> <a href="/ckleng/main/main.do" class="ico03"><span class="hidden">Home</span></a> </div>
			<c:if test="${fn:length(curD02Categories)>0}">
			<ul class="lnbNav fl">
				<c:set var="curD02" value="${curD02Categories[depth02]}" />
				<c:set var="curD" value="${curD02Categories[depth02]}" />
				<c:forEach var="x" begin="0" end="${fn:length(curD02Categories)-1}">
					<c:set var="clss" value="" />
					<c:choose>
						<c:when test="${x eq depth02}">
							<c:set var="clss" value="on" />
						</c:when>
					</c:choose>
					<li class="menu0${(x+1)} ${clss}"><a
						href="${curD02Categories[x].fullMenuLink}"
						${curD02Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}>${curD02Categories[x].menuNm}</a>
						<c:set var="d03menuKey" value="menu_${curD02Categories[x].menuNo}" />
						<c:set var="d03Categories" value="${menuAll3[d03menuKey]}" />
						<c:if test="${fn:length(d03Categories)>0}">
							<ul>
								<c:forEach var="y" begin="0"
									end="${fn:length(d03Categories)-1}">
									<c:set var="clss2"
										value="${x eq depth02 && y eq depth03 ? 'on' : ''}" />
									<c:if test="${x eq depth02 && y eq depth03}">
										<c:set var="curD" value="${d03Categories[y]}" />
										<c:set var="curD03" value="${d03Categories[y]}" />
									</c:if>
									<li class="${clss2}"><a
										href="${d03Categories[y].fullMenuLink}"
										${d03Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>${d03Categories[y].menuNm}</a></li>
								</c:forEach>
							</ul>
						</c:if></li>
				</c:forEach>
			</ul>
			</c:if>

			<div class="snsSet snsIco">
				<ul>
					<li><a href="/ckl/forPrintEng.jsp" class="ico03" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="새창열림"><span class="hidden">Print</span></a></li>
				</ul>
			</div>
			<!-- //snsSet -->

		</div>
	</div>
	<!-- snb -->


		<div class="subPageInfo">
			<h1>${curD.menuNm}</h1>
			<div id="locationSet">
				<div id="location">
					<ol>
						<li class="home">home</li>
						<c:set var="size" value="${fn:length(pathData)}" />
						<c:if test="${size > 0}">
							<c:forEach var="x" begin="0" end="${size-1}">
								<c:choose>
									<c:when test="${x eq size-1}">
										<li class="current"><c:out value="${pathData[x]}" /></li>
									</c:when>
									<c:otherwise>
										<li><c:out value="${pathData[x]}" /></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
					</ol>
				</div>
			</div>
			<div class="menuSeqArr">
				<c:if test="${not empty curD.preMenuLink }"><a href="${curD.preMenuLink }" class="leftMenuArr"><span class="hidden">prev menu</span></a></c:if>
				<c:if test="${empty curD.preMenuLink }"><span class="leftMenuArrOff"></span></c:if>
				<c:if test="${not empty curD.nextMenuLink }"><a href="${curD.nextMenuLink }" class="rightMenuArr"><span class="hidden">next menu</span></a></c:if>
				<c:if test="${empty curD.nextMenuLink }"><span class="rightMenuArrOff"></span></c:if>
			</div>

		</div>



	<div class="contentSet"><!-- snsSet -->
		<div id="content">
			<div class="contentLeft">

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
							<jsp:include page="/WEB-INF/jsp${_includePage}" flush="true" />
						</c:catch>
					</c:otherwise>
				</c:choose>
			</div>

			<%-- <jsp:include page="/ckleng/main/cklRight.do?viewType=CONTBODY" flush="true" /> --%>
		</div>
	</div>
	<!-- //content -->



	<div class="tailer">

		<div class="totMenuF">
		<c:forEach var="x" begin="0" end="3">
			<dl class="tmenu${x+1}">
				<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
				<dd>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll3[d02MenuKey]}" />
					<c:if test="${fn:length(d02Categories)>0}">
					<ul>
						<c:forEach var="y" begin="0" end="${fn:length(d02Categories)-1}">
							<li><a href="${d02Categories[y].fullMenuLink}" ${d02Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${d02Categories[y].menuNm}</a></li>
						</c:forEach>
					</ul>
					</c:if>
				</dd>
			</dl>
		</c:forEach>
		</div>

		<jsp:include page="/WEB-INF/jsp/ckleng/inc/cklengFooter.jsp" flush="true" />

	</div>

</div>






<!--[if lte IE 7]>
<script type="text/javascript">
//<![CDATA[
	$('*').each(function(index) {
		if ($(this).css("overflow")=="hidden"){
			$(this).css("zoom",1);
		}
		if ($(this).css("display")=="inline-block"){
			$(this).css("display",'inline');
			$(this).css("zoom",1);
		}
	});
//]]>
</script>
<![endif]-->
</body>
</html>