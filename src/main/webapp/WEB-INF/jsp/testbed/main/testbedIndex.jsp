<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Map.Entry" %>
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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var='siteName' value='${paramVO.siteName}'/>
<%
	UsersVO user = UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user);

    //메뉴설정 SiteMngService.PORTAL_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.EDU_SITE_ID;
	/* testbed20170830 */
	String siteName = (String)pageContext.getAttribute("siteName") != null ? (String)pageContext.getAttribute("siteName") : "" ;
	String testbedContextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteMngService.TESTBED_SITE_ID;
	if ( "edu".equals( siteName )  )
		pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);
	else if ( "testbed".equals( siteName )  )
		pageContext.setAttribute("testbedContextScopeMenuAllName", testbedContextScopeMenuAllName);
	/* //testbed20170830 */ 
	String menuNo = request.getParameter("menuNo");
	if("".equals(menuNo)) throw new Exception("menuNo 값이 없습니다.!"); 

	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	/* testbed20170830 */
	HashMap<String, List<MenuManageVO>> menuMap = new HashMap<String, List<MenuManageVO>>();
	HashMap<String, List<MenuManageVO>> eduMenuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(contextScopeMenuAllName);
	HashMap<String, List<MenuManageVO>> testbedMenuMap = (HashMap<String, List<MenuManageVO>>)application.getAttribute(testbedContextScopeMenuAllName);
	menuMap.putAll(eduMenuMap);
	if ( "testbed".equals( siteName ) )
		menuMap.putAll( testbedMenuMap );
	/* //testbed20170830 */
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	egovframework.rte.fdl.property.EgovPropertyService propertiesService = (egovframework.rte.fdl.property.EgovPropertyService)context.getBean("propertiesService");
	String realTp = EgovProperties.getProperty("Globals.realMode");
	request.setAttribute("facebookAppKey", propertiesService.getString("Sns.facebookAppKey"));

	MenuManageVO currentVo = masterMenuManagerService.getCurrentMenu(menuMap, Integer.parseInt(menuNo));
	pageContext.setAttribute("currMenu", currentVo);
System.out.println("============================= currentVo : " + currentVo);
System.out.println("============================= menuMap : " + menuMap);
System.out.println("============================= menuNo : " + menuNo);
	if (currentVo != null){
		String position = currentVo.getPosition();
		int depth01 = Integer.parseInt(position.substring(0,2)) -1;
		int depth02 = Integer.parseInt(position.substring(2,4)) -1;
		int depth03 = Integer.parseInt(position.substring(4,6)) -1;
		int depth04 = Integer.parseInt(position.substring(6,8)) -1;
		int depth05 = Integer.parseInt(position.substring(8,10)) -1;
		pageContext.setAttribute("depth01", depth01);
		pageContext.setAttribute("depth02", depth02);
		pageContext.setAttribute("depth03", depth03);
		pageContext.setAttribute("depth04", depth04);
		pageContext.setAttribute("depth05", depth05);
	}
	
	//인증 리다이렉트페이지
	int port = Globals.OS_TYPE.equals("WINDOWS") ? 80 : 80;
	String protocol = "http";
	if ("Y".equals(realTp)) protocol = "https";
	//String url = protocol+"://"+request.getServerName()+":"+port+"/"+paramVO.getString("siteName")+"/"+paramVO.getString("programId")+"/"+paramVO.getString("targetMethod")+".do?"+request.getQueryString();
	String _targetUrl = (String)session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);

	if("500075".equals(menuNo) || "500076".equals(menuNo) || "500077".equals(menuNo)) { //본인인증페이지
		if (StringUtils.hasText(_targetUrl)) {
			session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
		}
	}
 	else {
 		if(!"localhost".equals(request.getServerName())){
			String _targetUrl_ = org.springframework.security.web.util.UrlUtils.buildFullRequestUrl(protocol, request.getServerName(), port, currentVo.getFullMenuLink(), null);
			_targetUrl_ = _targetUrl_.replaceAll(":80", "");
			session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, _targetUrl_);
 		}
	}
	System.out.println( request.getServerName() );
 	String dataHref = "https://" + request.getServerName();
	if ( port != 80 ) {
		dataHref += ":" + port;
	}
	pageContext.setAttribute("dataHref", dataHref);
	
