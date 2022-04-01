<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%-- <%@page import="kr.co.unp.main.service.impl.MainServiceImpl"%> --%>
<%@page import="egovframework.com.cmm.service.Globals"%>
<%@page import="kr.co.unp.util.CacheUtil"%>
<%@ page import="kr.co.unp.mpm.vo.*" %>
<%@ page import="kr.co.unp.member.vo.*" %>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.UnpUserDetailsHelper" %>
<%@ page import="kr.co.unp.siteMng.service.*" %>
<%@ page import="kr.co.unp.mpm.service.MasterMenuManager"%>
<%@ page import="kr.co.unp.cmm.sec.ram.service.impl.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="kr.co.unp.util.ZValue"%>
<%@page import="kr.co.unp.banner.vo.Banner"%>
<%@page import="kr.co.unp.banner.service.BannerService"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<%-- <%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

    //메뉴설정 SiteMngService.PORTAL_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.PORTAL_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);

	String menuNo = request.getParameter("menuNo");
	if("".equals(menuNo)) throw new Exception("menuNo 값이 없습니다.!");

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
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
 */
	//인증 리다이렉트페이지
	int port = Globals.OS_TYPE.equals("WINDOWS") ? 9999 : 80;

	if( !"200029".equals(menuNo) ){ //본인인증페이지 제외
		String _targetUrl = org.springframework.security.web.util.UrlUtils.buildFullRequestUrl("http", request.getServerName(), port, currentVo.getFullMenuLink(), null);
		session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, _targetUrl);
	}
%> --%>
<c:set var="list" value="${fn:contains(includePage, 'list')}" />
<c:set var="read" value="${fn:contains(includePage, 'read')}" />
<c:set var="reg" value="${fn:contains(includePage, 'reg')}" />
<c:set var="view" value="${fn:contains(includePage, 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
   <c:set var="title" value=""/>
