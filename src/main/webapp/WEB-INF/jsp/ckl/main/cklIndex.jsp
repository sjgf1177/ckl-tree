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

    //메뉴설정 SiteMngService.CKL_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.CKL_SITE_ID;
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
<%= contextScopeMenuAllName %>
<%= menuMap %>
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="<%= Globals.OS_TYPE %>" />
<c:set var="list" value="${fn:contains(fn:toLowerCase(includePage), 'list')}" />
<c:set var="read" value="${fn:contains(fn:toLowerCase(includePage), 'read')}" />
<c:set var="reg" value="${fn:contains(fn:toLowerCase(includePage), 'reg')}" />
<c:set var="view" value="${fn:contains(fn:toLowerCase(includePage), 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
   <c:set var="title" value=""/>
<c:forEach var="x" begin="0" end="${fn:length(pathData)-1}">
	<c:choose>
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(목록) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(상세) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(쓰기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(수정) | ${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]} | ${title}"/></c:otherwise>
	</c:choose>
</c:forEach>

<c:set var="topCategories" value="${menuAll2['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll2[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll2[curD03menuKey]}" />

<jsp:include page="/WEB-INF/jsp/ckl/inc/cklHead.jsp" flush="true" />

<meta name="title" content="${fn:replace(title, '"', '˝')}" /> <!-- ' -->

<meta name="type" content="website" />

<c:set var="title" value="${title} CKL 기획센터" />
<title>${title}</title>

</head>
<body class="sub01">
<ul class="skip">
	<li><a href="#content" class="skipContents">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
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

function logoutSSO() {
	$.get("/edu/member/logout.json",function(data) {
		var retUrl = "${ssoDomain}/sso/member/logoutSSO.do?service=ckl";
		//alert(retUrl);
		location.href= retUrl;
	},"json");
	return false;
}