%>
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="<%= Globals.OS_TYPE %>" />
<c:set var="serverName" value="<%= request.getServerName() %>" />
<c:set var="list" value="${fn:contains(fn:toLowerCase(includePage), 'list')}" />
<c:set var="read" value="${fn:contains(fn:toLowerCase(includePage), 'read')}" />
<c:set var="reg" value="${fn:contains(fn:toLowerCase(includePage), 'reg')}" />
<c:set var="view" value="${fn:contains(fn:toLowerCase(includePage), 'read')}" />
<c:set var="pathData" value="${fn:split(currMenu.path, '|')}" />
<c:set var="title" value=""/>
<c:set var="1depth_title" value=""/>
<c:forEach var="x" begin="0" end="${fn:length(pathData)-1}">
	<c:choose>
		<c:when test="${x eq fn:length(pathData)-1 and list eq true}"><c:set var="title" value="${pathData[x]}(목록) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (read eq true or view eq true)}"><c:set var="title" value="${pathData[x]}(상세) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId eq null)}"><c:set var="title" value="${pathData[x]}(쓰기) | ${title}"/></c:when>
		<c:when test="${x eq fn:length(pathData)-1 and (reg eq true and result.nttId ne null)}"><c:set var="title" value="${pathData[x]}(수정) | ${title}"/></c:when>
		<c:otherwise><c:set var="title" value="${pathData[x]}&lt;${title}"/></c:otherwise>
	</c:choose>
</c:forEach>
<c:choose>
<c:when test="${param.menuNo eq '500026' }"><c:set var="title" value="온라인교육 &lt;"/></c:when>
<c:when test="${param.menuNo eq '500034' }"><c:set var="title" value="창의인재동반 &lt;"/></c:when>
<c:when test="${param.menuNo eq '500046' }"><c:set var="title" value="취업정보  &lt;"/></c:when>
</c:choose>