<c:forEach var="x" begin="0" end="${fn:length(pathData)-1}">
	<c:choose>
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(목록)&lt;${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(읽기)&lt;${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(쓰기)&lt;${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(수정)&lt;${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]}&lt;${title}"/></c:otherwise>
	</c:choose>
</c:forEach>


<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/portalHead.jsp" flush="true" /> --%>


<title>${title}ckl</title>
</head>
<body>
<ul class="skip">
<li><a href="#content">본문내용 바로가기</a></li>
<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul>
<div id="gnbSubMenuBg" class="gnbBack"></div>
<div id="bg_gnb"></div>
<div id="bg_lnb"></div>
<div id="wrap">
	<div id="wrap_con">

		<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/head.jsp" flush="true" /> --%>

		<div id="subSpot">
			<p><em>증권&middot;금융계IT 인프라를</em> 책임지고 있는 자본시장 IT 솔루션 리더 <span class="c">ckl</span></p>
			<div class="facebookVoit">
				<div id="fb-root"></div>
				<script>(function(d, s, id) {
				  var js, fjs = d.getElementsByTagName(s)[0];
				  if (d.getElementById(id)) return;
				  js = d.createElement(s); js.id = id;
				  js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.3&appId=<c:out value="${facebookAppKey}" />";
				  fjs.parentNode.insertBefore(js, fjs);
				}(document, 'script', 'facebook-jssdk'));
				</script>
				<div class="fb-like" data-href="https://pms.ccbrain.co.kr:9999" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div>
				<div class="t"><span class="i">ckl FTIC</span>를 좋아합니다.</div>
			</div>
		</div>

		<div id="locationSet">
			<div class="navSet">
			<c:set var="topCategories" value="${menuAll2['menu_0']}" />
			<c:set var="curD" value="${topCategories[depth01]}" />
			<c:set var="d01Category" value="${topCategories[depth01]}" />
			<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
			<c:set var="d02Categories" value="${menuAll2[d01menuKey]}" />
				<div id="lnb">
				<c:if test="${fn:length(d02Categories)>0}">
					<ul>
					<c:set var="curD02" value="${d02Categories[depth02]}" />
					<c:set var="curD" value="${d02Categories[depth02]}" />
			 		<c:forEach var="x" begin="0" end="${fn:length(d02Categories)-1}">
					<c:set var="cnd" value="Y" />
					<c:if test="${cnd eq 'Y'}">
					<c:set var="clss" value=""/>
					<c:choose>
			 			<c:when test="${x eq depth02}"><c:set var="clss" value="class='on'" /></c:when>
			 		</c:choose>
						<li ${clss}>
						<c:choose>
							<c:when test="${userVO.entrprsNo == 0}">
								<c:if test="${d02Categories[x].menuNo ne 200040}">
									<a href="${d02Categories[x].fullMenuLink}" ${d02Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}>${d02Categories[x].menuNm}</a>
								</c:if>
							</c:when>
							<c:otherwise>
								<a href="${d02Categories[x].fullMenuLink}" ${d02Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}>${d02Categories[x].menuNm}</a>
							</c:otherwise>
							</c:choose>
							<c:set var="d03menuKey" value="menu_${d02Categories[x].menuNo}" />
							<c:set var="d03Categories" value="${menuAll2[d03menuKey]}" />
							<c:if test="${fn:length(d03Categories)>0}">
							<ul>
							<c:forEach var="y" begin="0" end="${fn:length(d03Categories)-1}">
								<c:set var="clss2" value="${x eq depth02 && y eq depth03 ? 'class=\"on\"' : ''}" />
								<c:if test="${x eq depth02 && y eq depth03}">
									<c:set var="curD" value="${d03Categories[y]}" />
									<c:set var="curD03" value="${d03Categories[y]}" />
								</c:if>
								<li ${clss2}><a href="${d03Categories[y].fullMenuLink}" ${d03Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}>${d03Categories[y].menuNm}</a></li>
							</c:forEach>
							</ul>
							</c:if>
						</li>
					</c:if>
					</c:forEach>
					</ul>
				</c:if>
				</div>
				<div id="location">
					<ol>
						<li class="home">home</li>
						<c:set var="size" value="${fn:length(pathData)}" />
						<c:if test="${size > 0}" >
							<c:forEach var="x" begin="0" end="${size-1}">
								<c:choose>
									<c:when test="${x eq size-1}"><li class="current"><c:out value="${pathData[x]}"/></li></c:when>
									<c:otherwise><li><c:out value="${pathData[x]}"/></li></c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
					</ol>
				</div>
			</div>
		</div>

		<!--container-->

		<div id="containerSet">
			<div id="container" class="clearfix">

				<!--content-->
				<div id="content">
				    <div class="hgroup">
				        <h1><span>${currMenu.menuNm}</span></h1>
				    </div>

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

					</div><!--//content-->
				<hr />
				<a href="#wrap" class="pageTop" title="문서 처음으로 이동">TOP</a>
			</div><!--//container-->
		</div>
		<hr />

	</div>
</div><!-- //wrap -->



<%-- <jsp:include page="/WEB-INF/jsp/portal/inc/portalFooter.jsp" flush="true" /> --%>

<script type="text/javascript" src="/js/zclip/jquery.zclip.js"></script>
<div class="souceUrl">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</div>
<div class="check" style="display: none">복사완료</div>
<script type="text/javascript">
	$(document).ready(function(){
	    $(".souceUrl").zclip({
		    path: "/js/zclip/ZeroClipboard.swf",
	        copy:$('.souceUrl').text(),
	        beforeCopy:function(){
	            $('.souceUrl').css('background','yellow');
	            $(this).css('color','orange');
	        },
	        afterCopy:function(){
	            $('.souceUrl').css('background','green');
	            $(this).css('color','purple');
	            $(this).next('.check').show();
	            $(this).width(1000)
	        }
	    });
	});
</script>



</body>
</html>
<font color="red">*/WEB-INF/jsp${empty includePage ? currMenu.contentsPath : includePage}</font>