$(function() {
	<sec:authorize ifAnyGranted="ROLE_USER">
	$('.loginIng').show();
	</sec:authorize>


	$(".logoutBtn").click(function() {
		logoutSSO();
		return false;
     });

});
//]]>
</script>

	<!-- global -->
	<div class="globalSet">
		<ul class="globalLink">
			<li><a href="https://www.kocca.kr" target="_blank" title="새창열림">한국콘텐츠진흥원<span class="mainIcos icoArr"></span></a></li>
			<li><a href="https://edu.kocca.kr" target="_blank" title="새창열림">에듀코카<span class="mainIcos icoArr"></span></a></li>
		</ul>
		<ul class="globalUtil">
			<sec:authorize ifNotGranted="ROLE_USER">
			<li class="bar"><a href="/ckl/member/forLogin.do?menuNo=200055">로그인</a></li>
			<li class="bar"><a href="/ckl/member/join01.do?menuNo=200054">회원가입</a></li>
			</sec:authorize>
			<sec:authorize ifAnyGranted="ROLE_USER">
			<li class="bar"><strong class="text-danger"><c:out value="${userVO.userNm }"/></strong>님 로그인중입니다.</li>
			<li class="bar"><a href="/ckl/member/logout.do" class="ico4 logoutBtn" >로그아웃</a></li>
			<li class="bar"><a href="/ckl/userMember/forUpdate.do?menuNo=200033" class="myInfo">나의정보</a></li>
			</sec:authorize>
			<li class="mr20"><a href="/ckleng/main/main.do">English</a></li>
			<li class="schIcos">
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
			</li>
		</ul>
	</div>
	<!-- //global -->

	<div id="header">
		<div class="logoSet">
			<p class="mCommon orgLogo"><span class="hidden">대한민국 영토 콘텐츠로 넓힌다!  KOCCA 한국콘텐츠진흥원</span></p>
			<h1 class="mCommon logo"><a href="/ckl/main/main.do"><span class="hidden">콘텐츠코리아랩(Content korea lab)</span></a></h1>
		</div>

		<div id="gnb">
			<c:set var="topCategories" value="${menuAll2['menu_0']}" />
			<ul>
				<c:forEach var="x" begin="0" end="4">
					<li id="smenu${x+1}" ${x eq depth01 ? 'class="on"' : ''}><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a>
					<%--
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
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
			<div class="gnbTotMenu"><a href="javascript:void(0);"><span class="hidden">전체메뉴 열기</span></a></div>
			<div class="totMenuT">
				<c:forEach var="x" begin="0" end="5">
					<dl class="tms${x+1}">
						<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
						<dd>
							<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
							<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
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
				<a href="javascript:void(0);" class="closetotMenuT"><span class="hidden">전체메뉴 닫기</span></a>
			</div>
			<!-- 전체메뉴 열기 -->

		</div>
	</div>

	<!-- snb -->
	<div class="navSet">
		<div id="lnb">
			<div class="lnbHome dib fl"> <a href="/ckl/main/main.do" class="ico03"><span class="hidden">홈페이지</span></a> </div>
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
						<c:set var="d03Categories" value="${menuAll2[d03menuKey]}" />
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
					<li>
						<a href="javascript:void(0);" class="ico01 snsToggleOpen"><span class="hidden">SNS 공유하기</span></a>
						<div class="snsDrop">
							<c:url value="https://www.facebook.com/sharer.php" var="fbUrl">
								<c:param name="t" value="${title}" />
								<c:param name="u" value="${currMenu.fullMenuLink}" />
							</c:url>
							<c:url value="https://twitter.com/share" var="twitterUrl">
								<c:param name="text" value="${title}" />
								<c:param name="url" value="${currMenu.fullMenuLink}" />
							</c:url>
							<ul>
							    <li><a href="<c:out value='${fbUrl}' escapeXml='true' />" class="icos01" onclick="return facebookOpen();" title="(새창열림)페이스북 링크 공유하기" target="_blank">페이스북</a></li>
							    <li><a href="<c:out value="${twitterUrl }" escapeXml='true' />" class="icos02" onclick="return twitterOpen();" title="(새창열림)트위터 링크 공유하기" target="_blank">트위터</a></li>
							    <!-- <li><a href="https://story.kakao.com/share?url=" class="icos03" onclick="return kakaostoryOpen();" title="(새창열림)카카오스토리 링크 공유하기" target="_blank">카카오스토리</a></li> -->
							</ul>
						</div>
					</li>
					<li><a Href="#self" Class="ico02 CopyClipOpen"><span Class="hidden">URL 복사하기</span></a>
					<script type="text/javascript">
					//<![CDATA[
						var linkURL = document.URL;
						var param = "";
						$(document).ready(function(){
							$(':hidden').each(function(){
								if(null != $(this).attr('name') && $(this).val() != ""){
									if( linkURL.indexOf($(this).attr('name')) < 0){
										param += "&"+$(this).attr('name')+"="+$(this).val();
									}
								}
							});

							$(".snsIco .ico02").click(function(){
								urlLink();
								return false;
							});
						});

						//$("#COPYCP").prop("value", linkURL);
						function urlLink() {
						    var IE = (document.all) ? true : false;
						    if (IE) {
						         window.clipboardData.setData('Text', linkURL + param);
						         alert('주소가 복사되었습니다. 브라우저의 URL 입력창에 Ctrl+V로 붙여 넣기 하세요.');
						    } else {
						        temp = prompt("이 글의 트랙백 주소입니다. Ctrl+C를 눌러 클립보드로 복사하세요", linkURL + param );
						    }
						    return false;
						}
					//]]>
					</script>
					</li>
					<li><a href="/ckl/forPrint.jsp" class="ico03" onclick="window.open(this.href, 'printPage', 'width=1120,height=650,scrollbars=1,toolbar=1,status');return false;" target="_blank" title="(새창열림)내용인쇄하기"><span class="hidden">인쇄하기</span></a></li>
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
				<c:if test="${not empty curD.preMenuLink }"><a href="${curD.preMenuLink }" class="leftMenuArr"><span class="hidden">이전 메뉴 보기</span></a></c:if>
				<c:if test="${empty curD.preMenuLink }"><span class="leftMenuArrOff"></span></c:if>
				<c:if test="${not empty curD.nextMenuLink }"><a href="${curD.nextMenuLink }" class="rightMenuArr"><span class="hidden">다음 메뉴 보기</span></a></c:if>
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

			<%-- <jsp:include page="/jsp/ckl/main/cklRight.do?viewType=CONTBODY" flush="true" /> --%>
		</div>
	</div>
	<!-- //content -->



	<div class="tailer">

		<div class="totMenuF">
		<c:forEach var="x" begin="0" end="5">
			<dl class="tmenu${x+1}">
				<dt><a href="${topCategories[x].fullMenuLink}" ${topCategories[x].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"' : ''}>${topCategories[x].menuNm}</a></dt>
				<dd>
					<c:set var="d02MenuKey" value="menu_${topCategories[x].menuNo}" />
					<c:set var="d02Categories" value="${menuAll2[d02MenuKey]}" />
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

		<jsp:include page="/WEB-INF/jsp/ckl/inc/cklFooter.jsp" flush="true" />

	</div>

<iframe name="ssoAuthFrame" id="ssoAuthFrame" style="width:0px;height:0px;border:0;" src="${ssoDomain }/sso/member/checkSSO.do?service=ckl&amp;menuNo=<c:out value="${paramVO.menuNo }" />&amp;userTp=<c:out value="${userVO.userIdx }" />" title="SSO 로그인 유무확인 프레임 입니다."></iframe>


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