<c:set var="topCategories" value="${menuAll5['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll5[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${d02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll5[curD03menuKey]}" />

   <!doctype html>
    <%
    if("500007".equals(menuNo) || "500019".equals(menuNo) || "500026".equals(menuNo) || "500034".equals(menuNo) || "500046".equals(menuNo) || "500108".equals(menuNo) ) { //본인인증페이지
    %>

 
    <html lang="ko">
    <head>
        <c:set var="title" value="${title} 콘텐츠문화광장" />
        <title>${title}</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />

        <meta name="title" content="${fn:replace(title, '"', '˝')}" />
        <meta name="type" content="website" />
        
        <c:if test="${not empty og}">
        <meta property="og:title" content="${fn:replace(og.title, '"', '˝')}" />
        <meta property="og:image" content="${og.image}" />
        <meta property="og:description" content="<c:out value='${og.description}'/>" />
        <meta property="og:type" content="website" />
        </c:if>
        
        <jsp:include page="/WEB-INF/jsp/testbed/inc/testbedSubMainHead.jsp" flush="true" />
        <script type="text/javascript" src="https://101.livere.co.kr/js/livere8_lib.js" charset="utf-8"></script>
    </head>
    <body>

    <c:choose>
        <c:when test="${param.menuNo eq '500007'}"><jsp:include page="/WEB-INF/jsp/edu/main/eduSubMainHome.jsp" flush="true" /></c:when>
        <c:when test="${param.menuNo eq '500019'}"><jsp:include page="/WEB-INF/jsp/edu/main/eduSubMainOffline.jsp" flush="true" /></c:when>
        <c:when test="${param.menuNo eq '500026'}"><jsp:include page="/WEB-INF/jsp/edu/main/eduSubMainOnline.jsp" flush="true" /></c:when>
        <c:when test="${param.menuNo eq '500034'}"><jsp:include page="/WEB-INF/jsp/edu/main/eduSubMainEduSupport.jsp" flush="true" /></c:when>
        <c:when test="${param.menuNo eq '500046'}"><jsp:include page="/WEB-INF/jsp/edu/main/eduSubMainRecruitInfo.jsp" flush="true" /></c:when>
        <c:when test="${param.menuNo eq '500108'}"><jsp:include page="/WEB-INF/jsp/edu/main/eduSubMainHR.jsp" flush="true" /></c:when>
    </c:choose>

    </body>
    </html>

    <% }else{ %>
<html lang="ko">
<head>
	<c:set var="title" value="${title} 콘텐츠문화광장222" />
	<title>${title}</title>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1, maximum-scale=3, minimum-scale=1" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />

	<meta name="title" content="${fn:replace(title, '"', '˝')}" />
	<meta name="type" content="website" />
	
	<c:if test="${not empty og}">
	<meta property="og:title" content="${fn:replace(og.title, '"', '˝')}" />
	<meta property="og:image" content="${og.image}" />
	<meta property="og:description" content="<c:out value='${og.description}'/>" />
	<meta property="og:type" content="website" />
	</c:if>
	

	<jsp:include page="/WEB-INF/jsp/testbed/inc/testbedHead.jsp" flush="true" />
	<script type="text/javascript" src="https://101.livere.co.kr/js/livere8_lib.js" charset="utf-8"></script>
</head>
<c:set var="subNum" value="sub0${depth01+1 }" />
<c:if test="${depth01 > 5  }">
	<c:set var="subNum" value="sub01" />
</c:if>
<c:if test="${depth01 == 8  }">
	<c:set var="subNum" value="member" />
</c:if>
<body class="<c:out value="${subNum }" />">

<!-- <ul class="skip">
	<li><a href="#content" class="skipContents">본문내용 바로가기</a></li>
	<li><a href="#gnb">주메뉴 바로가기</a></li>
</ul> -->
<div class="sub01Head wrapper sub_layout_page contents_view_page">

	<!-- //header -->
		<c:import url="/WEB-INF/jsp/testbed/inc/head.jsp" />
	<!-- //header -->

	<!-- <div class="svisualSet"></div> -->

		<!--container-->
		<div class="col-12 sub_contents_wrap">
            <div class="col-12 col-center mw-1200 over-visible">
                <div class="col-12 pr15 pl15">
                    <div class="lnb_wrap <c:if test='${fn:indexOf(pathData[0], "온라인교육") > -1 }'>online</c:if>">
                        <div class="lnb_header">
                        <h3 class="show-tablecell vm tc">${pathData[0]}</h3>
                        </div>
                        <c:if test="${fn:length(curD02Categories)>0}">
                        <c:choose>
                        	<c:when test='${fn:indexOf(pathData[0], "온라인교육") > -1 }'>
                        		<ul class="lnb_con">
		                        <c:set var="curD02" value="${curD02Categories[depth02]}" />
		                        <c:set var="curD" value="${curD02Categories[depth02]}" />
		                        <c:forEach var="x" begin="0" end="${fn:length(curD02Categories)-1}">
		                            <c:set var="clss" value="${x eq depth02 ? 'on' : ''}" />
		                            <c:set var="lnbClss" value="1" />
		                            <li class="${clss}">
			                            <a href="${curD02Categories[x].fullMenuLink}" ${curD02Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}>
			                                <p class="lnb_title">${curD02Categories[x].menuNm}</p>
			                                <div class="lnb_desc img_${curD02Categories[x].menuNo}">
			                                    <span>
			                                    	<c:choose>
			                                        <%-- 정규과정 --%>
			                                        <c:when test="${curD02Categories[x].menuNo eq '500027'}">방송영상,게임,만화<br/>캐릭터,음악공연등의 과목</c:when>
			                                        <%-- 열린강좌 --%>
	                                                <c:when test="${curD02Categories[x].menuNo eq '500085'}">공공이 모두 이용할<br/>수 있는 학습 콘텐츠</c:when>
	                                                <%-- 테마과정 --%>
	                                                <c:when test="${curD02Categories[x].menuNo eq '511111'}">다양한 콘텐츠를<br/>테마별로 이용할 수<br/>있는 과정</c:when>
	                                                <%-- 맞춤교육 --%>
	                                                <c:when test="${curD02Categories[x].menuNo eq '500005'}">방송영상,게임,만화<br/>캐릭터,음악공연등의<br/>과목</c:when>
	                                                <%-- 교육체계도 --%>
	                                                <c:when test="${curD02Categories[x].menuNo eq '500030'}">온라인 과정의<br/>교육체계도 및<br/>Track 확인</c:when>
	                                                <%-- 아카데미 이야기 --%>
	                                                <c:when test="${curD02Categories[x].menuNo eq '522222'}">방송영상,게임,만화<br/>캐릭터,음악공연등의<br/>과목</c:when>
	                                                <%-- 학습지원 --%>
	                                                <c:when test="${curD02Categories[x].menuNo eq '500033'}">방송영상,게임,만화<br/>캐릭터,음악공연등의<br/>과목</c:when>
                                                	</c:choose>
			                                    </span>
			                                </div>
			                            </a>
		                            </li>
		                        </c:forEach>
		                        </ul>
                        		</c:when>
                        		<c:when test="${siteName eq 'testbed'}">
									<c:set var="topCategoriesTestbed" value="${menuAll7['menu_0']}" />
									<c:set var="d01Category" value="${topCategoriesTestbed[depth01]}" />
									<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
									<c:set var="curD02Categories" value="${menuAll7[d01menuKey]}" />
									<c:set var="d02MenuKey" value="menu_700000" />
									<c:set var="d02Categories" value="${menuAll7[d02MenuKey]}" />
									<c:set var="curD02" value="${curD02Categories[depth02]}" />
									<c:set var="curD" value="${curD02Categories[depth02]}" />
	                        		<ul class="lnb_con">
			                        <c:forEach var="x" begin="0" end="${fn:length(curD02Categories)-1}">
			                        	<c:set var="clss" value="${x eq depth02 ? 'on' : ''}" />
			                            <c:set var="lnbClss" value="1" />
			                            <c:set var="d03menuKey" value="menu_${curD02Categories[x].menuNo}" />
			                            <c:set var="d03Categories" value="${menuAll7[d03menuKey]}" /> 
			                            <c:if test="${fn:length(d03Categories)>0}">
			                                <c:set var="lnbClss" value="2" />
			                            </c:if>
			                            <li class="lnb_${lnbClss} ${clss}">
			                            	<a href="${curD02Categories[x].fullMenuLink}" ${curD02Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}><span>${curD02Categories[x].menuNm}</span></a>
			                            	<c:if test="${fn:length(d03Categories)>0}">
				                                <ul>
				                                <c:forEach var="y" begin="0"	end="${fn:length(d03Categories)-1}">
				                                    <c:set var="clss2" value="${x eq depth02 && y eq depth03 ? 'active' : ''}" />
				                                    <c:if test="${x eq depth02 && y eq depth03}">
				                                        <c:set var="curD" value="${d03Categories[y]}" />
				                                        <c:set var="curD03" value="${d03Categories[y]}" />
				                                    </c:if>
				                                    <c:if test="${d03Categories[y].menuNo ne '500124' && d03Categories[y].menuNo ne '500125' && d03Categories[y].menuNo ne '500126' && d03Categories[y].menuNo ne '500128'}">
				
				                                    <li class="${clss2}">
				                                    <a	href="${d03Categories[y].fullMenuLink}" ${d03Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}><span>${d03Categories[y].menuNm}</span></a>
				                                    </li>
				                                    </c:if>
				                                </c:forEach>
				                                </ul>
				                            </c:if>
			                            </li>
			                        </c:forEach>
		                        	</ul>
                        		</c:when>
                        	<c:otherwise>
	                        	<ul class="lnb_con">
		                        <c:set var="curD02" value="${curD02Categories[depth02]}" />
		                        <c:set var="curD" value="${curD02Categories[depth02]}" />
		                        <c:forEach var="x" begin="0" end="${fn:length(curD02Categories)-1}">
		                            <c:set var="clss" value="${x eq depth02 ? 'on' : ''}" />
		                            <c:set var="lnbClss" value="1" />
		                            <c:set var="d03menuKey" value="menu_${curD02Categories[x].menuNo}" />
		                            <c:set var="d03Categories" value="${menuAll5[d03menuKey]}" />
		                            <c:set var="d02Url" value="${fn:replace(curD02Categories[x].fullMenuLink, '/edu/', '/testbed/')}" />
		                            <c:if test="${fn:length(d03Categories)>0}">
		                                <c:set var="lnbClss" value="2" />
		                            </c:if>
		                            <li class="lnb_${lnbClss} ${clss}">
		                            	<a href="${d02Url}" ${curD02Categories[x].menuPopupYn eq 'Y'?'target="_blank" title="새창열림"':''}><span>${curD02Categories[x].menuNm}</span></a>
		                            <c:if test="${fn:length(d03Categories)>0}">
		                                <ul>
		                                <c:forEach var="y" begin="0"	end="${fn:length(d03Categories)-1}">
		                                    <c:set var="clss2" value="${x eq depth02 && y eq depth03 ? 'active' : ''}" />
		                                    <c:if test="${x eq depth02 && y eq depth03}">
		                                        <c:set var="curD" value="${d03Categories[y]}" />
		                                        <c:set var="curD03" value="${d03Categories[y]}" />
		                                    </c:if>
		                                    <c:if test="${d03Categories[y].menuNo ne '500124' && d03Categories[y].menuNo ne '500125' && d03Categories[y].menuNo ne '500126' && d03Categories[y].menuNo ne '500128'}">
		
		                                    <li class="${clss2}">
		                                    <c:set var="d03Url" value="${fn:replace(d03Categories[y].fullMenuLink, '/edu/', '/testbed/')}" />
		                                    <a	href="${d03Url}" ${d03Categories[y].menuPopupYn eq 'Y' ? 'target="_blank" title="새창열림"':''}><span>${d03Categories[y].menuNm}</span></a>
		                                    </li>
		                                    </c:if>
		                                </c:forEach>
		                                </ul>
		                            </c:if>
		                            </li>
		                        </c:forEach>
		                        </ul>
                        	</c:otherwise>
                        </c:choose>
                        </c:if>

                        <!-- snsSet 백업 참조 -->
                        <!-- //snsSet -->

                    </div>

                    <!-- sub 컨텐츠 -->
                    <div id="subContainer" class="col-12 col-md-0 fn-md over-hidden sub_contents printPage">
                        <div class="col-12 sub_section">
                            <div class="over-hidden sub_contents_header">
	                            <c:choose>
	                                <c:when  test="${curD.menuNo eq '700135'}">
	                                		<h4 class="fl">${curD.menuNm}<spen style="font-size:14px;margin-left:12px;color:#dc2979;">문의 : 02-6310-0758</spen></h4>
	                                </c:when>
	                                <c:when  test="${curD.menuNo eq '700103'}">
	                                		<h4 class="fl">${curD.menuNm}<spen style="font-size:14px;margin-left:12px;color:#dc2979;">문의 : 02-6310-0776</spen></h4>
	                                </c:when>	                                
	                                <c:otherwise>
                                		<h4 class="fl">${curD.menuNm}</h4>
                                	</c:otherwise>
								</c:choose>

                                <div class="fr linemap_wrap">
                                    <ul class="col-12 linemap_con">
                                        <li><a href="/testbed/main/main.do?menuNo=500108"><span style="display:none;">HOME</span></a></li>
                                        <c:set var="size" value="${fn:length(pathData)}" />
                                        <c:if test="${size > 0}">
                                            <c:choose>
                                                <c:when test="${param.menuNo eq '500007'}"><li><a href="javascript:void(0);"><span>새소식</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500019'}"><li><a href="javascript:void(0);"><span>현장교육</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500026'}"><li><a href="javascript:void(0);"><span>온라인교육</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500034'}"><li><a href="javascript:void(0);"><span>창의인재동반</span></a></li></c:when>
                                                <c:when test="${param.menuNo eq '500046'}"><li><a href="javascript:void(0);"><span>취업정보</span></a></li></c:when>
                                                <c:otherwise>
                                                    <c:forEach var="x" begin="0" end="${size-1}" varStatus="status">
                                                        <li><a href="javascript:void(0);" tabindex="-1"><span><c:out value="${pathData[x]}"/></span></a></li>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                            <!-- 서브 컨텐츠 바디 -->
                            <div class="sub_contents_body">
                                <!--content-->
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
                                <!--//content-->
                            </div>
                            <!-- 서브 컨텐츠 바디 끝-->
                        </div>
                    </div>
                    <!-- sub 컨텐츠 -->

                </div>
            </div>
		</div>
    <!-- footer -->
    <jsp:include page="/WEB-INF/jsp/testbed/inc/testbedFooter.jsp" flush="true">
    	<jsp:param name="menuNm" value="${pathData[0]}"></jsp:param>
    </jsp:include> 
    <!-- //footer -->
</div>
<!-- //wrap -->


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
    <% } %> 
    
